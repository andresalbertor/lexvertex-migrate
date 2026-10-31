const fs = require('fs');
const path = require('path');

const csvPath = 'D:/AndrésRestrepo/Downloads/DIVIPOLA-_Códigos_municipios_20261023.csv';
const sqlPath = path.join(__dirname, 'src/main/resources/db/migration/V22__divipola_colombia.sql');

const content = fs.readFileSync(csvPath, 'utf8');
const lines = content.split('\n').map(l => l.trim()).filter(l => l.length > 0);

// Skip header
const header = lines.shift();

const departments = new Map(); // code -> name
const cities = []; // { deptCode, code, name }

function escapeSql(str) {
    return str.replace(/'/g, "''");
}

function titleCase(str) {
    // Basic title case that ignores particles (de, la, el, las, los, y) unless it's the first word
    const words = str.toLowerCase().split(' ').map(w => w.trim()).filter(w => w.length > 0);
    return words.map((word, i) => {
        if (i !== 0 && ['de', 'la', 'el', 'del', 'los', 'las', 'y'].includes(word)) {
            return word;
        }
        return word.charAt(0).toUpperCase() + word.slice(1);
    }).join(' ');
}

for (const line of lines) {
    const regex = /"([^"]*)"|([^,]+)/g;
    let match;
    const cols = [];
    while ((match = regex.exec(line)) !== null) {
        cols.push((match[1] || match[2]).trim());
    }
    
    if (cols.length >= 4) {
        const deptCode = cols[0];
        const deptName = titleCase(cols[1]);
        const cityCode = cols[2];
        const cityName = titleCase(cols[3]);
        
        departments.set(deptCode, deptName);
        cities.push({ deptCode, code: cityCode, name: cityName });
    }
}

let sql = `-- V22: Sincronizacion completa de DIVIPOLA (Departamentos y Municipios de Colombia)

-- 1. Desactivar todos los registros actuales de Colombia
UPDATE department_state SET is_active = FALSE WHERE country_iso2 = 'CO';
UPDATE city c 
JOIN department_state d ON c.department_state_id = d.id 
SET c.is_active = FALSE 
WHERE d.country_iso2 = 'CO';

-- 2. Insertar / Actualizar departamentos
INSERT INTO department_state (country_iso2, code, name, type, code_type, is_active) VALUES
`;

const deptValues = Array.from(departments.entries()).map(([code, name]) => {
    return `    ('CO', '${escapeSql(code)}', '${escapeSql(name)}', 'DEPARTMENT', 'DIVIPOLA', TRUE)`;
});
sql += deptValues.join(',\n') + '\nON DUPLICATE KEY UPDATE name = VALUES(name), is_active = TRUE;\n\n';

sql += `-- 3. Insertar / Actualizar municipios
INSERT INTO city (department_state_id, code, name, code_type, is_active)
SELECT d.id, v.code, v.name, 'DIVIPOLA', TRUE
FROM department_state d
JOIN (
`;

const cityValues = cities.map(c => `    SELECT '${escapeSql(c.deptCode)}' AS dept, '${escapeSql(c.code)}' AS code, '${escapeSql(c.name)}' AS name`);
sql += cityValues.join(' UNION ALL\n');

sql += `
) v ON v.dept = d.code
WHERE d.country_iso2 = 'CO'
ON DUPLICATE KEY UPDATE name = VALUES(name), is_active = TRUE;
`;

fs.writeFileSync(sqlPath, sql, 'utf8');
console.log(`Generated ${cities.length} cities and ${departments.size} departments in ${sqlPath}`);

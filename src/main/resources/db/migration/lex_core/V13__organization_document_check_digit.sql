-- Normalize the organization document: keep the check digit in its own column.
-- SD (legacy placeholder) applies only to persons, not organizations.

UPDATE app_organization
SET check_digit = SUBSTRING_INDEX(document_number, '-', -1),
    document_number = SUBSTRING_INDEX(document_number, '-', 1)
WHERE document_number LIKE '%-%'
  AND check_digit IS NULL;

UPDATE document_type
SET applies_to = 'PERSON'
WHERE code = 'SD';

-- Document type for the organization legal representative.

ALTER TABLE app_organization
    ADD COLUMN legal_representative_document_type VARCHAR(20) NULL AFTER legal_representative_name,
    ADD KEY idx_app_organization_legal_rep_doc_type (legal_representative_document_type),
    ADD CONSTRAINT fk_app_organization_legal_rep_doc_type FOREIGN KEY (legal_representative_document_type)
        REFERENCES document_type (code) ON DELETE RESTRICT ON UPDATE RESTRICT;

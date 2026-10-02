CREATE TABLE ${db_schema}.professionals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_type_id UUID NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    professional_type_id UUID NOT NULL,
    license_number VARCHAR(100),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    city_id UUID,
    contact_id UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by UUID,
    CONSTRAINT fk_professionals_document_type FOREIGN KEY (document_type_id) REFERENCES ${db_schema}.document_types(id),
    CONSTRAINT fk_professionals_professional_type FOREIGN KEY (professional_type_id) REFERENCES ${db_schema}.professional_types(id),
    CONSTRAINT fk_professionals_city FOREIGN KEY (city_id) REFERENCES ${db_schema}.city_municipalities(id),
    CONSTRAINT fk_professionals_contact FOREIGN KEY (contact_id) REFERENCES ${db_schema}.contacts(id),
    CONSTRAINT fk_professionals_created_by FOREIGN KEY (created_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_professionals_updated_by FOREIGN KEY (updated_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT uk_professionals_document UNIQUE (document_type_id, document_number),
    CONSTRAINT uk_professionals_license_number UNIQUE (license_number)
);

CREATE INDEX idx_professionals_professional_type_id ON ${db_schema}.professionals(professional_type_id);
CREATE INDEX idx_professionals_city_id ON ${db_schema}.professionals(city_id);
CREATE INDEX idx_professionals_contact_id ON ${db_schema}.professionals(contact_id);

ALTER TABLE ${db_schema}.contacts
    ADD CONSTRAINT fk_contacts_created_by FOREIGN KEY (created_by) REFERENCES ${db_schema}.professionals(id),
    ADD CONSTRAINT fk_contacts_updated_by FOREIGN KEY (updated_by) REFERENCES ${db_schema}.professionals(id);

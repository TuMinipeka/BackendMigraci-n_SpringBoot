CREATE TABLE ${db_schema}.patient_contacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contact_id UUID NOT NULL,
    patient_id UUID NOT NULL,
    is_primary_contact BOOLEAN NOT NULL DEFAULT FALSE,
    is_emergency_contact BOOLEAN NOT NULL DEFAULT FALSE,
    relationship_type_id UUID NOT NULL,
    CONSTRAINT fk_patient_contacts_contact FOREIGN KEY (contact_id) REFERENCES ${db_schema}.contacts(id),
    CONSTRAINT fk_patient_contacts_patient FOREIGN KEY (patient_id) REFERENCES ${db_schema}.patients(id) ON DELETE CASCADE,
    CONSTRAINT fk_patient_contacts_relationship_type FOREIGN KEY (relationship_type_id) REFERENCES ${db_schema}.relationship_types(id),
    CONSTRAINT uk_patient_contacts_patient_contact UNIQUE (patient_id, contact_id)
);

CREATE INDEX idx_patient_contacts_contact_id ON ${db_schema}.patient_contacts(contact_id);
CREATE INDEX idx_patient_contacts_patient_id ON ${db_schema}.patient_contacts(patient_id);

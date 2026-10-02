CREATE TABLE ${db_schema}.clinical_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL,
    creation_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    record_number VARCHAR(50) NOT NULL,
    opened_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP WITHOUT TIME ZONE,
    status_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    CONSTRAINT fk_clinical_records_patient FOREIGN KEY (patient_id) REFERENCES ${db_schema}.patients(id),
    CONSTRAINT fk_clinical_records_status FOREIGN KEY (status_id) REFERENCES ${db_schema}.clinical_record_statuses(id),
    CONSTRAINT fk_clinical_records_created_by FOREIGN KEY (created_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT uk_clinical_records_record_number UNIQUE (record_number)
);

CREATE INDEX idx_clinical_records_patient_id ON ${db_schema}.clinical_records(patient_id);
CREATE INDEX idx_clinical_records_status_id ON ${db_schema}.clinical_records(status_id);

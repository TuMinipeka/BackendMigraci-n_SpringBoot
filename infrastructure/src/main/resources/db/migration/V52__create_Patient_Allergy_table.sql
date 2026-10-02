CREATE TABLE ${db_schema}.patient_allergies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL,
    substance VARCHAR(200) NOT NULL,
    reaction TEXT,
    severity VARCHAR(20),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    recorded_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    recorded_by UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_patient_allergies_patient
        FOREIGN KEY (patient_id) REFERENCES ${db_schema}.patients(id) ON DELETE CASCADE,
    CONSTRAINT fk_patient_allergies_recorded_by
        FOREIGN KEY (recorded_by) REFERENCES ${db_schema}.professionals(id)
);

CREATE INDEX idx_patient_allergies_patient_id
    ON ${db_schema}.patient_allergies(patient_id);

CREATE INDEX idx_patient_allergies_recorded_by
    ON ${db_schema}.patient_allergies(recorded_by);

CREATE INDEX idx_patient_allergies_patient_active
    ON ${db_schema}.patient_allergies(patient_id, active);

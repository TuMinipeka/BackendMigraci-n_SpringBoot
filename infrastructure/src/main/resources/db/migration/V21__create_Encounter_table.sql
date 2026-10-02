CREATE TABLE ${db_schema}.encounters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clinical_record_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    encounter_type_id UUID NOT NULL,
    started_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    ended_at TIMESTAMP WITHOUT TIME ZONE,
    reason_for_visit TEXT,
    current_condition TEXT,
    modality_id UUID NOT NULL,
    status_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by UUID,
    CONSTRAINT fk_encounters_clinical_record FOREIGN KEY (clinical_record_id) REFERENCES ${db_schema}.clinical_records(id),
    CONSTRAINT fk_encounters_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_encounters_type FOREIGN KEY (encounter_type_id) REFERENCES ${db_schema}.encounter_types(id),
    CONSTRAINT fk_encounters_modality FOREIGN KEY (modality_id) REFERENCES ${db_schema}.encounter_modalities(id),
    CONSTRAINT fk_encounters_status FOREIGN KEY (status_id) REFERENCES ${db_schema}.encounter_statuses(id),
    CONSTRAINT fk_encounters_created_by FOREIGN KEY (created_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_encounters_updated_by FOREIGN KEY (updated_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT ck_encounters_dates CHECK (ended_at IS NULL OR ended_at >= started_at)
);

CREATE INDEX idx_encounters_clinical_record_id ON ${db_schema}.encounters(clinical_record_id);
CREATE INDEX idx_encounters_professional_id ON ${db_schema}.encounters(professional_id);

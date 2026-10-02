CREATE TABLE ${db_schema}.clinical_notes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    encounter_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    subjective TEXT,
    objective TEXT,
    assessment TEXT,
    plan TEXT,
    additional_notes TEXT,
    signed_at TIMESTAMP WITHOUT TIME ZONE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_clinical_notes_encounter FOREIGN KEY (encounter_id) REFERENCES ${db_schema}.encounters(id) ON DELETE CASCADE,
    CONSTRAINT fk_clinical_notes_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id)
);

CREATE INDEX idx_clinical_notes_encounter_id ON ${db_schema}.clinical_notes(encounter_id);

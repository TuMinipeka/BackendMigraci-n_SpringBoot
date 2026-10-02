CREATE TABLE ${db_schema}.risk_assessments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    encounter_id UUID NOT NULL,
    risk_level_id UUID NOT NULL,
    suicidal_ideation BOOLEAN NOT NULL DEFAULT FALSE,
    suicide_plan BOOLEAN NOT NULL DEFAULT FALSE,
    suicide_intent BOOLEAN NOT NULL DEFAULT FALSE,
    self_harm BOOLEAN NOT NULL DEFAULT FALSE,
    harm_to_others BOOLEAN NOT NULL DEFAULT FALSE,
    risk_factors TEXT,
    protective_factors TEXT,
    clinical_actions TEXT,
    observations TEXT,
    assessed_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    assessed_by UUID NOT NULL,
    CONSTRAINT fk_risk_assessments_encounter FOREIGN KEY (encounter_id) REFERENCES ${db_schema}.encounters(id) ON DELETE CASCADE,
    CONSTRAINT fk_risk_assessments_risk_level FOREIGN KEY (risk_level_id) REFERENCES ${db_schema}.risk_levels(id),
    CONSTRAINT fk_risk_assessments_assessed_by FOREIGN KEY (assessed_by) REFERENCES ${db_schema}.professionals(id)
);

CREATE INDEX idx_risk_assessments_encounter_id ON ${db_schema}.risk_assessments(encounter_id);
CREATE INDEX idx_risk_assessments_risk_level_id ON ${db_schema}.risk_assessments(risk_level_id);

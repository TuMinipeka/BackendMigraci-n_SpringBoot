CREATE TABLE ${db_schema}.treatment_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    encounter_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    treatment_status_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_treatment_plans_encounter FOREIGN KEY (encounter_id) REFERENCES ${db_schema}.encounters(id),
    CONSTRAINT fk_treatment_plans_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_treatment_plans_status FOREIGN KEY (treatment_status_id) REFERENCES ${db_schema}.treatment_statuses(id),
    CONSTRAINT ck_treatment_plans_dates CHECK (end_date IS NULL OR end_date >= start_date)
);

CREATE INDEX idx_treatment_plans_encounter_id ON ${db_schema}.treatment_plans(encounter_id);

CREATE TABLE ${db_schema}.treatment_goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    treatment_plan_id UUID NOT NULL,
    description TEXT NOT NULL,
    target_date DATE,
    completed_at TIMESTAMP WITHOUT TIME ZONE,
    notes TEXT,
    treatment_goal_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_treatment_goals_plan FOREIGN KEY (treatment_plan_id) REFERENCES ${db_schema}.treatment_plans(id) ON DELETE CASCADE,
    CONSTRAINT fk_treatment_goals_status FOREIGN KEY (treatment_goal_id) REFERENCES ${db_schema}.treatment_goal_statuses(id)
);

CREATE INDEX idx_treatment_goals_plan_id ON ${db_schema}.treatment_goals(treatment_plan_id);

CREATE TABLE ${db_schema}.ai_runs_statuses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_ai_runs_statuses_name UNIQUE (name_status)
);

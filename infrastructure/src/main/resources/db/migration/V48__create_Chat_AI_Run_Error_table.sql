CREATE TABLE ${db_schema}.chat_ai_run_errors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ai_run_id UUID NOT NULL,
    error_message TEXT NOT NULL,
    error_code VARCHAR(30),
    provider_error_id VARCHAR(120),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_ai_run_errors_run FOREIGN KEY (ai_run_id) REFERENCES ${db_schema}.chat_ai_runs(id) ON DELETE CASCADE
);

CREATE INDEX idx_chat_ai_run_errors_run_id ON ${db_schema}.chat_ai_run_errors(ai_run_id);

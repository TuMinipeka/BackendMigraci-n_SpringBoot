CREATE TABLE ${db_schema}.chat_ai_run_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ai_run_id UUID NOT NULL,
    prompt_tokens INTEGER NOT NULL DEFAULT 0,
    completion_tokens INTEGER NOT NULL DEFAULT 0,
    total_tokens INTEGER NOT NULL DEFAULT 0,
    cost DECIMAL(10,6) NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_ai_run_metrics_run FOREIGN KEY (ai_run_id) REFERENCES ${db_schema}.chat_ai_runs(id) ON DELETE CASCADE,
    CONSTRAINT uk_chat_ai_run_metrics_run UNIQUE (ai_run_id),
    CONSTRAINT ck_chat_ai_run_metrics_values CHECK (prompt_tokens >= 0 AND completion_tokens >= 0 AND total_tokens >= 0 AND cost >= 0)
);

CREATE TABLE ${db_schema}.chat_ai_runs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL,
    message_id UUID,
    model_id UUID NOT NULL,
    ai_run_status_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_ai_runs_conversation FOREIGN KEY (conversation_id) REFERENCES ${db_schema}.chat_conversations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_ai_runs_message FOREIGN KEY (message_id) REFERENCES ${db_schema}.chat_messages(id),
    CONSTRAINT fk_chat_ai_runs_model FOREIGN KEY (model_id) REFERENCES ${db_schema}.ai_models(id),
    CONSTRAINT fk_chat_ai_runs_status FOREIGN KEY (ai_run_status_id) REFERENCES ${db_schema}.ai_runs_statuses(id)
);

CREATE INDEX idx_chat_ai_runs_conversation_id ON ${db_schema}.chat_ai_runs(conversation_id);
CREATE INDEX idx_chat_ai_runs_message_id ON ${db_schema}.chat_ai_runs(message_id);

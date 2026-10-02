CREATE TABLE ${db_schema}.chat_conversation_ai_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL,
    ai_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    default_model_id UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_ai_settings_conversation FOREIGN KEY (conversation_id) REFERENCES ${db_schema}.chat_conversations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_ai_settings_default_model FOREIGN KEY (default_model_id) REFERENCES ${db_schema}.ai_models(id),
    CONSTRAINT uk_chat_ai_settings_conversation UNIQUE (conversation_id)
);

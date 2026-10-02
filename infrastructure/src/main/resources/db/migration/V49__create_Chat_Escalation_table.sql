CREATE TABLE ${db_schema}.chat_escalations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL,
    status_id UUID NOT NULL,
    from_ai BOOLEAN NOT NULL DEFAULT FALSE,
    reason TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_escalations_conversation FOREIGN KEY (conversation_id) REFERENCES ${db_schema}.chat_conversations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_escalations_status FOREIGN KEY (status_id) REFERENCES ${db_schema}.escalations_statuses(id)
);

CREATE INDEX idx_chat_escalations_conversation_id ON ${db_schema}.chat_escalations(conversation_id);
CREATE INDEX idx_chat_escalations_status_id ON ${db_schema}.chat_escalations(status_id);

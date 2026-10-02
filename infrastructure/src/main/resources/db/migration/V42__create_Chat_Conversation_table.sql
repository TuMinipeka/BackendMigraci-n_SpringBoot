CREATE TABLE ${db_schema}.chat_conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_status_id UUID NOT NULL,
    priority_id UUID,
    last_message_at TIMESTAMP WITHOUT TIME ZONE,
    closed BOOLEAN NOT NULL DEFAULT FALSE,
    closed_at TIMESTAMP WITHOUT TIME ZONE,
    closed_by UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_conversations_status FOREIGN KEY (conversation_status_id) REFERENCES ${db_schema}.conversation_statuses(id),
    CONSTRAINT fk_chat_conversations_priority FOREIGN KEY (priority_id) REFERENCES ${db_schema}.priorities(id),
    CONSTRAINT fk_chat_conversations_closed_by FOREIGN KEY (closed_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT ck_chat_conversations_closed CHECK ((closed = FALSE AND closed_at IS NULL) OR closed = TRUE)
);

CREATE INDEX idx_chat_conversations_status_id ON ${db_schema}.chat_conversations(conversation_status_id);
CREATE INDEX idx_chat_conversations_priority_id ON ${db_schema}.chat_conversations(priority_id);

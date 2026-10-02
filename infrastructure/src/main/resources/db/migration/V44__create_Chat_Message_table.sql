CREATE TABLE ${db_schema}.chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL,
    message_type_id UUID NOT NULL,
    participant_id UUID NOT NULL,
    content JSONB NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_messages_conversation FOREIGN KEY (conversation_id) REFERENCES ${db_schema}.chat_conversations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_messages_type FOREIGN KEY (message_type_id) REFERENCES ${db_schema}.message_types(id),
    CONSTRAINT fk_chat_messages_participant FOREIGN KEY (participant_id) REFERENCES ${db_schema}.chat_participants(id)
);

CREATE INDEX idx_chat_messages_conversation_created_at ON ${db_schema}.chat_messages(conversation_id, created_at);
CREATE INDEX idx_chat_messages_participant_id ON ${db_schema}.chat_messages(participant_id);
CREATE INDEX idx_chat_messages_content_gin ON ${db_schema}.chat_messages USING GIN(content);

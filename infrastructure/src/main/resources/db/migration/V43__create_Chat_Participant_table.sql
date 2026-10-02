CREATE TABLE ${db_schema}.chat_participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL,
    participant_type_id UUID NOT NULL,
    patient_id UUID,
    professional_id UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_participants_conversation FOREIGN KEY (conversation_id) REFERENCES ${db_schema}.chat_conversations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_participants_type FOREIGN KEY (participant_type_id) REFERENCES ${db_schema}.sender_types(id),
    CONSTRAINT fk_chat_participants_patient FOREIGN KEY (patient_id) REFERENCES ${db_schema}.patients(id),
    CONSTRAINT fk_chat_participants_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT ck_chat_participants_actor CHECK (num_nonnulls(patient_id, professional_id) <= 1)
);

CREATE INDEX idx_chat_participants_conversation_id ON ${db_schema}.chat_participants(conversation_id);
CREATE INDEX idx_chat_participants_patient_id ON ${db_schema}.chat_participants(patient_id);
CREATE INDEX idx_chat_participants_professional_id ON ${db_schema}.chat_participants(professional_id);

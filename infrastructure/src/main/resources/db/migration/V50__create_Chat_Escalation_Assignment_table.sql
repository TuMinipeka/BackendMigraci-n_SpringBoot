CREATE TABLE ${db_schema}.chat_escalation_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    escalation_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    assigned_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_escalation_assignments_escalation FOREIGN KEY (escalation_id) REFERENCES ${db_schema}.chat_escalations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_escalation_assignments_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT uk_chat_escalation_assignments UNIQUE (escalation_id, professional_id)
);

CREATE INDEX idx_chat_escalation_assignments_escalation_id ON ${db_schema}.chat_escalation_assignments(escalation_id);

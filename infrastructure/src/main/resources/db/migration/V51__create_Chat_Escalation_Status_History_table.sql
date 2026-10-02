CREATE TABLE ${db_schema}.chat_escalation_status_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    escalation_id UUID NOT NULL,
    escalation_status_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_chat_escalation_history_escalation FOREIGN KEY (escalation_id) REFERENCES ${db_schema}.chat_escalations(id) ON DELETE CASCADE,
    CONSTRAINT fk_chat_escalation_history_status FOREIGN KEY (escalation_status_id) REFERENCES ${db_schema}.escalations_statuses(id)
);

CREATE INDEX idx_chat_escalation_history_escalation_id ON ${db_schema}.chat_escalation_status_history(escalation_id);

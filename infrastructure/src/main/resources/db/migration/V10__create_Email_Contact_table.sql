CREATE TABLE ${db_schema}.email_contacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contact_id UUID NOT NULL,
    email VARCHAR(150) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_email_contacts_contact FOREIGN KEY (contact_id) REFERENCES ${db_schema}.contacts(id) ON DELETE CASCADE,
    CONSTRAINT uk_email_contacts_contact_email UNIQUE (contact_id, email)
);

CREATE INDEX idx_email_contacts_contact_id ON ${db_schema}.email_contacts(contact_id);

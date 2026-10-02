CREATE TABLE ${db_schema}.phone_contacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contact_id UUID NOT NULL,
    phone VARCHAR(30) NOT NULL,
    notes TEXT,
    CONSTRAINT fk_phone_contacts_contact FOREIGN KEY (contact_id) REFERENCES ${db_schema}.contacts(id) ON DELETE CASCADE,
    CONSTRAINT uk_phone_contacts_contact_phone UNIQUE (contact_id, phone)
);

CREATE INDEX idx_phone_contacts_contact_id ON ${db_schema}.phone_contacts(contact_id);

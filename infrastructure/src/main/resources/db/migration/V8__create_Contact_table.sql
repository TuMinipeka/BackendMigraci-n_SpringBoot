CREATE TABLE ${db_schema}.contacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(150),
    notes TEXT,
    city_id UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by UUID,
    CONSTRAINT fk_contacts_city FOREIGN KEY (city_id) REFERENCES ${db_schema}.city_municipalities(id)
);

CREATE INDEX idx_contacts_city_id ON ${db_schema}.contacts(city_id);

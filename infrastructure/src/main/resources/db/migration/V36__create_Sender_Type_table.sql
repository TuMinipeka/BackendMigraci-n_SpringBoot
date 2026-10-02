CREATE TABLE ${db_schema}.sender_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_sender_types_name UNIQUE (name_type)
);

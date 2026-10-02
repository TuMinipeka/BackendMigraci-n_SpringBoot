CREATE TABLE ${db_schema}.relationship_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    description VARCHAR(50) NOT NULL,
    CONSTRAINT uk_relationship_types_description UNIQUE (description)
);

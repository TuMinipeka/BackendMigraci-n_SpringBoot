CREATE TABLE ${db_schema}.state_regions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_region VARCHAR(50) NOT NULL,
    code_region VARCHAR(10) NOT NULL,
    description VARCHAR(100),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    country_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_state_regions_country FOREIGN KEY (country_id) REFERENCES ${db_schema}.countries(id),
    CONSTRAINT uk_state_regions_country_code UNIQUE (country_id, code_region)
);

CREATE INDEX idx_state_regions_country_id ON ${db_schema}.state_regions(country_id);

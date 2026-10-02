CREATE TABLE ${db_schema}.city_municipalities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_city VARCHAR(50) NOT NULL,
    code_city VARCHAR(10) NOT NULL,
    description VARCHAR(100),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    region_id UUID NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_city_municipalities_region FOREIGN KEY (region_id) REFERENCES ${db_schema}.state_regions(id),
    CONSTRAINT uk_city_municipalities_region_code UNIQUE (region_id, code_city)
);

CREATE INDEX idx_city_municipalities_region_id ON ${db_schema}.city_municipalities(region_id);

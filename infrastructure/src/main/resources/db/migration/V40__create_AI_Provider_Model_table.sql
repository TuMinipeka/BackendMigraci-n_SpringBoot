CREATE TABLE ${db_schema}.provider_models_ai (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_provider_ai VARCHAR(100) NOT NULL,
    razon_social VARCHAR(100),
    sitio_web TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_provider_models_ai_name UNIQUE (name_provider_ai)
);

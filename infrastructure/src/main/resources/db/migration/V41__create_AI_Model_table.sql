CREATE TABLE ${db_schema}.ai_models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_model_id UUID NOT NULL,
    name_model VARCHAR(100) NOT NULL,
    model_key VARCHAR(120) NOT NULL,
    input_token_price DECIMAL(12,8) NOT NULL DEFAULT 0,
    output_token_price DECIMAL(12,8) NOT NULL DEFAULT 0,
    max_tokens INTEGER,
    context_window INTEGER,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ai_models_provider FOREIGN KEY (provider_model_id) REFERENCES ${db_schema}.provider_models_ai(id),
    CONSTRAINT uk_ai_models_provider_key UNIQUE (provider_model_id, model_key),
    CONSTRAINT ck_ai_models_prices CHECK (input_token_price >= 0 AND output_token_price >= 0),
    CONSTRAINT ck_ai_models_tokens CHECK (max_tokens IS NULL OR max_tokens >= 0),
    CONSTRAINT ck_ai_models_context_window CHECK (context_window IS NULL OR context_window >= 0)
);

CREATE INDEX idx_ai_models_provider_model_id ON ${db_schema}.ai_models(provider_model_id);

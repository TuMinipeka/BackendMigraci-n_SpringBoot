CREATE TABLE ${db_schema}.professional_studies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    study_id UUID NOT NULL,
    professional_id UUID NOT NULL,
    title VARCHAR(100) NOT NULL,
    university VARCHAR(100),
    is_valid BOOLEAN NOT NULL DEFAULT TRUE,
    resolution_number VARCHAR(60),
    country_id UUID,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_professional_studies_study FOREIGN KEY (study_id) REFERENCES ${db_schema}.studies(id),
    CONSTRAINT fk_professional_studies_professional FOREIGN KEY (professional_id) REFERENCES ${db_schema}.professionals(id) ON DELETE CASCADE,
    CONSTRAINT fk_professional_studies_country FOREIGN KEY (country_id) REFERENCES ${db_schema}.countries(id),
    CONSTRAINT uk_professional_studies UNIQUE (professional_id, study_id, title)
);

CREATE INDEX idx_professional_studies_study_id ON ${db_schema}.professional_studies(study_id);
CREATE INDEX idx_professional_studies_professional_id ON ${db_schema}.professional_studies(professional_id);

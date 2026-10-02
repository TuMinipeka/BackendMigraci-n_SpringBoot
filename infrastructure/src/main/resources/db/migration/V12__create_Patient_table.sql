CREATE TABLE ${db_schema}.patients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_type_id UUID NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    second_last_name VARCHAR(50),
    birth_date DATE NOT NULL,
    biological_sex_id UUID,
    gender_identity UUID,
    email VARCHAR(150),
    phone VARCHAR(30),
    address VARCHAR(250),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by UUID,
    city_id UUID,
    CONSTRAINT fk_patients_document_type FOREIGN KEY (document_type_id) REFERENCES ${db_schema}.document_types(id),
    CONSTRAINT fk_patients_biological_sex FOREIGN KEY (biological_sex_id) REFERENCES ${db_schema}.genders(id),
    CONSTRAINT fk_patients_gender_identity FOREIGN KEY (gender_identity) REFERENCES ${db_schema}.genders(id),
    CONSTRAINT fk_patients_created_by FOREIGN KEY (created_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_patients_updated_by FOREIGN KEY (updated_by) REFERENCES ${db_schema}.professionals(id),
    CONSTRAINT fk_patients_city FOREIGN KEY (city_id) REFERENCES ${db_schema}.city_municipalities(id),
    CONSTRAINT uk_patients_document UNIQUE (document_type_id, document_number)
);

CREATE INDEX idx_patients_biological_sex_id ON ${db_schema}.patients(biological_sex_id);
CREATE INDEX idx_patients_gender_identity ON ${db_schema}.patients(gender_identity);
CREATE INDEX idx_patients_city_id ON ${db_schema}.patients(city_id);

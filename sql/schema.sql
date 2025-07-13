DROP TABLE IF EXISTS appointment_procedure;
DROP TABLE IF EXISTS appointment;
DROP TABLE IF EXISTS dentist;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS procedure;

CREATE TABLE procedure
(
    id          BIGSERIAL,
    name        VARCHAR(100),
    description VARCHAR(200),
    --------------------------------------------------
    CONSTRAINT procedure_id_pk PRIMARY KEY (id),
    CONSTRAINT procedure_name_uk UNIQUE (name),
    CONSTRAINT procedure_name_nn CHECK ( name IS NOT NULL),
    CONSTRAINT procedure_desc_nn CHECK (description IS NOT NULL)
);

CREATE TABLE client
(
    id         BIGSERIAL,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    email      VARCHAR(50),
    nickname   VARCHAR(50),
    password   VARCHAR(200),
    is_admin   BOOLEAN
    ----------------------------------------------------------
    CONSTRAINT client_id_pk PRIMARY KEY (id),
    CONSTRAINT client_email_uk UNIQUE (email),
    CONSTRAINT client_email_nn CHECK ( email IS NOT NULL ),
    CONSTRAINT client_nickname_uk UNIQUE (nickname),
    CONSTRAINT client_nickname_nn CHECK ( nickname IS NOT NULL ),
    CONSTRAINT client_password_nn CHECK ( password IS NOT NULL )
);

CREATE TABLE dentist
(
    id         BIGSERIAL,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    email      VARCHAR(50),
    ------------------------------------------------------------------
    CONSTRAINT dentist_id_pk PRIMARY KEY (id),
    CONSTRAINT dentist_first_name_nn CHECK ( first_name IS NOT NULL ),
    CONSTRAINT dentist_last_name_nn CHECK (last_name IS NOT NULL),
    CONSTRAINT dentist_email_uk UNIQUE (email),
    CONSTRAINT dentist_email_nn CHECK ( email IS NOT NULL )
);

CREATE TABLE appointment
(
    id               BIGSERIAL,
    client_id        BIGINT,
    dentist_id       BIGINT,
    appointment_date DATE,
    appointment_time TIME,
    ---------------------------------------------------------------------------
    CONSTRAINT appointment_id_pk PRIMARY KEY (id),
    CONSTRAINT client_id_fk FOREIGN KEY (client_id) REFERENCES client (id),
    CONSTRAINT client_id_nn CHECK ( client_id IS NOT NULL ),
    CONSTRAINT dentist_id_fk FOREIGN KEY (dentist_id) REFERENCES dentist (id),
    CONSTRAINT dentist_id_nn CHECK ( dentist_id IS NOT NULL ),
    CONSTRAINT appointment_daytime_nn CHECK ( appointment_date IS NOT NULL )
);

CREATE TABLE appointment_procedure
(
    id             BIGSERIAL,
    appointment_id BIGINT,
    procedure_id   BIGINT,
    --------------------------------------------------------------------------------------
    CONSTRAINT id_pk PRIMARY KEY (id),
    CONSTRAINT appointment_id_fk FOREIGN KEY (appointment_id) REFERENCES appointment (id),
    CONSTRAINT appointment_id_nn CHECK ( appointment_id IS NOT NULL ),
    CONSTRAINT procedure_id_fk FOREIGN KEY (procedure_id) REFERENCES procedure (id),
    CONSTRAINT procedure_id_nn CHECK ( procedure_id IS NOT NULL )
);
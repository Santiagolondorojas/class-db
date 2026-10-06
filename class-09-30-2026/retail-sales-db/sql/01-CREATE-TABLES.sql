-- =============================================================================
-- Retails Sales and Inventory Management System
-- =============================================================================

-- =============================================================================
-- Geography
-- =============================================================================

-- Table country
CREATE TABLE country (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    iso2_code                   VARCHAR(2) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Department
CREATE TABLE department (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    country                     INT NOT NULL REFERENCES country (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table City
CREATE TABLE city (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    department                  INT NOT NULL REFERENCES department (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Catalog
-- =============================================================================

-- Table user type
CREATE TABLE user_type (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type                        VARCHAR(30)  NOT NULL UNIQUE,
    description                 VARCHAR(200) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table role
CREATE TABLE role (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(30)  NOT NULL UNIQUE,
    description                 VARCHAR(200) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table document type
CREATE TABLE document_type (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table payment method
CREATE TABLE payment_method (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table payment status
CREATE TABLE payment_status (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table type inventory transfer
CREATE TABLE type_inventory_transfer (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table category
CREATE TABLE category (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table phone
CREATE TABLE phone (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    number                      VARCHAR(20) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Suppliers and Stores
-- =============================================================================

-- Table store
CREATE TABLE store (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
    store_number                VARCHAR(20) NOT NULL UNIQUE,
    name                        VARCHAR(100) NOT NULL,
    email                       VARCHAR(100) NOT NULL UNIQUE,      
    address                     VARCHAR(100) NOT NULL,
    city                        INT NOT NULL REFERENCES city (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP           
)

-- Table suplier
CREATE TABLE suplier (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NO NULL,
    nit                         VARCHAR(30) NO NULL UNIQUE,
    email                       VARCHAR(100) NO NULL UNIQUE,
    address                     VARCHAR(100) NOT NULL,
    city                        INT NOT NULL REFERENCES city (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP     
)

-- =============================================================================
-- users
-- =============================================================================

-- Table user
CREATE TABLE user (
    id                           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    document_number              VARCHAR(20) NOT NULL UNIQUE,
    document_type                INT NOT NULL REFERENCES document_type (id),
    user_type                    INT NOT NULL REFERENCES user_type (id),
    first_name                   VARCHAR(50) NOT NULL,
    middle_name                  VARCHAR(50),
    first_lastname               VARCHAR(50) NOT NULL,
    second_lastname              VARCHAR(50),
    email                        VARCHAR(100) NOT NULL UNIQUE,
    address                      VARCHAR(100) NOT NULL,
    description                  VARCHAR(200) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP     
)

-- Table customer
CREATE TABLE customer (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_data                   INT NOT NULL REFERENCES user (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
) 

-- Table employee
CREATE TABLE employee (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_data                   INT NOT NULL REFERENCES user (id),
    number                      VARCHAR(10) NOT NULL UNIQUE,    
    role                        INT NOT NULL REFERENCES role (id),
    store                       INT NOT NULL REFERENCES store (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP       
)

-- =============================================================================
-- product
-- =============================================================================

-- Table product
CREATE TABLE product (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku                         VARCHAR(20) NOT NULL UNIQUE,
    name                        VARCHAR(50) NO NULL,
    description                 TEXT NOT NULL,
    details                     JSON NOT NULL,
    suplier_id                  INT NOT NULL REFERENCES suplier (id),
    unit_price                  NUMERIC(10,2) CHECK,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Table product_category
CREATE TABLE product_category (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id                  INT NOT NULL UNIQUE REFERENCES product (id),
    category_id                 INT NOT NULL UNIQUE REFERENCES category (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
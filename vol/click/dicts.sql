-- product brands, vid=1
CREATE DICTIONARY IF NOT EXISTS product_brands
(
    id   UInt64,
    name String,
    descriptor String
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT t.tid AS id, t.name AS name, COALESCE(d.field_descriptor_value, "") as descriptor FROM taxonomy_term_data t LEFT JOIN field_data_field_descriptor d ON t.tid = d.entity_id AND d.bundle="manufacturer" WHERE t.vid=1'
            ))
    LIFETIME(MIN 360 MAX 1440) LAYOUT(FLAT());

-- product categories, vid=2
CREATE DICTIONARY IF NOT EXISTS product_categories
(
    id   UInt64,
    name String,
    descriptor String
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT t.tid AS id, t.name AS name, COALESCE(d.field_descriptor_value, "") as descriptor FROM taxonomy_term_data t LEFT JOIN field_data_field_descriptor d ON t.tid = d.entity_id AND d.bundle="product_types" WHERE t.vid=2'
            ))
    LIFETIME(MIN 360 MAX 1440) LAYOUT(FLAT());

-- company, eck_company
CREATE DICTIONARY IF NOT EXISTS company_branches
(
    id   UInt64,
    name String,
    descriptor String,
    disabled UInt16
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT id, descriptor, name, archived as disabled FROM eck_company'
            ))
    LIFETIME(MIN 1440 MAX 14440) LAYOUT(FLAT());

-- partner, eck_partner
CREATE DICTIONARY IF NOT EXISTS company_suppliers
(
    id   UInt64,
    name String,
    commission Float32,
    disabled UInt16
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT id, title as name, margin as commission, disabled FROM eck_partner'
            ))
    LIFETIME(MIN 1440 MAX 14440) LAYOUT(FLAT());


-- partner, eck_refuse_reason
CREATE DICTIONARY IF NOT EXISTS request_cancellation_reasons
(
    id   UInt64,
    name String,
    descriptor String,
    description String,
    disabled UInt16
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT id, name, descriptor, description, archived as disabled FROM eck_refuse_reason'
            ))
    LIFETIME(MIN 1440 MAX 14440) LAYOUT(FLAT());

-- partner, eck_refuse_reason
CREATE DICTIONARY IF NOT EXISTS request_statuses
(
    id   UInt64,
    name String,
    descriptor String
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT id, name, descriptor FROM eck_allowed_values where field_name="field_status"'
            ))
    LIFETIME(MIN 1440 MAX 14440) LAYOUT(FLAT());

-- client profile, eck_allowed_values
CREATE DICTIONARY IF NOT EXISTS client_profiles
(
    id   UInt64,
    name String,
    descriptor String
)
    PRIMARY KEY id
    SOURCE (MYSQL(
            host 'ss-mysql'
            port 3306
            user 'click'
            password 'nopass'
            db 'ss'
            query 'SELECT id, name, descriptor FROM eck_allowed_values where field_name="field_profile"'
            ))
    LIFETIME(MIN 1440 MAX 14440) LAYOUT(FLAT());

CREATE TABLE IF NOT EXISTS attendance_details
(
    attendance_register_id BIGINT,
    org_unit_id BIGINT,
    user_id BIGINT,
    register_name TEXT,
    session_name TEXT,
    percentage DECIMAL,
    symbol TEXT,
    UNIQUE (attendance_register_id, org_unit_id, user_id, register_name, session_name, percentage, symbol)
)

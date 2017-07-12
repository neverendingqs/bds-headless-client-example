CREATE TABLE IF NOT EXISTS user_logins
(
    org_id BIGINT,
    user_id BIGINT,
    user_name TEXT,
    ip TEXT,
    session_id BIGINT,
    status_type TEXT,
    attempt_date TIMESTAMP,
    impersonating_user_id BIGINT,
    time_off BIGINT,
    UNIQUE (org_id, user_id, user_name, ip, session_id, status_type, attempt_date, impersonating_user_id, time_off)
)

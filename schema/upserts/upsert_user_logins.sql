INSERT INTO user_logins
    SELECT DISTINCT
        org_id,
        user_id,
        user_name,
        ip,
        session_id,
        status_type,
        attempt_date,
        impersonating_user_id,
        time_off
    FROM tmp_user_logins
ON CONFLICT ON CONSTRAINT user_logins_org_id_user_id_user_name_ip_session_id_status_t_key
DO NOTHING

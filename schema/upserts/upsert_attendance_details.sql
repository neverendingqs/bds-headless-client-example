INSERT INTO attendance_details
    SELECT DISTINCT
        attendance_register_id,
        org_unit_id,
        user_id,
        register_name,
        session_name,
        percentage,
        symbol
    FROM tmp_attendance_details
ON CONFLICT ON CONSTRAINT attendance_details_attendance_register_id_org_unit_id_user__key
DO NOTHING

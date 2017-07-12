INSERT INTO content_user_completion
    SELECT
        content_object_id,
        org_unit_id,
        user_id,
        date_completed
    FROM tmp_content_user_completion
ON CONFLICT ON CONSTRAINT content_user_completion_pkey
DO UPDATE SET
    date_completed = EXCLUDED.date_completed

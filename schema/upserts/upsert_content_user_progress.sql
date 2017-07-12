INSERT INTO content_user_progress
    SELECT
        content_object_id,
        user_id,
        completed_date,
        last_visited,
        is_read,
        num_real_visits,
        num_fake_visits,
        total_time,
        is_visited,
        is_current_bookmark,
        is_self_assessment_complete
    FROM tmp_content_user_progress
ON CONFLICT ON CONSTRAINT content_user_progress_pkey
DO UPDATE SET
    completed_date = EXCLUDED.completed_date,
    last_visited = EXCLUDED.last_visited,
    is_read = EXCLUDED.is_read,
    num_real_visits = EXCLUDED.num_real_visits,
    num_fake_visits = EXCLUDED.num_fake_visits,
    total_time = EXCLUDED.total_time,
    is_visited = EXCLUDED.is_visited,
    is_current_bookmark = EXCLUDED.is_current_bookmark,
    is_self_assessment_complete = EXCLUDED.is_self_assessment_complete

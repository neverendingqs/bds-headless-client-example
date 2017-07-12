INSERT INTO assignment_submissions
    SELECT
        dropbox_id,
        org_unit_id,
        user_id,
        group_id,
        file_submission_count,
        total_file_size,
        feedback_user_id,
        feedback_is_read,
        score,
        is_graded,
        grade_item_id,
        last_submission_date,
        feedback,
        feedback_last_modified,
        feedback_read_date
    FROM tmp_assignment_submissions
ON CONFLICT ON CONSTRAINT assignment_submissions_dropbox_id_org_unit_id_user_id_group_key
DO UPDATE SET
    user_id = EXCLUDED.user_id,
    group_id = EXCLUDED.group_id,
    file_submission_count = EXCLUDED.file_submission_count,
    total_file_size = EXCLUDED.total_file_size,
    feedback_user_id = EXCLUDED.feedback_user_id,
    feedback_is_read = EXCLUDED.feedback_is_read,
    score = EXCLUDED.score,
    is_graded = EXCLUDED.is_graded,
    grade_item_id = EXCLUDED.grade_item_id,
    last_submission_date = EXCLUDED.last_submission_date,
    feedback = EXCLUDED.feedback,
    feedback_last_modified = EXCLUDED.feedback_last_modified,
    feedback_read_date = EXCLUDED.feedback_read_date

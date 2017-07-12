CREATE TABLE IF NOT EXISTS assignment_submissions
(
    dropbox_id BIGINT,
    org_unit_id BIGINT,
    user_id BIGINT,
    group_id BIGINT,
    file_submission_count BIGINT,
    total_file_size BIGINT,
    feedback_user_id BIGINT,
    feedback_is_read BOOLEAN,
    score DECIMAL,
    is_graded BOOLEAN,
    grade_item_id BIGINT,
    last_submission_date TIMESTAMP,
    feedback TEXT,
    feedback_last_modified TEXT,
    feedback_read_date TIMESTAMP,
    UNIQUE (dropbox_id, org_unit_id, user_id, group_id)
)

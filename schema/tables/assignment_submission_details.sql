CREATE TABLE IF NOT EXISTS assignment_submission_details
(
    submission_id BIGINT PRIMARY KEY,
    dropbox_id BIGINT,
    user_id BIGINT,
    group_id BIGINT,
    number_of_files_submitted INT,
    total_file_size BIGINT,
    submitted_by_user_id BIGINT,
    date_submitted TIMESTAMP,
    comments TEXT,
    is_turn_it_in_exempt BOOLEAN,
    is_deleted BOOLEAN,
    is_preview BOOLEAN
)

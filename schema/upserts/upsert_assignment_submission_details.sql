INSERT INTO assignment_submission_details
    SELECT
        submission_id,
        dropbox_id,
        user_id,
        group_id,
        number_of_files_submitted,
        total_file_size,
        submitted_by_user_id,
        date_submitted,
        comments,
        is_deleted,
        is_preview
    FROM tmp_assignment_submission_details
ON CONFLICT ON CONSTRAINT assignment_submission_details_pkey
DO UPDATE SET
    dropbox_id = EXCLUDED.dropbox_id,
    user_id = EXCLUDED.user_id,
    group_id = EXCLUDED.group_id,
    number_of_files_submitted = EXCLUDED.number_of_files_submitted,
    total_file_size = EXCLUDED.total_file_size,
    submitted_by_user_id = EXCLUDED.submitted_by_user_id,
    date_submitted = EXCLUDED.date_submitted,
    comments = EXCLUDED.comments,
    is_deleted = EXCLUDED.is_deleted,
    is_preview = EXCLUDED.is_preview

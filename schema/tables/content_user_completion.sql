CREATE TABLE IF NOT EXISTS content_user_completion
(
    content_object_id BIGINT,
    org_unit_id BIGINT,
    user_id BIGINT,
    date_completed TIMESTAMP,
    PRIMARY KEY (content_object_id, org_unit_id, user_id)
)

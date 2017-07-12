CREATE TABLE IF NOT EXISTS content_user_progress
(
    content_object_id BIGINT,
    user_id BIGINT,
    completed_date TIMESTAMP,
    last_visited TIMESTAMP,
    is_read BOOLEAN,
    num_real_visits BIGINT,
    num_fake_visits BIGINT,
    total_time BIGINT,
    is_visited BOOLEAN,
    is_current_bookmark BOOLEAN,
    is_self_assessment_complete BOOLEAN,
    PRIMARY KEY (content_object_id, user_id)
)

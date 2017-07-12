CREATE TABLE IF NOT EXISTS quiz_attempts
(
    attempt_id BIGINT,
    quiz_id BIGINT,
    user_id BIGINT,
    org_unit_id BIGINT,
    quiz_name TEXT,
    attempt_number BIGINT,
    time_started TIMESTAMP,
    time_completed TIMESTAMP,
    score DECIMAL,
    possible_score DECIMAL,
    is_graded BOOLEAN,
    grade_item_id BIGINT,
    PRIMARY KEY (attempt_id, quiz_id, user_id)
)

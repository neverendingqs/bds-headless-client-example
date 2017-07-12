CREATE TABLE IF NOT EXISTS quiz_user_answers
(
    attempt_id BIGINT,
    question_id BIGINT,
    question_version_id BIGINT,
    time_completed TIMESTAMP,
    question_number BIGINT,
    comment TEXT,
    sort_order BIGINT,
    score TEXT,
    page BIGINT,
    PRIMARY KEY (attempt_id, question_id, question_version_id)
)

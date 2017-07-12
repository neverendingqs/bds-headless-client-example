CREATE TABLE IF NOT EXISTS quiz_user_answer_responses
(
    attempt_id BIGINT,
    attempt_number BIGINT,
    question_id BIGINT,
    question_version_id BIGINT,
    answer_id BIGINT,
    sort_order BIGINT,
    is_correct BOOLEAN,
    user_selection BIGINT,
    user_answer TEXT,
    PRIMARY KEY (attempt_id, question_id, question_version_id, answer_id)
)

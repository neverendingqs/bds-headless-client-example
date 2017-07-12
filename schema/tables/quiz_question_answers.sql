CREATE TABLE IF NOT EXISTS quiz_question_answers
(
    answer_id BIGINT,
    question_id BIGINT,
    question_version_id BIGINT,
    sort_order BIGINT,
    is_correct BOOLEAN,
    weight DECIMAL,
    answer TEXT,
    comment TEXT,
    description TEXT,
    PRIMARY KEY (answer_id, question_id, question_version_id)
)

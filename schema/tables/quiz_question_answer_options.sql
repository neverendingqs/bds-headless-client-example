CREATE TABLE IF NOT EXISTS quiz_question_answer_options
(
    answer_id BIGINT,
    answer_text TEXT,
    weight DECIMAL,
    question_id BIGINT,
    question_version_id BIGINT,
    PRIMARY KEY (answer_id, question_id, question_version_id) --, answer_text)
)

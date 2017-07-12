CREATE TABLE IF NOT EXISTS quiz_questions
(
    quiz_id BIGINT,
    sort_order BIGINT,
    created_date TIMESTAMP,
    difficulty BIGINT,
    is_bonus BOOLEAN,
    is_mandatory BOOLEAN,
    is_auto_graded BOOLEAN,
    section_name TEXT,
    last_modified TIMESTAMP,
    points DECIMAL,
    question_id BIGINT,
    question_version_id BIGINT,
    question_type TEXT,
    name TEXT,
    question TEXT,
    comment TEXT,
    answer_key TEXT,
    PRIMARY KEY (quiz_id, sort_order, question_id, question_version_id, created_date, last_modified)
)

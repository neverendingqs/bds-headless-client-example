INSERT INTO quiz_question_answer_options
    SELECT
        answer_id,
        answer_text,
        weight,
        question_id,
        question_version_id
    FROM tmp_quiz_question_answer_options
ON CONFLICT ON CONSTRAINT quiz_question_answer_options_pkey
DO NOTHING

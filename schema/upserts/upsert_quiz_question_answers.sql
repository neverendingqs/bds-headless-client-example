INSERT INTO quiz_question_answers
    SELECT DISTINCT
        answer_id,
        question_id,
        question_version_id,
        sort_order,
        is_correct,
        weight,
        answer,
        comment,
        description
    FROM tmp_quiz_question_answers
ON CONFLICT ON CONSTRAINT quiz_question_answers_pkey
DO UPDATE SET
    sort_order = EXCLUDED.sort_order,
    is_correct = EXCLUDED.is_correct,
    weight = EXCLUDED.weight,
    answer = EXCLUDED.answer,
    comment = EXCLUDED.comment,
    description = EXCLUDED.description

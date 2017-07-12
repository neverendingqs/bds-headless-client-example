INSERT INTO quiz_user_answers
    SELECT
        attempt_id,
        question_id,
        question_version_id,
        time_completed,
        question_number,
        comment,
        sort_order,
        score,
        page
    FROM tmp_quiz_user_answers
ON CONFLICT ON CONSTRAINT quiz_user_answers_pkey
DO UPDATE SET
    time_completed = EXCLUDED.time_completed,
    question_number = EXCLUDED.question_number,
    comment = EXCLUDED.comment,
    sort_order = EXCLUDED.sort_order,
    score = EXCLUDED.score,
    page = EXCLUDED.page

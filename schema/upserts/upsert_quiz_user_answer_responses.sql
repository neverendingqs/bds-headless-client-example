INSERT INTO quiz_user_answer_responses
    SELECT
        attempt_id,
        attempt_number,
        question_id,
        question_version_id,
        answer_id,
        sort_order,
        is_correct,
        user_selection,
        user_answer
    FROM tmp_quiz_user_answer_responses
ON CONFLICT ON CONSTRAINT quiz_user_answer_responses_pkey
DO UPDATE SET
    attempt_number = EXCLUDED.attempt_number,
    sort_order = EXCLUDED.sort_order,
    is_correct = EXCLUDED.is_correct,
    user_selection = EXCLUDED.user_selection,
    user_answer = EXCLUDED.user_answer

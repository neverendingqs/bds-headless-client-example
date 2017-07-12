INSERT INTO quiz_attempts
    SELECT
        attempt_id,
        quiz_id,
        user_id,
        org_unit_id,
        quiz_name,
        attempt_number,
        time_started,
        time_completed,
        score,
        possible_score,
        is_graded,
        grade_item_id
    FROM tmp_quiz_attempts
ON CONFLICT ON CONSTRAINT quiz_attempts_pkey
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    quiz_name = EXCLUDED.quiz_name,
    attempt_number = EXCLUDED.attempt_number,
    time_started = EXCLUDED.time_started,
    time_completed = EXCLUDED.time_completed,
    score = EXCLUDED.score,
    possible_score = EXCLUDED.possible_score,
    is_graded = EXCLUDED.is_graded,
    grade_item_id = EXCLUDED.grade_item_id

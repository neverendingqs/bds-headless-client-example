INSERT INTO quiz_questions
    SELECT DISTINCT
        quiz_id,
        sort_order,
        created_date,
        difficulty,
        is_bonus,
        is_mandatory,
        is_auto_graded,
        section_name,
        last_modified,
        points,
        question_id,
        question_version_id,
        question_type,
        name,
        question,
        comment,
        answer_key
    FROM tmp_quiz_questions
ON CONFLICT ON CONSTRAINT quiz_questions_pkey
DO UPDATE SET
    sort_order = EXCLUDED.sort_order,
    created_date = EXCLUDED.created_date,
    difficulty = EXCLUDED.difficulty,
    is_bonus = EXCLUDED.is_bonus,
    is_mandatory = EXCLUDED.is_mandatory,
    is_auto_graded = EXCLUDED.is_auto_graded,
    section_name = EXCLUDED.section_name,
    last_modified = EXCLUDED.last_modified,
    points = EXCLUDED.points,
    question_type = EXCLUDED.question_type,
    name = EXCLUDED.name,
    question = EXCLUDED.question,
    comment = EXCLUDED.comment,
    answer_key = EXCLUDED.answer_key

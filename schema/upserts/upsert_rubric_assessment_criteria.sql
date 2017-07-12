INSERT INTO rubric_assessment_criteria
    SELECT DISTINCT
        assessment_id,
        user_id,
        rubric_id,
        criterion_name,
        score,
        level_achieved,
        feedback,
        is_score_overridden
    FROM tmp_rubric_assessment_criteria
ON CONFLICT ON CONSTRAINT rubric_assessment_criteria_assessment_id_user_id_rubric_id__key
DO NOTHING

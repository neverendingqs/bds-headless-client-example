INSERT INTO rubric_assessment
    SELECT
        rubric_id,
        org_unit_id,
        user_id,
        rubric_name,
        score,
        level_achieved,
        -- criterion,  -- missing from data set
        assessed_by_user_id,
        assessment_date,
        is_completed,
        activity_type,
        activity_name,
        activity_object_id,
        date_created,
        assessment_id
    FROM tmp_rubric_assessment
ON CONFLICT ON CONSTRAINT rubric_assessment_pkey
DO UPDATE SET
    rubric_name = EXCLUDED.rubric_name,
    score = EXCLUDED.score,
    level_achieved = EXCLUDED.level_achieved,
    --- criterion = EXCLUDED.criterion,  -- missing from data set
    assessed_by_user_id = EXCLUDED.assessed_by_user_id,
    assessment_date = EXCLUDED.assessment_date,
    is_completed = EXCLUDED.is_completed,
    activity_type = EXCLUDED.activity_type,
    activity_name = EXCLUDED.activity_name,
    activity_object_id = EXCLUDED.activity_object_id,
    date_created = EXCLUDED.date_created,
    assessment_id = EXCLUDED.assessment_id

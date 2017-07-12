CREATE TABLE IF NOT EXISTS rubric_assessment
(
    rubric_id BIGINT,
    org_unit_id BIGINT,
    user_id BIGINT,
    rubric_name TEXT,
    score DECIMAL,
    level_achieved TEXT,
    -- criterion TEXT,  -- missing from data set
    assessed_by_user_id BIGINT,
    assessment_date TIMESTAMP,
    is_completed BOOLEAN,
    activity_type TEXT,
    activity_name TEXT,
    activity_object_id BIGINT,
    date_created TIMESTAMP,
    assessment_id BIGINT,
    PRIMARY KEY (rubric_id, org_unit_id, user_id, assessment_date)
)

CREATE TABLE IF NOT EXISTS rubric_assessment_criteria
(
    assessment_id BIGINT,
    user_id BIGINT,
    rubric_id BIGINT,
    criterion_name TEXT,
    score DECIMAL,
    level_achieved TEXT,
    feedback TEXT,
    is_score_overridden BOOLEAN,
    UNIQUE (assessment_id, user_id, rubric_id, criterion_name, score, level_achieved, feedback, is_score_overridden)
)

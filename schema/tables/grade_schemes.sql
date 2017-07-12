CREATE TABLE IF NOT EXISTS grade_schemes
(
    grade_scheme_id BIGINT,
    org_unit_id BIGINT,
    scheme_name TEXT,
    symbol_string TEXT,
    range_start DECIMAL,
    range_end DECIMAL,
    UNIQUE (grade_scheme_id, range_start, range_end)
)

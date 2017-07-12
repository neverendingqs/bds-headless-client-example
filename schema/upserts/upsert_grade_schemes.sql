INSERT INTO grade_schemes
    SELECT
        grade_scheme_id,
        org_unit_id,
        scheme_name,
        symbol_string,
        range_start,
        range_end
    FROM tmp_grade_schemes
ON CONFLICT ON CONSTRAINT grade_schemes_grade_scheme_id_range_start_range_end_key
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    scheme_name = EXCLUDED.scheme_name,
    symbol_string = EXCLUDED.symbol_string

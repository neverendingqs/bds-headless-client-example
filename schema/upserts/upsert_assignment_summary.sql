INSERT INTO assignment_summary
    SELECT
        dropbox_id,
        org_unit_id,
        name,
        category,
        type,
        grade_item_id,
        possible_score,
        start_date,
        end_date,
        due_date,
        is_restricted,
        is_deleted,
        turn_it_in_enabled
    FROM tmp_assignment_summary
ON CONFLICT ON CONSTRAINT assignment_summary_pkey
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    name = EXCLUDED.name,
    category = EXCLUDED.category,
    type = EXCLUDED.type,
    grade_item_id = EXCLUDED.grade_item_id,
    possible_score = EXCLUDED.possible_score,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    due_date = EXCLUDED.due_date,
    is_restricted = EXCLUDED.is_restricted,
    is_deleted = EXCLUDED.is_deleted,
    turn_it_in_enabled = EXCLUDED.turn_it_in_enabled

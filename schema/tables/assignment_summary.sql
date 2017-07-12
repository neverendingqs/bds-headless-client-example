CREATE TABLE IF NOT EXISTS assignment_summary
(
    dropbox_id BIGINT PRIMARY KEY,
    org_unit_id BIGINT,
    name TEXT,
    category TEXT,
    type TEXT,
    grade_item_id BIGINT,
    possible_score DECIMAL,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    due_date TIMESTAMP,
    is_restricted BOOLEAN,
    is_deleted BOOLEAN,
    turn_it_in_enabled BOOLEAN
)

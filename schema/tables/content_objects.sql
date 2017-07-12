CREATE TABLE IF NOT EXISTS content_objects
(
    content_object_id BIGINT PRIMARY KEY,
    org_unit_id BIGINT,
    title TEXT,
    content_object_type TEXT,
    completion_type TEXT,
    parent_content_object_id BIGINT,
    location TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    due_date TIMESTAMP,
    object_tool_name TEXT,
    object_id_1 BIGINT,
    object_id_2 BIGINT,
    object_id_3 BIGINT,
    date_created TIMESTAMP,
    is_deleted BOOLEAN
)

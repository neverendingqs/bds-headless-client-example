INSERT INTO content_objects
    SELECT
        content_object_id,
        org_unit_id,
        title,
        content_object_type,
        completion_type,
        parent_content_object_id,
        location,
        start_date,
        end_date,
        due_date,
        object_tool_name,
        object_id_1,
        object_id_2,
        object_id_3,
        date_created,
        is_deleted
    FROM tmp_content_objects
ON CONFLICT ON CONSTRAINT content_objects_pkey
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    title = EXCLUDED.title,
    content_object_type = EXCLUDED.content_object_type,
    completion_type = EXCLUDED.completion_type,
    parent_content_object_id = EXCLUDED.parent_content_object_id,
    location = EXCLUDED.location,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    due_date = EXCLUDED.due_date,
    object_tool_name = EXCLUDED.object_tool_name,
    object_id_1 = EXCLUDED.object_id_1,
    object_id_2 = EXCLUDED.object_id_2,
    object_id_3 = EXCLUDED.object_id_3,
    date_created = EXCLUDED.date_created,
    is_deleted = EXCLUDED.is_deleted

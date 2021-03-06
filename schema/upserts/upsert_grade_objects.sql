INSERT INTO grade_objects
    SELECT
        grade_object_id,
        org_unit_id,
        parent_grade_object_id,
        name,
        type_name,
        category_name,
        start_date,
        end_date,
        is_auto_pointed,
        is_formula,
        is_bonus,
        max_points,
        can_exceed_max_grade,
        exclude_from_final_grade_calc,
        grade_scheme_id,
        weight,
        num_lowest_grades_to_drop,
        num_highest_grades_to_drop,
        weight_distribution_type,
        created_date,
        tool_name,
        associated_tool_item_id,
        last_modified,
        short_name,
        grade_object_type_id,
        sort_order
    FROM tmp_grade_objects
ON CONFLICT ON CONSTRAINT grade_objects_pkey
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    parent_grade_object_id = EXCLUDED.parent_grade_object_id,
    name = EXCLUDED.name,
    type_name = EXCLUDED.type_name,
    category_name = EXCLUDED.category_name,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    is_auto_pointed = EXCLUDED.is_auto_pointed,
    is_formula = EXCLUDED.is_formula,
    is_bonus = EXCLUDED.is_bonus,
    max_points = EXCLUDED.max_points,
    can_exceed_max_grade = EXCLUDED.can_exceed_max_grade,
    exclude_from_final_grade_calc = EXCLUDED.exclude_from_final_grade_calc,
    grade_scheme_id = EXCLUDED.grade_scheme_id,
    weight = EXCLUDED.weight,
    num_lowest_grades_to_drop = EXCLUDED.num_lowest_grades_to_drop,
    num_highest_grades_to_drop = EXCLUDED.num_highest_grades_to_drop,
    weight_distribution_type = EXCLUDED.weight_distribution_type,
    created_date = EXCLUDED.created_date,
    tool_name = EXCLUDED.tool_name,
    associated_tool_item_id = EXCLUDED.associated_tool_item_id,
    last_modified = EXCLUDED.last_modified,
    short_name = EXCLUDED.short_name,
    grade_object_type_id = EXCLUDED.grade_object_type_id,
    sort_order = EXCLUDED.sort_order

INSERT INTO org_unit_ancestors
    SELECT
        org_unit_id,
        ancestor_org_unit_id
    FROM tmp_org_unit_ancestors
ON CONFLICT ON CONSTRAINT org_unit_ancestors_pkey
DO NOTHING

CREATE TABLE IF NOT EXISTS org_unit_ancestors
(
    org_unit_id BIGINT,
    ancestor_org_unit_id BIGINT,
    PRIMARY KEY (org_unit_id, ancestor_org_unit_id)
)

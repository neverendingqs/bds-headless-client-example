INSERT INTO discussion_posts_read_status
    SELECT
        user_id,
        topic_id,
        post_id,
        is_read,
        first_read_date,
        last_read_date
    FROM tmp_discussion_posts_read_status
ON CONFLICT ON CONSTRAINT discussion_posts_read_status_pkey
DO UPDATE SET
    is_read = EXCLUDED.is_read,
    first_read_date = EXCLUDED.first_read_date,
    last_read_date = EXCLUDED.last_read_date

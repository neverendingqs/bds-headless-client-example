INSERT INTO discussion_posts
    SELECT
        org_unit_id,
        topic_id,
        forum_id,
        user_id,
        post_id,
        thread_id,
        thread,
        topic,
        forum,
        is_reply,
        parent_post_id,
        num_replies,
        date_posted,
        is_deleted,
        rating_sum,
        num_ratings,
        score
    FROM tmp_discussion_posts
ON CONFLICT ON CONSTRAINT discussion_posts_pkey
DO UPDATE SET
    org_unit_id = EXCLUDED.org_unit_id,
    forum_id = EXCLUDED.forum_id,
    user_id = EXCLUDED.user_id,
    thread = EXCLUDED.thread,
    topic = EXCLUDED.topic,
    forum = EXCLUDED.forum,
    is_reply = EXCLUDED.is_reply,
    parent_post_id = EXCLUDED.parent_post_id,
    num_replies = EXCLUDED.num_replies,
    date_posted = EXCLUDED.date_posted,
    is_deleted = EXCLUDED.is_deleted,
    rating_sum = EXCLUDED.rating_sum,
    num_ratings = EXCLUDED.num_ratings,
    score = EXCLUDED.score

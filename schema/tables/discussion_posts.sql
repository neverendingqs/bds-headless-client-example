CREATE TABLE IF NOT EXISTS discussion_posts
(
    org_unit_id BIGINT,
    topic_id BIGINT,
    forum_id BIGINT,
    user_id BIGINT,
    post_id BIGINT,
    thread_id BIGINT,
    thread TEXT,
    topic TEXT,
    forum TEXT,
    is_reply BOOLEAN,
    parent_post_id BIGINT,
    num_replies BIGINT,
    date_posted TIMESTAMP,
    is_deleted BOOLEAN,
    rating_sum BIGINT,
    num_ratings BIGINT,
    score DECIMAL,
    PRIMARY KEY (topic_id, thread_id, post_id)
)

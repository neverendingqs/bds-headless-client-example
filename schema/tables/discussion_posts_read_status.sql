CREATE TABLE IF NOT EXISTS discussion_posts_read_status
(
    user_id BIGINT,
    topic_id BIGINT,
    post_id BIGINT,
    is_read BOOLEAN,
    first_read_date TIMESTAMP,
    last_read_date TIMESTAMP,
    PRIMARY KEY (user_id, topic_id, post_id)
)

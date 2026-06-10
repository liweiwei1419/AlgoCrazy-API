CREATE TABLE IF NOT EXISTS public.problem_review_topics (
    id BIGSERIAL PRIMARY KEY,
    exercise_id INTEGER NOT NULL,
    review_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    review_tag VARCHAR(100) NULL,
    why_typical TEXT NULL,
    site_review TEXT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS public.problem_reviews (
    id BIGSERIAL PRIMARY KEY,
    topic_id BIGINT NOT NULL,
    exercise_id INTEGER NOT NULL,
    recommend_score INTEGER NOT NULL,
    thinking_score INTEGER NOT NULL,
    stuck_point VARCHAR(30) NOT NULL DEFAULT 'OTHER',
    short_comment VARCHAR(300) NOT NULL,
    user_id BIGINT NULL,
    author_type VARCHAR(20) NOT NULL DEFAULT 'GUEST',
    guest_nickname VARCHAR(100) NULL,
    is_anonymous BOOLEAN NOT NULL DEFAULT TRUE,
    display_nickname VARCHAR(100) NOT NULL DEFAULT '匿名用户',
    status VARCHAR(20) NOT NULL DEFAULT 'VISIBLE',
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_problem_reviews_topic
        FOREIGN KEY (topic_id) REFERENCES public.problem_review_topics(id) ON DELETE CASCADE,
    CONSTRAINT chk_problem_reviews_recommend_score
        CHECK (recommend_score BETWEEN 1 AND 5),
    CONSTRAINT chk_problem_reviews_thinking_score
        CHECK (thinking_score BETWEEN 1 AND 5),
    CONSTRAINT chk_problem_reviews_stuck_point
        CHECK (stuck_point IN ('IDEA', 'BORDER', 'IMPLEMENTATION', 'COMPLEXITY', 'MISREAD', 'OTHER')),
    CONSTRAINT chk_problem_reviews_author_type
        CHECK (author_type IN ('USER', 'GUEST')),
    CONSTRAINT chk_problem_reviews_status
        CHECK (status IN ('VISIBLE', 'PENDING', 'DELETED', 'SPAM'))
);

CREATE INDEX IF NOT EXISTS idx_problem_review_topics_enabled
    ON public.problem_review_topics (review_enabled, is_deleted, sort_order, updated_at DESC);

CREATE INDEX IF NOT EXISTS idx_problem_reviews_topic_created
    ON public.problem_reviews (topic_id, status, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_problem_reviews_exercise_id
    ON public.problem_reviews (exercise_id);

COMMENT ON TABLE public.problem_review_topics IS '题目点评精选题：控制哪些典型题开放点评，并保存站长点评';
COMMENT ON COLUMN public.problem_review_topics.exercise_id IS '关联 exercise_solutions.id';
COMMENT ON COLUMN public.problem_review_topics.review_tag IS '这道题的典型标签，如原地覆盖、二分边界、DP 状态定义';
COMMENT ON COLUMN public.problem_review_topics.why_typical IS '为什么这题典型';
COMMENT ON COLUMN public.problem_review_topics.site_review IS '站长点评';

COMMENT ON TABLE public.problem_reviews IS '用户对精选题的评分、卡点和短评';
COMMENT ON COLUMN public.problem_reviews.recommend_score IS '推荐指数：1-5';
COMMENT ON COLUMN public.problem_reviews.thinking_score IS '思维含量：1-5';
COMMENT ON COLUMN public.problem_reviews.stuck_point IS '卡点：IDEA/BORDER/IMPLEMENTATION/COMPLEXITY/MISREAD/OTHER';

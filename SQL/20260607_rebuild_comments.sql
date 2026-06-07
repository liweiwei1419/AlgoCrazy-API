-- 通用评论系统重建脚本
-- 适用前提：当前网站没有需要保留的真实评论数据。
-- 执行效果：重建 comments 表；保留 message_board 表但新代码不再写入它。

DROP TABLE IF EXISTS public.comments;

CREATE TABLE public.comments (
    id BIGSERIAL PRIMARY KEY,
    target_type VARCHAR(50) NOT NULL,
    target_id BIGINT NOT NULL,
    content TEXT NOT NULL,

    parent_id BIGINT NULL,
    reply_to_comment_id BIGINT NULL,

    user_id BIGINT NULL,
    author_type VARCHAR(20) NOT NULL DEFAULT 'GUEST',
    guest_nickname VARCHAR(100) NULL,
    guest_email VARCHAR(255) NULL,
    is_anonymous BOOLEAN NOT NULL DEFAULT FALSE,

    display_nickname VARCHAR(100) NOT NULL DEFAULT '匿名用户',
    display_avatar VARCHAR(500) NULL,

    reply_to_user_id BIGINT NULL,
    reply_to_nickname VARCHAR(100) NULL,

    reply_count INTEGER NOT NULL DEFAULT 0,
    like_count INTEGER NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'VISIBLE',

    ip_hash VARCHAR(128) NULL,
    user_agent_hash VARCHAR(128) NULL,

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITHOUT TIME ZONE NULL,

    CONSTRAINT fk_comments_parent
        FOREIGN KEY (parent_id) REFERENCES public.comments(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_reply_to
        FOREIGN KEY (reply_to_comment_id) REFERENCES public.comments(id) ON DELETE SET NULL,
    CONSTRAINT chk_comments_author_type
        CHECK (author_type IN ('USER', 'GUEST')),
    CONSTRAINT chk_comments_status
        CHECK (status IN ('VISIBLE', 'PENDING', 'DELETED', 'SPAM')),
    CONSTRAINT chk_comments_target_type
        CHECK (target_type IN ('ARTICLE', 'EXERCISE', 'MESSAGE_BOARD', 'PROBLEM_REVIEW'))
);

CREATE INDEX idx_comments_target_top
    ON public.comments (target_type, target_id, parent_id, status, created_at DESC);

CREATE INDEX idx_comments_parent_created
    ON public.comments (parent_id, status, created_at ASC);

CREATE INDEX idx_comments_user_id
    ON public.comments (user_id);

COMMENT ON TABLE public.comments IS '通用评论表：文章、练习、留言板、题目点评共用';
COMMENT ON COLUMN public.comments.target_type IS '评论目标类型：ARTICLE、EXERCISE、MESSAGE_BOARD、PROBLEM_REVIEW';
COMMENT ON COLUMN public.comments.target_id IS '评论目标 ID；留言板可固定使用 1';
COMMENT ON COLUMN public.comments.parent_id IS '顶层评论为空；二级回复保存顶层评论 ID';
COMMENT ON COLUMN public.comments.reply_to_comment_id IS '回复动作实际指向的评论或回复 ID';
COMMENT ON COLUMN public.comments.author_type IS 'USER 表示登录用户，GUEST 表示游客';
COMMENT ON COLUMN public.comments.is_anonymous IS '登录用户是否匿名展示';
COMMENT ON COLUMN public.comments.display_nickname IS '前台展示昵称';
COMMENT ON COLUMN public.comments.status IS 'VISIBLE、PENDING、DELETED、SPAM';

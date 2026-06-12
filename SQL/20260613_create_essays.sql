CREATE TABLE IF NOT EXISTS essays (
                                      id SERIAL PRIMARY KEY,
                                      title VARCHAR(255) NOT NULL,
                                      content TEXT NOT NULL,
                                      is_published BOOLEAN NOT NULL DEFAULT false,
                                      sort_order INTEGER NOT NULL DEFAULT 0,
                                      view_count INTEGER NOT NULL DEFAULT 0,
                                      created_by VARCHAR(100),
                                      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                      is_deleted BOOLEAN NOT NULL DEFAULT false
);

COMMENT ON TABLE essays IS '随笔表：独立补充文章';
COMMENT ON COLUMN essays.id IS '主键ID';
COMMENT ON COLUMN essays.title IS '标题';
COMMENT ON COLUMN essays.content IS 'Markdown 正文内容';
COMMENT ON COLUMN essays.is_published IS '是否发布: true-已发布, false-草稿';
COMMENT ON COLUMN essays.sort_order IS '展示顺序';
COMMENT ON COLUMN essays.view_count IS '浏览次数';
COMMENT ON COLUMN essays.created_by IS '创建者';
COMMENT ON COLUMN essays.created_at IS '创建时间';
COMMENT ON COLUMN essays.updated_at IS '更新时间';
COMMENT ON COLUMN essays.is_deleted IS '软删除标记';

CREATE INDEX IF NOT EXISTS idx_essays_is_published ON essays(is_published);
CREATE INDEX IF NOT EXISTS idx_essays_sort_order ON essays(sort_order);
CREATE INDEX IF NOT EXISTS idx_essays_is_deleted ON essays(is_deleted);

ALTER TABLE comments DROP CONSTRAINT IF EXISTS chk_comments_target_type;
ALTER TABLE comments
    ADD CONSTRAINT chk_comments_target_type
        CHECK (target_type IN ('ARTICLE', 'EXERCISE', 'MESSAGE_BOARD', 'PROBLEM_REVIEW', 'ESSAY'));

COMMENT ON COLUMN comments.target_type IS '评论目标类型：ARTICLE、EXERCISE、MESSAGE_BOARD、PROBLEM_REVIEW、ESSAY';

CREATE TABLE IF NOT EXISTS faqs (
                                    id SERIAL PRIMARY KEY,
                                    question TEXT NOT NULL,
                                    answer TEXT NOT NULL,
                                    is_published BOOLEAN NOT NULL DEFAULT false,
                                    sort_order INTEGER NOT NULL DEFAULT 0,
                                    created_by VARCHAR(100),
                                    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    is_deleted BOOLEAN NOT NULL DEFAULT false
);

COMMENT ON TABLE faqs IS '常见问答表';
COMMENT ON COLUMN faqs.id IS '主键ID';
COMMENT ON COLUMN faqs.question IS '问题';
COMMENT ON COLUMN faqs.answer IS '答案';
COMMENT ON COLUMN faqs.is_published IS '是否发布: true-已发布, false-草稿';
COMMENT ON COLUMN faqs.sort_order IS '展示顺序';
COMMENT ON COLUMN faqs.created_by IS '创建者';
COMMENT ON COLUMN faqs.created_at IS '创建时间';
COMMENT ON COLUMN faqs.updated_at IS '更新时间';
COMMENT ON COLUMN faqs.is_deleted IS '软删除标记';

CREATE INDEX IF NOT EXISTS idx_faqs_is_published ON faqs(is_published);
CREATE INDEX IF NOT EXISTS idx_faqs_sort_order ON faqs(sort_order);
CREATE INDEX IF NOT EXISTS idx_faqs_is_deleted ON faqs(is_deleted);

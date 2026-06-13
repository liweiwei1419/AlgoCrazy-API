CREATE TABLE IF NOT EXISTS admin_manual_articles (
                                                     id SERIAL PRIMARY KEY,
                                                     title VARCHAR(255) NOT NULL,
                                                     content TEXT NOT NULL,
                                                     sort_order INTEGER NOT NULL DEFAULT 0,
                                                     created_by VARCHAR(100),
                                                     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                     is_deleted BOOLEAN NOT NULL DEFAULT false
);

COMMENT ON TABLE admin_manual_articles IS '站长管理手册文章表';
COMMENT ON COLUMN admin_manual_articles.id IS '主键ID';
COMMENT ON COLUMN admin_manual_articles.title IS '标题';
COMMENT ON COLUMN admin_manual_articles.content IS 'Markdown 正文内容';
COMMENT ON COLUMN admin_manual_articles.sort_order IS '展示顺序';
COMMENT ON COLUMN admin_manual_articles.created_by IS '创建者';
COMMENT ON COLUMN admin_manual_articles.created_at IS '创建时间';
COMMENT ON COLUMN admin_manual_articles.updated_at IS '更新时间';
COMMENT ON COLUMN admin_manual_articles.is_deleted IS '软删除标记';

CREATE INDEX IF NOT EXISTS idx_admin_manual_articles_sort_order ON admin_manual_articles(sort_order);
CREATE INDEX IF NOT EXISTS idx_admin_manual_articles_is_deleted ON admin_manual_articles(is_deleted);

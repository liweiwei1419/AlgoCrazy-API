CREATE TABLE IF NOT EXISTS article_videos (
    id SERIAL PRIMARY KEY,
    article_id INTEGER NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    video_url VARCHAR(1000) NOT NULL,
    cover_url VARCHAR(1000),
    duration_seconds INTEGER,
    sort_order INTEGER DEFAULT 0,
    is_published BOOLEAN DEFAULT false,
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT false
);

CREATE INDEX IF NOT EXISTS idx_article_videos_article_id ON article_videos(article_id);
CREATE INDEX IF NOT EXISTS idx_article_videos_sort_order ON article_videos(sort_order);
CREATE INDEX IF NOT EXISTS idx_article_videos_published ON article_videos(is_published);

COMMENT ON TABLE article_videos IS '正文视频表';
COMMENT ON COLUMN article_videos.article_id IS '关联的正文文章ID';
COMMENT ON COLUMN article_videos.title IS '视频标题';
COMMENT ON COLUMN article_videos.description IS '视频说明';
COMMENT ON COLUMN article_videos.video_url IS '视频播放地址';
COMMENT ON COLUMN article_videos.cover_url IS '视频封面地址';
COMMENT ON COLUMN article_videos.duration_seconds IS '视频时长，单位秒';
COMMENT ON COLUMN article_videos.sort_order IS '显示顺序';
COMMENT ON COLUMN article_videos.is_published IS '是否发布';

CREATE TABLE IF NOT EXISTS article_video_danmus (
    id SERIAL PRIMARY KEY,
    article_video_id INTEGER NOT NULL REFERENCES article_videos(id) ON DELETE CASCADE,
    content VARCHAR(300) NOT NULL,
    time_ms INTEGER NOT NULL,
    color VARCHAR(20) DEFAULT '#ffffff',
    mode VARCHAR(20) DEFAULT 'scroll',
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT false
);

CREATE INDEX IF NOT EXISTS idx_article_video_danmus_video_id ON article_video_danmus(article_video_id);
CREATE INDEX IF NOT EXISTS idx_article_video_danmus_time ON article_video_danmus(time_ms);

COMMENT ON TABLE article_video_danmus IS '正文视频弹幕表';
COMMENT ON COLUMN article_video_danmus.article_video_id IS '关联的正文视频ID';
COMMENT ON COLUMN article_video_danmus.content IS '弹幕内容';
COMMENT ON COLUMN article_video_danmus.time_ms IS '弹幕出现时间，单位毫秒';
COMMENT ON COLUMN article_video_danmus.color IS '弹幕颜色';
COMMENT ON COLUMN article_video_danmus.mode IS '弹幕模式：scroll、top、bottom';

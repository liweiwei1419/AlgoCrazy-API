CREATE TABLE IF NOT EXISTS exercise_videos (
    id SERIAL PRIMARY KEY,
    exercise_solution_id INTEGER NOT NULL REFERENCES exercise_solutions(id) ON DELETE CASCADE,
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

CREATE INDEX IF NOT EXISTS idx_exercise_videos_exercise_id ON exercise_videos(exercise_solution_id);
CREATE INDEX IF NOT EXISTS idx_exercise_videos_sort_order ON exercise_videos(sort_order);
CREATE INDEX IF NOT EXISTS idx_exercise_videos_published ON exercise_videos(is_published);

COMMENT ON TABLE exercise_videos IS '练习视频表';
COMMENT ON COLUMN exercise_videos.exercise_solution_id IS '关联的练习解答ID';
COMMENT ON COLUMN exercise_videos.title IS '视频标题';
COMMENT ON COLUMN exercise_videos.description IS '视频说明';
COMMENT ON COLUMN exercise_videos.video_url IS '视频播放地址';
COMMENT ON COLUMN exercise_videos.cover_url IS '视频封面地址';
COMMENT ON COLUMN exercise_videos.duration_seconds IS '视频时长，单位秒';
COMMENT ON COLUMN exercise_videos.sort_order IS '显示顺序';
COMMENT ON COLUMN exercise_videos.is_published IS '是否发布';

CREATE TABLE IF NOT EXISTS exercise_video_danmus (
    id SERIAL PRIMARY KEY,
    exercise_video_id INTEGER NOT NULL REFERENCES exercise_videos(id) ON DELETE CASCADE,
    content VARCHAR(300) NOT NULL,
    time_ms INTEGER NOT NULL,
    color VARCHAR(20) DEFAULT '#ffffff',
    mode VARCHAR(20) DEFAULT 'scroll',
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT false
);

CREATE INDEX IF NOT EXISTS idx_exercise_video_danmus_video_id ON exercise_video_danmus(exercise_video_id);
CREATE INDEX IF NOT EXISTS idx_exercise_video_danmus_time ON exercise_video_danmus(time_ms);

COMMENT ON TABLE exercise_video_danmus IS '练习视频弹幕表';
COMMENT ON COLUMN exercise_video_danmus.exercise_video_id IS '关联的练习视频ID';
COMMENT ON COLUMN exercise_video_danmus.content IS '弹幕内容';
COMMENT ON COLUMN exercise_video_danmus.time_ms IS '弹幕出现时间，单位毫秒';
COMMENT ON COLUMN exercise_video_danmus.color IS '弹幕颜色';
COMMENT ON COLUMN exercise_video_danmus.mode IS '弹幕模式：scroll、top、bottom';

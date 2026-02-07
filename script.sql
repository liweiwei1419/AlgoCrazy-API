-- 创建数据库
CREATE DATABASE algo_crazy_db;

CREATE TABLE articles (
                          id SERIAL PRIMARY KEY,
                          author VARCHAR(255) NOT NULL,                     -- 作者名称
                          title VARCHAR(255) NOT NULL,                      -- 文章标题
                          content TEXT NOT NULL,                            -- 文章内容
                          category VARCHAR(50),                             -- 文章分类
                          tags VARCHAR(50)[],                               -- 文章标签数组
                          url VARCHAR(255),                                 -- 新增：文章URL
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 更新时间
                          like_count INTEGER DEFAULT 0,                     -- 点赞数
                          view_count INTEGER DEFAULT 0,                     -- 阅读数
                          is_deleted BOOLEAN DEFAULT FALSE,                 -- 逻辑删除标志
                          deleted_at TIMESTAMP               -- 删除时间(可选)
);

-- 为URL字段添加唯一约束（可选）
CREATE UNIQUE INDEX idx_articles_url ON articles(url) WHERE url IS NOT NULL;

-- 为URL字段添加索引（可选）
CREATE INDEX idx_articles_url ON articles(url);


ALTER TABLE articles ADD COLUMN parent_id INTEGER REFERENCES articles(id); -- 父级文章ID
ALTER TABLE articles ADD COLUMN display_order INTEGER DEFAULT 0; -- 同级显示顺序
ALTER TABLE articles ADD COLUMN path VARCHAR(255) DEFAULT ''; -- 路径(如"1,5,12"表示1→5→12)
ALTER TABLE articles ADD COLUMN is_folder BOOLEAN DEFAULT FALSE; -- 是否为文件夹


-- 创建算法分类常量表
CREATE TABLE algorithm_categories
(
    id         SERIAL PRIMARY KEY,
    value      INTEGER NOT NULL UNIQUE,
    label      TEXT    NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN   DEFAULT FALSE
);

-- 插入常量数据
INSERT INTO algorithm_categories (value, label)
VALUES (1, '基础排序算法'),
       (2, '递归'),
       (3, '循环不变量'),
       (4, '归并排序'),
       (5, '快速排序'),
       (6, '滑动窗口'),
       (7, '双指针'),
       (8, '二分查找'),
       (9, '链表'),
       (10, '栈'),
       (11, '队列'),
       (12, '优先队列'),
       (13, '二叉树'),
       (14, '二叉搜索树'),
       (15, '哈希表'),
       (16, '回溯算法'),
       (17, '动态规划'),
       (18, '贪心算法'),
       (19, '广度优先遍历与拓扑排序'),
       (20, '前缀和'),
       (21, '字典树'),
       (22, '位运算'),
       (23, '并查集'),
       (24, '单源短路径'),
       (25, '最小生成树'),
       (26, '暂时无法分类');


-- 为 articles 表添加一句话题解字段，字段名为 one_sentence_solution，类型为 VARCHAR(255)
ALTER TABLE articles
    ADD COLUMN one_sentence_solution VARCHAR(255);

CREATE TABLE comments
(
    id                SERIAL PRIMARY KEY,
    article_id        INTEGER NOT NULL REFERENCES articles (id),
    user_id           INTEGER NOT NULL REFERENCES suanfa8_user (id),
    content           TEXT    NOT NULL,
    parent_comment_id INTEGER REFERENCES comments (id), -- 用于支持二级评论，指向父评论 ID
    created_at        TIMESTAMP DEFAULT NOW(),
    updated_at        TIMESTAMP DEFAULT NOW(),
    is_deleted        BOOLEAN   DEFAULT FALSE           -- 添加 is_deleted 字段，默认值为 FALSE
);

ALTER TABLE comments
    ADD COLUMN like_count INTEGER DEFAULT 0;


alter table public.suanfa8_user
    rename column deleted to is_deleted;

alter table public.suanfa8_user
    rename column create_time to created_at;

alter table public.suanfa8_user
    rename column update_time to updated_at;


alter table public.comments
    alter column user_id type BIGINT using user_id::BIGINT;

alter table public.comments
    add user_nickname varchar(100);


-- 创建文章点赞记录表
CREATE TABLE article_like_records
(
    id         SERIAL PRIMARY KEY,
    user_id    BIGINT NOT NULL REFERENCES suanfa8_user (id), -- 关联用户表
    article_id BIGINT NOT NULL REFERENCES articles (id),     -- 关联文章表
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE (user_id, article_id)                             -- 确保一个用户对一篇文章只能有一条点赞记录
);
-- 向 article_like_records 表添加 updated_at 字段，类型为 timestamp with time zone，默认值为当前时间
ALTER TABLE public.article_like_records
    ADD COLUMN updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP;

-- 向 article_like_records 表添加 isDelete 字段，类型为 boolean，默认值为 false
ALTER TABLE public.article_like_records
    ADD COLUMN is_deleted boolean DEFAULT false;

-- 在 comments 表中添加 reply_count 字段，用于记录回复数量，默认值为 0
ALTER TABLE comments
    ADD COLUMN reply_count INTEGER DEFAULT 0;

-- 为 comments 表添加 reply_to_user_id 字段
ALTER TABLE comments ADD COLUMN reply_to_user_id BIGINT REFERENCES suanfa8_user(id);
-- -- 为 comments 表添加 reply_to_user_nickname 字段
-- ALTER TABLE comments ADD COLUMN reply_to_user_nickname VARCHAR(100);

-- 为 comments 表添加 reply_to_comment_id 字段，用于记录回复的评论 ID
ALTER TABLE comments
    ADD COLUMN reply_to_comment_id INTEGER REFERENCES comments (id);

-- 创建LeetCode题目表
CREATE TABLE IF NOT EXISTS leetcode_problems (
                                                 id INTEGER PRIMARY KEY,
                                                 title VARCHAR(255) NOT NULL,
                                                 title_slug VARCHAR(255) NOT NULL,
                                                 difficulty VARCHAR(20) NOT NULL,
                                                 paid_only VARCHAR(10) NOT NULL,
                                                 url VARCHAR(255) NOT NULL,
                                                 created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                                 updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建唯一索引
CREATE UNIQUE INDEX IF NOT EXISTS idx_leetcode_problems_id ON leetcode_problems(id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_leetcode_problems_title_slug ON leetcode_problems(title_slug);


-- 修改难度字段类型为VARCHAR(20)，用于存储枚举值
ALTER TABLE leetcode_problems
    ALTER COLUMN difficulty TYPE VARCHAR(20)
        USING (
        CASE difficulty
            WHEN '简单' THEN 'easy'
            WHEN '中等' THEN 'medium'
            WHEN '困难' THEN 'hard'
            ELSE difficulty
            END
        );

-- 修改是否会员题字段类型为BOOLEAN
ALTER TABLE leetcode_problems
    ALTER COLUMN paid_only TYPE BOOLEAN
        USING (paid_only = '是');



-- 创建表
CREATE TABLE IF NOT EXISTS message_board (
                                             id BIGSERIAL PRIMARY KEY,
                                             nickname VARCHAR(100) NOT NULL,
                                             email VARCHAR(100) NOT NULL,
                                             avatar VARCHAR(255) DEFAULT '',
                                             content TEXT NOT NULL,
                                             status INTEGER DEFAULT 0 NOT NULL,
                                             reply_content TEXT DEFAULT '',
                                             reply_time TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                                             created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
                                             updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
                                             is_deleted BOOLEAN DEFAULT FALSE NOT NULL
);

-- 添加表注释
COMMENT ON TABLE message_board IS '留言板表';

-- 添加列注释
COMMENT ON COLUMN message_board.id IS '主键ID';
COMMENT ON COLUMN message_board.nickname IS '昵称';
COMMENT ON COLUMN message_board.email IS '邮箱';
COMMENT ON COLUMN message_board.avatar IS '头像';
COMMENT ON COLUMN message_board.content IS '留言内容';
COMMENT ON COLUMN message_board.status IS '状态：0-待回复，1-已回复';
COMMENT ON COLUMN message_board.reply_content IS '回复内容';
COMMENT ON COLUMN message_board.reply_time IS '回复时间';
COMMENT ON COLUMN message_board.created_at IS '创建时间';
COMMENT ON COLUMN message_board.updated_at IS '更新时间';
COMMENT ON COLUMN message_board.is_deleted IS '是否删除';

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_message_board_created_at ON message_board(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_message_board_status ON message_board(status);
CREATE INDEX IF NOT EXISTS idx_message_board_is_deleted ON message_board(is_deleted);

-- 修改message_board表的时间类型（从带时区改为不带时区）
-- 修改reply_time列
ALTER TABLE message_board
    ALTER COLUMN reply_time TYPE TIMESTAMP
        USING reply_time AT TIME ZONE 'UTC';

-- 修改created_at列（带默认值）
ALTER TABLE message_board
    ALTER COLUMN created_at TYPE TIMESTAMP
        USING created_at AT TIME ZONE 'UTC',
    ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

-- 修改updated_at列（带默认值）
ALTER TABLE message_board
    ALTER COLUMN updated_at TYPE TIMESTAMP
        USING updated_at AT TIME ZONE 'UTC',
    ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

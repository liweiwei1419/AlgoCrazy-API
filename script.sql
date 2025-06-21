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
ALTER TABLE articles ADD COLUMN one_sentence_solution VARCHAR(255);

CREATE TABLE comments (
                          id SERIAL PRIMARY KEY,
                          article_id INTEGER NOT NULL REFERENCES articles(id),
                          user_id INTEGER NOT NULL REFERENCES suanfa8_user(id),
                          content TEXT NOT NULL,
                          parent_comment_id INTEGER REFERENCES comments(id), -- 用于支持二级评论，指向父评论 ID
                          created_at TIMESTAMP DEFAULT NOW(),
                          updated_at TIMESTAMP DEFAULT NOW(),
                          is_deleted BOOLEAN DEFAULT FALSE -- 添加 is_deleted 字段，默认值为 FALSE
);

ALTER TABLE comments ADD COLUMN like_count INTEGER DEFAULT 0;


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
CREATE TABLE article_like_records (
                                      id SERIAL PRIMARY KEY,
                                      user_id BIGINT NOT NULL REFERENCES suanfa8_user(id), -- 关联用户表
                                      article_id BIGINT NOT NULL REFERENCES articles(id),  -- 关联文章表
                                      created_at TIMESTAMP DEFAULT NOW(),
                                      UNIQUE (user_id, article_id) -- 确保一个用户对一篇文章只能有一条点赞记录
);
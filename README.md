# 算法也疯狂-后端 API

```postgresql
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
```
# 算法也疯狂-后端 API

```postgresql
-- 创建数据库
CREATE DATABASE algo_crazy_db;

-- 创建文章表
CREATE TABLE articles (
                          ID SERIAL PRIMARY KEY,
                          author VARCHAR ( 255 ) NOT NULL,-- 作者ID，
                          title VARCHAR ( 255 ) NOT NULL,-- 文章标题
                          CONTENT TEXT NOT NULL,-- 文章内容
                          category VARCHAR ( 50 ),-- 文章分类
                          tags VARCHAR ( 50 ) [],-- 文章标签数组
                          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,-- 创建时间
                          updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,-- 更新时间
                          like_count INTEGER DEFAULT 0,-- 点赞数
                          view_count INTEGER DEFAULT 0,-- 阅读数
                          is_deleted BOOLEAN DEFAULT FALSE,-- 逻辑删除标志
                          deleted_at TIMESTAMP WITH TIME ZONE -- 删除时间(可选)

);
```
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
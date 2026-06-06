-- Generated from /Users/liwei/algo_crazy_db_public_articles.csv
-- Assumption: public.articles has columns id and url; old URL is checked to avoid accidental overwrite.
BEGIN;

-- 第 0 部分 写在前面的话
UPDATE public.articles
SET url = 'preface'
WHERE id = 1 AND url = 'home';
-- 第 1 节 本书亮点
UPDATE public.articles
SET url = 'book-highlights'
WHERE id = 198 AND url = 'highlights';
-- 第 2 节 写在前面的话
UPDATE public.articles
SET url = 'before-start'
WHERE id = 199 AND url = 'words-before-we-begin';
-- 第 3 节 本书章节介绍
UPDATE public.articles
SET url = 'chapter-guide'
WHERE id = 200 AND url = 'chapter-overview';
-- 第 4 节 如何使用本书
UPDATE public.articles
SET url = 'reading-guide'
WHERE id = 201 AND url = 'how-to-use';
-- 第 5 节 适合本书的读者和不适合本书的读者
UPDATE public.articles
SET url = 'target-readers'
WHERE id = 202 AND url = 'suitable-readers';
-- 第 2 部分 数据结构基础
UPDATE public.articles
SET url = 'data-structures'
WHERE id = 204 AND url = 'data-structure-basics';
-- 第 2 章 递归的最佳学习材料：归并排序与快速排序
UPDATE public.articles
SET url = 'recursion-sorting'
WHERE id = 208 AND url = 'recursion';
-- 第 4 章 滑动窗口与双指针：数组问题的量体裁衣与相遇即解
UPDATE public.articles
SET url = 'sliding-window-pointers'
WHERE id = 210 AND url = 'sliding-window-two-pointers';
-- 第 6 节 总结与练习
UPDATE public.articles
SET url = 'algorithm-basics-summary'
WHERE id = 216 AND url = 'summary-practice';
-- 第 9 章 树与二叉树：DFS、BFS 与后序遍历的妙用
UPDATE public.articles
SET url = 'tree-traversal'
WHERE id = 221 AND url = 'trees-dfs-bfs';
-- 第 16 章 前缀和与哈希表：子数组问题的优化策略
UPDATE public.articles
SET url = 'prefix-sum-hash-table'
WHERE id = 228 AND url = 'prefix-sum-hashmap';
-- 第 2 节 看不见的栈：理解递归的隐形引擎
UPDATE public.articles
SET url = 'recursion-stack'
WHERE id = 234 AND url = 'recursion-call-stack';
-- 第 5 节 编程实现归并排序
UPDATE public.articles
SET url = 'merge-sort-code'
WHERE id = 237 AND url = 'merge-sort-implementation';
-- 第 6 节 计算逆序对数量：归并排序的经典应用
UPDATE public.articles
SET url = 'inversion-count'
WHERE id = 238 AND url = 'count-inversions';
-- 第 7 节 快速排序算法详解：从思想到实现
UPDATE public.articles
SET url = 'quicksort'
WHERE id = 239 AND url = 'quick-sort';
-- 第 8 节 随机选择基准元素：避免有序数组的最坏情况
UPDATE public.articles
SET url = 'quicksort-random-pivot'
WHERE id = 240 AND url = 'quick-sort-random-pivot';
-- 第 9 节 快速排序优化：处理重复元素的高效方法
UPDATE public.articles
SET url = 'quicksort-duplicates'
WHERE id = 241 AND url = 'quick-sort-duplicates';
-- 第 10 节 快速排序例题选讲
UPDATE public.articles
SET url = 'quicksort-problems'
WHERE id = 242 AND url = 'quick-sort-examples';
-- 第 2 节 必须退出循环后才能确定答案的问题（本节内容非常重要）
UPDATE public.articles
SET url = 'binary-search-boundary'
WHERE id = 245 AND url = 'binary-search-post-loop';
-- 第 4 节 二分查找问题选讲
UPDATE public.articles
SET url = 'binary-search-problems'
WHERE id = 247 AND url = 'binary-search-examples';
-- 第 2 节 滑动窗口两道经典题目详解
UPDATE public.articles
SET url = 'sliding-window-problems'
WHERE id = 251 AND url = 'sliding-window-classics';
-- 第 4 节 双指针算法问题选讲
UPDATE public.articles
SET url = 'two-pointer-problems'
WHERE id = 253 AND url = 'two-pointers-examples';
-- 第 5 节 总结与练习
UPDATE public.articles
SET url = 'sliding-window-summary'
WHERE id = 254 AND url = 'sliding-window-two-pointers-summary';
-- 第 2 节 动态数组是如何自动扩容的？
UPDATE public.articles
SET url = 'dynamic-array-growth'
WHERE id = 256 AND url = 'dynamic-array-resizing';
-- 第 3 节 警惕复杂度震荡
UPDATE public.articles
SET url = 'resize-thrashing'
WHERE id = 257 AND url = 'complexity-oscillation';
-- 第 2 节 修改链表结点的指针
UPDATE public.articles
SET url = 'linked-list-pointers'
WHERE id = 261 AND url = 'linked-list-pointer-manipulation';
-- 第 5 节 链表与其他数据结构
UPDATE public.articles
SET url = 'linked-list-structures'
WHERE id = 264 AND url = 'linked-list-vs-others';
-- 第 1 节 说栈是在说功能而没有说实现
UPDATE public.articles
SET url = 'stack-concept'
WHERE id = 266 AND url = 'stack-abstract-concept';
-- 第 2 节 栈问题选讲
UPDATE public.articles
SET url = 'stack-problems'
WHERE id = 267 AND url = 'stack-examples';
-- 第 4 节 队列问题选讲
UPDATE public.articles
SET url = 'queue-problems'
WHERE id = 269 AND url = 'queue-examples';
-- 第 1 节 优先队列是抽象概念
UPDATE public.articles
SET url = 'priority-queue-concept'
WHERE id = 271 AND url = 'priority-queue-abstract';
-- 第 2 节 建立在数组上的树结构
UPDATE public.articles
SET url = 'heap-array'
WHERE id = 272 AND url = 'heap-as-array';
-- 第 3 节 堆的调整：上浮与下沉
UPDATE public.articles
SET url = 'heap-adjustment'
WHERE id = 273 AND url = 'heap-swim-sink';
-- 第 4 节 最大堆代码实现
UPDATE public.articles
SET url = 'max-heap-code'
WHERE id = 274 AND url = 'max-heap-implementation';
-- 第 6 节 优先队列问题选讲
UPDATE public.articles
SET url = 'priority-queue-problems'
WHERE id = 276 AND url = 'priority-queue-examples';
-- 第 2 节 二叉树的深度优先遍历
UPDATE public.articles
SET url = 'tree-dfs'
WHERE id = 279 AND url = 'binary-tree-dfs';
-- 第 3 节 二叉树的中序遍历和后序遍历
UPDATE public.articles
SET url = 'tree-inorder-postorder'
WHERE id = 280 AND url = 'binary-tree-inorder-postorder';
-- 第 4 节 二叉树的广度优先遍历
UPDATE public.articles
SET url = 'tree-bfs'
WHERE id = 281 AND url = 'binary-tree-bfs';
-- 第 5 节 树的问题选讲
UPDATE public.articles
SET url = 'tree-problems'
WHERE id = 282 AND url = 'tree-examples';
-- 第 2 节 红黑树与 B 树简介
UPDATE public.articles
SET url = 'rb-tree-b-tree'
WHERE id = 285 AND url = 'red-black-tree-b-tree';
-- 第 3 节 二叉搜索树问题选讲
UPDATE public.articles
SET url = 'bst-problems'
WHERE id = 286 AND url = 'bst-examples';
-- 第 3 节 哈希冲突、装载因子与扩容
UPDATE public.articles
SET url = 'hash-collisions'
WHERE id = 290 AND url = 'hash-collision-load-factor';
-- 第 4 节 哈希表问题选讲
UPDATE public.articles
SET url = 'hash-table-problems'
WHERE id = 291 AND url = 'hash-table-examples';
-- 第 3 节 回溯算法应用于 Flood Fill 问题
UPDATE public.articles
SET url = 'flood-fill'
WHERE id = 295 AND url = 'backtracking-flood-fill';
-- 第 2 节 最优子结构
UPDATE public.articles
SET url = 'optimal-substructure'
WHERE id = 299 AND url = 'dp-optimal-substructure';
-- 第 3 节 求解过程需要满足：无后效性
UPDATE public.articles
SET url = 'dp-state-independence'
WHERE id = 300 AND url = 'dp-no-aftereffect';
-- 第 4 节 当动态规划遇到「后效性」问题怎么办？
UPDATE public.articles
SET url = 'dp-state-design'
WHERE id = 301 AND url = 'dp-aftereffect-solution';
-- 第 5 节 线性 DP 问题选讲
UPDATE public.articles
SET url = 'linear-dp'
WHERE id = 302 AND url = 'dp-linear';
-- 第 6 节 两个字符串的 DP 问题选讲
UPDATE public.articles
SET url = 'string-dp'
WHERE id = 303 AND url = 'dp-two-strings';
-- 第 7 节 区间 DP 问题选讲
UPDATE public.articles
SET url = 'interval-dp'
WHERE id = 304 AND url = 'dp-interval';
-- 第 8 节 树形 DP 问题选讲
UPDATE public.articles
SET url = 'tree-dp'
WHERE id = 305 AND url = 'dp-tree';
-- 第 9 节 0-1 背包问题
UPDATE public.articles
SET url = 'zero-one-knapsack'
WHERE id = 306 AND url = 'knapsack-01';
-- 第 10 节 完全背包问题
UPDATE public.articles
SET url = 'complete-knapsack'
WHERE id = 307 AND url = 'knapsack-complete';
-- 第 2 节 贪心算法问题选讲
UPDATE public.articles
SET url = 'greedy-problems'
WHERE id = 310 AND url = 'greedy-examples';
-- 第 2 节 广度优先遍历问题选讲
UPDATE public.articles
SET url = 'bfs-problems'
WHERE id = 313 AND url = 'bfs-examples';
-- 第 4 节 总结与练习
UPDATE public.articles
SET url = 'graph-bfs-summary'
WHERE id = 315 AND url = 'bfs-topological-summary';
-- 第 1 节 前缀和简介
UPDATE public.articles
SET url = 'prefix-sum'
WHERE id = 316 AND url = 'prefix-sum-intro';
-- 第 2 节 前缀和与哈希表
UPDATE public.articles
SET url = 'prefix-sum-hash'
WHERE id = 317 AND url = 'prefix-sum-hashmap-application';
-- 第 2 节 字典树问题选讲
UPDATE public.articles
SET url = 'trie-problems'
WHERE id = 320 AND url = 'trie-examples';
-- 第 2 节 并查集的优化 1：路径压缩
UPDATE public.articles
SET url = 'path-compression'
WHERE id = 323 AND url = 'union-find-path-compression';
-- 第 3 节 并查集的优化 2：按秩合并
UPDATE public.articles
SET url = 'union-by-rank'
WHERE id = 324 AND url = 'union-find-union-by-rank';
-- 第 4 节 并查集问题选讲
UPDATE public.articles
SET url = 'union-find-problems'
WHERE id = 325 AND url = 'union-find-examples';
-- 第 1 节 单源最短路径问题与松弛操作
UPDATE public.articles
SET url = 'relaxation'
WHERE id = 327 AND url = 'shortest-path-relaxation';
-- 第 1 节 相关概念与切分定理
UPDATE public.articles
SET url = 'mst-cut-property'
WHERE id = 333 AND url = 'mst-concepts-cut-property';
-- 第 5 部分 总结与典型问题
UPDATE public.articles
SET url = 'final-summary'
WHERE id = 338 AND url = 'summary-classic-problems';
-- 第 21 章 总结与典型问题
UPDATE public.articles
SET url = 'classic-problems'
WHERE id = 339 AND url = 'review-classic-problems';
-- 第 2 节 写在最后的话
UPDATE public.articles
SET url = 'closing-notes'
WHERE id = 341 AND url = 'final-words';

COMMIT;

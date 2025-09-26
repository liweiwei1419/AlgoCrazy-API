SET session_replication_role = 'replica';
-- public DDL
CREATE SCHEMA "public";
COMMENT ON SCHEMA "public" IS 'standard public schema';
ALTER SCHEMA "public" OWNER TO "pg_database_owner";

-- public.algorithm_categories DDL
CREATE SEQUENCE IF NOT EXISTS "public"."algorithm_categories_id_seq";
CREATE TABLE "public"."algorithm_categories" (
"id" int4 NOT NULL DEFAULT nextval('algorithm_categories_id_seq'::regclass),
"value" int4 NOT NULL,
"label" text NOT NULL,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"is_deleted" bool DEFAULT false,
PRIMARY KEY ("id"));

-- public.article_like_records DDL
CREATE SEQUENCE IF NOT EXISTS "public"."article_like_records_id_seq";
CREATE TABLE "public"."article_like_records" (
"id" int4 NOT NULL DEFAULT nextval('article_like_records_id_seq'::regclass),
"user_id" int8 NOT NULL,
"article_id" int4 NOT NULL,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"is_deleted" bool DEFAULT false,
PRIMARY KEY ("id"));

-- public.articles DDL
CREATE SEQUENCE IF NOT EXISTS "public"."articles_id_seq";
CREATE TABLE "public"."articles" (
"id" int4 NOT NULL DEFAULT nextval('articles_id_seq'::regclass),
"author" varchar(255) NOT NULL,
"title" varchar(255) NOT NULL,
"content" text NOT NULL,
"category" varchar(50),
"tags" _varchar,
"url" varchar(255),
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"like_count" int4 DEFAULT 0,
"view_count" int4 DEFAULT 0,
"is_deleted" bool DEFAULT false,
"deleted_at" timestamp(6),
"source_url" varchar(255),
"parent_id" int4,
"display_order" int4 DEFAULT 0,
"path" varchar(255) DEFAULT ''::character varying,
"is_folder" bool DEFAULT false,
"solution_url" varchar(255),
"book_check" bool DEFAULT false,
"suggestion" varchar(100),
"one_sentence_solution" varchar(255),
PRIMARY KEY ("id"));

-- public.comments DDL
CREATE SEQUENCE IF NOT EXISTS "public"."comments_id_seq";
CREATE TABLE "public"."comments" (
"id" int4 NOT NULL DEFAULT nextval('comments_id_seq'::regclass),
"article_id" int4 NOT NULL,
"user_id" int8 NOT NULL,
"content" text NOT NULL,
"parent_comment_id" int4,
"created_at" timestamp(6) DEFAULT now(),
"updated_at" timestamp(6) DEFAULT now(),
"is_deleted" bool DEFAULT false,
"is_guest" bool DEFAULT false,
"like_count" int4 DEFAULT 0,
"user_nickname" varchar(100),
"reply_count" int4 DEFAULT 0,
"reply_to_user_id" int8,
"reply_to_comment_id" int4,
PRIMARY KEY ("id"));

-- public.judge_detail DDL
CREATE SEQUENCE IF NOT EXISTS "public"."judge_detail_id_seq";
CREATE TABLE "public"."judge_detail" (
"id" int4 NOT NULL DEFAULT nextval('judge_detail_id_seq'::regclass),
"submission_id" int4 NOT NULL,
"testcase_id" int4 NOT NULL,
"status" varchar(20) NOT NULL,
"time_used" int4,
"memory_used" int4,
"is_deleted" bool DEFAULT false,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY ("id"));

-- public.judge_results DDL
CREATE SEQUENCE IF NOT EXISTS "public"."judge_results_id_seq";
CREATE TABLE "public"."judge_results" (
"id" int4 NOT NULL DEFAULT nextval('judge_results_id_seq'::regclass),
"submission_id" int4,
"test_case_index" int4,
"input" text,
"expected_output" text,
"actual_output" text,
"status" varchar(255),
"execution_time" int4,
"memory_usage" int4,
PRIMARY KEY ("id"));

-- public.problem DDL
CREATE SEQUENCE IF NOT EXISTS "public"."problem_id_seq";
CREATE TABLE "public"."problem" (
"id" int4 NOT NULL DEFAULT nextval('problem_id_seq'::regclass),
"title" varchar(255) NOT NULL,
"description" text NOT NULL,
"input_description" text,
"output_description" text,
"sample_input" text,
"sample_output" text,
"hint" text,
"time_limit" int4 DEFAULT 1000,
"memory_limit" int4 DEFAULT 65536,
"difficulty" varchar(20),
"is_deleted" bool DEFAULT false,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY ("id"));

-- public.suanfa8_user DDL
CREATE TABLE "public"."suanfa8_user" (
"id" int8 NOT NULL,
"username" varchar(100),
"password" varchar(100),
"nickname" varchar(100),
"avatar" varchar(100),
"email" varchar(100),
"role_id" int4 NOT NULL,
"homepage" varchar(100),
"is_deleted" bool NOT NULL,
"created_at" timestamp(6) NOT NULL,
"updated_at" timestamp(6) NOT NULL,
PRIMARY KEY ("id"));

-- public.submission DDL
CREATE SEQUENCE IF NOT EXISTS "public"."submission_id_seq";
CREATE TABLE "public"."submission" (
"id" int4 NOT NULL DEFAULT nextval('submission_id_seq'::regclass),
"user_id" int4 NOT NULL,
"problem_id" int4 NOT NULL,
"code" text NOT NULL,
"language" varchar(20) NOT NULL,
"status" varchar(20) DEFAULT 'pending'::character varying,
"score" int4 DEFAULT 0,
"time_used" int4,
"memory_used" int4,
"submit_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"is_deleted" bool DEFAULT false,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"message" text,
"execution_time" int4,
PRIMARY KEY ("id"));

-- public.testcase DDL
CREATE SEQUENCE IF NOT EXISTS "public"."testcase_id_seq";
CREATE TABLE "public"."testcase" (
"id" int4 NOT NULL DEFAULT nextval('testcase_id_seq'::regclass),
"problem_id" int4 NOT NULL,
"input" text NOT NULL,
"output" text NOT NULL,
"is_sample" bool DEFAULT false,
"is_deleted" bool DEFAULT false,
"created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
"updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY ("id"));

-- public.algorithm_categories Indexes
CREATE UNIQUE INDEX "algorithm_categories_value_key" ON "public"."algorithm_categories" USING btree ("value"  "pg_catalog"."int4_ops" ASC NULLS LAST);

-- public.article_like_records Indexes
CREATE UNIQUE INDEX "article_like_records_user_id_article_id_key" ON "public"."article_like_records" USING btree ("user_id"  "pg_catalog"."int8_ops" ASC NULLS LAST,"article_id"  "pg_catalog"."int4_ops" ASC NULLS LAST);
ALTER TABLE "public"."article_like_records" ADD CONSTRAINT "article_like_records_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."suanfa8_user" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."article_like_records" ADD CONSTRAINT "article_like_records_article_id_fkey" FOREIGN KEY ("article_id") REFERENCES "public"."articles" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;

-- public.articles Indexes
CREATE UNIQUE INDEX "idx_articles_url" ON "public"."articles" USING btree ("url" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST);
COMMENT ON COLUMN "public"."articles"."source_url" IS '原题链接';
COMMENT ON COLUMN "public"."articles"."solution_url" IS '题解地址';
COMMENT ON COLUMN "public"."articles"."book_check" IS '书本校对，临时字段';
COMMENT ON COLUMN "public"."articles"."suggestion" IS '审核建议';

-- public.comments Indexes
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_article_id_fkey" FOREIGN KEY ("article_id") REFERENCES "public"."articles" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."comments" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."suanfa8_user" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_reply_to_user_id_fkey" FOREIGN KEY ("reply_to_user_id") REFERENCES "public"."suanfa8_user" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_reply_to_comment_id_fkey" FOREIGN KEY ("reply_to_comment_id") REFERENCES "public"."comments" ("id")ON DELETE NO ACTION ON UPDATE NO ACTION;

-- public.judge_detail Indexes
ALTER TABLE "public"."judge_detail" ADD CONSTRAINT "judge_detail_submission_id_fkey" FOREIGN KEY ("submission_id") REFERENCES "public"."submission" ("id")ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."judge_detail" ADD CONSTRAINT "judge_detail_testcase_id_fkey" FOREIGN KEY ("testcase_id") REFERENCES "public"."testcase" ("id")ON DELETE CASCADE ON UPDATE NO ACTION;

-- public.judge_results Indexes
COMMENT ON COLUMN "public"."judge_results"."status" IS 'Possible values: PASSED, FAILED, TIME_LIMIT_EXCEEDED, MEMORY_LIMIT_EXCEEDED';

-- public.suanfa8_user Indexes
COMMENT ON TABLE "public"."suanfa8_user" IS '用户表';
COMMENT ON COLUMN "public"."suanfa8_user"."id" IS '主键';
COMMENT ON COLUMN "public"."suanfa8_user"."username" IS '用户名';
COMMENT ON COLUMN "public"."suanfa8_user"."password" IS '密码';
COMMENT ON COLUMN "public"."suanfa8_user"."nickname" IS '昵称';
COMMENT ON COLUMN "public"."suanfa8_user"."avatar" IS '头像';
COMMENT ON COLUMN "public"."suanfa8_user"."email" IS '邮箱';
COMMENT ON COLUMN "public"."suanfa8_user"."role_id" IS '角色（1：管理员，0：普通用户）';
COMMENT ON COLUMN "public"."suanfa8_user"."homepage" IS '个人主页';
COMMENT ON COLUMN "public"."suanfa8_user"."is_deleted" IS '是否删除（0：未删除，1：已删除）';
COMMENT ON COLUMN "public"."suanfa8_user"."created_at" IS '创建时间';
COMMENT ON COLUMN "public"."suanfa8_user"."updated_at" IS '修改时间';

-- public.submission Indexes
ALTER TABLE "public"."submission" ADD CONSTRAINT "submission_problem_id_fkey" FOREIGN KEY ("problem_id") REFERENCES "public"."problem" ("id")ON DELETE CASCADE ON UPDATE NO ACTION;

-- public.testcase Indexes
ALTER TABLE "public"."testcase" ADD CONSTRAINT "testcase_problem_id_fkey" FOREIGN KEY ("problem_id") REFERENCES "public"."problem" ("id")ON DELETE CASCADE ON UPDATE NO ACTION;

-- public.algorithm_categories DML
INSERT INTO "public"."algorithm_categories" ("id","value","label","created_at","updated_at","is_deleted") VALUES (1,1,'基础排序算法','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(2,2,'递归','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(3,3,'循环不变量','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(4,4,'归并排序','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(5,5,'快速排序','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(6,6,'滑动窗口','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(7,7,'双指针','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(8,8,'二分查找','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(9,9,'链表','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(10,10,'栈','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(11,11,'队列','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(12,12,'优先队列','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(13,13,'二叉树','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(14,14,'二叉搜索树','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(15,15,'哈希表','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(16,16,'回溯算法','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(17,17,'动态规划','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(18,18,'贪心算法','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(19,19,'广度优先遍历与拓扑排序','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(20,20,'前缀和','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(21,21,'字典树','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(22,22,'位运算','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(23,23,'并查集','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(24,24,'单源短路径','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(25,25,'最小生成树','2025-06-11 03:50:49','2025-06-11 03:50:49',false),(26,26,'暂时无法分类','2025-06-11 03:50:49','2025-06-11 03:50:49',false);
-- public.article_like_records DML
INSERT INTO "public"."article_like_records" ("id","user_id","article_id","created_at","updated_at","is_deleted") VALUES (2,1575406949798027265,19,'2025-06-24 11:01:08','2025-06-24 03:01:08',false),(3,1575406949798027265,64,'2025-06-24 11:25:48','2025-06-24 03:25:48',false),(5,1575406949798027265,118,'2025-07-16 01:36:26','2025-07-16 01:36:26',false),(6,1575406949798027265,119,'2025-07-16 01:36:45','2025-07-16 01:36:45',false),(7,1575406949798027265,5,'2025-07-27 03:06:26','2025-07-27 03:06:26',false);
-- public.articles DML
INSERT INTO "public"."articles" ("id","author","title","content","category","tags","url","created_at","updated_at","like_count","view_count","is_deleted","deleted_at","source_url","parent_id","display_order","path","is_folder","solution_url","book_check","suggestion","one_sentence_solution") VALUES (26,'liweiwei1419','第 3 章 时间复杂度：衡量算法效率的的理论工具','',NULL,NULL,'time-complexity','2025-06-09 12:18:02','2025-06-09 12:18:02',0,2,false,NULL,NULL,20,3,'',false,NULL,true,NULL,'时间复杂度是理论概念，它预测了当数据量很大的时候，算法执行的快慢。'),(6,'liweiwei1419','「力扣」第 3 题：无重复字符的最长子串（中等）','# 理解题意

根据「示例 3」的解释，子串是原字符串种 **连续** 的一部分，区别于子序列。题目中的关键字是 **连续**、**不重复**、**最长**。

我们先介绍暴力解法，然后再针对暴力解法进行优化。通常优化解法都是建立在分析清楚暴力解法的缺陷和多余的操作以后提出的。

## 思路分析
**暴力解法**：枚举所有的子串，再对每一个子串判断是否有重复字符，时间复杂度为 $ O(n^3) $，这里 $ n $ 是输入字符串的长度。

**优化思路**：在枚举子串的过程中，我们注意到：**如果一个子串包含重复字符，那么与它有相同左端点的、长度更长的字符串一定也包含重复字符，这部分子串就没有必要枚举（这一点很关键，是本题可以使用滑动窗口算法的原因）**。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image11016072773196746969.png)

如何找到下一个没有重复字符的子串呢？如上图所示，在 `a` 处遇到了重复字符，我们应该在 `a` 第 1 次出现的位置的右侧继续寻找没有重复字符的子串，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image10040074184651906015.png)


基于以上的分析，我们就可以使用 **右指针变量 `right`、左指针变量 `left` 交替向右移动的方式，找出所有的没有重复字符的子串**，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image5723601162984519534.png)


在右边界 `right` 向右移动的过程中，无重复的子串的长度在增加，我们在这个时候记录没有重复子串的长度最长值。

综上所述：

+ **右边界 `right` 右移，是为了：尝试找到更长的没有重复字符的子串，直到子串中包含重复字符；**
+ **左边界 `left` 右移，是为了：使得原来有重复字符的子串，变成没有重复字符，然后右边界 `right` 右移，尝试找更长的没有重复字符的子串。**

**编码细节**：如何判断子串里是否有重复的字符呢？

+ 在遍历的时候顺便统计每个字符出现的次数，出现 2 次就表示子串中出现了重复字符；
+ 题目的「提示」里说：`s` 由英文字母、数字、符号和空格组成。查阅 ASCII 表，最大值为 127，因此我们可以开辟一个长度为 128 的整型数组，表示每个字符出现的个数，数组的下标表示字符的 ASCII 数值，数组的值记录了对应的字符出现的次数；
+ 在右边界 `right` 右移的时候，纳入窗口的字符频数增加，在左边界 `left` 右移的时候，移出窗口的字符频数减少。

以「示例 1」：输入 `"abcabcbb"`，输出 `3` 为例，滑动窗口的解法如下表格所示，其中「操作」一栏，「扩张」表示滑动窗口右边界 `right` 右移，「收缩」表示滑动窗口左边界 `left` 右移。

| 步骤 | 窗口 | 每个字符出现的次数 | 是否重复 | 下一步操作 | 当前最大长度 |
| --- | --- | --- | --- | --- | --- |
| 1 | `''''` | `{}` | 无 | 扩张 | 0 |
| 2 | `''a''` | `{''a'':1}` | 无 | 扩张 | 1 |
| 3 | `''ab''` | `{''a'':1,''b'':1}` | 无 | 扩张 | 2 |
| 4 | `''abc''` | `{''a'':1,''b'':1,''c'':1}` | 无 | 扩张 | 3 |
| 5 | `''abca''` | `{''a'':2,''b'':1,''c'':1}` | `''a''` 重复 | 收缩 | 3 |
| 6 | `''bca''` | `{''a'':1,''b'':1,''c'':1}` | 无 | 扩张 | 3 |
| 7 | `''bcab''` | `{''a'':1,''b'':2,''c'':1}` | `''b''` 重复 | 收缩 | 3 |
| 8 | `''cab''` | `{''a'':1,''b'':1,''c'':1}` | 无 | 扩张 | 3 |
| 9 | `''cabc''` | `{''a'':1,''b'':1,''c'':2}` | `''c''` 重复 | 收缩  | 3 |
| 10 | `''abc''` | `{''a'':1,''b'':1,''c'':1}` | 无 | 扩张 | 3 |
| 11 | `''abcb''` | `{''a'':1,''b'':2,''c'':1}` | `''b''` 重复 | 收缩 | 3 |
| 12 | `''bcb''` | `{''b'':2,''c'':1}` | `''b''` 重复 | 收缩 | 3 |
| 13 | `''cb''` | `{''b'':1,''c'':1}` | 无 | 扩张 | 3 |
| 14 | `''cbb''` | `{''b'':2,''c'':1}` | `''b''` 重复 | 收缩 | 3 |
| 15 | `''bb''` | `{''b'':2}` | `''b''` 重复 | 收缩 | 3 |
| 16 | `''b''` | `{''b'':1}` | 无 | 程序结束 |  3 |


**最终结果**：最大长度为 `3`（如 `"abc"` 或 `"bca"`）。

**参考代码 1**：

```java
public class Solution {

    public int lengthOfLongestSubstring(String s) {
        int n = s.length();
        if (n < 2) {
            return n;
        }
        
        // 题目的提示说：s 由英文字母、数字、符号和空格组成，查阅 ASCII 表，最大值为 127
        // 为了使得 freq[127] 不越界，开辟有 128 个长度的数组
        int[] freq = new int[128];
        // 转换为字符数组，避免每一次 s.charAt() 方法检查下标越界
        char[] charArray = s.toCharArray();
        int left = 0;
        int right = 0;
        int maxLen = 1;
        while (right < n) {
            freq[charArray[right]]++;
            while (freq[charArray[right]] == 2) {
                // 当 window 中某个字符的频数为 2 时，表示滑动窗口内有重复字符
                freq[charArray[left]]--;
                left++;
                // 左移以后，继续检查当前右边界字符是否还会重复，这个过程不止重复一次，所以内层也用 while
            }
            // 此时子串 s[left..right] 没有重复元素，其长度为 right - left + 1
            maxLen = Math.max(maxLen, right - left + 1);
            right++;
        }
        return maxLen;
    }
     
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度。右指针遍历了数组一次，左指针还没有遍历到数组的末尾就停了下来；
+ 空间复杂度：$ O(|C|) $，其中 $ C $ 表示所有可能出现的字符的集合，$ |C| $表示不同字符的个数。

**再次优化**：根据上面的分析，我们设置的左边界 `left` 需要一步一步来到 `right` 所在位置字符的右侧，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image5841122573289594946.png)


其实可以 **在遍历的时候记录当前遍历到的字符出现的下标**，并且遇到相同字符的时候只需要更新就好了，因为即使 `right` 所在位置字符在之前出现多次，`left` 只需要来到 **与 `right` 位置最近的（即下标值最大的）之前出现过的位置**。这里还需要注意：**以前出现过的位置，如果在左边界 `left` 之前，是无效的**，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image4797811799092240389.png)


所以只有在上一次出现的位置在 `left` 以及 `left` 的右边，才更新 `left` 到上一次出现的位置的右边。

**参考代码 2**：

```java
import java.util.Arrays;

public class Solution {

    public int lengthOfLongestSubstring(String s) {
        int n = s.length();
        if (n < 2) {
            return n;
        }

        // 记录了每个字符在数组中的下标，初始化的时候为 -1 表示还未读到数据
        int[] position = new int[128];
        Arrays.fill(position, -1);
        char[] charArray = s.toCharArray();
        int maxLen = 1;
        for (int left = 0, right = 0; right < n; right++) {
            // 如果已经出现过，左边界应该更新到（最新的）上一次相同字符的下一个位置
            if (position[charArray[right]] != -1 && position[charArray[right]] >= left) {
                left = position[charArray[right]] + 1;
            }
            maxLen = Math.max(maxLen, right - left + 1);
            position[charArray[right]] = right;
        }
        return maxLen;
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题小结

- 由于题目要我们找 **最长不重复子串的长度**，右边界右移，尝试找到更长的不包括重复字符的子串；
- 当子串中包含重复字符时，右边界继续右移，依然包含重复字符，此时应该将左边界右移，让子串不包含重复字符以后，再让右边界右移，如此反复；
- 通过维护字符的频数或者出现的下标判断子串中的字符是否重复。

我们用数对 `(i, j)` 表示子串 `s[i..j]` ，把暴力解法和滑动窗口算法需要考虑的情况列成如下的表格进行对比。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image11642076753979470772.png)

滑动窗口算法避免了暴力解法的多余计算，使得时间复杂度降低了一个级别。','6',NULL,'0003-longest-substring-without-repeating-characters','2025-06-09 06:39:28','2025-06-12 17:06:07',1,18,false,NULL,'https://leetcode.cn/problems/longest-substring-without-repeating-characters/description/',29,1,'',false,'https://leetcode.cn/problems/longest-substring-without-repeating-characters/solutions/8210/ge-ban-fa-hua-dong-chuang-kou-dong-tai-gui-hua-pyt/',true,NULL,NULL),(1,'liweiwei1419','测试修改','测试','17',NULL,'0091-decode-ways','2025-06-08 21:57:39','2025-06-19 12:43:16',0,1,true,NULL,'https://leetcode.cn/problems/decode-ways/description/',39,10,'',false,'',true,'完成。',NULL),(85,'liweiwei1419','「力扣」第 135 题：分发糖果（困难）','

## 思路分析
题目说：相邻的孩子中，评分高的孩子必须获得更多的糖果。这意味着：

+ 如果一个孩子的评分比他左边的孩子高，那么他应该比左边的孩子得到更多的糖果；
+ 如果一个孩子的评分比他右边的孩子高，那么他应该比右边的孩子得到更多的糖果；
+ **如果相邻的两个孩子评分相同，根据「示例 2」，右边的孩子可以少分一棵糖果**。

为了给出最少的糖果，需要同时满足每个孩子与左边孩子和右边孩子的需求。为了同时满足这两个条件，我们需要：

+ 从左到右遍历：确保每个孩子比左边评分低的孩子糖果多；
+ 从右到左遍历：确保每个孩子比右边评分低的孩子糖果多。

具体做法是：

+ 第一次遍历（从左到右）：如果当前孩子的评分比左边的高，那么当前孩子的糖果数至少是左边孩子的糖果数加一。初始化 `left` 数组为 1，因为每个孩子至少一个糖果。从左到右遍历，如果`ratings[i] > ratings[i - 1]`，则 `left[i] = left[i - 1] + 1`；
+ 第二次遍历（从右到左）：如果当前孩子的评分比右边的高，那么当前孩子的糖果数至少是右边孩子的糖果数加一。初始化 `right` 数组为 1。从右到左遍历，如果 `ratings[i] > ratings[i + 1]`，则`right[i] = right[i + 1] + 1`。
+ 合并结果：对于每个孩子，取 `left` 和 `right` 中的较大值，因为需要同时满足左右两边的条件。`res += Math.max(left[i], right[i])`。

**参考代码 1**：

```java
import java.util.Arrays;

public class Solution {

    public int candy(int[] ratings) {
        int n = ratings.length;
        int[] left = new int[n];
        int[] right = new int[n];
        // 每个小朋友至少分到一个苹果
        Arrays.fill(left, 1);
        Arrays.fill(right, 1);

        for (int i = 1; i < n; i++) {
            if (ratings[i] > ratings[i - 1]) {
                left[i] = left[i - 1] + 1;
            }
        }
        for (int i = n - 2; i >= 0; i--) {
            if (ratings[i] > ratings[i + 1]) {
                right[i] = right[i + 1] + 1;
            }
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            res += Math.max(left[i], right[i]);
        }
        return res;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，因为进行了 3 次线性遍历；
+ 空间复杂度：$ O(n) $，因为使用了两个额外的数组 `left` 和 `right`。

这个解法我们可以叫它动态规划，`left` 和 `right` 是状态数组。其实本题到这里就可以了，优化解法的时间复杂度还是 $ O(n) $，只不过只需要遍历一次。下面介绍的贪心算法当作开阔思路。

## 贪心算法
我们尝试在一次遍历中同时考虑左右关系，分为如下 3 种情况：

+ **情况 1**： 如果当前孩子评分比前一个高，处于上升趋势，给糖果的个数需要依次增加，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0135-candy/temp-image17096698196918926057.png)

给当前孩子的个数等于上升次数 + 1。

+ **情况 2**：如果当前孩子评分比前一个低，处于下降趋势，在转折处应该先给一颗糖果，如果转折以后一直处于下降趋势，需要给依次给下降序列的孩子补上糖果，如下图所示；

![](https://minio.dance8.fun/algo-crazy/0135-candy/temp-image14747316611974212513.png)

每下降一次，给糖果的数量在数值上等于处于下降趋势的长度，即下降一次补 1 颗糖，下降 2 次补 2 颗糖。这里补的糖数不包括峰值处，处于峰值处的孩子要补多少颗糖放在情况「情况 3」讨论。

+ **情况 3**： 还有一种情况，我们还需要给处于峰值处的孩子再补 1 颗糖，那就是下降序列的长度超过上升序列的长度时，还需要再给处于上升、下降的峰值的孩子补 1 颗糖果，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0135-candy/temp-image4919335177441652344.png)

综上所述，我们在一次遍历的过程中，就需要记录上升的次数 `inc` 和下降的次数 `dec`。在遍历的过程中，无非就是遇到上升、下降和持平 3 种情况，我们分别针对这 3 种情况处理即可，处理细节我们放在「参考代码 2」中。

**参考代码 2**：

```java
public class Solution {

    public int candy(int[] ratings) {
        int n = ratings.length;
        if (n == 0) {
            return 0;
        }

        // 当前连续上升的长度（不包括当前元素）
        int inc = 0;
        // 记录上一次的连续上升长度，在下降时 inc 会被重置，因此需要复制一个变量出来
        int preInc = inc;
        // 当前连续下降的长度
        int dec = 0;
        // 总糖果数，第一个孩子给 1 颗糖
        int res = 1;
        for (int i = 1; i < n; i++) {
            if (ratings[i - 1] < ratings[i]) {
                inc++;
                dec = 0;
                // 在上升和持平的时候 preInc 都等于 inc
                preInc = inc;
                res += (inc + 1);
            } else if (ratings[i - 1] == ratings[i]) {
                // 重置 inc、dec、preInc
                inc = 0;
                dec = 0;
                preInc = inc;
                res++;
            } else {
                inc = 0;
                dec++;
                // 由于 inc 被重置，使用 preInc 和 dec 比较
                if (dec > preInc) {
                    // 需要给最高峰再补 1 颗糖果（因为之前的上升峰值不够覆盖下降）
                    res += (dec + 1);
                } else {
                    res += dec;
                }
            }
        }
        return res;
    }
    
}
```

**说明**：由于在下降的时候（当 `ratings[i - 1] < ratings[i]`时，即上面代码的 `else` 情况），`inc` 被重置为 0，而我们优需要比较之前 `inc` 和 `dec` 的数值，因此我们复制 `inc` 的值到 `preInc` ，在上升和持平的时候 `preInc` 都等于 `inc` ，在下降的时候，用复制出来的 `preInc` 的值和 `inc` 比较。这是因为在下降有可能是持续的，`inc` 被覆盖但我们还需要它的值，所以就得再复制一个变量。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组的长度，我们只遍历了输入数组一次；
+ 空间复杂度：$ O(1) $。只使用了常数个临时变量。

','18',NULL,'0135-candy','2025-06-11 08:20:34','2025-06-16 14:46:06',1,9,false,NULL,'https://leetcode.cn/problems/candy/description/',40,7,'',false,NULL,true,'完成。',NULL),(17,'liweiwei1419','「力扣」第 10 题：正则表达式匹配（困难）','## 理解题意

本题题意的重点是两个通配符的含义：

+ `.` 匹配任意 1 个字符，与之前是什么字符无关；
+ `*` 与之前的 1 个字符有关，可以表示把之前的那个字符消去（匹配 0 次），也可以表示之前的那个字符出现多次（匹配 1 次或者多次）

## 思路分析
本题其实是「最长公共子序列」问题的进阶版本，状态的定义是类似的，只不过在状态转移的时候，分类讨论的细节多了一些。

+ **状态定义**：二维数组 `dp`，其中 `dp[i][j]` 表示 `s` 的前 `i` 个字符（即 `s[0..i - 1]`）和 `p` 的前 `j` 个字符（即 `p[0..j - 1]`）是否匹配。**注意**：`dp` 的下标 `i` 和 `j` 比字符串的实际下标大 1，这是为了处理空字符串（即 `i = 0` 或 `j = 0` 时表示空串）；
+ **状态转移方程**：针对 `p` 中的通配符进行分类讨论，按照「先简单后复杂」的顺序会容易一些。`*` 是相对复杂的情况，因为它还要看前一个字符，所以我们先讨论 `p[j - 1]` 不是 `*` 的时候。
    - **情况 1**： 如果 `p[j - 1]` 不是 `*`。不是 `*` 的时候，分为两种情况「对应的字符相等」和「 `p[j - 1] = ''.''`」，所以：
        * **当 `s[i - 1] == p[j - 1]` 或者 `p[j - 1] == ''.''` 时**，`dp[i][j] = dp[i - 1][j - 1]`；
        * 否则 `dp[i][j] = false`。
    - **情况 2**： 如果 `p[j - 1]` 是 `*`，就需要讨论 `*` 之前的字符 `p[j - 2]` 与 `s[i - 1]` 的匹配情况。
        * 当 `*` 把前面字符匹配 0 次时：`p[j - 2]` 是什么都可以（ `*` 的作用是消去 `p[j - 2]` 的匹配），此时我们忽略 `p[j - 2]` 和 `''*''`，即 `p[0..j - 3]` 部分需要匹配 `s[0..i - 1]` 部分，对应状态转移是 `dp[i][j] = dp[i][j - 2]`；
        * 当 `*` 把前面字符匹配 1 次或者多次时，首先需要满足 `p[j - 2]` 和 `s[i - 1]` 匹配，即：`s[i - 1] == p[j - 2]` 或者 `p[j - 2] ==  ''.''`，因为 `''*''` 可以继续匹配，然后再看`s[0..i - 2]` 与 `p[0..j - 1]` 的匹配情况，此时 `dp[i][j] = dp[i - 1][j]`。这时你可以看作 `''*''` 去掉了 `s[i - 1]`，并继续用 `p[0..j - 1]`（即 `''*''` 仍在模式中）去匹配 `s[0..i - 2]`。

这么说可能还是太抽象了，我们用一个具体的例子来解释。以 `s = "abcd"`，`p = "abcda*"` 为例，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0010-regular-expression-matching/temp-image16136367037051536936.png)

此时 `p[j - 1] = ''*''`，`p[j - 2] = s[i - 1]` ，此时 `s[0..i - 1]` 与 `p[0..j - 1]` 的匹配情况 `dp[i][j]` 就等于去掉 `s[i - 1]` 但保留 `p[j - 1]` 的之前的匹配情况，即 `dp[i][j] = dp[i - 1][j]`。本例表示：**要匹配多次，首先得从匹配 0 次、匹配 1 次开始**， 然后再往 `s` 的后面加上更多的 `a` ，因为 `''a'' == p[j - 2]` ，就能一直匹配正确，因此当 `p[j - 2] = s[i - 1]` 或者 `p[j - 2] = ''.''` 时，`dp[i][j] = dp[i - 1][j]`。

+ **考虑初始化**：
    - `dp[0][0] = true`：空字符串匹配空模式；
    - `dp[i][0] = false`：非空字符串不匹配空模式；
    - `dp[0][j]`：当 `s` 为空时，模式 `p` 能否匹配它取决于 `p` 是否能「去掉」前面的字符，而 `''*''` 是唯一能「去掉」字符的通配符，因为它可以匹配零个前面的字符，所以是 `dp[0][j] = dp[0][j - 2]`。
+ **考虑输出值**：输出即 `dp[m][n]`；


**参考代码 1**：

```java
public class Solution {

    public boolean isMatch(String s, String p) {
        int m = s.length();
        int n = p.length();
        char[] sCharArray = s.toCharArray();
        char[] pCharArray = p.toCharArray();
        boolean[][] dp = new boolean[m + 1][n + 1];
        // 初始化，空字符串匹配空模式
        dp[0][0] = true;
        // 处理模式中 ''*'' 可以匹配零个字符的情况
        for (int j = 1; j <= n; j++) {
            if (pCharArray[j - 1] == ''*'') {
                dp[0][j] = dp[0][j - 2];
            }
        }

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                char sc = sCharArray[i - 1];
                char pc = pCharArray[j - 1];
                if (pc == ''.'' || sc == pc) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else if (pc == ''*'') {
                    char prevChar = pCharArray[j - 2];
                    // 匹配零个字符
                    dp[i][j] = dp[i][j - 2];
                    if (prevChar == ''.'' || sc == prevChar) {
                        // 匹配多个字符
                        dp[i][j] = dp[i][j - 2] || dp[i - 1][j];
                    }
                }
            }
        }
        return dp[m][n];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(mn) $，其中 $ m $ 是字符串 `s` 的长度，$ n $ 是模式 `p` 的长度；
+ 空间复杂度：$ O(mn) $，用于存储动态规划的二维表格。

**考虑优化空间**：注意到 `dp[i][j]` 的状态只依赖于：上一行的 `dp[i - 1][j]`、 当前行的 `dp[i][j - 1]` 或 `dp[i][j - 2]`。因此，我们可以将二维数组优化为一维数组，只需要保存前一行的状态即可。

**参考代码 2**：

```java
public class Solution {

    public boolean isMatch(String s, String p) {
        int m = s.length();
        int n = p.length();
        char[] sCharArray = s.toCharArray();
        char[] pCharArray = p.toCharArray();
        boolean[] dp = new boolean[n + 1];
        dp[0] = true;
        for (int j = 1; j <= n; j++) {
            if (pCharArray[j - 1] == ''*'') {
                dp[j] = dp[j - 2];
            }
        }
        for (int i = 1; i <= m; i++) {
            // 保存 dp[i - 1][0]的值
            boolean prev = dp[0];
            // s 不为空但 p 为空，肯定不匹配
            dp[0] = false;
            for (int j = 1; j <= n; j++) {
                // 保存 dp[i - 1][j] 的值
                boolean temp = dp[j];
                char sc = sCharArray[i - 1];
                char pc = pCharArray[j - 1];
                if (pc == ''.'' || pc == sc) {
                    // prev 是 dp[i - 1][j - 1]
                    dp[j] = prev;
                } else if (pc == ''*'') {
                    char prevChar = pCharArray[j - 2];
                    if (prevChar == ''.'' || prevChar == sc) {
                        // dp[j - 2] 是 dp[i][j - 2], temp 是 dp[i - 1][j]
                        dp[j] = dp[j - 2] || temp;
                    } else {
                        dp[j] = dp[j - 2];
                    }
                } else {
                    dp[j] = false;
                }
                // 更新 prev 为 dp[i - 1][j]，供下一列使用
                prev = temp;
            }
        }
        return dp[n];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(mn) $，与「参考代码 1」相同；
+ 空间复杂度：$ O(n) $，优化为一维数组。

## 本题总结
本题的关键点是处理通配符：

+ `''.''` 或字符匹配：`dp[i][j] = dp[i - 1][j - 1]`；
+ `''*''`：分匹配零次（`dp[i][j - 2]`）或多次（`dp[i - 1][j]`）。

难点是：`''*''` 匹配 1 次或者多次时，由于 `p[j - 1]` 仍可继续匹配 `s[i - 1]` 前面的字符，所以 `dp[i][j] = dp[i - 1][j]`（），结合本文中具体的例子来理解会容易一些。

# 总结
本节通过 3 个经典问题展示了动态规划在解决两个字符串关系问题中的应用：

+ 定义状态时通常使用「前缀子串」的概念；
+ 状态转移往往基于字符串末尾字符的关系；
+ 初始化边界条件（特别是空字符串情况）非常重要；
+ 空间优化可以通过滚动数组等技术实现。','17',NULL,'0010-regular-expression-matching','2025-06-09 11:08:39','2025-06-18 18:29:56',1,8,false,NULL,'https://leetcode.cn/problems/regular-expression-matching/description/',39,16,'',false,NULL,true,'完成。',NULL),(25,'liweiwei1419','第 2 章 循环不变量：明确变量的定义，写出逻辑清晰的代码','',NULL,NULL,'loop-invariant','2025-06-09 12:18:02','2025-06-09 12:18:02',0,17,false,NULL,NULL,20,2,'',false,NULL,true,NULL,'写代码需要语义清晰，可读性强，「循环不变量」就是很好的例子。'),(5,'liweiwei1419','「力扣」第 152 题：乘积最大子序列（中等）','## 思路分析

本题与「力扣」第 53 题（最大子数组和）有相似之处，子数组是数组中连续的部分，只是本题求的是连续子数组的最大乘积。

我们初步的状态定义和「力扣」第 53 题一样，以 `nuns[i]` 结尾的最大乘积（即 1、`nums[i]` 必须被选择；2、以 `nuns[i]` 结尾），但乘积这件事情有一个特殊的性质：**乘以一个负数会使得最大值和最小值互换**。即：原本的最大值乘以负数后变成最小值，原本的最小值乘以负数后变成最大值。这一点提示我们：**在设计状态的时候，就需要将「最小值」与「最大值」都定义出来，因此我们对状态数组增加维度**。

+ **状态定义**：
    - `dp[i][0]` 表示：以 `nums[i]` 结尾的连续子数组的最小乘积；
    - `dp[i][1]` 表示：以 `nums[i]` 结尾的连续子数组的最大乘积。
+ **状态转移方程**：在推导状态转移方程的时候，根据 `nums[i]` 和 `dp[i - 1][0]`、`dp[i - 1][1]` 的正负分类讨论。整体思想还是类似「力扣」第 53 题：**如果之前的乘积对结果「有用」则累积起来，无用（或者说累积起来不会使得结果更好）则丢弃**。为了避免冗长的文字叙述，我们列表格如下：

![](https://minio.dance8.fun/algo-crazy/0152-maximum-product-subarray/temp-image6258836020870361948.png)

写出状态转移方程如下：

![](https://minio.dance8.fun/algo-crazy/0152-maximum-product-subarray/temp-image16555287990768630457.png)

+ **考虑初始值**：根据定义，`nums[0]` 必须被选，所以 `dp[0][0] = nums[0]` ，`dp[0][1] = nums[0]` ；
+ **考虑最终结果**：在遍历完整个数组后，我们需要找出最大的 `dp[i][1]`。

**参考代码 1**：

```java
public class Solution {

    public int maxProduct(int[] nums) {
        int n = nums.length;
        // dp[i][0]：以 nums[i] 结尾的连续子数组的最小值
        // dp[i][1]：以 nums[i] 结尾的连续子数组的最大值
        int[][] dp = new int[n][2];
        dp[0][0] = nums[0];
        dp[0][1] = nums[0];
        for (int i = 1; i < n; i++) {
            if (nums[i] >= 0) {
                dp[i][0] = Math.min(nums[i], nums[i] * dp[i - 1][0]);
                dp[i][1] = Math.max(nums[i], nums[i] * dp[i - 1][1]);
            } else {
                dp[i][0] = Math.min(nums[i], nums[i] * dp[i - 1][1]);
                dp[i][1] = Math.max(nums[i], nums[i] * dp[i - 1][0]);
            }
        }

        // 只关心最大值，需要遍历
        int res = dp[0][1];
        for (int i = 1; i < n; i++) {
            res = Math.max(res, dp[i][1]);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 表示数组的长度；
+ 空间复杂度：$ O(n) $，使用了两个状态数组，每个状态数组的大小都是 $ n $。
+ **考虑优化空间**：由于 `dp[i][0]` 和 `dp[i][1]` 只参考了 `dp[i - 1][0]` 和 `dp[i - 1][1]` 的值，可以使用两个变量作为滚动变量，实现状态转移。

**参考代码 2**：

```java
public class Solution {

    public int maxProduct(int[] nums) {
        int n = nums.length;
        // 以 nums[i - 1] 结尾的连续子数组的最大乘积
        int preMax = nums[0];
        // 以 nums[i - 1] 结尾的连续子数组的最小乘积
        int preMin = nums[0];
        // 赋值滚动变量
        int curMax;
        int curMin;
        int res = nums[0];
        for (int i = 1; i < n; i++) {
            if (nums[i] >= 0) {
                curMax = Math.max(preMax * nums[i], nums[i]);
                curMin = Math.min(preMin * nums[i], nums[i]);
            } else {
                curMax = Math.max(preMin * nums[i], nums[i]);
                curMin = Math.min(preMax * nums[i], nums[i]);
            }
            res = Math.max(res, curMax);

            // 赋值滚动变量
            preMax = curMax;
            preMin = curMin;
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 表示数组的长度；
+ 空间复杂度：$ O(1) $，使用了常数个变量。

## 本题总结
+ 固定以 `nums[i]` 结尾能约束子问题范围，让状态转移容易；
+ 升维：同时维护最大/最小值，能处理负数导致的极值翻转问题。

它们是解决子数组/子序列 DP 问题的常见方法和技巧。','17',NULL,'0152-maximum-product-subarray','2025-06-08 22:11:51','2025-07-27 02:21:27',2,12,false,NULL,'https://leetcode.cn/problems/maximum-product-subarray/description/',39,7,'',false,'https://leetcode.cn/problems/maximum-product-subarray/solutions/251440/dong-tai-gui-hua-li-jie-wu-hou-xiao-xing-by-liweiw/',true,'完成。',NULL),(108,'liweiwei1419','「力扣」第 374 题：猜数字大小（简单）','以前中央电视台有个节目叫「幸运 52」，里面有个猜价格游戏。游戏是这么玩的：当主持人展示一款商品时，选手猜测价格为 50 元，主持人提示「价格低了」，选手根据这一信息，再次猜测价格为 70 元，主持人又提示「价格高了」，选手继续调整价格猜测，如此反复，直到猜出正确价格或用完规定的猜测次数。猜价格的策略就应用了二分查找的思想：减而治之，即：逐渐减少搜索区间，然后处理之。

查字典其实也用到了类似二分查找的思想：先翻到（大致的）位置，将该页首字与目标字对比，若首字比目标字靠后，往前翻，若靠前，往后翻。不断如此，定位目标字。

我们这一节向大家介绍两道非常基础的二分查找问题，它们是：

- 「力扣」第 374 题：猜数字大小（简单）；
- 「力扣」第 704 题：二分查找（简单）。

# 例题 1：「力扣」第 374 题：猜数字大小（简单）
+ 题目链接：[https://leetcode.cn/problems/guess-number-higher-or-lower/description/](https://leetcode.cn/problems/guess-number-higher-or-lower/description/)

## 思路分析

本题其实就是「猜价格游戏」，是二分查找最开始的样子：**查找一个有范围的整数**。

题目中的「我」是「出题人」，而「你」是「我们编写的程序」，大家区分清楚就好。题目要猜的数在 1 到 `n` 之间，于是初始化两个变量，`left = 1` 和 `right = n`，表示搜索的左右边界。每次循环计算中间值 `mid = (left + righ) / 2`（此处 `mid` 是 `middle` 的简写），调用函数 `guess(mid)` 来判断 `mid` 是否是要猜的数字：

+ 如果 `guess(mid) == 0`，说明猜对了，返回 `mid`；
+ 如果 `guess(mid) == -1`，题目说「你猜的数字比我选出的数字大」，所以「我们编写的程序」猜大了，下一轮应该往小了猜，因此将 `right` 更新为 `mid - 1`，设置 `right = mid - 1`；
+ 如果 `guess(mid) = 1`，题目说「你猜的数字比我选出的数字小」，说明「我们编写的程序」猜小了，下一轮应该往大了猜，因此将 `left` 更新为 `mid + 1`，设置 `left = mid + 1`。

重复上述过程，直到找到目标数字。

**参考代码 1**：

```java
public class Solution extends GuessGame {

    public int guessNumber(int n) {
        int left = 1;
        int right = n;
        while (left <= right) {
            // 写 int mid = (left + right) / 2; 在 left + right 超过 int 范围的时候会溢出
            // 可以改成 int mid = left + (right - left) / 2; 或者改成 int mid = (left + right) >>> 1;
            int mid = left + (right - left) / 2;
            if (guess(mid) == 0) {
                return mid;
            } else if (guess(mid) == -1) {
                // 猜大了，下一轮往小了猜
                right = mid - 1;
            } else {
                // guess(mid) == 1，猜小了，下一轮往大了猜
                left = mid + 1;
            }
        }
        // 由于一定会猜中，代码不会执行到这里，写任意可以编译通过的代码即可
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $，其中 $ n $ 是数字的范围。二分查找每次将搜索范围缩小到接近原来的一半。设数组长度为$ n $，第一次搜索范围是 $ n $，第二次是 $ \frac{n}{2} $，第三次是 $ \frac{n}{4} $，以此类推，直到搜索区间长度为 1。设搜索次数为 $ k $，则 $ \frac{n}{2^k} = 1 $，得 $ k = \log_2 n $，因此时间复杂度是 $ O(\log n) $；
+ 空间复杂度：$ O(1) $。仅使用几个额外的变量（如左右边界变量、中间元素变量），这些变量的空间占用是固定的，不随输入数组大小 $ n $的变化而变化。

**注意**：$ n $ 的范围是 $ 1 \le n \le 2^{31} - 1 $。如果 `mid` 的取值写成 `int mid = (left + right) / 2` ，会看到「力扣」给出「超出时间限制」的提示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749619287-rMkDCt-image.png)


这是因为 `left + right` 超过了整形 `int` 的范围，解决办法是：写成 `int mid = left + (right - left) / 2` 或者 `int mid = (left + right) >>> 1`（Java 中有无符号右移，其它编程语言可能不支持）。

!!! info 阅读提示

「力扣」上的问题都给出了数据范围，**数据范围是非常重要的题目条件**。因此我们只在 `left + right` 有可能溢出的时候写成 `int mid = left + (right - left) / 2`。理由是：虽然写 `int mid = left + (right - left) / 2` 在很多时候也正确，但是如果 `left + right` 不会整型溢出，写成 `int mid = left + (right - left) / 2` 在计算 `mid` 的时候多一个操作，这个多的操作是没有必要的。

!!! 

就本题而言，循环可以继续的条件 `left <= right` 可以写成 `left < right`。这是因为根据题目的意思，在搜索区间里一定存在我们要猜的数字，所以 **当 `left` 与 `right` 重合的时候，表示已经猜中了答案**，只不过是最后才猜中的。与此同时，在函数 `guessNumber(int n)` 的最后必须写成 `return left` 或者 `return right`，如「参考代码 2」所示。

**参考代码 2**：

```java
public class Solution extends GuessGame {

    public int guessNumber(int n) {
        int left = 1;
        int right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            int guessNum = guess(mid);
            if (guessNum == 0) {
                return mid;
            } else if (guessNum == -1) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        // 写成 return right; 也能通过
        return left;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

这里还有一个细节：**由于我们在循环体中写了 `if (guessNum == 0)` ，所以如果没有猜中，或者执行 `left = mid + 1` 或者执行 `right = mid - 1`，退出循环以后，都能让 `left` 与 `right` 重合**，大家可以使用一个具体的例子代入验证，所以退出循环以后，我们返回 `left` 或者 `right` 都对。

**说明：本题给出的两版「参考代码」没有本质区别。**

','8',NULL,'0374-guess-number-higher-or-lower','2025-06-11 09:10:31','2025-06-12 11:23:59',1,11,false,NULL,'https://leetcode.cn/problems/guess-number-higher-or-lower/description/',30,1,'',false,'https://leetcode.cn/problems/guess-number-higher-or-lower/solutions/12107/shi-fen-hao-yong-de-er-fen-cha-zhao-fa-mo-ban-pyth/',true,NULL,'可以在循环体内找到。'),(21,'liweiwei1419','第 2 部分 数据结构基础','',NULL,NULL,'data-structures','2025-06-09 04:14:34','2025-06-09 04:14:34',0,7,false,NULL,NULL,0,2,'',false,NULL,false,NULL,NULL),(196,'liweiwei1419','第 2 节 章节介绍','在学习算法的旅程开始之前，让我们先了解本书的整体框架。本书采用循序渐进的方式组织内容，分为四个核心部分，从基础概念到高级应用，逐步构建读者的算法知识体系。

# 第 1 部分：算法基础
我们介绍了基础算法和基本的算法思想。我们介绍了算法背后的想法，强调了充分理解算法合理性的重要性。

+ 第 1 章 基础排序算法：算法学习的起点。我们介绍了 4 种基础排序算法，它们分别是选择排序、冒泡排序、插入排序、希尔排序，它们是学习算法的基础，学习算法应该先知道学习算法解决了什么问题，解决问题的基本思想是什么，最后才是代码实现；
+ 第 2 章 循环不变量：明确变量的定义，写出逻辑清晰的代码。我们介绍了设计的变量应该有准确的定义，并且保持定义不变。明确定义可以帮助我们更清楚地知道变量初始值、循环过程中的逻辑先后顺序和返回值；
+ 第 3 章 时间复杂度：衡量算法效率的的理论工具。我们详细介绍了时间复杂度是什么，时间复杂度不是程序一次的运行时间，它表示了程序在应对更大数据规模的时候的变化快慢。我们还通过时间复杂度的极限定义介绍了时间复杂度的计算规则；
+ 第 4 章 递归：分而治之的实现工具。我们介绍了所有的递归其实背后都是分而治之算法思想的体现。分而治之是思想，分治在代码层面的体现就是递归，树和图的问题使用递归可以写出逻辑清晰的代码。我们还指出了完全舍弃递归是没有必要的，我们不应该因为递归使用了空间，有栈溢出风险，就不用递归，不能因噎废食，具体问题应该具体分析；
+ 第 5 章 归并排序与快速排序：分而治之思想的典型应用。我们介绍了两种非常重要的排序方法，它们是理解分而治之思想和递归最好的学习材料；
+ 第 6 章 滑动窗口与双指针：数组问题的量体裁衣与相遇即解。我们指出了解决一个问题最重要的是算法思想，想清楚合理性，而不是记住解法；
+ 第 7 章 二分查找：逐渐缩小搜索区间。其实二分查找是一个很简单的算法，二分查找虽然有一些细节和注意事情，但只要我们充分理解思想以后，就不会为这些细节和注意事项困扰。如果只是生搬硬套算法模板，就不能灵活应用，解决更多更复杂的问题。

# 第 2 部分：数据结构基础
我们介绍了常见的数据结构以及它们的应用场景，介绍了它们的应用场景，我们需要对问题本身有充分的认识，然后再选择合适的数据结构。

+ 第 8 章 动态数组：只是个障眼法，其实还是静态。我们介绍了数组的局限性，以及解决方案。由此产生的复杂度震荡以及均摊复杂度分析方法。应对更复杂、多变的情况，我们应该使用更合适的方法对算法进行评估；
+ 第 9 章 链表：动态数据结构基础。我们介绍了第一个真正动态的数据结构：链表。链表是树和图的基础。我们介绍了如何修改链表的指针指向解决问题，以及在解决链表中常见的技巧：虚拟头结点和快慢指针；
+ 第 10 章 栈与队列：LIFO 和 FIFO 的经典应用。我们首先指出了栈与队列是抽象概念，提出它们更突出了处理顺序，真正的实现还是数组和链表。我们在介绍例题时，重点强调了为什么使用栈与队列；
+ 第 11 章 优先队列：建立在数组上的树结构。我们介绍了优先队列的应用场景：动态选取最值，并且介绍了优先队列的经典实现：二叉堆。二叉堆的设计思想非常经典和巧妙：既然只需要求最值，且数据经常变化，那么我们就只维护局部最值。最后我们介绍了优先队列的应用；
+ 第 12 章 二叉树与二分搜索树：高效查找与动态维护。我们介绍了后序遍历这种经典的解决树问题的思想，其实后序遍历还是分而治之的算法思想、递归实现，只是向大家强调了从下往上看这种解决问题的角度。最后我们还介绍了红黑树的实现思想，红黑树应用了巧妙的算法设计思想，是效率的平衡；
+ 第 13 章 哈希表：哈希表其实就是数组，是快速查找与去重的利器。哈希表的核心思想是通过哈希函数将键映射到数组索引，实现近乎 $ O(1) $ 的查找效率。然而，哈希冲突、链地址法、负载因子与重哈希等问题，本质上都是设计上的权衡——在时间、空间与实现复杂度之间寻找最优解。

# 第 3 部分：算法设计思想
这部分深入探讨 3 大经典算法思想，每种思想都配有典型例题解析，展示如何将抽象思想转化为具体解决方案。

+ 第 14 章 回溯算法：全局使用一个变量去尝试所有可能，其实还是深度优先遍历；
+ 第 15 章 动态规划：其实就是表格法。我们介绍了通过将问题分解为重叠子问题，并记住子问题的解，以避免重复计算，我们还介绍了定义子问题的通用思想：升维和固定不确定的地方，以便于状态转移。虽然思想还是分治、组合子问题的解，但实际上可以递推求解；
+ 第 16 章 贪心算法：贪心算法思考的问题是「局部最优能否带来全局最优」。我们介绍了在问题具备贪心选择性质时，通过局部最优解得到全局最优解的特殊问题。

**<font style="color:rgb(38, 38, 38);">第 4 部分：进阶篇</font>**

最后这部分介绍更高级的算法主题，适合希望深入学习的读者：

+ 第 17 章 广度优先遍历与拓扑排序：层级遍历与依赖解析。我们介绍了广度优先遍历可以解决最短路径问题，并且还介绍了「多源 BFS」和「双向 BFS」，最后介绍了拓扑排序，拓扑排序最常见的实现就是广度优先遍历，借助入度数组的概念，像「剥洋葱」一样删去顶点和边；
+ 第 18 章 前缀和与哈希表：子数组问题的优化策略。我们介绍了在遍历的过程中使用哈希表记住前缀和信息。「前缀和」与「哈希表」都是典型的空间换时间思想的应用；
+ 第 19 章 字典树：高效处理字符串匹配问题（帮我补充）。我们介绍了字典树这种多叉树，字典树通过共享前缀来优化字符串存储与查询的空间效率；
+ 第 20 章 位运算：利用二进制优化计算。我们介绍了位运算的技巧；
+ 第 21 章 并查集：解决连通性问题的经典数据结构。我们介绍了并查集的设计思想、优化策略以及应用；
+ 第 22 章 单源最短路径：Dijkstra 与 Bellman-Ford 算法。我们介绍了解决单源最短路径的两个算法。其中 Dijkstra 算法用于解决没有负权边问题的单源最短路径，当有负权边时，须要使用 Bellman-Ford 算法，它们的理论基础都是「松弛操作」；
+ 第 23 章 最小生成树算法：Kruskal 与 Prim 算法。我们介绍了两个找到最小生成树的算法，它们的理论基础都是「切分定理」。

值得一提的是，我们在高级主题中仍然保持「思想优先」的讲解方式，如 Dijkstra 算法背后的松弛操作原理，最小生成树的切分定理等。

通过这样由浅入深的结构安排，读者可以系统地掌握从基础到进阶的算法知识。每个章节都配有精心设计的示例和练习，建议按照顺序学习，在理解基础概念后再挑战更复杂的内容。让我们开始这段算法学习的精彩旅程吧！

',NULL,NULL,'subjective-parts','2025-07-28 09:55:52','2025-07-28 10:01:29',0,7,false,NULL,NULL,19,0,'subjective-parts',false,NULL,false,NULL,NULL),(2,'liweiwei1419','LCR 170. 交易逆序对的总数','**提示**：`0 <= record.length <= 50000`

## 思路分析

「计算数组的逆序对」可以当做归并排序的例题进行学习，想不明白的地方，在草稿纸上用几个规模小的例子模拟代码的执行。不妨多写几遍，很可能写过几遍之后，就渐渐地理解了思路和细节。

**暴力解法**：使用两层循环枚举所有的数对，逐一判断是否构成逆序关系，时间复杂度是 $ O(n^2) $，这里 $ n $ 是数组的长度，空间复杂度是 $ O(1) $。

**分治思想**：整个过程其实就是实现了一次归并排序，**一边计算逆序对的总数，一边实现排序，以避免重复计算**。「逆序对」来源于 3 个部分：

+ 左边区间的逆序对；
+ 右边区间的逆序对；
+ 横跨两个区间的逆序对。

在「合并两个有序数组」的时候，**利用数组的有序性可以一下子数出逆序对的个数（这是加快计算的原因）**。这里排序的作用是：

+ 消除逆序对，避免重复计算；
+ 当前排序，是下一轮排序、一下子数出逆序对总数的基础。

由于逆序这件事情是对称的，可以数出前面有多少个元素比自己大，也可以数出后面有多少个元素比自己小。我们以前者（数出前面有多少个元素比自己大）为例，在第 2 个数组里的元素归并回去的时候，数出第 1 个数组里还没有归并回去的元素的个数，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749709472305-443f5ec4-aa83-4bf8-8f06-672ca7c70b10.png)

即：在 `j` 指向的元素赋值回去的时候，给计数器加上 `mid - i + 1`。

**参考代码**：

```java
public class Solution {

    public int reversePairs(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return 0;
        }

        // 有些场景不允许对输入数组做修改，因此将输入数组复制一份（该操作非必须）
        int[] copy = new int[n];
        for (int i = 0; i < n; i++) {
            copy[i] = nums[i];
        }

        int[] temp = new int[n];
        return reversePairs(copy, 0, n - 1, temp);
    }

    // nums[left..right] 计算逆序对个数并且排序
    private int reversePairs(int[] nums, int left, int right, int[] temp) {
        if (left == right) {
            return 0;
        }

        int mid = left + (right - left) / 2;
        int leftPairs = reversePairs(nums, left, mid, temp);
        int rightPairs = reversePairs(nums, mid + 1, right, temp);
        // 如果整个数组已经有序，则无需合并，注意这里使用小于等于
        if (nums[mid] <= nums[mid + 1]) {
            return leftPairs + rightPairs;
        }
        int crossPairs = mergeAndCount(nums, left, mid, right, temp);
        return leftPairs + rightPairs + crossPairs;
    }

    // nums[left..mid] 有序，nums[mid + 1..right] 有序
    private int mergeAndCount(int[] nums, int left, int mid, int right, int[] temp) {
        for (int i = left; i <= right; i++) {
            temp[i] = nums[i];
        }

        int i = left;
        int j = mid + 1;

        int count = 0;
        for (int k = left; k <= right; k++) {
            // 有下标访问，得先判断是否越界
            if (i == mid + 1) {
                nums[k] = temp[j];
                j++;
            } else if (j == right + 1) {
                nums[k] = temp[i];
                i++;
            } else if (temp[i] <= temp[j]) {
                // 注意：这里是 <= ，写成 < 就不对，请思考原因
                nums[k] = temp[i];
                i++;
            } else {
                nums[k] = temp[j];
                j++;
                // 在 j 指向的元素归并回去的时候，计算逆序对的个数，只多了这一行代码
                count += (mid - i + 1);
            }
        }
        return count;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log n) $，这里 $ n $ 是数组的长度。复杂度是归并排序的时间复杂度，归并的时候每一步计算逆序对的个数的时间复杂度是 $ O(1) $ ；
+ 空间复杂度：$ O(n) $。

','4',NULL,'shu-zu-zhong-de-ni-xu-dui','2025-06-08 22:09:10','2025-06-12 14:31:01',1,15,false,NULL,'https://leetcode.cn/problems/shu-zu-zhong-de-ni-xu-dui-lcof/description/',28,1,'',false,'https://leetcode.cn/problems/shu-zu-zhong-de-ni-xu-dui-lcof/solutions/92471/bao-li-jie-fa-fen-zhi-si-xiang-shu-zhuang-shu-zu-b/',true,NULL,NULL),(14,'liweiwei1419','「力扣」第 139 题：单词拆分（中等）','## 思路分析
题目要求判断字符串能否拆分为字典中的单词（无需具体方案），适合用动态规划解决。线性 DP 通常的状态定义是「以什么什么结尾」，这样定义容易推导转移方程。

+ **状态定义**：`dp[i]` 表示子串 `s[0..i]` （以 `s[i]` 结尾）能否被拆分成字典中的单词；
+ **状态转移方程**：需要分类讨论：
    - 不拆：如果整个子串恰好在单词集合中，`dp[i] = true`。判断一个单词是否在单词集合中，单词集合应该先放入哈希表，这样就能以 $ O(1) $ 的时间复杂度判断；
    - 拆分：存在一个分割点 `j`，使得 `s[0..j]` 可拆分（即：之前计算的状态值 `dp[j] = true`）且剩余部分 `s[j + 1..i]` 在字典中。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0139-word-break/temp-image10140032751785294213.png)

+ **考虑初始化**：刚开始的时候就需要分类讨论，所以不单独写初始化的代码；
+ **考虑输出**：输出就是 `dp[n - 1]` ，这里 `n` 是字符串的长度。

**参考代码 1**：

```java
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {

    public boolean wordBreak(String s, List<String> wordDict) {
        Set<String> wordSet = new HashSet<>(wordDict);
        int n = s.length();

        // 状态定义：以 s[i] 结尾的子字符串是否符合题意
        boolean[] dp = new boolean[n];
        for (int i = 0; i < n; i++) {
            // 分类讨论 1：不拆分，substring 右端点不包含，所以是 i + 1
            if (wordSet.contains(s.substring(0, i + 1))) {
                dp[i] = true;
                continue;
            }
            // 分类讨论 2：拆分
            for (int j = i - 1; j >= 0; j--) {
                if (wordSet.contains(s.substring(j + 1, i + 1)) && dp[j]) {
                    dp[i] = true;
                    // 这个 break 很重要，一旦得到 dp[i] = true ，循环不必再继续
                    break;
                }
            }
        }
        return dp[n - 1];
    }

}
```

**复杂度分析**：

+ 时间复杂度： $ O(n^2) $，其中 $ n $ 是字符串 `s` 的长度，需要遍历所有的可能的子串；
+ 空间复杂度： $ O(n + m) $，其中 $ n $ 为 `dp` 数组空间，$ m $ 为字典哈希表的存储开销。

如果字典中的单词长度有限，可以进一步优化：先计算出字典中单词的最大长度 `maxLen`，然后在内层循环中只检查长度不超过 `maxLen` 的子串。

**参考代码 2**：

```java
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {

    public boolean wordBreak(String s, List<String> wordDict) {
        // 将字典转换为 HashSet，方便快速查找
        Set<String> wordSet = new HashSet<>(wordDict);
        int n = s.length();

        // 计算字典中单词的最大长度
        int maxLen = 0;
        for (String word : wordDict) {
            maxLen = Math.max(maxLen, word.length());
        }

        // 状态定义：dp[i] 表示以 s[i] 结尾的子字符串是否符合题意
        boolean[] dp = new boolean[n];
        for (int i = 0; i < n; i++) {
            // 分类讨论 1：不拆分，检查整个子串 s[0:i + 1]
            if (i + 1 <= maxLen && wordSet.contains(s.substring(0, i + 1))) {
                dp[i] = true;
                continue;
            }
            // 分类讨论 2：拆分，倒着遍历，从 i - 1 开始，最多检查 maxLen 长度的子串
            for (int j = i - 1; j >= Math.max(0, i - maxLen); j--) {
                if (dp[j] && wordSet.contains(s.substring(j + 1, i + 1))) {
                    dp[i] = true;
                    // 找到一个符合题意的拆分即可
                    break; 
                }
            }
        }
        return dp[n - 1];
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \cdot \text{maxLen}) $，外层循环遍历 $ n $ 次，这里 $ n $ 是字符串 `s` 的长度，`maxLen` 是字典中单词的最大长度；
+ 空间复杂度：（同「参考代码 1」）。

## 本题总结
+ 哈希表加速查询：将字典存入哈希表，实现 $ O(1) $ 时间复杂度的单词匹配；
+ 剪枝优化：预处理字典的最大单词长度 `maxLen`，避免无效检查（当子串 `s[j + 1..i]` 的长度超过字典单词最大长度时一定不匹配）。','17',NULL,'0139-word-break','2025-06-09 10:49:07','2025-06-18 17:42:23',1,13,false,NULL,'https://leetcode.cn/problems/word-break/description/',39,9,'',false,NULL,true,'完成。',NULL),(16,'liweiwei1419','「力扣」第 72 题：编辑距离（中等）','## 思路分析
本题的状态定义类似「力扣」第 1143 题（最长公共子序列，中等）。

+ **定义状态**：`dp[i][j]` 表示将 `word1` 的前 `i` 个字符转换成 `word2` 的前 `j` 个字符所需的最少操作次数；
+ **状态转移方程**：
    - 如果 `word1[i - 1] == word2[j - 1]`，那么 `dp[i][j] = dp[i - 1][j - 1]`，因为不需要额外的任何操作。
    - 如果 `word1[i - 1] != word2[j - 1]`，那么 `dp[i][j]` 可以通过对 `word2` 的以下 3 种操作得到：

**情况 1：插入操作**。在 `word2` 的末尾加上与 `word1[i - 1]` 相同的字符，此时编辑距离需要参考 `word1[i - 2]` 与 `word2[j - 1]` 的编辑距离，即 `dp[i - 1][j]`，再加上「在 `word2` 的末尾加入」这一操作，因此：`dp[i][j] = dp[i - 1][j] + 1`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0072-edit-distance/temp-image12145208201550729222.png)

**情况 2：删除操作**。在 `word2` 的末尾删除一个字符，此时编辑距离需要参考 `word1[i - 1]` 与 `word2[j - 2]` 的编辑距离，即 `dp[i][j - 1]`，再加上「`word2` 的末尾删除」这一操作，因此：`dp[i][j] = dp[i][j - 1] + 1`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0072-edit-distance/temp-image1970344305085290330.png)

**说明**：我们这里叙述的「插入」和「删除」操作，都是以 `word1` 为基准，让 `word2` 变化。如果以 `word2` 为基准，让 `word1` 变化就是「删除」和「插入」操作，就不重复叙述了。

**情况 3：替换操作**。将 `word2` 的最后一个字符替换成与 `word1` 的最后一个字符相同的字符，此时编辑距离需要参考 `word1[i - 2]` 与 `word2[j - 2]` 的编辑距离，即 `dp[i - 1][j - 1]`，再加上「`word2` 的末尾替换」这一操作，因此：`dp[i][j] = dp[i - 1][j - 1] + 1`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0072-edit-distance/temp-image18381258776097604158.png)

取这 3 种操作的最小值就是「状态转移方程」，请见「参考代码 1」。

+ **考虑初始化**：一个空字符串与非空字符串的编辑距离就是非空字符串的长度（在空字符串的末尾依次插入非空字符串的字符），所以 `dp[0][j] = j`、`dp[i][0] = i`。
+ **考虑输出**：`dp[m][n]`，这里 `m` 是字符串 `word1` 的长度，`n` 是字符串 `word2` 的长度；

**参考代码 1**：

```java
public class Solution {

    public int minDistance(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();

        // 多开一行一列是为了保存边界条件，即字符长度为 0 的情况，这一点在字符串的动态规划问题中比较常见
        int[][] dp = new int[m + 1][n + 1];
        // 初始化：当 word2 长度为 0 时，将 word1 的全部删除即可
        for (int i = 1; i <= m; i++) {
            dp[i][0] = i;
        }
        // 当 word1 长度为 0 时，插入所有 word2 的字符即可
        for (int j = 1; j <= n; j++) {
            dp[0][j] = j;
        }

        // 由于 word1.charAt(i) 操作会去检查下标是否越界，因此在 Java 里，将字符串转换成字符数组是常见额操作
        char[] word1Array = word1.toCharArray();
        char[] word2Array = word2.toCharArray();
        // 递推开始，注意：填写 dp 数组的时候，由于初始化多设置了一行一列，横纵坐标有个偏移
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                // 这是最佳情况
                if (word1Array[i - 1] == word2Array[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1];
                    continue;
                }
                // 否则在以下三种情况中选出步骤最少的，这是「动态规划」的「最优子结构」
                // 1、在下标 i 处插入一个字符
                int insert = dp[i][j - 1] + 1;
                // 2、替换一个字符
                int replace = dp[i - 1][j - 1] + 1;
                // 3、删除一个字符
                int delete = dp[i - 1][j] + 1;
                dp[i][j] = Math.min(Math.min(insert, replace), delete);

            }
        }
        return dp[m][n];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，这里 `m` 是字符串 `word1` 的长度，`n` 是字符串 `word2` 的长度；
+ 空间复杂度：$ O(m \times n) $。

一般情况下，写出「参考代码 1」就可以了。优化空间的代码理解起来很晦涩，这里仅给出参考。

**考虑优化空间**：根据状态转移方程，当前要填写的单元格的数值，取决于它的左边一格、上边一格，左上边主对角线上一个的数值。计算 `dp[i][j]` 只需要上一行 `i - 1` 和当前行的前一个值 `j - 1` ，因此可以将二维数组优化为一维数组，空间复杂度从 $ O(mn) $ 降为 $ O(n) $。

在填写当前行的时候，上一行的状态值 `dp[i - 1][j - 1]` 会被覆盖，因此需要使用一个变量（这里命名为 `prev`）先保存起来，另外，可以选择较短的字符串作为内层循环的目标，减少状态数组的大小。

**参考代码 2**：

```java
public class Solution {

    public int minDistance(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();
        
        // 选择较短的字符串作为内层循环的目标
        if (m < n) {
            return minDistance(word2, word1);
        }
        
        int[] dp = new int[n + 1];
        // 初始化：将空字符串转换为 word2 前 j 个字符需要 j 次插入操作
        for (int j = 0; j <= n; j++) {
            dp[j] = j;
        }
        
        char[] word1Array = word1.toCharArray();
        char[] word2Array = word2.toCharArray();
        for (int i = 1; i <= m; i++) {
            // 保存 dp[i - 1][j - 1] 的值
            int prev = dp[0];
            dp[0] = i;
            for (int j = 1; j <= n; j++) {
                // 保存当前 dp[j] 的值，即下一次循环的 dp[i - 1][j - 1]
                int temp = dp[j];
                if (word1Array[i - 1] == word2Array[j - 1]) {
                    // 字符相同，不需要操作
                    dp[j] = prev;
                } else {
                    // 取 3 种操作中的最小值加 1
                    dp[j] = Math.min(prev, Math.min(dp[j - 1], dp[j])) + 1;
                }
                // 更新 prev 为下一轮准备的 dp[i - 1][j - 1]
                prev = temp;
            }
        }
        return dp[n];
    }
}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $；
+ 空间复杂度：$ O(\min(m, n)) $，状态数组的大小为 `n + 1`，其中 `n` 是较短字符串的长度。','17',NULL,'0072-edit-distance','2025-06-09 10:54:09','2025-06-18 18:26:49',1,10,false,NULL,'https://leetcode.cn/problems/edit-distance/description/',39,15,'',false,NULL,true,'完成。',NULL),(195,'liweiwei1419','第 1 节 写在前面的话','# 关于算法的真相
翻开这本书前，我们需要达成一个共识：算法是编程的基础，但不是编程的全部。就像建筑师要懂力学公式，但真正盖房子时还得考虑材料、预算和用户需求一样。算法面试只是能力的切片测试，它考的是你拆解问题的思维，和真实开发中要考虑系统设计、团队协作、工程规范是不同维度的能力。通过算法面试就像考下驾照，而实际开发才是真正上路开车——两者需要的技能并不完全相同。

我见过能秒杀 Hard 题却写不好业务代码的面试高手，也遇到过算法平平但工程能力极强的优秀开发者。这本书告诉你的是「如何理解算法」，而不是「如何成为程序员」——前者是后者的必要不充分条件。当有人质疑「这些算法题工作中用不上」时，请明白：重点不在于记住特定题目的解法，而在于培养解决问题的思维方法。实际上，对于大多数开发工作而言，掌握基础的算法知识就足够了，不必过度钻研高难度算法题——就像会开车不一定要懂发动机原理，但了解基本的机械常识能让你开得更好。

如果你能通过项目经验（如参与知名开源项目、你是知名软件作者）证明自己的开发实力，完全可以向公司申请免去算法考核——毕竟实际工程能力才是最重要的。当然，掌握基础算法依然是加分项，就像老司机虽然不用考交规，但懂规则总比不懂强。

# 《算法也疯狂》是一本什么样的书？
这本书的初衷很简单：我不想写一本让人望而生畏的算法教材。那些公式堆砌、代码密布的大部头已经够多了，但真正能让人读进去的却很少。所以，我试着用新手也能懂的方式，把算法和数据结构讲清楚——就像当初我自己摸索时希望有人能解释给我听的那样。  

如果你正在准备面试，或者刚开始刷「力扣」却总被动态规划、二分查找绕晕，这本书或许能帮到你。但如果你已经啃得动《算法导论》，甚至能轻松解决「力扣」Hard 题，那本书可能对你帮助不大，本书更偏向「入门」和「理解」，而非高深技巧。  

# 为什么叫《算法也疯狂》？
学算法的人大概都经历过这种状态：盯着题目半天没思路，好不容易写出代码却死活通不过测试用例，调试到凌晨、甚至调试一整天依然一头雾水……那种抓狂的感觉，简直让人想摔键盘。但奇怪的是，当你终于搞懂一道难题，或者想出比别人更巧妙的解法时，那种兴奋感又会让人上瘾。  

这本书想陪你度过这段「从抓狂到上瘾」的过程。我不会告诉你「背下这十道题就能通过面试」，因为那根本不现实。算法不是靠死记硬背就能掌握的，它需要你真正理解背后的逻辑，并在不断解决问题的过程中获得成就感。  

# 这本书的特点 
比起传统教材，本书更注重「可视化」和「实战」。我们把抽象的算法用图画出来，复杂的逻辑用生活例子类比。比如哈希表就像图书馆的索引系统，动态规划好比拆解任务的小本子。所介绍的知识点会搭配「力扣」上的具体题目，让你边学边练。  

我们的代码也尽量写得易读。我不喜欢那种为了「炫技」而压缩成一行的写法，而是坚持「一行代码只做一件事」，毕竟代码是给人看的，不是给机器看的。书里所有例子都能在配套网站（https://suanfa8.com）找到源码，本书使用的是 Java 语言，但没有过多地使用 Java 语言特有的语法，非 Java 语言的朋友阅读是没有障碍的，大家还可以使用 AI 工具转成其它语言。  

# 怎么用这本书？
你可以跳着读。比如对二分查找一头雾水，就直接翻到第 7 章；觉得动态规划太难，就先放一放，回头再看。每章开头会提示重点内容，结尾会总结关键思想，方便你按需取舍。  

不过大家别指望一次就能完全掌握。有些章节你可能需要阅读、练习两遍、三遍，甚至隔段时间再回来看才有新的领悟。这很正常，我当初学算法时也经常这样。最重要的是动手实践——把书里的例子按照自己的理解自己敲一遍，再找几道类似题目练手，比看十遍都有用。  

# 跨越知道与做到的鸿沟
知道和真正实现隔着十万八千里，学习算法就是从「知道」走向「做到」的过程。比如排序算法：没学过的人可能只会说「直接排序就好了」，而学过的人则懂得描述具体算法，区分不同场景的优劣，甚至应用分治思想优化性能。

学习算法首先要理解思想内核，验证其逻辑合理性，最后才是编码实现。本书会用生活化的比喻（比如哈希表像图书馆索引）拆解抽象概念，但理解思想后，必须亲手编程实践——这是弥合理论与工程鸿沟的唯一路径。

不过也要警惕过度实现。就像驾驶无需精通内燃机，使用数据库不必重写 B+ 树，我们理解红黑树的自平衡机制或哈希表的冲突处理思想即可，不必重复造轮子。算法的海洋里，我们无需遍历每一片水域，而要成为「工具选择专家」：在适合的场景，拿起最趁手的算法工具。

# 最后一点心里话
写这本书时，我常想起自己初学算法的日子：被递归绕得晕头转向，写二分查找总是漏掉边界条件，甚至怀疑自己是不是不适合编程。但现在回头看，那些看似「疯狂」的纠结，恰恰是成长的必经之路。  

算法不是考试，而是一种思考方式。希望这本书能让你少走点弯路，至少知道——你现在的抓狂，我也经历过，而且这一切终会值得。  ',NULL,NULL,'introduction','2025-07-28 09:55:15','2025-07-28 10:01:10',0,8,false,NULL,NULL,19,0,'',false,NULL,false,NULL,NULL),(22,'liweiwei1419','第 3 部分 算法设计思想','',NULL,NULL,'algorithm-design','2025-06-09 04:14:34','2025-06-09 04:14:34',0,2,false,NULL,NULL,0,3,'',false,NULL,false,NULL,NULL),(61,'liweiwei1419','「力扣」第 26 题：删除排序数组中的重复项（简单）','## 思路分析

题目告诉我们「数组 **非严格递增** 排列」，即：相同元素是紧挨在一起的。很容易想到，将不重复元素依次覆盖到前面位置，不影响最终结果且满足原地删除要求。如下图所示：

![image.png](https://minio.dance8.fun/algo-crazy/0026-remove-duplicates-from-sorted-array/temp-image11682355694362552457.png)


我们可以使用一个变量 `i` 用于遍历数组，另一个变量 `j` 用于比较和赋值，这里 `j` 的定义还比较模糊，接下来，我们准确描述 `j` 的定义。

**编码细节**：我们期望 `j` 与「数组没有重复元素」有关，即 `j` 扫过的区域没有重复元素。`j` 作为边界可以有两种定义，如下图所示：

![image.png](https://minio.dance8.fun/algo-crazy/0026-remove-duplicates-from-sorted-array/temp-image5773267248114255346.png)


把 `j` 的定义写得准确一点，就是：`nums[0..j]` 没有重复元素和 `nums[0..j)` 没有重复元素，于是可以写出以下两版代码。

**参考代码 1**：定义 `nums[0..j]` 没有重复元素。

```java
public class Solution {

    public int removeDuplicates(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return n;
        }
        // 循环不变量：nums[0..j] 是移除重复元素以后的数组
        int j = 0;
        for (int i = 1; i < n; i++) {
            if (nums[i] != nums[j]) {
                j++;
                nums[j] = nums[i];
            }
        }
        return j + 1;
    }
    
}
```

我们向大家解释代码是如何写出来的：

+ 循环开始前：根据定义，「`nums[0..j]` 没有重复元素」，只有一个数的时候，显然满足「没有重复元素」，因此循环开始之前 `j = 0`，符合定义；
+ 循环的过程中：根据定义，`j` 表示的是区间 `nums[0..j]` 里最后一个数。每一个遍历到的新值 `nuns[i]` ，都要与 `nums[j]` 比较，它们的值不相等时，才赋值。在赋值之前，应该先移动 `j` ，再赋值；
+ 循环结束的时候：题目要求返回移除了重复元素的数组的个数，根据定义「`nums[0..j]` 没有重复元素」，很显然返回 `j + 1`。

另外，因为 `j` 用于比较和赋值，`j` 一定会看到下标 0 位置的值，所以 `i` 从 1 开始遍历就好。

!!! note
**阅读提示**：大家可以看到，当我们明确了变量的定义以后，在编写代码的时候，一直看变量的定义就好。
!!! 

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度。只需要遍历一次数组；
+ 空间复杂度：$ O(1) $，只使用了常数个变量。

**参考代码 2**：定义 `nums[0..j)` 没有重复元素，即变量 `j` 指向了下一个要赋值的位置。

```java
public class Solution {

    public int removeDuplicates(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return n;
        }
        // 循环不变量：nums[0..j) 是移除重复元素以后的数组
        int j = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] != nums[j - 1]) {
                // 注意顺序：先更新值，再递增下标
                nums[j] = nums[i];
                j++;
            }
        }
        return j;
    }
    
}
```



我们向大家解释代码是如何写出来的：

+ 循环开始前：根据定义，「`nums[0..j)` 没有重复元素」，如果我们还定义 `j = 0` ，此时 `nums[0..j)` 是空区间，虽然满足定义，但是 `j = 1` 才是更好的初始值（`j = 1` 也满足定义），**否则下一步 `j` 要移动 2 格，与后面的代码逻辑不统一（变量的初始值要恰到好处，在本题中，只有 1 个元素的数组没有重复元素才是恰到好处的初始状态，而不应该选择「空数组没有重复元素」作为初始状态）**；
+ 循环的过程中：根据定义，`nums[j - 1]` 才是最新赋值的元素。所以每一个遍历到的新值 `nuns[i]` ，都要与 `nums[j - 1]` 比较，它们的值不相等时，才赋值。直接在 `j` 位置赋值就好了，赋值完成以后，再将 `j` 右移一位；
+ 循环结束的时候：根据定义「`nums[0..j)` 没有重复元素」，很显然返回 `j`。

同理 `i` 从 1 开始遍历。

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
+ 本题我们使用一个变量 `j` ，既用于赋值，也用于比较；
+ 代码的细节可以通过准确地定义变量（将变量的定义融入「区间」概念），让自己更清楚变量初始化的值、循环过程中的代码逻辑、循环结束以后应该返回的值；
+ 先有定义，再有代码，这是我们向大家介绍循环不变量的原因。','3',NULL,'0026-remove-duplicates-from-sorted-array','2025-06-10 14:02:22','2025-06-17 19:21:25',1,72,false,NULL,'https://leetcode.cn/problems/remove-duplicates-from-sorted-array/description/',25,0,'',false,'https://leetcode.cn/problems/remove-duplicates-from-sorted-array/solutions/3595771/yi-ge-bian-liang-yong-yu-bian-li-ling-yi-rv6i/',false,NULL,NULL),(9,'liweiwei1419','「力扣」第 198 题：打家劫舍（中等）','!!! info 阅读提示

本题我们给出了二维数组和一维数组的状态设计，是为了展示不同的状态设计对状态转移的影响。大家可以选择自己认为好理解的状态设计，只要时间复杂度是 $ O(n) $ 即可，这里 $ n $ 是数组的长度，空间复杂度没有必要优化到 $ O(1) $。

!!!




## 思路分析

题目只问最大金额是多少，没有问偷得这个金额的具体方案是什么，可以考虑使用动态规划求解。一间房屋只有偷和不偷两种选择，于是我们可以把「偷」和「不偷」两种方式固定下来（即定义两个状态数组，都以 `nums[i]` 结尾，区别是 `nums[i]` 偷与不偷），状态定义和状态转移方程如下：

+ **状态定义**：定义一个二维数组 `dp`，其中：
    - `dp[i][0]` 表示区间 `nums[0..i]` 里不偷窃房屋 `nums[i]` 时能够获得的最大金额，即固定 `nums[i]` 不偷；
    - `dp[i][1]` 表示区间 `nums[0..i]` 里偷窃房屋 `nums[i]` 时能够获得的最大金额，即固定 `nums[i]` 偷。
+ **状态转移方程**：
    - 对于 `dp[i][0]`，规定了 `nums[i]` 不偷，那么 `nums[i - 1]` 可以偷，也可以不偷，此时最大金额为 `max(dp[i - 1][0], dp[i - 1][1])`；
    - 对于 `dp[i][1]`，规定了 `nums[i]` 一定会偷，那么 `nums[i - 1]` 就一定不能偷，此时最大金额为 `dp[i - 1][0] + nums[i]`。

综上，状态转移方程为：

```java
dp[i][0] = max(dp[i - 1][0], dp[i - 1][1])
dp[i][1] = dp[i - 1][0] + nums[i]
```

+ **考虑初始化**：
    - 不偷窃第 0 个房屋：`dp[0][0] = 0`；
    - 偷窃第 0 个房屋：`dp[0][1] = nums[0]`。
+ **考虑输出**：最终的结果是最后一个房屋偷或不偷的最大值，即 `max(dp[len - 1][0], dp[len - 1][1])`；
+ **考虑优化空间**：`dp[i][0]` 和 `dp[i][1]` 只依赖于 `dp[i - 1][0]` 和 `dp[i - 1][1]`，因此可以考虑使用滚动数组技巧，优化空间非必须，这里省略。

**参考代码 1**：

```java
public class Solution {

    public int rob(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return nums[0];
        }

        // 定义 dp 数组
        int[][] dp = new int[n][2];
        // 初始化
        dp[0][0] = 0; // 不偷第 0 个房屋
        dp[0][1] = nums[0]; // 偷第 0 个房屋

        // 动态规划
        for (int i = 1; i < n; i++) {
            // 不偷第 i 个房屋
            dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1]);
            // 偷第 i 个房屋
            dp[i][1] = dp[i - 1][0] + nums[i];
        }
        // 返回最后一个房屋偷或不偷的最大值
        return Math.max(dp[n - 1][0], dp[n - 1][1]);
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(n) $，其中 $ n $ 是房屋的数量；
+ 空间复杂度：$ O(n) $，使用了一个二维数组 `dp` 来存储中间状态。

其实对于这道问题，偷和不偷也可以不用分得那么细，可以只定义一个数组 `dp`，其中 `dp[i]` 表示考虑到第 `i` 个房屋时能够获得的最大金额，注意：此时 `nums[i]` 偷和不偷并未固定，可偷也可以不偷。

对于房屋 `nums[i]`，我们有两个选择：

+ 偷房屋 `nums[i]`，就不能偷房屋 `nums[i - 1]`，此时的最大金额为 `dp[i - 2] + nums[i]`；
+ 不偷房屋 `nums[i]`，那么最大金额就是 `dp[i - 1]`。

以上二者的最大值，就是状态转移方程：`dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])`，注意到这里出现了 `i - 2`，因此初始的时候，就需要考把 `dp[0]` 和 `dp[1]` 计算好，从 `dp[2]` 开始递推：

+ 只有一间房屋时，肯定要偷：`dp[0] = nums[0]`；
+ 两间房屋时，选择金额较大的那个：`dp[1] = max(nums[0], nums[1])`。

输出的结果是 `dp[n - 1]`，其中 `n` 是房屋的数量。

**参考代码 2**：

```java
public class Solution {

    public int rob(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return nums[0];
        }

        // dp[i]：区间 [0..i] 在不触动警报装置的情况下，能够偷窃到的最高金额
        int[] dp = new int[n];
        dp[0] = nums[0];
        dp[1] = Math.max(nums[0], nums[1]);
        for (int i = 2; i < n; i++) {
            // 分类讨论：在偷 nums[i] 与不偷 nums[i] 中选择一个最大值
            dp[i] = Math.max(dp[i - 1], nums[i] + dp[i - 2]);
        }
        return dp[n - 1];
    }
    
}
```

我们发现：`dp[i]` 只依赖于 `dp[i - 1]` 和 `dp[i - 2]`，因此可以用两个变量分别存储，将空间复杂度优化到 $ O(1) $。

**参考代码 3**：

```java
public class Solution {

    public int rob(int[] nums) {
        int len = nums.length;
        if (len == 1) {
            return nums[0];
        }

        int prev2 = nums[0];
        int prev1 = Math.max(nums[0], nums[1]);
        for (int i = 2; i < len; i++) {
            int current = Math.max(prev1, prev2 + nums[i]);
            // 最早失效的变量是 prev2
            prev2 = prev1;
            prev1 = current;
        }
        return prev1;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是房屋的数量；
+ 空间复杂度：$ O(n) $，只使用了常数个额外空间。','17',NULL,'0198-house-robber','2025-06-09 06:39:52','2025-06-18 17:56:07',1,7,false,NULL,'https://leetcode.cn/problems/house-robber/description/',39,12,'',false,NULL,true,'完成。',NULL),(110,'liweiwei1419','「力扣」第 35 题：搜索插入位置（简单）','本节的内容非常重要，还是我们一直和大家强调的，**学习算法一定要理解逻辑，而不是靠记忆**。只要大家能够耐心、细心，充分地理解本节的两道例题，相信对于二分查找的代码应该怎么写，就不会存在疑问。

# 看到 mid 需要保留引发的「血案」
小标题有一些标题党了，但的确反应了有一些初学的朋友可能会陷入的思维误区，那就是：觉得 `mid` 一定要被排除在搜索区间外，即代码只能是 `left = mid + 1` 或者 `right = mid - 1`。但事实上，有一类二分查找的问题，例如要我们查找符合条件的「第一个出现的元素」「最后一个出现的元素」，还有找「最大值」「最小值」。它们的特点是：**必须等到退出循环以后才能确定答案，分析出这一点非常重要，直接决定了代码应该怎么写**，即：我们无法写出一个 `if-else` 语句直接找到答案。

这一类问题在代码层面的特点是：**看到了 `mid` 位置的值，有可能保留 `mid` 位置进入下一轮搜索**，其解决的过程，看起来如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618394-AarCqU-image.png)


搜索范围逐渐缩小，直至区间里只剩下一个数。我们把它叫形象地叫做「两边夹」，最后剩下一个数，也称为「排除法」，换句话说：**把所有不是答案的全都排除，剩下的那个数就是我们要找的答案**。我们以「力扣」上的 2 道问题为例，介绍这一类问题的思路和编码细节。

# 例题 1：「力扣」第 35 题：搜索插入位置（简单）

+ 题目地址：[https://leetcode.cn/problems/search-insert-position/description/](https://leetcode.cn/problems/search-insert-position/description/)



## 题意分析

+ 根据「示例 1」和「提示」第 3 条（`nums` 无重复元素）：找到等于 `target` 的元素，可以直接返回该元素的下标；
+ 根据「示例 2」：3 是第 1 个大于 `target = 2` 的元素，返回 3 的下标；
+ 根据「示例 3」：如果有序数组的最后一个元素严格小于 `target`，那么返回最后一个元素的下标 `+ 1`（也就是数组的长度）。「示例 3」说明了特殊情况时应该返回什么，因为很有可能输入数组中并不存在大于等于 `target` 的数字。

!!! info 阅读提示

在编码的时候，一般先写处理特殊情况的代码，然后再写处理一般情况的逻辑。理由是：

+ **确保程序稳定性**：特殊情况往往是那些不符合常规逻辑、可能导致程序异常或错误的情况；
+ **提高代码可读性与维护性**：将特殊情况的处理代码放在前面，能让阅读代码的人快速了解这段代码可能遇到的异常场景以及相应的处理方式；
+ **简化一般情况代码**：当特殊情况被优先处理后，在编写一般情况代码时，就可以假设已经排除了那些特殊的、可能干扰正常逻辑的因素，使得一般情况的代码能够专注于核心业务逻辑的实现，变得更加简洁明了。

!!!

综上所述：题目要我们找的是第 1 个 **大于等于** 目标元素 `target` 的下标。

## 思路分析

在 **有序数组** 中查找符合条件的某个数（或者它的下标），可以使用二分查找：根据搜索区间中间位置 `mid` 的值，判断下一轮搜索区间是什么。根据「题意分析」中对 3 个示例的分析，根据 `nums[mid]` 与 `target` 的数值关系可以分为如下 3 种情况：

+ **情况 1**：当 `nums[mid] < target` 时，`mid` 以及 `mid` 左边的所有元素一定不是第 1 个大于等于目标元素位置，因此下一轮搜索区间是 `[mid + 1..right]`，下一轮把 `left` 移动到 `mid + 1` 位置，因此设置 `left = mid + 1`。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618466-VnzwmF-image.png)


+ **情况 2**：当 `nums[mid] = target` 时，题目说没有重复元素，此时返回 `mid`；
+ **情况 3（易错、重点）**：当 `nums[mid] > target` 时，`mid` 有可能是第 1 个大于 `target` 的元素的位置，**`mid` 位置需要保留**。`mid` 的右边一定不是我们要找的目标元素，所以下一轮搜索区间是 `[left..mid]`，因此设置 `right = mid`。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618482-xUOhiZ-image.png)


我们先把代码写出来。如下是 **错误代码（因为我运行过，所以知道是错误代码，不是因为我能一眼看出来）**：

```java
public class Solution {

    public int searchInsert(int[] nums, int target) {
        int n = nums.length;
        // 题目最后的「提示」中说，nums 不为空，所以不用对 n = 0 作特殊判断
        // 对「示例 3」出现的情况作特殊判断
        if (nums[n - 1] < target) {
            return n;
        }

        // 在区间 [0..n - 1] 里查找第 1 个大于等于 target 的元素的下标
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        // 这里返回值是什么，请见本题接下来的叙述
        return left;
    }

}
```

把上面的代码提交给「力扣」，得到的结果是：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618516-ExplTX-image.png)


下面我们分析出现死循环的原因。运行上图的测试用例 `nums = [1, 3, 5, 6]`、`target = 2`，在循环体内把 `left`、`right` 和 `mid` 的值都打印出来，可以看到：程序在 `left`、`mid` 和 `right` 的值都为 1 的时候进入了死循环。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618524-kqHPnV-image.png)


原因很容易分析出来，只需要经过简单的计算：当 `left = 1`、`right = 1` 时，`mid = (left + right) / 2 = (1 + 1) / 2 = 1`，`nums[mid] = nums[1] = 3 > target = 2`，此时代码执行的是 `right = mid`，右边界不收缩，进入死循环。

解决办法是：当 `left` 与 `right` 重合的时候，退出循环，也就是把 `while (left <= right)` 改成 `while (left < right)` 。

**强调一下重点：循环体内看到 `right = mid` 或者 `left = mid`，在 `left` 与 `right` 重合的时候，需要停止搜索，即循环可以继续的条件写成 `left < right`，理由是：如果  `left` 与 `right` 重合的时候继续执行循环体，当执行到 `right = mid` 或者 `left = mid` 分支时，搜索区间不缩小，进入死循环。**

接下来我们要解决的问题是：退出循环以后，返回值是什么？我们看分析循环体里的 3 个分支：

+ **分支 1**：执行 `return mid`，整个函数都退出了；
+ **分支 2 和分支 3**：执行 `left = mid + 1` 或者执行 `right = mid`。在循环的最后，即区间里只剩下 2 个元素的时候，计算 `mid` 的值，`mid = (left + right) / 2 = left`。此时执行 `left = mid + 1` 或者 `right = mid` 的结果都是让 `left` 与 `right` 重合。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618573-TMxuRT-image.png)


因此退出循环以后，返回 `left` 或者 `right` 均可。

**参考代码 1**：其实就是把上面错误的代码中的 `left <= right` 改成了 `left < right`，并且去掉了注释。

```java
class Solution {

    public int searchInsert(int[] nums, int target) {
        int n = nums.length;
        if (nums[n - 1] < target) {
            return n;
        }
        int left = 0;
        int right = n - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(1) $。

既然 `n` 也有可能是答案（根据「示例 3」），我们可以在初始化的时候，把右边界 `right` 设置成 `n`。还可以在循环体中省略 `if (nums[mid] == target)` 这个判断，把它合并到 `else if (nums[mid] > target)` 的判断中，也就是：当 `nums[mid] >= target` 时，执行 `right = mid`。

**参考代码 2**：

```java
public class Solution {

    public int searchInsert(int[] nums, int target) {
        int n = nums.length;
        int left = 0;
        int right = n;
        // 在区间 nums[left..right] 里查找第 1 个大于等于 target 的元素的下标
        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] < target){
                // 下一轮搜索的区间是 [mid + 1..right]
                left = mid + 1;
            } else {
                // 下一轮搜索的区间是 [left..mid]
                right = mid;
            }
        }
        return left;
    }

}
```

**说明**：这样的代码有一个形象的解释：在循环体内排除掉所有不是答案的情况，最后剩下的就是问题的解。

- 如果写 `if (nums[mid] == target)`，有一定概率很快找到答案，提前结束查找；
- 如果不写 `if (nums[mid] == target)`，循环体里只有 2 个分支，可以少做一些判断。

各有优缺点，没有本质差别，写不写这个直接找到目标值的判断由大家自己决定。

**复杂度分析**：（同「参考代码 1」）。

## 本题总结

本题有 2 个关键点，它们都是从题目中分析得到的：

- `n` 也有可能是问题的答案；
- 当 `nums[mid] > target` 时，`mid` 位置是否有可能是问题答案，此时 `mid` 需要被保留，不能设置 `right = mid - 1`；

当循环体里出现代码 `left = mid + 1` 以及 `right = mid` 时，循环可以继续的条件要写成 `left < right`。因为：当 `left` 与 `right` 相等时，继续执行循环体，如果执行到 `right = mid` 就会进入死循环。

本题介绍的 `while (left < right)` 这种写法，退出循环以后 `left` 与 `right` 重合，此时：

- 如果问题一定有解，重合位置的值就是二分查找要找的答案；
- 如果不能确定问题一定有解，再判断一次重合位置的值是否是答案即可。

','8',NULL,'0035-search-insert-position','2025-06-11 09:10:31','2025-06-16 22:09:47',1,48,false,NULL,'https://leetcode.cn/problems/search-insert-position/description/',30,3,'',false,'https://leetcode.cn/problems/search-insert-position/solutions/10969/te-bie-hao-yong-de-er-fen-cha-fa-fa-mo-ban-python/',true,NULL,'可以在循环体内找到，也可以退出循环以后才得到答案。'),(29,'liweiwei1419','第 6 章 滑动窗口与双指针：数组问题的量体裁衣与相遇即解','',NULL,NULL,'sliding-window-two-pointers','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,20,6,'',true,NULL,true,NULL,'理解算法的有效性是解决问题的关键，一旦理解了设计算法的原因，就会觉得我们设计的算法处理问题很「理所当然」，只不过给了一个名字而已。'),(24,'liweiwei1419','第 1 章 基础排序算法：算法学习的起点','',NULL,NULL,'sorting','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,20,1,'',true,NULL,true,NULL,'这一章内容作为「开胃菜」，了解即可，不用熟练掌握。'),(8,'liweiwei1419','「力扣」第 209 题：长度最小的子数组（中等）','# 思路分析

我们先给出暴力解法，再给出优化思路。

**暴力解法**：枚举所有子数组，分别计算它们的和，如果和大于等于 `target` ，记录长度，求出所有满足子数组和大于等于 `target` 的长度的最小值。时间复杂度为 $ O(n^3) $，这里 $ n $ 是输入数组的长度。

**优化思路**：**题目中给出的数组是正整数数组**，如果一个连续子数组的和大于等于 `target` ，**此时左端点不变，长度更长的子数组一定满足和大于等于 `target`** ，但是题目要求找长度最小值，因此左端点固定，长度更长的子数组就没有必要考虑（这一点很关键，是本题可以使用滑动窗口算法的原因）。

此时应该 **考虑把左端点依次移除，看看是不是依然有子数组的和大于等于 `target`**，直到子数组的和小于 `target` ，再考虑扩展右端点，找到另一个和大于等于 `target` 的子数组。我们画出示意图如下：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image7382533529234845356.png)

题目要找的是「长度最小的子数组」，因此在 `left` 右移，窗口长度变短的时候记录最小值。

再次和大家强调：**正整数数组是本题可以使用滑动窗口算法的关键前提**。这是因为：由于数组中的元素均为正整数：

- 当移动滑动窗口的右边界时，窗口内元素的总和单调递增；
- 当移动滑动窗口的左边界时，窗口内元素的总和单调递减。

这种单调性使得我们能够依据窗口内元素总和与目标值 `target` 的大小关系，明确地移动左右边界，进而高效地找出满足条件的最小长度连续子数组。如果数组元素中存在负数，窗口内元素总和的单调性将被打破，滑动窗口算法不能使用。

以「示例 1」为例，输入 `target = 7`，`nums = [2, 3, 1, 2, 4, 3]`, 使用滑动窗口解法的过程如下表格所示：

| 步骤 | 窗口           | 窗口和 | 是否 ≥ target | 下一步操作               | 当前最小长度 |
| ---- | -------------- | ------ | ------------- | ------------------------ | ------------ |
| 1    | `[]`           | 0      | 否            | 扩张                     | `n + 1`      |
| 2    | `[2]`          | 2      | 否            | 扩张                     | `n + 1`      |
| 3    | `[2, 3]`       | 5      | 否            | 扩张                     | `n + 1`      |
| 4    | `[2, 3, 1]`    | 6      | 否            | 扩张                     | `n + 1`      |
| 5    | `[2, 3, 1, 2]` | 8      | 是            | 收缩                     | 4            |
| 6    | `[3, 1, 2]`    | 6      | 否            | 扩张                     | 4            |
| 7    | `[3, 1, 2, 4]` | 10     | 是            | 收缩                     | 4            |
| 8    | `[1, 2, 4]`    | 7      | 是            | 收缩                     | 3            |
| 9    | `[2, 4]`       | 6      | 否            | 扩张                     | 3            |
| 10   | `[2, 4, 3]`    | 9      | 是            | 收缩                     | 3            |
| 11   | `[4, 3]`       | 7      | 是            | 收缩                     | 2            |
| 12   | `[3]`          | 3      | 否            | 右边界不能扩张，程序结束 | 2            |


**最终结果**：最小长度为 `2`，对应的连续子数组是 `[4, 3]`。

**参考代码**：

```java
public class Solution {

    public int minSubArrayLen(int s, int[] nums) {
        int n = nums.length;
        int left = 0;
        int right = 0;
        int sum = 0;
        // 循环不变量：nums[left..right) >= s
        int minLen = n + 1;
        while (right < n) {
            sum += nums[right];
            right++;
            while (sum >= s) {
                // 如果加上某个数的和刚好大于 s，此时左边界需要右移，右移很可能不止一次，所以内部也是 while 循环
                minLen = Math.min(minLen, right - left);
                sum -= nums[left];
                left++;
            }
        }
        // 特殊用例判断
        return minLen == n + 1 ? 0 : minLen;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，右指针遍历了数组一次、左指针还没有遍历到数组的末尾就停了下来，因此时间复杂度为 $ O(n) $；
+ 空间复杂度：$ O(1) $。

# 本题小结

* 重要前提：子数组中的数值均为正整数，且题目要我们找 **长度最小** 的和大于等于 `target` 的长度；
- 右边界右移，找到一个和大于等于 `target` 的长度；
- 左边界右移，看看此时和是否还大于等于 `target` ，记录最小值，如此反复；
- 通过累加窗口的和判断是否满足条件。
','6',NULL,'0209-minimum-size-subarray-sum','2025-06-09 06:39:41','2025-06-12 20:30:40',1,14,false,NULL,'https://leetcode.cn/problems/minimum-size-subarray-sum/description/',29,2,'',false,'https://leetcode.cn/problems/minimum-size-subarray-sum/solutions/3695522/hua-dong-chuang-kou-java-by-liweiwei1419-i166/',true,NULL,NULL),(23,'liweiwei1419','第 4 部分 进阶篇','',NULL,NULL,'advanced-algorithms/','2025-06-09 04:14:34','2025-06-09 04:14:34',0,0,false,NULL,NULL,0,4,'',false,NULL,false,NULL,NULL),(30,'liweiwei1419','第 7 章 二分查找：逐渐缩小搜索区间','',NULL,NULL,'binary-search','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,20,7,'',true,NULL,true,NULL,'「二分查找」并非魔鬼、并非细节爆炸，希望大家通过学习二分查找章节，摒弃思维定式，算法学习没有捷径。'),(116,'liweiwei1419','「力扣」第 33 题：搜索旋转排序数组（中等）','# 例题 3：「力扣」第 33 题：搜索旋转排序数组（中等）

+ 题目地址：[https://leetcode.cn/problems/search-in-rotated-sorted-array/description/](https://leetcode.cn/problems/search-in-rotated-sorted-array/description/)

## 思路分析

题目说：整数数组按升序排列，数组中的值 **互不相同**，让我们必须设计一个时间复杂度为 $ O(\log n) $ 的算法，因此遍历数组 `nums` 找到目标值 `target` ，时间复杂度为 $ O(n) $，不符合题目要求，遍历数组没有利用到数组旋转有序的特点。

数组虽然经过旋转，**但仍然部分有序**，即：在数组的中间位置画一条线（当数组元素个数为偶数时，中间位置靠左、靠右均可），可能出现的情况如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749630199-TorDyf-image.png)


「旋转」形成的效果是：从数组中最大的数，突然来到了数组中最小的数，**这种变化出现的区域很小，因此数组中仍然会有一半的区域是有序的**，我们查找 `target` 的办法是：

+ 如果 `target` 落在有序的部分，继续使用二分查找；
+ 如果 `target` 落在非有序的部分，继续一分为二，直至区间的长度为 1、为 0。

**参考代码 1：**

```java
public class Solution {

    public int search(int[] nums, int target) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            // 注意：这里要写 <=，因为在搜索的最后，有可能出现 left 等于 mid
            // 如果不加等号，程序会错误地进入 else 分支（认为左半部分无序），导致逻辑错误
            if (nums[left] <= nums[mid]) {
                // 左半部分有序，即 nums[left] <= target < nums[mid]
                if (nums[left] <= target && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            } else {
                // 右半部分有序，即 nums[mid] < target <= nums[right]
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return -1;
    }

}
```

**代码编写说明**：

+ 目标元素可以在循环体内直接找到，所以循环可以继续的条件是 `left <= right`，剩余的分类讨论中，一定要写 `left = mid + 1` 和 `right = mid - 1`，这是因为 `nums[mid]` 是否等于 `target` 已经判断完了，代码能走到后面，`mid` 一定不是解；
+ 因为数组中的值互不相同，所以可以根据左边界 `nums[left]` 和中间位置 `nums[mid]` 的大小关系，判断哪一部分是升序的；
+ 注意：`nums[left] <= target < nums[mid]` 和 `nums[mid] < target <= nums[right]` 中写 `<` 的地方：因为之前不满足 `nums[mid] == target`，代码才走到这里，所以这里不应包含 `nums[mid] = target` 的情况；
+ 由于 `mid = (left + right) / 2` 这种中间数取法是下取整，所以在搜索的最后 `left` 有可能等于 `mid`。当 `mid == left` 时，`nums[left] == nums[mid]`，此时左半部分（`[left..mid]`）实际上是一个单元素区间，可以视为有序的。如果不加等号，程序会错误地进入 `else` 分支（认为左半部分无序），导致逻辑错误。以 `nums = [3, 1]`，`target = 1` 为例：
    - 初始时 `left = 0`，`right = 1`，`mid = (0 + 1) / 2 = 0`，`nums[mid] = 3`。
    - 检查 `nums[left] <= nums[mid]`：`nums[0] = 3`，`nums[mid] = 3`，`3 <= 3` 为 `true`。如果不加等号，`3 < 3` 为 `false`，程序会错误地认为左半部分无序，进入 `else` 分支；
    - 进入 `if (nums[left] <= nums[mid])` 分支后：检查 `nums[left] <= target < nums[mid]`：`3 <= 1 < 3` 为 `false`，所以调整 `left = mid + 1 = 1`。
    - 下一轮循环 `left = 1`，`right = 1`：`mid = 1`，`nums[mid] = 1`，找到目标值。因此 `if (nums[left] <= nums[mid])` 这里需要写 `<=` 而不能写 `<`。

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $，这里 $ n $ 是数组 `nums` 的长度，每次都将搜索区间缩小为接近原来一半；
+ 空间复杂度：$ O(1) $，只使用了常数个的额外的变量。

由于 `mid = (left + right) / 2` 这种写法，在搜索的最后 `left = mid` ，而我们之前设定的判别条件是  `if(nums[left] < nums[mid])` ，为了避免 `left = mid` 出现，也可以在取中间数的时候，使用取上取整，即 `mid = (left + right + 1) / 2`。

**参考代码 2**：

```java
public class Solution {

    public int search(int[] nums, int target) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            // mid 上取整，if (nums[left] < nums[mid])  就可以写 <
            int mid = (left + right + 1) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            if (nums[left] < nums[mid]) {
                if (nums[left] <= target && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            } else {
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return -1;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

也可以比较右边界元素 `nums[right]` 和中间位置 `nums[mid]` 的大小关系，由于中间数取法 `mid = (left + right) / 2`，`mid`不会等于 `right`，`if (nums[mid] < nums[right])` 不需要取 `=`。

**参考代码 3**：

```java
public class Solution {

    public int search(int[] nums, int target) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            if (nums[mid] < nums[right]) {
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            } else {
                if (nums[left] <= target && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
        }
        return -1;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
本题展示的多种代码版本，需要结合我们之前学习的二分查找的结论，例如：

+ 先写可以一下子找到问题答案的情况；
+ `mid = (left + right) / 2` 这种写法，当区间里只有两个元素的时候，`mid = left`，如果需要让 `mid = right` ，要写成 `mid = (left + right + 1) / 2`。

','8',NULL,'0033-search-in-rotated-sorted-array','2025-06-11 09:10:31','2025-06-12 16:47:54',1,15,false,NULL,'https://leetcode.cn/problems/search-in-rotated-sorted-array/description/',30,9,'',false,'https://leetcode.cn/problems/search-in-rotated-sorted-array/solutions/16003/er-fen-fa-python-dai-ma-java-dai-ma-by-liweiwei141/',true,NULL,'可以在循环体内找到。'),(114,'liweiwei1419','「力扣」第 378 题：有序矩阵中第 K 小的元素（中等）','这一节我们介绍 4 道典型的使用二分查找解决的问题，希望通过这 4 道问题能够帮助大家理清解决问题的思路：

+ 如果题目要我们找一个整数，并且从题目可以得到单调性，因此可以使用二分查找来找到这个整数；
+ 如果题目要我们找的目标元素可以使用一个表达式写出来，用 `while (left <= right)` 这种写法，否则问题的答案需要等到退出循环以后才能得到，用 `while (left < right)` 这种写法。

# 例题 1：「力扣」第 378 题：有序矩阵中第 K 小的元素（中等）

!!! info 阅读提示

该题的细节比较多，叙述篇幅较长，我们在每一段落的开头都标注了重点。初次学习的时候可能比较难想明白，可以借助一个或者几个具体的测试用例，模拟代码的执行流程，相信大家一定会有所收获。

!!!

+ 题目地址：[https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/description/](https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/description/)

## 思路分析

**暴力解法**：题目说「矩阵中第 `k` 小的元素，是 **排序后** 的第 `k` 小元素，而不是第 `k` 个不同的元素」，即相同值的元素也参与排序。我们可以遍历矩阵，将矩阵中的元素添加到一个一维数组中，对该一维数组使用内置的排序函数进行排序，返回排序后下标为 `k - 1` 的元素的值，这是暴力解法。

暴力解法 **没有利用到条件「矩阵每行和每列元素均按升序排序」**，时间复杂度为 $ O(n^2 \log(n^2)) $，存储矩阵元素的 `nums` 列表需要 $ O(n^2) $ 的空间，空间复杂度为 $ O(n^2) $。

根据题目条件「矩阵每行和每列元素均按升序排序」，**最小值** 是矩阵左上角的元素，**最大值** 是矩阵右下角的元素，并且 **矩阵中的元素都是整数**，所以本题要求我们 **查找一个有范围的整数**，这一点提示我们可以使用二分查找。

## 1. 题目的单调性
我们记「排序后 的第 `k` 小元素」为 `x`，即：排好序以后 `x` 的前面（包括 `x`）有 `k` 个数，也就是说，整个矩阵里小于等于 `x` 的数有 `k` 个，由此可以得到：

+ 如果矩阵中小于等于某个数（记为 `mid`）的元素个数较多（比 `k` 大），那么 `mid` 就比第 `k` 小元素 `x` 大；
+ 如果矩阵中小于等于某个数 `mid` 的元素个数较小（比 `k` 小），那么 `mid` 就比第 `k` 小元素 `x` 小。

这是本题的单调性，可以使用二分查找来确定整数 `x` 的值。接下来我们要解决的问题是：如何快速统计矩阵中小于等于某个数的元素个数。

## 2. 如何快速统计小于等于某个数的元素个数

由于矩阵的每行、每列都是有序的，可以对矩阵的每一行使用二分查找确定小于等于 `x` 的元素个数。具体来说：

+ 遍历矩阵的每一行，对于第 `i` 行（`i` 从 0 开始计算），使用「二分查找」找到满足 `matrix[i][j] <= x` 的最大的`j`（`j` 从 0 开始计算），那么该行小于等于 `x` 的元素个数就是 `j + 1`；
+ 将每行的个数累加起来，就得到了矩阵中小于等于 `x` 的元素总个数；
+ 由于需要对矩阵的每一行使用「二分查找」，矩阵有 `n` 行，每一行的元素数量为 `n`，所以「时间复杂度」为 $ O(n \log n) $。

其实还可以使用类似「力扣」第 240 题：搜索二维矩阵 II（中等）的做法，使用 **线性级别** 的时间复杂度完成个数统计，我们举例和大家说明。假设有如下图所示的 `6 × 6` 矩阵，要计算矩阵中小于等于 `x = 8` 的元素个数。

![image.png](https://pic.leetcode.cn/1749617197-YBPWxg-image.png)


+ 从矩阵的左下角元素 `matrix[5][0]` 开始，元素为 `6` ，因为 `6 <= 8`，我们将 `i + 1`（即 `5 + 1 = 6`）累加到 `count` 中，此时 `count = 6`，然后将 `j + 1`，即 `j = 1`。如下图所示：

![image.png](https://pic.leetcode.cn/1749617203-xYwYAX-image.png)


+ 现在我们在 `matrix[5][1]` 位置，元素为 `8`。此时 `8 <= 8`，我们将 `i + 1`（即 `5 + 1 = 6`）累加到 `count` 中，`count = 12`，然后将 `j + 1`，即 `j = 2`。如下图所示：

![image.png](https://pic.leetcode.cn/1749617211-BNEgII-image.png)


+ 现在我们在 `matrix[5][2]` 位置，值为 `10`。此时 `10 > 8`，我们向上遍历，找到第一个小于等于 8 的元素 `matrix[3][2]`，将 `i + 1`（即 `3 + 1 = 4`）累加到 `count` 中，`count = 16`，然后将 `j + 1`，即 `j = 3`。如下图所示：

![image.png](https://pic.leetcode.cn/1749617217-VPnMLn-image.png)


+ 现在我们在 `matrix[3][3]` 位置，元素为 `10`。此时 `10 > 8`，我们向上遍历，找到第一个小于等于 8 的元素 `matrix[1][4]`，将 `i + 1`（即 `1 + 1 = 2`）累加到 `count` 中，`count = 18`，然后将 `j + 1`，即 `j = 4`。如下图所示：

![image.png](https://pic.leetcode.cn/1749617226-fiiHDm-image.png)


依次进行下去，直到 `i = 0，j = n - 1` 都没有发现小于等于 8 的元素，我们以 $ O(m + n) $ 的「时间复杂度」 计算矩阵中小于等于 `x = 8` 的元素个数为 `18`。

代码如下：

```java
public int countLessOrEqual(int[][] matrix, int threshold) {
    int n = matrix.length;
    int count = 0;
    int j = 0;
    for (int i = n - 1; i >= 0; i--) {
        while (j < n && matrix[i][j] <= threshold) {
            count += (i + 1);
            j++;
        }
    }
    return count;
}
```

## 3. 二分查找的分类讨论与情况合并

记矩阵中小于等于 `x` 的元素个数为 `count`。根据题意：

+ 当 `count < k` 时，说明当前猜测值 `mid` 太小了，下一轮往大了猜，设置 `left = mid + 1`；
+ 当 `count = k` 时，说明当前猜测值 `mid` 有可能猜对，**但还应该尝试更小的值**，此时设置 `right = mid`。这是因为当前猜测值 `mid` 有可能在矩阵中并不存在。如下图所示：

![image.png](https://pic.leetcode.cn/1749617238-ArOulB-image.png)


+ 当 `count > k` 时，说明当前猜测值 `mid` 太大了，下一轮往小了猜，设置 `right = mid - 1`。

根据我们在第 2 节的介绍，需要合并 `right = mid - 1` 和 `right = mid` 两种情况，即：

```java
if (count >= k) {
    right = mid;
} else {
    left = mid + 1;
}
```

根据上面的分析，我们写出如下代码：

```java
public class Solution {

    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        int left = matrix[0][0];
        int right = matrix[n - 1][n - 1];
        while (left < right) {
            // 注意：超出时间限制的原因在这里
            int mid = (left + right) / 2;
            int count = countLessOrEqual(matrix, n, mid);
            if (count >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private static int countLessOrEqual(int[][] matrix, int n, int mid) {
        int count = 0;
        int j = 0;
        for (int i = n - 1; i >= 0; i--) {
            while (j < n && matrix[i][j] <= mid) {
                count += (i + 1);
                j++;
            }
        }
        return count;
    }

}
```

将上面这段代码提交给「力扣」，会提示「超出时间限制」。

![image.png](https://pic.leetcode.cn/1749617249-Emevld-image.png)


超时的测试用例矩阵中的整数都是负数，因此不能通过的原因是：在 <font style="color:rgba(0, 0, 0, 0.85);">Java 中，</font>`<font style="color:rgba(0, 0, 0, 0.85);">/</font>`<font style="color:rgba(0, 0, 0, 0.85);"> 运算符遵循「截断除法」的规则，即：对于正整数除法，结果是向下取整；对于负整数除法，结果是向上取整，即</font>都是向零的方向取整。

而本题的解决方案是：对于负数，使用 `(left + right) >> 1`。大家可以尝试运行如下代码：

```java
public static void main(String[] args) {
    int a = -7;
    // -3
    System.out.println(a / 2);
    // -4
    System.out.println(a >> 1);
}
```

+ 首先，`-7` 的二进制原码是 `10000111`（假设使用 8 位二进制表示），其反码是 `11111000`，补码是 `11111001`（在 Java 中，负数以补码形式存储）；
+ 当进行算术右移 1 位操作时，右移 1 位得到 `11111100`，这是右移后的补码；
+ 对补码 `11111100` 求原码，先减 1 得到反码 `11111011`，再取反得到原码 `10000100`，对应的十进制数就是 `-4`。

## 4. 为什么必须要下取整

这是由边界收缩行为决定的，`left = mid + 1` 与 `right = mid` 对应的中间数取法就要求中间数取较小的那一个。当区间里只有两个元素的时候：

+ 如果进入 `left = mid + 1` 分支，`left` 与 `right` 重合；
+ 如果进入 `right  = mid` 分支，`right` 与 `left` 重合。

如果设置 `mid` 上取整，还进入 `right = mid` 分支，边界不收缩，程序进入死循环。

完整的、可以通过「力扣」测评的代码：

```java
public class Solution {

    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        int left = matrix[0][0];
        int right = matrix[n - 1][n - 1];
        while (left < right) {
            int mid = (left + right) >> 1;
            int count = countLessOrEqual(matrix, mid);
            if (count >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private int countLessOrEqual(int[][] matrix, int x) {
        int n = matrix.length;
        int count = 0;
        int j = 0;
        for (int i = n - 1; i >= 0; i--) {
            while (j < n && matrix[i][j] <= x) {
                count += (i + 1);
                j++;
            }
        }
        return count;
    }

}
```

## 5. 「二分查找」的答案一定在矩阵中吗？

根据上述解法，我们要找的是：使得 `count = k` 的 `x` 的最小值，使用二分查找一定可以逼近到最值。粗略地理解该结论是这样的：每一次执行 `countLessOrEqual()` 函数，其实 **读到的都是矩阵中的元素**，因此二分查找的答案一定在矩阵中。

这么说可能有点抽象，以「示例 1」为例：

![image.png](https://pic.leetcode.cn/1749617261-VbhrDu-image.png)


搜索范围是 `[1..15]`。

- **第 1 轮**：`left = 1, right = 15, mid = 8`，数出小于等于 8 的元素个数有 2 个（小于 `k`），所以第 8 小的元素不可能是 8，第 8 小的元素至少是 9，设置 `left = mid + 1`，如下图所示：


![image.png](https://pic.leetcode.cn/1749617269-qGsmgp-image.png)

- **第 2 轮**：`left = 9, right = 15, mid = 12`，数出小于等于 12 的元素个数有 6 个（小于 `k`）。所以第 8 小的元素不可能是 12，第 8 小的元素至少是 13，设置 `left = mid + 1`，如下图所示：

![image.png](https://pic.leetcode.cn/1749617276-kWGtth-image.png)


- **第 3 轮**：`left = 13, right = 15, mid = 14`，数出小于等于 14 的元素个数有 8 个（等于 `k`）。所以第 8 小的元素最大是 14，设置 `right = mid`，如下图所示：


![image.png](https://pic.leetcode.cn/1749617298-BAOdyV-image.png)


- **第 4 轮**：`left = 13, right = 14, mid = 13`，数出小于等于 13 的元素个数有 8 个（等于 `k`）。所以第 8 小的元素最大是 13，设置 `right = mid`。 到此为止，`left` 与 `right` 重合，我们找到了满足 `count = k` 的 `x` 的最小值 13。如下图所示：

![image.png](https://pic.leetcode.cn/1749617308-EURRyS-image.png)

综上所述，我们要找的其实是 **矩阵中小于等于 `x` 的元素个数恰好等于 `k` 的 `x` 的最小值，利用单调性，我们可以使用二分查找 `while (left < right)` 这种代码形式来找到该最值，所以二分查找最后 `left` 与 `right` 重合的那个值一定在矩阵中**。

## 本题总结

本题的难点是：由于有矩阵中可能有负数，所以 `mid` 的取值应该使用 `int mid = (left + right) >> 1` 。不同编程语言对于整数除法中负数的舍入规则可能不同，读者需要自己根据所选编程语言的特性采取相应的写法。

','8',NULL,'0378-kth-smallest-element-in-a-sorted-matrix','2025-06-11 09:10:31','2025-06-12 17:37:31',0,16,false,NULL,'https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/description/',30,7,'',false,'https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/solutions/3695015/zhao-de-shi-zui-xiao-zhi-suo-yi-left-yu-1pilg/)',true,NULL,'必须退出循环以后才能确定答案。'),(112,'liweiwei1419','「力扣」第 875 题：爱吃香蕉的珂珂（中等）','「最大值极小化」就是「最大值尽可能小」的意思。对于初次接触本节问题的朋友来说，可能会有一定难度，原因其实很简单，就是之前没有见过。

首先，题目要找的是一个整数，显然可以使用二分查找找到这个整数，这一点其实是很显然的。有的初学的朋友可能误以为二分查找必须要求输入数组有序，但实际上，这一类问题的二分查找是 **对目标整数一分为二进行查收（逼近）**，而不是在输入数组上直接使用二分查找，这一点请大家区分。

其次，在代码层面上，每一次缩小搜索的范围，我们都需要把输入数组里所有的元素都遍历一遍。有些朋友可能对这一点有所怀疑。事实上这一类问题最优的时间复杂度就是 $ O(n \log n) $，这里 $ n $ 是输入数组的长度。

# 例题 1：「力扣」第 875 题：爱吃香蕉的珂珂（中等）
+ 题目地址：[https://leetcode.cn/problems/koko-eating-bananas/description/](https://leetcode.cn/problems/koko-eating-bananas/description/)


## 理解题意
题目中的关键设定：如果这堆香蕉少于 `k` 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。大家不要太纠结这个奇怪的设定，它就是一个问题场景而已，和小时候做数学题做到一个水池，一边放水、一边蓄水，问多长时间能灌满水池一样，挺无聊的。

哪一堆香蕉先吃无关紧要，每一堆香蕉的根数是正数。

根据题意可知：**珂珂吃香蕉的速度越慢，耗时越多；反之，速度越快，耗时越少**。速度与耗时的 **单调性** 是解决本题的关键。由于速度是一个有范围的整数，因此可以使用二分查找找到这个有范围的整数。

**注意**：如果目前尝试的速度恰好使得珂珂在规定的时间 `h` 小时内吃完，因为题目问的是最小速度，所以我们 **还应该尝试更小的速度** 是不是还可以保证在 `h` 小时内吃完内吃完所有的香蕉。这一点决定了 **二分查找的答案需要在退出循环以后才能确定**，因此循环可以继续的条件是 `left < right`。

## 思路分析
我们要找的是速度。因为题目限制了珂珂一个小时之内只能选择一堆香蕉吃，因此速度最大值是：这几堆香蕉中，数量最多的那一堆。速度的最小值是 1，其实还可以再分析出准确的速度的最小值是多少，由于二分查找的时间复杂度很低，分析出准确的速度的最小值不是很有必要（搜索范围扩大了，不会错过答案）。

**每堆香蕉吃完的耗时 = 这堆香蕉的数量 / 珂珂一小时吃香蕉的数量**。根据题意（如果这堆香蕉少于 `k` 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉），这里的 `/` 在不能整除的时候，需要 **上取整**。其它细节请见下面「参考代码」的注释。

## 编码细节
我们编写一个函数 `calculateSum`，参数是 `piles` （香蕉堆数组）、`speed`(珂珂当前尝试的速度）。下面我们讨论 `calculateSum(piles, mid)` （这里实际上传入的是搜索范围 `[left..right]` 里的中间值 `mid`）和 `h` 的大小关系，可以分为如下 3 种情况：

+ **情况 1**：`calculateSum(piles, mid) > h`，耗时太多，说明吃得慢，接下来吃的速度要快一点，此时设置 `left = mid + 1`;
+ **情况 2**：`calculateSum(piles, mid) == h`，耗时正好等于 `h`，说明：当前速度可能是答案。不过还有可能的情况是：吃得慢一点，也能保证耗时是 `h`，此时设置 `right = mid`；
+ **情况 3**：`calculateSum(piles, mid) < h`，耗时太少，吃得太快，尝试更小的速度，此时设置 `right = mid - 1`。

根据之前的分析，循环体内出现了 `left = mid + 1`、`right = mid - 1` 和 `right = mid`，循环可以继续的条件要写成 `left < right` ，并且需要把 `right = mid - 1` 与 `right = mid` 的情况合并（如果不合并，代码不能通过系统测评，大家可以自己尝试一下）。「参考代码」如下：

**参考代码**：

```java
public class Solution {

    public int minEatingSpeed(int[] piles, int h) {
        int maxVal = 1;
        for (int pile : piles) {
            maxVal = Math.max(maxVal, pile);
        }

        // 速度最小的时候，耗时最长
        int left = 1;
        // 速度最大的时候，耗时最短
        int right = maxVal;
        while (left < right) {
            int mid = (left + right) / 2;
            if (calculateSum(piles, mid) > h) {
                // 耗时太多，说明速度太慢了，下一轮搜索区间是 [mid + 1..right]
                left = mid + 1;
            } else {
                // 搜索区间是上面 if 的反面区间，即下一轮搜索区间在 [left..mid]
                right = mid;
            }
        }
        return left;
    }

    // 珂珂按照 speed 速度吃完这堆香蕉需要的小时数
    private int calculateSum(int[] piles, int speed) {
        int hours = 0;
        for (int pile : piles) {
            int hour = pile / speed;
            if (pile % speed != 0) {
                hour++;
            }
            hours += hour;
            // 上取整还可以这样写 hours += (pile + speed - 1) / speed;
        }
        return hours;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log \max(piles)) $，这里 $ n $ 是数组 `piles` 的长度。我们在 $ [1, \max{piles}] $ 里使用二分查找定位最小速度，而每一次执行判别函数的时间复杂度是 $ O(n) $；
+ 空间复杂度：$ O(1) $，只使用了常数个额外的变量。

## 本题总结

+ **本题可以使用二分查找的原因是单调性**：速度越慢，耗时越多；速度越快，耗时越少。通过调节速度，以控制时间；
+ 本题的关键：当尝试的速度 `mid` 使得吃完所有香蕉恰好需要 `h` 小时的时候，`mid` 有可能是答案，代码 `right = mid` 一定会出现；
+ 理解需要将 `right = mid` 和 `right = mid - 1` 这两种情况进行合并的理由：让退出循环以后 `left` 与 `right` 重合，以避免复杂的分类讨论。

','8',NULL,'0875-koko-eating-bananas','2025-06-11 09:10:31','2025-06-12 17:00:10',1,6,false,NULL,'https://leetcode.cn/problems/koko-eating-bananas/description/',30,5,'',false,'https://leetcode.cn/problems/koko-eating-bananas/solutions/51963/er-fen-cha-zhao-ding-wei-su-du-by-liweiwei1419/',true,NULL,'必须退出循环以后才能确定答案。'),(113,'liweiwei1419','「力扣」第 410 题：分割数组的最大值（困难）','## 思路分析

本题是一道非常经典的「最大值极小化」问题，题目中的关键字「**非负整数**」很关键，我们放在最后和大家强调。

「子数组各自和的最大值最小」这句话读起来有一点点绕，我们拆分一下：

+ 输入数组是确定的，`k` 是确定的，其中一组的和多了，别的组的和就少；
+ 对于特定的、分割成 `k` 组的分割，对每一组求和，求出它们的最大值 `val`；
+ 我们需要找到所有的、分割成 `k` 组的分割中，`val` 的最小值。具体怎么拆，题目不用我们求，只需要我们计算出 `val` 的值。

观察到「数组各自和的最大值」和分割数，有如下关系：

+ 如果设置「数组各自和的最大值」很大，会使得分割数很小；
+ 如果设置「数组各自和的最大值」很小，会使得分割数很大。

这是本题的 **单调性**，并且题目要我们找的是一个整数，因此可以使用二分查找。

## 编码细节
假设某个「数组各自和的最大值」`mid` 使得数组的分割数为 `splits`，根据 `splits` 与 `k` 的大小关系，可以分为如下 3  种情况：

- **情况 1（`splits = k`）**：**当前 `mid` 有可能是答案**，下一轮应该尝试更小的数值，因此设置 `right = mid`；
- **情况 2（`splits > k`）**：`mid` 太小导致 `splits` 太大，因此设置 `left = mid + 1`；
- **情况 3（`splits < k`）**：`mid` 太大导致 `splits` 太小，因此设置 `right = mid - 1`。

根据我们之前的分析，出现 `right = mid`，为了避免出现死循环，循环可以继续的条件需要写成 `left < right` ，表示退出循环以后找到答案。并且，为了使得退出循环以后 `left` 与 `right` 重合（避免交叉越界带来的分类讨论），合并 `right = mid` 与 `right = mid - 1` 的情况。


接着我们确定查找的范围：

+ 二分查找的下界是数组 `nums` 中的最大元素，这是因为数组的最大元素一定会属于某一组，否则无法分组。例如，对于数组 `nums = [1, 2, 3, 4, 5]`，如果分割成若干子数组，其中一个子数组必然会包含 `5`，所以「子数组和的最大」值最小就是 `5`；
+ 二分查找的上界是数组 `nums` 所有元素的和，这是因为如果把整个数组作为一个子数组（这是分割的一种极端情况，当 `k = 1` 时），那么子数组和的最大值就是数组所有元素的总和。例如，对于数组 `nums = [1, 2, 3, 4, 5]`，其所有元素和为 `1 + 2 + 3 + 4 + 5 = 15`，这是「子数组和最大值」可能达到的最大情况。

**最后我们来看「非负整数」这个前提为什么很重要**。当数组元素为非负整数时，子数组的和具有单调性。如果我们增加子数组中元素的个数，那么子数组的和只会增加或者保持不变（当新增元素为 0 时），不会减少。在二分查找过程中，我们需要判断是否可以将数组分成 `k` 个非空连续子数组，使得每个子数组的和不超过某个给定的最大值。由于非负整数，保证了和具有单调性，我们可以从左到右遍历数组，依次累加元素，**当累加和超过给定的最大值时，就开启一个新的子数组**。**如果数组元素可以为负数，那么在累加过程中，和可能会减少，这样就无法按照这种简单的方式进行子数组的划分，二分查找就无法正常工作**。

**参考代码**：

```java
public class Solution {

    public int splitArray(int[] nums, int k) {
        int max = 0;
        int sum = 0;
        // 计算「子数组各自的和的最大值」的范围
        for (int num : nums) {
            max = Math.max(max, num);
            sum += num;
        }

        // 尝试「子数组各自的和的最大值」mid，使得它对应的「子数组的分割数」恰好等于 k
        int left = max;
        int right = sum;
        while (left < right) {
            int mid = (left + right) / 2;
            int splits = split(nums, mid);
            if (splits <= k) {
                // 下一轮搜索区间是 [left..mid]
                right = mid;
            } else {
                // 下一轮搜索的区间是 [mid + 1..right]
                left = mid + 1;
            }
        }
        return left;
    }

    /**
     * @param nums 原始数组
     * @param maxIntervalSum 子数组各自的和的最大值
     * @return 满足不超过「子数组各自的和的最大值」的分割数
     */
    private int split(int[] nums, int maxIntervalSum) {
        // 至少是一个分割
        int splits = 1;
        // 当前区间的和
        int curIntervalSum = 0;
        for (int num : nums) {
            // 尝试加上当前遍历的这个数，如果加上去超过了「子数组各自的和的最大值」，就不加这个数，另起炉灶
            if (curIntervalSum + num > maxIntervalSum) {
                curIntervalSum = 0;
                splits++;
            }
            curIntervalSum += num;
        }
        return splits;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log \sum nums) $，这里 $ n $ 是输入数组的长度，$ \sum nums $ 表示输入数组的和，代码在 $ [\max(nums) .. \sum nums] $ 区间里使用二分查找找到目标元素，而每一次判断分支需要遍历一遍数组，「时间复杂度」为 $ O(n) $；
+ 空间复杂度：$ O(1) $ ，只使用了常数个额外的变量。

## 本题总结
+ 本题要找的是一个整数，这个整数有范围，并且还有单调性，所以可以使用二分查找找到这个整数；
+ 「非负整数」这个前提非常重要，如果不是非负整数数组，就不能使用二分查找。

','8',NULL,'0410-split-array-largest-sum','2025-06-11 09:10:31','2025-06-13 02:09:16',1,7,false,NULL,'https://leetcode.cn/problems/split-array-largest-sum/description/',30,6,'',false,'https://leetcode.cn/problems/split-array-largest-sum/solutions/242909/er-fen-cha-zhao-by-liweiwei1419-4/',true,NULL,'必须退出循环以后才能确定答案。'),(115,'liweiwei1419','「力扣」第 719 题：找出第 k 小的距离对（困难）','## 题解题意

+ 题目中的关键字：整数数组；
+ 数对的距离定义为：两个数的差的 **绝对值**。因为输入数组是整数数组，所以数对的距离一定为非负整数；
+ 根据「示例 2」，数组中所有的数都是 1，距离只能为 $ 0 $，但题目偏偏要问 `k = 2`，说明：**「第 `k` 小的距离对」不是「第 `k` 小的不同距离对」**，因此题目最后给出的数据范围是 `1 <= k <= n * (n - 1) / 2`，类似问题的问法还有「力扣」第 378 题：有序矩阵中第 k 小的元素。

本题的暴力解法是：

+ 计算所有的数对的距离，时间复杂度为 $ O(n^2) $；
+ 然后排序，时间复杂度是 $ O(n \log n) $；
+ 最后再找到第 `k` 小的数，题目说相同距离也参与排序，排序以后第 `k` 小的距离的下标是 `k - 1` ；

总的时间复杂度是：$ O(n^3 \log n) $。

## 思路分析
题目要求返回一个整数（输入数组是 **整数数组**），并且这个整数是 **有范围** 的，因此可以使用二分查找来找到这个有范围的整数：先猜答案是某个整数 `a`，然后遍历输入数组：

- 如果距离 **小于等于** `a` 的数对的个数 `< k`，**`a` 肯定是不是第 `k` 小的距离**，说明猜的数 `a` 太小了；
- 如果距离 **小于等于** `a` 的数对的个数 `= k`，说明 **猜的数 `a` 有可能是第 `k` 小的距离**，不过也有可能猜的数 `a` 不是第 `k` 小的距离，可以确定的是此时答案最大是 `a`；
- 如果距离 **小于等于** `a` 的数对的个数 `> k`，说明猜的数 `a` 太大了。

那么如何计算小于等于 `a` 的数对的个数呢？注意到：如果 **一个整数区间** 里，最小数和最大数的差值为 `diff`，那么这个整数区间里的 **所有** 数对的差值都小于等于 `diff`，因此如果加速计算，需要先对输入数组排序。

我们以在有序数组 `[3, 6, 8, 10, 12, 16]` 中找到所有距离小于等于 5 的数对的个数为例，距离小于等于 5 的所有数对形成了一个「区间」，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749754882-unDjCj-image.png)


使用滑动窗口算法可以找到这些区间，并且数出距离小于等于 5 的所有数对的个数，具体做法是：

+ 左边界 `left`、右边界 `right` 同向交替移动，`right` 先移动，直到 `right - left > a` 时停下，然后 `left` 右移，直到 `right - left <= a` 时停下，然后 `right` 继续右移，如此进行下去；
+ **在右边界 `right` 右移的时候，累加距离小于等于 `a` 的元素的个数**，个数为 `right - left` ，其含义是：**右边界与非右边界里的所有元素的距离都小于等于 `a`**，非右边界的元素个数为 `right - left`（区间 `[left..right]` 的长度（`right - left + 1`）再减 1，这个 1 是 `right` 所在位置）。如下图所示：10 与 6、8 的距离均小于 5，此时我们找到了两个数对 (10, 6) 与 (10, 8) ，数对的个数为 3 - 1 = 2。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749754897-mEZnNA-image.png)


可能有的朋友要问了，是不是漏了数对 (6, 8) ？其实它是在之前 `right` 移动到下标 2 的时候数出来的。下图展示了在数组 `[3, 6, 8, 10, 12, 16]` 里找到所有距离小于等于 5 的数对的个数的过程。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749754904-wmWGGn-image.png)


最后我们讨论二分查找代码如何写，设距离小于 `a` 的数对个数为 `count`：

+ 当 `count < k`，说明此时猜测的 `a` 太小了（`a` 越大数出的数对个数越多），下一轮应该猜更大的数；
+ 当 `count = k`，说明此时猜测的 `a` 可能是题目要求的答案，如果不是，答案只能是比 `a` 更小的数，因此问题的答案是 **使得 `count = k` 的最小的 `a`，使用 `while (left < right)` 这种写法**；
+ 当 `count > k`，说明此时猜测的 `a` 太大了，下一轮应该猜更小的数。

因此二分查找循环体内代码是：

```java
if (count < k) {
    left = a + 1;
} else if (count == k) {
    right = a; 
} else {
    right = a - 1;
}
```

根据我们之前的分析，应该把 `count == k` 和 `count > k` 的情况合并，它们都是对搜索右边界 `right` 的设置。

**参考代码**：

```java
import java.util.Arrays;

public class Solution {

    public int smallestDistancePair(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0;
        int right = nums[n - 1] - nums[0];
        while (left < right) {
            int mid = (left + right) / 2;
            int count = countLessEquals(nums, mid);
            if (count < k) {
                // 如果小于等于 mid 的个数严格小于 k 个，说明 mid 太小了
                // 下一轮搜索区间为 [mid + 1..right]
                left = mid + 1;
            } else {
                // 下一轮搜索区间为 [left..mid]
                right = mid;
            }
        }
        return left;
    }

    // 统计距离（数值之差）小于等于 threshold 的个数
    private int countLessEquals(int[] nums, int threshold) {
        int count = 0;
        int n = nums.length;
        for (int left = 0, right = 0; right < n; right++ ) {
            while (nums[right] - nums[left] > threshold) {
                left++;
            }
            count += right - left;
            // 此时满足 nums[right] - nums[left] <= threshold
            // right 与 [left..right - 1] 里的每一个元素的「距离」都小于等于 threshold
            // [left..right - 1] 里元素的个数为 right - left
        }
        return count;
    }

}
```

**复杂度分析：**

+ 时间复杂度：使用 $ n $ 表示输入数组的长度，$ m $ 表示输入数组 `nums` 的最大值和最小值的差值。
    - 排序：$ O(n \log n) $；
    - 二分查找：$ O(\log m) $；每一轮 `countLessEquals()` 函数需要遍历整个输入数组；
    - 滑动窗口：使用两个变量遍历 $ O(2n) = O(n) $；
    - 因此总的「时间复杂度」为 $ O(n \log n + n \log m) $。
+ 空间复杂度：$ O(\log n) $，排序一般认为使用「快速排序」或者「归并排序」，「空间复杂度」为 $ O(\log n) $。','8',NULL,'0719-find-k-th-smallest-pair-distance','2025-06-11 09:10:31','2025-06-13 03:09:14',1,8,false,NULL,'https://leetcode.cn/problems/find-k-th-smallest-pair-distance/description/',30,8,'',false,'https://leetcode.cn/problems/find-k-th-smallest-pair-distance/solutions/1602490/er-fen-cha-zhao-hua-dong-chuang-kou-java-8q95/',true,NULL,'必须退出循环以后才能确定答案。'),(150,'liweiwei1419','「力扣」第 720 题：词典中最长的单词（中等）','',NULL,NULL,'0720-longest-word-in-dictionary','2025-06-11 09:38:12','2025-06-11 09:38:13',0,1,false,NULL,'https://leetcode.cn/problems/longest-word-in-dictionary/description/',43,1,'',false,NULL,false,NULL,NULL),(49,'liweiwei1419','「力扣」第 39 题：组合总和（中等）','## 思路分析

根据示例 1，输入: `candidates = [2, 3, 6, 7]`，`target = 7`。

+ 输入数组里有 `2`，如果找到了组合总和为 `7 - 2 = 5` 的所有组合，再在之前加上 `2` ，就是 `7` 的所有组合；
+ 同理考虑 `3`，如果找到了组合总和为 `7 - 3 = 4` 的所有组合，再在之前加上 `3` ，就是 `7` 的所有组合，依次这样找下去。

我们画出递归树如下：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image10405474311841983789.png)

画图的规则是：

+ 创建一个分支时 **做减法** ；
+ 每一个箭头表示：从父亲结点的数值减去边上的数值，得到子结点的数值。边的值就是题目中给出的 `candidate` 数组的每个元素的值；
+ 减到 0 或者负数的时候停止；
+ 所有从根结点到叶子结点 0 的路径就是题目要找的结果。

这棵树有 $ 4 $ 个叶子结点的值 $ 0 $，对应的路径列表是 `[[2, 2, 3], [2, 3, 2], [3, 2, 2], [7]]`，而示例中给出的输出只有 `[[7], [2, 2, 3]]`。即：题目中要求每一个符合要求的解是 **不计算顺序** 的。

如何去掉重复组合呢？我们的策略是在画这棵递归树的时候就避免产生重复组合。在力扣第 15 题（三数之和）、力扣第 47 题（ 全排列 II ）中，我们曾经见过：按顺序计算，可以避免产生重复。对输入数组排序后，我们可以通过控制递归的起始位置（`begin` 参数）来避免产生重复的组合。

例如，在 `candidates = [2, 3, 6, 7]` 中，如果我们已经尝试了以 `2` 开头的组合（如 `[2, 2, 3]`），那么在后序的遍历中，我们不需要再尝试以 `3` 开头的组合中包含 `2` 的情况（如 `[3, 2, 2]`），因为这会生成重复的组合。

另外，排序的附加作用是：剪枝更彻底。例如，输入数组 `candidates = [2, 3, 6, 7]`，`target = 7`，当当前组合的和为 `5` 时，如果尝试加入 `6` 或 `7`，显然会超过 `target`，因此可以直接跳过这些数。


**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        int n = candidates.length;
        List<List<Integer>> res = new ArrayList<>();
        // 排序的作用：去重、剪枝更彻底
        Arrays.sort(candidates);
        Deque<Integer> path = new ArrayDeque<>();
        dfs(candidates, 0, n, target, path, res);
        return res;
    }

    private void dfs(int[] candidates, int begin, int len, int target, Deque<Integer> path, List<List<Integer>> res) {
        // 由于进入更深层的时候，小于 0 的部分被剪去，因此递归终止条件值只判断等于 0 的情况
        if (target == 0) {
            res.add(new ArrayList<>(path));
            return;
        }

        for (int i = begin; i < len; i++) {
            // 重点理解这里剪枝，前提是候选数组已经有序
            if (target - candidates[i] < 0) {
                break;
            }
            path.addLast(candidates[i]);
            dfs(candidates, i, len, target - candidates[i], path, res);
            path.removeLast();
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：最坏情况下，回溯算法的时间复杂度为 $ O(2^n) $，其中 `n` 是 `candidates` 数组的长度。由于每个元素可以被多次使用，实际复杂度会更高；
+ 空间复杂度：空间复杂度主要取决于递归栈的深度，最坏情况下为 `O(target)`。

## 本题总结
排序的主要目的是为了 **剪枝** 和 **避免重复组合**，从而提高算法的效率。有些朋友可能会疑惑什么时候使用 `used` 数组，什么时候使用 `begin` 变量。这里为大家简单总结：

+ 排列问题，讲究顺序（即 `[2, 2, 3]` 与 `[2, 3, 2]` 视为不同列表时），需要记录哪些数字已经使用过，此时用 `used` 数组；
+ 组合问题，不讲究顺序（即 `[2, 2, 3]` 与 `[2, 3, 2]` 视为相同列表时），需要按照某种顺序搜索，此时使用 `begin` 变量。

**注意**：具体问题应该具体分析， **理解算法的设计思想** 是至关重要的，请不要死记硬背。

| 特性 | `used` 数组 | `begin` 变量 |
| --- | --- | --- |
| **适用问题** | 排列问题（顺序相关） | 组合问题（顺序无关） |
| **核心目的** | 记录元素是否被使用过 | 控制搜索的起始位置，避免重复组合 |
| **遍历方式** | 每次从头遍历所有元素 | 从 `begin` 开始遍历后续元素 |
| **典型问题** | 全排列、带重复元素的排列问题 | 组合总和、子集问题 |
| **去重方式** | 通过 `used` 数组避免重复使用元素 | 通过 `begin` 变量避免重复组合 |

','16',NULL,'0039-combination-sum','2025-06-10 04:10:52','2025-07-09 14:38:55',1,16,false,NULL,'https://leetcode.cn/problems/combination-sum/description/',38,3,'',false,'https://leetcode.cn/problems/combination-sum/solutions/14697/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-m-2/',true,NULL,NULL),(151,'liweiwei1419','「力扣」第 212 题：单词搜索 II（困难）','',NULL,NULL,'0212-word-search-ii','2025-06-11 09:38:13','2025-06-11 09:38:13',0,0,false,NULL,'https://leetcode.cn/problems/word-search-ii/description/',43,2,'',false,NULL,false,NULL,NULL),(152,'liweiwei1419','「力扣」第 677 题：键值映射（中等）','',NULL,NULL,'0677-map-sum-pairs','2025-06-11 09:38:13','2025-06-11 09:38:13',0,0,false,NULL,'https://leetcode.cn/problems/map-sum-pairs/description/',43,3,'',false,NULL,false,NULL,NULL),(40,'liweiwei1419','第 16 章 贪心算法：局部最优能否带来全局最优？','',NULL,NULL,'greedy','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,22,3,'',true,NULL,true,NULL,'局部最优解构成了整体最优解，需要证明，但实际解题不需要严格证明。'),(153,'liweiwei1419','「力扣」第 648 题：单词替换（中等）','',NULL,NULL,'0648-replace-words','2025-06-11 09:38:13','2025-06-11 09:38:13',0,0,false,NULL,'https://leetcode.cn/problems/replace-words/description/',43,4,'',false,NULL,false,NULL,NULL),(48,'liweiwei1419','「力扣」第 47 题：全排列（中等）','## 思路分析
这一题在「力扣」第 46 题（全排列）的基础上增加了序列 `nums` 包含重复数字这一条件，且要求：返回的结果不能重复。

一个比较容易想到的做法是使用「力扣」第 46 题的代码，在结果集中去重，这些结果集的元素是列表，对列表去重不像用哈希表对基本元素去重那样容易。

如果要比较两个列表，一个容易想到的办法是对列表分别排序，然后逐个比对。既然要排序，我们可以 **在深度优先遍历之前就对输入数组排序**，一旦发现某个分支遍历下去会得到重复的元素就停止，这样结果集中就不会包含重复列表。

我们使用 `nums = [0, 0'', 1]` （为了区分两个 `0` ，另一个 `0` 使用 `0''` 表示）画出递归树如下：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image8038542746046228805.png)

图中虚线框住的叶子结点（且标有箭头）是产生重复排列的结点，它们的 `0''` 在前，`0` 在后，我们分析产生重复的原因：`[0’, 0, 1]` 与 `[0’, 1, 0]` 是在遍历到 `[0'']` 结点（位于该递归树第 2 层）的时候得到的，`[0'']` 子树与 `[0]` 子树（同样位于该递归树第 2 层）得到的结果一样。  `[0'']` 子树的特点是：

- 当前遍历到的值与前一个分支的值相等，即 `nums[i] == nums[i - 1]`；
- 接下来还要尝试选择 `0` ，即 `0` 还未被使用，即 `!used[i - 1]`。


代码写出来就是：

```java
if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) {
    continue;
}
```

`!used[i - 1]` 是初学的时候比较难理解的地方，大家须要结合语义进行理解：

- 由于当前分支选择的数字与上一个分支选择的数字相等；
- 由于上一个分支选择的数字还未被使用，接下来的遍历就会使用到这个数字，进而产生重复，所以应该跳过。

被跳过的分支如下图中被虚线框住的部分所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image6831033579373626783.png)


本题的参考代码如下：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> permuteUnique(int[] nums) {
        int n = nums.length;
        List<List<Integer>> res = new ArrayList<>();
        // 剪枝的前提是排序
        Arrays.sort(nums);
        boolean[] used = new boolean[n];
        Deque<Integer> path = new ArrayDeque<>();
        dfs(nums, 0, n, used, path, res);
        return res;
    }

    private void dfs(int[] nums, int index, int n, boolean[] used, Deque<Integer> path, List<List<Integer>> res) {
        if (index == n) {
            res.add(new ArrayList<>(path));
            return;
        }

        for (int i = 0; i < n; i++) {
            if (used[i]) {
                continue;
            }

            // nums[i - 1] 还继续选择，就会和前一个分支产生重复，因此应该剪去该分支
            if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) {
                continue;
            }

            used[i] = true;
            path.addLast(nums[i]);
            // System.out.println("递归之前：" + path);
            dfs(nums, index + 1, n, used, path, res);
            // 回溯部分的代码，和 dfs 之前的代码是对称的
            used[i] = false;
            path.removeLast();
            // System.out.println("递归之前：" + path);
        }
    }

}
```

**说明**：把注释的两个 `System.out.println`函数打开，并且对测试用例 `[0, 0, 1]`运行，得到的结果如下：

```plain
递归之前：[0]
递归之前：[0, 0]
递归之前：[0, 0, 1]
递归之后：[0, 0]
递归之后：[0]
递归之前：[0, 1]
递归之前：[0, 1, 0]
递归之后：[0, 1]
递归之后：[0]
递归之后：[]
递归之前：[1]
递归之前：[1, 0]
递归之前：[1, 0, 0]
递归之后：[1, 0]
递归之后：[1]
递归之后：[]
```

再对比剪枝以后的递归树，可以帮助我们理解剪枝的代码。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image7012194209620238534.png)
','16',NULL,'0047-permutations-ii','2025-06-10 03:59:26','2025-06-14 15:22:09',1,23,false,NULL,'https://leetcode.cn/problems/permutations-ii/description/',38,2,'',false,'https://leetcode.cn/problems/permutations-ii/solutions/9917/hui-su-suan-fa-python-dai-ma-java-dai-ma-by-liwe-2/',true,NULL,'排序是为了去重，注意剪枝条件：nums[i - 1] 未选择才会出现重复，此时应跳过。'),(188,'liweiwei1419','「力扣」第 41 题：缺失的第一个正数（困难）','## 题意分析

题目要求寻找数组中缺失的最小正整数，根据示「例 3」正整数是大于 0 的整数。例如：

- 输入数组是 `[1, 2, 0]`，1 出现、2 出现，3 没有出现，返回 3。
- 输入数组是 `[3, 4, -1, 1]`，1 出现、2 没有出现，返回 2。
- 输入数组是 `[7, 8, 9, 11, 12]`，1 没有出现，返回 1。

同时要求算法的时间复杂度应为 $O(n)$，并且只能使用常数级别的额外空间。

## 思路分析

本题如果不考虑时间、空间复杂度的限制，比较容易想到的做法是：哈希表和二分查找，下面分别简单叙述：

- **哈希表**：哈希表可以以 $O(1)$ 的时间复杂度判断某个数是否在其中。我们先将数组的所有元素放入哈希表，然后依次判断 `1..n` 是否在哈希表中。哈希表大小与数组长度相等，空间复杂度不符合题目要求；
- **二分查找**：先对数组排序，再使用二分查找，依次查找 `1..n` 是否在排序后的数组中，找不到则返回该正整数。排序的时间复杂度为 $O(n \log n)$，时间复杂度不符合题目要求。

下面我们介绍的思路，基于哈希表的思想，把输入数组本身当做哈希表使用，也叫「原地哈希」。

**由于要找的数在 `[1..n]`**，且只能使用常数级空间，可把原始数组当作哈希表。将 1 放到下标为 0 的位置，2 放到下标为 1 的位置，依次整理数组。最后遍历数组，第一个值不等于下标 + 1 的数就是缺失的第一个正数。这个方法我们可以简单总结为：把数值为 `i` 的数映射到下标为 `i - 1` 的位置。

## 示例演示

以示「例 2」为例，输入数组 `[3, 4, -1, 1]`：

- 下标 0 的元素 3 应在 2 号位置，交换下标 0 和 2 的元素，数组变为 `[-1, 4, 3, 1]`；
- 交换过来的 -1 不在 `[1..n]` ，进入下一轮循环；

**说明**：数值不在 `[1..n]` 区间里的数，根据我们的规则（数值 `i` 映射到下标 `i - 1`），数组里没有适合它放的位置，进入下一轮循环。由于后面的数还要根据我们的规则进行交换，所以之前不在 `[1..n]` 里的数还会被交换到其它位置。

- 下标 1 的元素 4 应在 3 号位置，交换下标 1 和 3 的元素，数组变为 `[-1, 1, 3, 4]`；
- 交换过来的 1 应在 0 号位置，交换下标 0 和 1 的元素，数组变为 `[1, -1, 3, 4]`；
- 交换过来的 -1 不在 `[1..n]` 区间，进入下一轮循环；
- 3 和 4 都在正确位置。
- 最后从数组的下标 0 位置开始遍历，找到缺失的第一个正数是 2。

**参考代码**：

```java
public class Solution {
    
    public int firstMissingPositive(int[] nums) {
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            // 数值位于 [1..N]，且不在正确位置上的时候移动，这个过程可能重复多次，因此使用 while
            while (nums[i] > 0 && nums[i] <= n && nums[nums[i] - 1] != nums[i]) {
                swap(nums, nums[i] - 1, i);
            }
        }
        for (int i = 0; i < n; i++) {
            if (nums[i] != i + 1) {
                return i + 1;
            }
        }
        // 都正确则返回数组长度 + 1
        return n + 1;
    }

    private void swap(int[] nums, int index1, int index2) {
        int temp = nums[index1];
        nums[index1] = nums[index2];
        nums[index2] = temp;
    }
    
}
```

**复杂度分析**：

* 时间复杂度：$O(n)$，虽然 `for` 循环里有 `while` 循环，但每个数平均只看一次；
* 空间复杂度：$O(1)$。

## 本题总结

- 本题要求寻找数组中缺失的最小正整数，要找的数位于 `[1..n]`。由于该范围对应数组下标，通过数值 -1 的方式，将 `[1..n]` 的数值与数组下标建立联系，从而将原数组当作哈希表来寻找缺失的最小正整数，实现符合时间复杂度为 $O(n)$ 且仅使用常数级别的额外空间的算法要求。这里通过原地交换实现映射，避免使用额外空间；
- 使用 `while` 循环确保每个数字最终到达正确位置；
- 遇到值不在 `[1..n]` 里的值，在数组上无处安放，就不要管它了，它等待后面的元素交换的时候挪动位置；
- 最后再遍历一次，遇到第一个遇到值不在 `[1..n]` 里的数，它的下标 + 1，就是缺失的第一个正数。','15',NULL,'0041-first-missing-positive','2025-06-11 18:57:32','2025-06-13 04:08:15',1,12,false,NULL,'https://leetcode.cn/problems/first-missing-positive/description/',37,4,'',false,NULL,true,NULL,'如果要查找的是正整数，考虑把数组当做哈希表，把 nums[i] 映射到下标 nums[i] - 1'),(20,'liweiwei1419','第 1 部分 算法基础','这一部分我们为初学者打下坚实的算法基础，重点培养正确的算法思维模式。我们从最基础的排序算法入手，逐步深入到算法设计的核心思想：

- 排序算法入门（第 1 章）：通过选择排序、冒泡排序等经典算法，理解算法如何解决问题；
- 编程思维培养（第 2-4 章）：从循环不变量到递归思想，建立清晰的编程逻辑；
- 经典算法剖析（第 5-7 章）：深入理解归并排序、双指针等核心算法。',NULL,NULL,'algorithms','2025-06-09 04:14:34','2025-07-26 13:18:08',0,20,false,NULL,NULL,0,1,'',false,NULL,false,NULL,NULL),(124,'liweiwei1419','「力扣」第 146 题：LRU 缓存（中等）','## 理解题意

首先，我们需要明确 LRU 缓存的要求：

+ **容量限制**：缓存有固定容量，当超过容量时，需要淘汰最久未使用的数据；
+ **快速访问**：需要 $ O(1) $ 时间复杂度完成 get 和 put 操作；
+ **使用顺序维护**：每次访问 （key 存在）或插入（key 不存在）都需要将该 key 标记为最近使用。

## 思路分析
需要快速判断 key 是否存在，如果 key 存在，拿到 value 的值，这是哈希表的典型应用（虽然本书到此还没有介绍哈希表，可以在阅读完哈希表章节以后再来做本题）。

哈希表不维护时间顺序，因此访问 key 的时间顺序就要交给其它数据结构。时间顺序是线性结构，可以使用数组和链表。题目还有「删除最久未使用的 key」和「访问 key 后变更访问时间为最近」的需求：数组不能满足在 $ O(1) $时间「访问 key 后变更访问时间为最近」，因为可能会涉及到很多元素的移动，因此只能使用链表结构。单向链表不能满足「访问 key 后变更访问时间为最近」，因为 **要想移动一个链表结点，需要知道它前驱结点的引用**，这是因为单向链表只有后继结点的引用，因此最合适的数据结构是双向链表。

根据以上分析，我们的设计思路如下：

+ **哈希表**：存储 key 到双向链表结点的映射，实现快速查找，value 存在双向链表的结点中；
+ **双向链表**：维护链表结点的访问时间顺序，最近 put 和 get 的数据放在链表的头部，最久未访问的在尾部（其实在头部存放最久未访问的结点，在尾部存放最近访问的结点也可以。只不过对于链表结构，在头部插入符合直觉），并使用虚拟头尾结点（dummy head 和 dummy tail）简化边界条件处理，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image16747425258069247946.png)


题目还有容量 `capacity` 的限制，我们可以在双向链表中维护结点总数 `size`，当 `size > capacity` 时，删除双向链表的末尾结点，并在哈希表中删除「key-双向链表结点」键值对即可。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class LRUCache {

    public LRUCache(int capacity) {
        this.size = 0;
        this.capacity = capacity;
        dummyHead = new DoubleLinkedNode();
        dummyTail = new DoubleLinkedNode();
        // 双向链表：初始化为 dummyHead <-> dummyTail
        dummyHead.next = dummyTail;
        dummyTail.prev = dummyHead;
    }

    public int get(int key) {
        DoubleLinkedNode node = cache.get(key);
        if (node == null) {
            return -1;
        }
        // 将访问的结点移动到头部
        moveToHead(node);
        return node.value;
    }

    public void put(int key, int value) {
        DoubleLinkedNode node = cache.get(key);
        if (node == null) {
            // 创建新结点
            DoubleLinkedNode newNode = new DoubleLinkedNode();
            newNode.key = key;
            newNode.value = value;
            // 添加到哈希表和链表头部
            cache.put(key, newNode);
            addNode(newNode);
            size++;
            // 如果超过容量，移除尾部结点
            if (size > capacity) {
                DoubleLinkedNode tail = popTail();
                cache.remove(tail.key);
                size--;
            }
        } else {
            // 更新值并移动到头部
            node.value = value;
            moveToHead(node);
        }
    }

    // 以下为成员变量和函数

    class DoubleLinkedNode {
        int key;
        int value;
        DoubleLinkedNode prev;
        DoubleLinkedNode next;
    }

    private void addNode(DoubleLinkedNode node) {
        // 总是将新结点添加到头部
        node.prev = dummyHead;
        node.next = dummyHead.next;

        dummyHead.next.prev = node;
        dummyHead.next = node;
    }

    private void removeNode(DoubleLinkedNode node) {
        // 从链表中移除现有结点
        // 找到前后结点
        DoubleLinkedNode prev = node.prev;
        DoubleLinkedNode next = node.next;
        // 建立它们的关系
        prev.next = next;
        next.prev = prev;
    }

    private void moveToHead(DoubleLinkedNode node) {
        // 先移除结点
        removeNode(node);
        // 再添加到头部
        addNode(node);
    }

    private DoubleLinkedNode popTail() {
        // 弹出尾部结点（最久未使用）
        DoubleLinkedNode res = dummyTail.prev;
        removeNode(res);
        return res;
    }

    // 用于快速判断 key 是否存在，如果存在得到链表中对应的结点
    private Map<Integer, DoubleLinkedNode> cache = new HashMap<>();
    private int size;
    private int capacity;
    // 双向链表的虚拟头结点和尾结点
    private DoubleLinkedNode dummyHead;
    private DoubleLinkedNode dummyTail;

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1)  $；
+ 空间复杂度：$ O(\text{capacity}) $，使用哈希表和双向链表存储所有元素。

## 本题总结

本题的难点在于如何将哈希表的快速查找和双向链表的顺序维护结合起来，我们以问答形式展示本题的关键实现要点。

+ 为什么需要双向链表？因为移动链表结点到开头需要移动结点的前驱引用，单向链表不维护前驱引用；
+ 为什么需要哈希表？因为需要快速判断 key 是否存在，快速访问 key 对应的双向链表结点，进而方便将链表结点移动到链表的开头、访问 value 等操作；
+ 哈希表与双向链表配合如何发挥作用？
    - 查找先在哈希表中找 key，如果存在，得到对应的双向链表结点，结点中存 key 对应的 value 值；
    - 双向链表维护了结点的访问时间顺序，把刚刚访问过的结点移动到链表的开头。在容量 capacity 的限制下需要删除结点，同时还需要删除哈希表中对应的 key，表示：key 是最久未访问的元素，从缓存中删除。

两者配合可以满足 LRU 缓存的所有要求，关键在于理解这两种数据结构的优势并巧妙结合。

','9',NULL,'0146-lru-cache','2025-06-11 09:15:01','2025-06-14 13:44:17',1,7,false,NULL,'https://leetcode.cn/problems/lru-cache/description/',32,7,'',false,'https://leetcode.cn/problems/lru-cache/solutions/187981/ha-xi-biao-shuang-xiang-lian-biao-java-by-liweiw-2/',true,'完成！','要求 O(1) ，所以用哈希表，要把链表的某个结点移到开头，用双链表（单链表不能得到前驱结点）。'),(120,'liweiwei1419','「力扣」第 92 题：反转链表 II（中等）','## 思路分析

这道题要求我们反转链表中从位置 `left` 到 `right` 的部分，可以通过以下步骤实现：

+ 找到需要反转部分的前一个结点（即第 `m - 1` 个结点）；
+ 反转从 `m` 到 `n` 的部分（与「力扣」第 206 题相同）；
+ 将反转后的子链表重新连接到原链表。

这种做法的问题是：在「反转从 `m` 到 `n` 的部分」这一步需要先遍历再反转，如果待反转部分占链表很大的比例，相当于使用接近 2 次遍历完成链表指定部分的反转。

其实还可以通过一次遍历实现，放在脑子里想稍微困难一点，画在纸上就相对容易一些。具体做法是：**把需要反转的部分，一个结点接着一个结点「插入」到需要反转部分的开头，每次操作都会将当前结点的下一个结点移动到原始区间 `[left..right]` 的最前面**。

## 示例演示
以「示例 1」为例，需要反转的部分是 `[2..4]` ，我们先把结点 3 「插入」结点 2 之前。具体做法是：把结点 2 的下一个结点指向结点 4，如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747658742474-a039fcd5-a01c-4f15-82c7-653d84cad4b7.png)


再把结点 3 的下一个结点指向结点 2，如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747658808644-0b0cac5b-713c-41ef-8957-f5b812bd0473.png)


最后把结点 1 的下一个结点指向结点 3，如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747658829703-afadea79-10dd-4b73-8468-fbc0eca4a420.png)


链表「拉平」以后如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747658881301-e0f91df1-2edf-4521-8955-e1f86d6e45da.png)


此时达到的效果是：结点 3 来到了结点 2 的前面，并且还可以继续站在结点 2 执行一次同样的「三连」操作，如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747659361049-96448c99-7286-4e3d-8055-84b79d86fbbe.png)

「拉平」以后如下图所示：

![img](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1747659384535-869bebfb-2615-43db-962e-b511e5f3615a.png)


于是我们完成了链表的区间反转，在此期间我们需要两个变量：

+ `prev` 始终指向待反转区间的 **前一个结点**（如上图结点 1）；
+ `cur` 始终指向待反转区间的第 1 个结点（如图结点 2），它的 `next` 不断更新为需要移动到头部的结点；
+ 每次操作就是依次把区间 `[left + 1..right]` 依次移动到 `left` 的前面，因此「三连」的轮数是 `right - (left + 1) + 1 = right - left`。

**注意**：

+ 操作顺序并不复杂，如果一时想不清楚，最好动笔画一画，这样更直观；
+ 由于反转有可能涉及原链表的第 1 个结点，为了避免复杂的分类讨论，需要使用虚拟头结点；

**参考代码**：

```java
public class Solution {

    public ListNode reverseBetween(ListNode head, int left, int right) {
        ListNode dummyNode = new ListNode(-1);
        dummyNode.next = head;
        ListNode preNode = dummyNode;
        for (int i = 0; i < left - 1; i++) {
            preNode = preNode.next;
        }

        ListNode currNode = preNode.next;
        ListNode nextNode;
        // 需要执行 right - left 轮
        for (int i = 0; i < right - left; i++) {
            // 先把 nextNode 记录下来，后面要用到
            nextNode = currNode.next;
            // 第 1 步：currNode 跳过一个结点产生连接
            currNode.next = nextNode.next;
            // 第 2 步：nextNode 结点的下一个结点指向待反转区间的头部
            nextNode.next = preNode.next;
            // 第 3 步：反转区间的前驱结点指向 nextNode
            preNode.next = nextNode;
            // 以上 3 步执行以后，nextNode 来到了待反转区间的头部，并且 currNode 自动后移
        }
        return dummyNode.next;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是链表的长度；
+ 空间复杂度：$ O(1) $，只使用到常数个变量。

# 总结
这一节我们通过两个问题，介绍了如何通过修改链表的指针指向，进而修改链表结构的具体操作，只要大家细心，就会发现链表中的问题其实不难。重点考查的思路和细心程度。







','9',NULL,'0092-reverse-linked-list-ii','2025-06-11 09:15:01','2025-06-14 12:49:57',1,3,false,NULL,'https://leetcode.cn/problems/reverse-linked-list-ii/description/',32,3,'',false,'https://leetcode.cn/problems/reverse-linked-list-ii/solutions/48221/4-ge-zhi-zhen-3-ge-zhi-zhen-by-liweiwei1419/',true,'完成！','在纸上画图，注意修改指针指向的先后顺序。'),(111,'liweiwei1419','「力扣」第 34 题：在排序数组中查找元素的第一个和最后一个位置（中等）','# 例题 2：「力扣」第 34 题：在排序数组中查找元素的第一个和最后一个位置（中等）
+ 题目地址：[https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/)


## 1. 思路分析
题目要求必须设计并实现时间复杂度为 $ O(\log n) $ 的算法解决此问题，因此不可以线性查找，也不可以找到了第一个位置以后，再线性查找，找到最后一个位置。**只要使用线性查找，时间复杂度都是** $ O(n) $，所以标准的做法是：两次二分查找，并且第二次二分查找的范围不用从数组下标 0 位置开始，从 `target` 出现的第一个位置开始就好了。

我们先写出代码框架，然后再补充细节。

```java
public class Solution {

    public int[] searchRange(int[] nums, int target) {
        int n = nums.length;
        // 题目的「提示 1」有说数组的长度有可能为 0，因此需要单独判断
        if (n == 0) {
            return new int[]{-1, -1};
        }
        int firstPosition = searchFirstPosition(nums, target);
        if (firstPosition == -1) {
            return new int[]{-1, -1};
        }
        // 代码能走到这里，数组中一定存在目标元素，且从 firstPosition 开始查找 lastPosition 即可
        int lastPosition = searchLastPosition(nums, firstPosition, target);
        return new int[]{firstPosition, lastPosition};
    }

    private int searchFirstPosition(int[] nums, int target) {
        // 等待实现
    }

    private int searchLastPosition(int[] nums, int firstPosition, int target) {
        // 等待实现
    }

}
```

下面我们依次实现 `searchFirstPosition` 和 `searchLastPosition` 方法。

## 2. 查找 target 的第一个位置
二分查找在搜索区间 `[left..right]` 里根据中间位置的值 `nums[mid]` 与 `target` 的大小关系，分为如下 3 种情况：

+ **情况 1**：当 `nums[mid] == target` 时，`mid + 1` 以及它以后的位置都不是 `target` 第一次出现的位置，如下图所示：

![image.png](https://pic.leetcode.cn/1749618761-rINtzy-image.png)


下一轮的搜索区间是 `[left..mid]`，下一轮设置 `right = mid`；

+ **情况 2**：当 `nums[mid] < target` 时，`mid` 以及 `mid` 左边的位置都不是 `target` 第一次出现的位置，下一轮的搜索区间是 `[mid + 1..right]`，下一轮设置 `left = mid + 1`；
+ **情况 3**：当 `nums[mid] > target` 时，`mid` 以及 `mid` 右边的位置都不是 `target` 第一次出现的位置，下一轮的搜索区间是 `[left..mid - 1]`，下一轮设置 `right = mid - 1`。

有了之前的经验，我们知道：当循环体内有 `right = mid` 这样的代码出现时，循环可以继续的条件就应该写成 `left < right`。现在我们可以写出 `searchFirstPosition` 方法的代码：

```java
private int searchFirstPosition(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;
    // 在 nums[left..right] 里查找 target 第 1 次出现的位置
    while (left < right) {
        int mid = (left + right) / 2;
        if (nums[mid] < target) {
            // mid 以及 mid 的左边一定不是目标元素第 1 次出现的位置
            // 下一轮搜索的区间是 [mid + 1..right]
            left = mid + 1;
        } else {
            // 下一轮搜索的区间是 [left..mid]
            right = mid;
        }
    }
    // 退出循环以后 left 与 right 重合
    if (nums[left] == target) {
        return left;
    }
    return -1;
}
```

**这里我们把  `nums[mid] == target` 与 `nums[mid] > target` 的情况合并起来写，原因我们放在本题讲解的最后说**。

退出循环以后 `left` 与 `right` 重合，原因我们在「例题 1」中已经和大家分析过了：在区间里只有 2 个元素的时候，`mid = left`（在这里表示数值），执行 `left = mid + 1` 或者 `right = mid` 都能让 `left` 与 `right` 重合。

**由于我们不能确定 `left` 与 `right` 重合的位置的值是否等于 `target`，退出循环以后还需要再做一次判断**。

## 3. 查找 target 的最后一个位置

根据 `nums[mid]` 与 `target` 的大小关系，可以分为如下 3 种情况：

+ **情况 1**：当 `nums[mid] == target` 时，`mid - 1` 以及它左边的位置都不是 `target` 最后一次出现的位置，下一轮的搜索区间是 `[mid..right]`，下一轮设置 `left = mid`；
+ **情况 2**：当 `nums[mid] < target` 时，`mid` 以及 `mid` 左边的位置都不是 `target` 最后一次出现的位置，下一轮的搜索区间是 `[mid + 1..right]`，下一轮设置 `left = mid + 1`；
+ **情况 3**：当 `nums[mid] > target` 时，`mid` 以及 `mid` 右边的位置都不是 `target` 最后一次出现的位置，下一轮的搜索区间是 `[left..mid - 1]`，下一轮设置 `right = mid - 1`。

我们先把 `searchLastPosition` 的代码写出来，再和大家强调重点：

```java
private int searchLastPosition(int[] nums, int firstPosition, int target) {
    int left = firstPosition;
    int right = nums.length - 1;
    while (left < right) {
        // 注意：有 left = mid，需要将 mid 取值改成上取整
        int mid = (left + right + 1) / 2;
        if (nums[mid] > target) {
            right = mid - 1;
        } else {
            left = mid;
        }
    }
    // 退出循环以后 left 与 right 重合，由于代码能运行到这里，数组中一定存在目标元素，直接返回 left 或者 right
    return left;
}
```

**重点 1：有 `left = mid` 这样的代码，循环可以继续的条件就应该写成 `left < right`，这一点我们已经强调多次**；

**重点 2：看到 `left = mid` 与 `right = mid - 1` 这种搭配，`mid` 的取法要改成上取整**，即 `int mid = (left + right + 1) / 2` 。 初学的时候可能会觉得很奇怪，我们一点一点和大家解释：

- `mid = (left + right + 1) / 2` 和 `mid = (left + right) / 2` 的地位是一样的，当区间里有偶数个元素的时候，位于中间位置的元素有两个，所以不能说一定就得用 `mid = (left + right) / 2` 才是对的；
- 只有循环执行到最后，才有必要刻意区分这两个中间位置，这是因为 **当区间里只有两个元素的时候**：

- 如果取 `mid = (left + right) / 2`，此时 `left = mid`（此处表示数值上相等），如果代码执行 `if-else` 的时候还是执行到 `left = mid`（此处是执行的代码），区间不能缩小，进入死循环；
- 如果取 `mid = (left + right + 1) / 2`，此时 `left = mid - 1`，`right = mid`（此处表示数值上相等），不论是执行 `left = mid` 还是 `right = mid - 1` 都能使得 `left` 与 `right` 重合。如下图所示：

![image.png](https://pic.leetcode.cn/1749618880-VELJvC-image.png)


分析到这里，大家应该发现了：

- **`left = mid + 1、right = mid` 对应 `mid = (left + right) / 2`**；
- **`left = mid、right = mid - 1` 对应 `mid = (left + right + 1) / 2`**。


**重点 3**：在 `searchLastPosition` 代码中，我们还是没有单独把 `nums[mid] == target` 单独写成一个分支，而是合并到其它分支去，最后我们来解释这件事情。

## 4. 细节：只写 if 和 else 两个分支

对于本题而言，单独写出一个 `if` 语句，把 `nums[mid] == target` 的情况写出来，代码也能通过「力扣」的系统测评，大家也可以自己尝试提交给「力扣」验证，这说明「力扣」的测试用例暂时没有覆盖完全。

我们自己编写一个测试用例，以 `searchFirstPosition` 为例：

```java
public class Solution {

    // 查找有序数组第一个等于 target 的元素，即 searchFirstPosition

    public static void main(String[] args) {
        int[] nums = new int[]{1, 2, 7, 10};
        int target = 5;
        int left = 0;
        int right = nums.length - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            System.out.println("left = " + left + ", right = " + right);
            if (nums[mid] == target) {
                // 两种情况合并，使得退出以后 left 与 right 重合
                right = mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        System.out.println("left = " + left);
        System.out.println("right = " + right);
    }

}
```

运行结果：

```plain
left = 0, right = 3
left = 2, right = 3
left = 2
right = 1
```

大家看到，**退出循环以后 `left` 与 `right` 的值并不相等。**。原因其实不难分析出：当 `if-else` 里有 `left = mid + 1` 和 `right = mid - 1` 时，且区间里只有两个元素的时候，此时 `mid = (left + right) / 2 = left`，如果执行 `right = mid - 1` （上面给出的例子就是这样），`right` 就来到了 `left` 的左边，`left` 与 `right` 不重合，如下图所示：

![](https://cdn.nlark.com/yuque/0/2025/png/1354172/1737225173284-a4a93483-71a1-494f-9783-37a47f25e99e.png)

如果我们一定要在 `while` 里面把 3 种情况都写出来，最后还要考虑 `right` 来到了 `left` 的左边的这种情况。更好的做法是：**在 `while` 里面就写两个分支，退出循环以后 `left` 与 `right` 重合（即 `left` 和 `right` 只相遇，但不会交叉越界），简化了代码逻辑**。

`left = mid + 1、right = mid` 对应 `mid = (left + right) / 2` 和 `left = mid、right = mid - 1` 对应 `mid = (left + right + 1) / 2` **它们都保证了退出循环以后 `left` 与 `right` 重合，写成两个分支**，需要讨论的情况更简单一些。对于本题而言，代码执行到 `searchLastPosition` 函数的时候，说明数组中一定存在 `target`，所以循环以后 `left` 与 `right` 重合的位置就是 `target` 最后一次出现的位置，不需要像 `searchFirstPosition` 再做一次判断。

以上我们就把本题的代码全写完了，为了节省篇幅，就不把它们再展示一遍。

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $。进行了两次二分查找，每次二分查找的时间复杂度都是 $ O(\log n) $，所以总的时间复杂度仍然是 $ O(\log n) $；
+ 空间复杂度：$ O(1) $。

## 5. 本题总结
+ 循环体内如果出现 `left = mid` 或者 `right = mid`，循环可以继续的条件应该写成 `left < right`；
+ 循环体内如果出现 `right = mid`、`right = mid - 1` 和 `left = mid + 1` ，需要合并 `right = mid`、`right = mid - 1`，否则 `right` 会来到搜索范围之外，还需要单独讨论；
+ 循环体内如果出现 `left = mid`、`left = mid + 1` 和 `right = mid - 1` ，需要：
    - 将 `mid` 的取值改成 `mid = (left + right + 1) / 2`，避免死循环；
    - 合并 `left = mid`、`left = mid + 1` ，不出现 `left = mid + 1` ，退出以后 `left` 与 `right` 重合，避免分类讨论。

以上这些「规则」其实都不需要记忆，写代码就像学骑车，刚开始可能需要记住各种规则，但熟练之后，这些细节都会变成直觉反应。最好的学习方法就是动手写。当我们反复遇到这些情况时，处理方式自然就会印在脑海里。

# 总结
我们通过本节的两道例题，其实向大家介绍了一种常见的二分查找模板代码：

```java
// left、right 初始化的值看题目而定
while (left < right) {
    int mid = (left + right) / 2;
    if ( __ ) {
        left = mid + 1;
    } else {
        right = mid;
    }
}
return left; // return right; 也可以
```

和

```java
// left、right 初始化的值看题目而定
while (left < right) {
    // if else 决定了 mid 这样写，否则会出现死循环
    // if else 怎么写，是问题本身决定的
    int mid = (left + right + 1) / 2;
    if ( __ ) {
        left = mid;
    } else {
        right = mid - 1;
    }
}
return left; // return right; 也可以
```

虽然写出来是两个代码片段，但其实它们的思想就一个：**在循环体中把不是答案的情况全都排除，最后剩下的那个数就是问题的答案**。

**有一些资料上说这是「左闭右开」的写法，是错误的解读。「左闭右开」只是区间表示法的一种约定，二分查找算法的重点在于如何设计判别条件，缩小搜索区间，不会因为把区间的右端点表示成开区间就得到解决，把搜索区间表示「左闭右开」其实是画蛇添足**。

**还有资料把这两个代码模板解释成「寻找第一个满足条件的值」和「寻找最后一个满足条件的值」，这是一种过度简化，其实这两个代码是二分查找的万能思维：通过条件排除不可能的解空间，可以解决使用二分查找的所有问题**。

为什么用这个模板，**其实还是由问题本身决定的**。我们回顾一下本节的两个例题，都有 `left = mid` 或者 `right = mid` 这样的情况，也就是 **看到 `mid` 时不能排除**。

因此，**写对二分查找的关键还是认真审题，题目本身决定了代码应该怎么写**。即：

+ **问题本身** 决定了 `if else` 里面是 `left = mid + 1、right = mid` 还是 `left = mid、right = mid - 1`；
+ 进而决定了 `mid` 的取值是 `mid = (left + right) / 2` 还是 `mid = (left + right + 1) / 2`，同时决定了 `while` 里面是 `left <= right` 还是 `left < right`。

**但本书还是不提倡大家陷入模板匹配的学习误区。至于大家经常问到的二分查找应该怎么写，有没有必要用一种代码写出所有的二分查找，本书的意见是这样的**：

+ **如果问题的答案有可能一下子找到，即在循环体中就能找到，那么就写成 `while (left <= right)` 这种形式，循环体内有 3 个分支**；
+ **如果问题的答案只有在退出循环以后才能确定，即目标元素的特性不能用一个 `if` 语句表示出来，就写成 `while (left < right)` 这种形式，循环体内有 2 个分支**。

**我们不想把大家限制在一种框架里，规定好每一步应该写什么。而应该具体问题具体分析**。

我们在本章的第 4 节会介绍《二分查找模板代码选讲》，到时大家就会看到，其实怎么写都能通过系统测评，无非是「拆东墙补西墙」，一个问题得到解决，不会因为我们套用了哪个代码模板而得到简化，而是因为我们真正地清楚题目给出的条件，进而设计出准确的 `if-else` 语句，把搜索区间准确地缩小，直至问题得到解决。
','8',NULL,'0034-find-first-and-last-position-of-element-in-sorted-array','2025-06-11 09:10:31','2025-06-13 03:16:31',1,11,false,NULL,'https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/',30,4,'',false,'https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/solutions/11627/si-lu-hen-jian-dan-xi-jie-fei-mo-gui-de-er-fen-cha/',true,NULL,'必须退出循环以后才能确定答案。'),(118,'liweiwei1419','「力扣」第 707 题：设计链表（中等）','## 思路分析

本题可以使用单链表实现，也可以使用双向链表实现。我们把实现要点作为注释写在代码中。以下是 3 点注意事项：

+ 虚拟头、尾结点技巧：使用虚拟头、尾结点可以统一处理在头部插入或者删除结点的特殊情况，避免了对头结点的特殊判断，简化代码逻辑；
+ 维护 `size` 变量：可以快速获取链表长度，用于边界条件检查和插入位置判断；
+ 边界条件处理：
    - 在 `get()`、`deleteAtIndex()` 方法中检查 `index` 是否越界；
    - 在 `addAtIndex()` 方法中处理 `index` 为负数或超过链表长度的情况。

**参考代码 1**：单链表实现。

```java
public class MyLinkedList {

    class ListNode {
        int val;
        ListNode next;

        ListNode(int x) {
            val = x;
        }
    }

    // 设置「虚拟头结点」避免链表中没有结点时复杂的分类讨论
    private ListNode dummyHead;

    // 设计「尾指针」是为了方便在尾部操作
    private ListNode tail;

    // 为了保证用户输入的 index 合法，故维护链表的长度
    private int size;

    public MyLinkedList() {
        size = 0;
        dummyHead = new ListNode(-1);
        tail = new ListNode(-1);
        // 注意，尾指针的 next 结点必须赋值，否则会抛出空指针异常
        tail.next = dummyHead;
    }

    public int get(int index) {
        if (index < 0 || index >= size) {
            return -1;
        }
        if (index == size - 1) {
            return tail.next.val;
        }

        ListNode curNode = dummyHead;
        for (int i = 0; i < index + 1; i++) {
            curNode = curNode.next;
        }
        return curNode.val;
    }

    public void addAtHead(int val) {
        ListNode newNode = new ListNode(val);
        newNode.next = dummyHead.next;
        dummyHead.next = newNode;
        // 注意维护尾指针
        if (size == 0) {
            tail.next = newNode;
        }
        size++;
    }

    public void addAtTail(int val) {
        ListNode oldTailNode = tail.next;
        ListNode newTailNode = new ListNode(val);
        oldTailNode.next = newTailNode;
        tail.next = newTailNode;
        size++;
    }

    public void addAtIndex(int index, int val) {
        if (index < 0 || index > size) {
            return;
        }
        if (index == 0) {
            addAtHead(val);
            return;
        }
        if (index == size) {
            addAtTail(val);
            return;
        }

        ListNode preNode = dummyHead;
        for (int i = 0; i < index; i++) {
            preNode = preNode.next;
        }

        ListNode newNode = new ListNode(val);
        ListNode nextNode = preNode.next;
        newNode.next = nextNode;
        preNode.next = newNode;
        size++;
    }

    public void deleteAtIndex(int index) {
        if (index < 0 || index >= size) {
            return;
        }
        ListNode preNode = dummyHead;
        for (int i = 0; i < index; i++) {
            preNode = preNode.next;
        }

        ListNode deleteNode = preNode.next;
        preNode.next = deleteNode.next;
        deleteNode.next = null;
        // 注意维护 tail 指针
        if (index == size - 1) {
            tail.next = preNode;
        }
        size--;
    }

}
```

**参考代码 2**：双向链表实现，需要设置虚拟头结点和尾结点。

```java
public class MyLinkedList {

    class ListNode {
        int val;
        ListNode pre;
        ListNode next;
        ListNode(int x) {
            val = x;
        }
    }

    private ListNode dummyHead;
    private ListNode dummyTail;
    // 设置 size 变量的作用，是为了判断 addAtIndex 方法的参数是否合法
    private int size;

    public MyLinkedList() {
        size = 0;
        dummyHead = new ListNode(-1);
        dummyTail = new ListNode(-1);
        dummyHead.next = dummyTail;
        dummyTail.pre = dummyHead;
    }

    public int get(int index) {
        if (index < 0 || index >= size) {
            return -1;
        }
        ListNode curNode = dummyHead;
        for (int i = 0; i < index + 1; i++) {
            curNode = curNode.next;
        }
        return curNode.val;
    }

    public void addAtHead(int val) {
        ListNode newNode = new ListNode(val);
        ListNode nextNode = dummyHead.next;
        // 顺序：dummyHead -> newNode -> nextNode
        dummyHead.next = newNode;
        // 维护 newNode 的两个指针
        newNode.pre = dummyHead;
        newNode.next = nextNode;
        nextNode.pre = newNode;
        size++;
    }

    public void addAtTail(int val) {
        ListNode newNode = new ListNode(val);
        // 顺序 preNode -> newNode -> dummyTail
        ListNode preNode = dummyTail.pre;
        preNode.next = newNode;
        newNode.pre = preNode;
        newNode.next = dummyTail;
        dummyTail.pre = newNode;
        size++;
    }

    public void addAtIndex(int index, int val) {
        if (index < 0 || index > size) {
            return;
        }
        if (index == 0) {
            addAtHead(val);
            return;
        }
        if (index == size) {
            // 注意 size 表示的是：下一个待添加到末尾元素的位置
            addAtTail(val);
            return;
        }

        ListNode preNode = dummyHead;
        for (int i = 0; i < index; i++) {
            preNode = preNode.next;
        }

        ListNode newNode = new ListNode(val);
        // 先保存下一个结点的引用
        // 顺序：pre -> newNode -> nextNode
        ListNode nextNode = preNode.next;

        nextNode.pre = newNode;
        preNode.next = newNode;

        newNode.pre = preNode;
        newNode.next = nextNode;
        size++;
    }

    public void deleteAtIndex(int index) {
        // 如果是单链表，这个操作比较复杂，时间复杂度是 O(N)
        if (index < 0 || index >= size) {
            // throw new IllegalArgumentException("您输入的 index 不合法");
            return;
        }

        ListNode preNode = dummyHead;
        for (int i = 0; i < index; i++) {
            preNode = preNode.next;
        }

        // 顺序：preNode deleteNode nextNode
        ListNode deleteNode = preNode.next;
        ListNode nextNode = deleteNode.next;

        preNode.next = nextNode;
        nextNode.pre = preNode;

        deleteNode.pre = null;
        deleteNode.next = null;
        size--;
    }

}
```

**复杂度分析**：

+ 时间复杂度：
    - `get()`: $ O(n) $；
    - `addAtHead()`: $ O(1) $；
    - `addAtTail()`: $ O(1) $；
    - `addAtIndex()`: $ O(n) $；
    - `deleteAtIndex()`: $ O(n) $；
+ 空间复杂度：$ O(1) $。

# 总结
链表是一种 **动态** 的线性数据结构，由离散存储的结点组成，每个结点包含数据和指向相邻结点的指针（双向链表则包含前后两个指针）。 链表的特点是：

+ **访问慢**：必须从头结点逐个遍历，时间复杂度为 $ O(n) $；
+ **增删快**：插入/删除只需修改相邻结点的指针，时间复杂度为 $ O(1) $（前提是已定位到操作位置）；
+ **头尾操作高效**：在链表头部（或双向链表的尾部）增删结点无需遍历，「时间复杂度」为 $ O(1) $。

**对比数组**：

+ 数组适合频繁访问，链表适合频繁增删；
+ 链表无需连续内存，可动态扩展。','9',NULL,'0707-design-linked-list','2025-06-11 09:15:01','2025-06-14 13:51:24',2,28,false,NULL,'https://leetcode.cn/problems/design-linked-list/description/',32,1,'',false,NULL,true,'争取下午 2 点前搞定','单链表与双链表均可。'),(53,'liweiwei1419','222','22222222','2',NULL,NULL,'2025-06-10 04:44:59','2025-06-10 04:45:00',0,9,false,NULL,'',NULL,0,'',false,NULL,false,NULL,NULL),(191,'liweiwei1419','「力扣」第 49 题：字母异位词分组（中等）','## 思路分析
分在同一组的单词要求 **字符种类、对应个数相同，但顺序可以不同**，因此我们需要找到一种与字符顺序无关的表示方法。

+ 方法一：对字符串排序，排序以后，字母异位词排序以后的字符串肯定相同，它们分在一组；
+ 方法二：对每个字符串进行字符计数，如 `a:2,b:1`，并将其序列化成字符串作为键，如 `a2b1`。

以上两种方法效率都不高。那么可不可以用一种简单的方式，例如一个数值来表示字母异位词呢？即设计一个哈希函数，字母异位词经过这个哈希函数映射到同一个整数。

在设计哈希函数的时候，经常用到质数，质数有个性质：每个大于 1 的整数都能唯一地分解为质数的乘积（不考虑顺序），也叫「算术基本定理」。**利用质数的乘积唯一性，将字母异位词映射到同一个整数，从而避免排序或计数的开销**。

于是我们可以把每个字母分配一个质数，例如 `a = 2, b = 3, c = 5...` 依次对应起来，对于每个单词，计算字母对应质数的乘积，作为「哈希表」的键，这样字符种类相同且每个字符出现次数相同的单词就都映射到同一个键了。

接下来还要解决的问题是：乘积有可能很大，计算乘积有可能溢出。解决办法是：因此每一次乘法，都模一个较大的质数 `1e9 + 7`。

可能大家还有疑惑？为什么模这个较大质数以后，不是字母异位词的哈希值仍是不同的？这是因为  `1e9 + 7` 这个数值很大（10 亿），「力扣」的测试用例 `1 <= strs.length <= 10^4`，不是字母异位词乘积取大质数模得到的哈希值仍然相同的概率很低很低。类似于在快速排序中，随机化切分元素以后，每一次选择切分元素恰好都是当前区间的最小值的概率极低，但理论上仍存在这种最坏情况。

**参考代码**：

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {

    // 为 26 个小写字母分配唯一的质数
    private static final int[] PRIMES = new int[]{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101};
    // 防止整数溢出的模数
    private static final long MOD = (long) 1e9 + 7;

    public List<List<String>> groupAnagrams(String[] strs) {
        Map<Long, List<String>> map = new HashMap<>();
        for (String str : strs) {
            long hash = 1;
            for (char c : str.toCharArray()) {
                hash = (hash * PRIMES[c - ''a'']) % MOD;
            }
            map.computeIfAbsent(hash, k -> new ArrayList<>()).add(str);
        }
        return new ArrayList<>(map.values());
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(nk) $，其中 `n` 是字符串数组长度，`k` 是字符串最大长度；
+ 空间复杂度：$ O(nk) $，用于存储哈希表和结果。

## 本题总结
本解法使用哈希表来分组字母异位词，核心在于设计一个能够唯一标识每组异位词的哈希函数。虽然该哈希函数在理论上还是有可能造成哈希冲突，由于 `1e9 + 7` 是一个很大的质数，哈希冲突的概率极低，因此可以通过系统测评。','15',NULL,'0049-group-anagrams','2025-06-11 18:57:32','2025-06-13 04:59:22',1,16,false,NULL,'https://leetcode.cn/problems/group-anagrams/description/',37,7,'',false,'https://leetcode.cn/problems/group-anagrams/solutions/190072/zi-ding-yi-zi-fu-chuan-de-ha-xi-gui-ze-shi-yong-zh/',true,NULL,'本题故意构造哈希冲突。'),(154,'liweiwei1419','「力扣」第 211 题：添加与搜索单词 - 数据结构设计（中等）','',NULL,NULL,'0211-design-add-and-search-words-data-structure','2025-06-11 09:38:13','2025-06-11 09:38:13',0,0,false,NULL,'https://leetcode.cn/problems/design-add-and-search-words-data-structure/description/',43,5,'',false,NULL,false,NULL,NULL),(173,'liweiwei1419','「力扣」第 743 题：网络延迟时间（中等）','',NULL,NULL,'0743-network-delay-time','2025-06-11 09:48:59','2025-06-11 09:48:59',0,0,false,NULL,'https://leetcode.cn/problems/network-delay-time/description/',46,1,'',false,NULL,false,NULL,NULL),(174,'liweiwei1419','「力扣」第 1334 题：阈值距离内邻居最少的城市（中等）','',NULL,NULL,'1334-find-the-city-with-the-smallest-number-of-neighbors-at-a-threshold-distance','2025-06-11 09:48:59','2025-06-11 09:48:59',0,0,false,NULL,'https://leetcode.cn/problems/find-the-city-with-the-smallest-number-of-neighbors-at-a-threshold-distance/description/',46,2,'',false,NULL,false,NULL,NULL),(175,'liweiwei1419','「力扣」第 1584 题：连接所有点的最小费用（中等）','',NULL,NULL,'1584-min-cost-to-connect-all-points','2025-06-11 09:48:59','2025-06-11 09:48:59',0,0,false,NULL,'https://leetcode.cn/problems/min-cost-to-connect-all-points/description/',47,1,'',false,NULL,false,NULL,NULL),(55,'liweiwei1419','「力扣」第 53 题：最大子数组和（中等）','## 思路分析
本题只需要求 **最大和** 这个结果值，而无需知道具体是哪个子数组取得的这个最大值，这种 **仅需求解最优解数值** 的特性，正是动态规划的典型适用场景 —— 我们可以通过状态转移高效计算最大值，而无需维护具体的子数组信息。

数组中的动态规划问题，遇到子数组、子序列的常见状态定义是：以 `nums[i]` 结尾。这是因为：

+ 如果不固定结尾，数组、子序列的可能性会爆炸（比如 `[1, 2, 3]` 的子序列有 `[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]`，难以直接递推）。
+ 固定 `nums[i]` 结尾后，状态转移只需关注如何从 `nums[0..i - 1]` 转移到 `nums[i]`，递推、状态转移更容易。

既然一个子数组一定会以某一个数结尾，那么我们就把以 `nums[i]` 结尾的连续子数组的最大和作为 `dp` 数组的定义。

+ **状态定义**：`dp[i]` 表示以 `nums[i]` 结尾的连续子数组的最大和；
+ **状态转移方程**：以 `nums[i]` 结尾的连续子数组，向前能延伸多少个元素是我们关心的，`dp[i - 1]`（`i > 0`）的值在之前已计算好。根据状态的定义：`nums[i]` 必须被选，而 `dp[i - 1]` 表示的连续子数组选或不选，就得看 `dp[i - 1]` 的正负：
    - 如果 `dp[i - 1] > 0`，加上一个正数比不加要大，此时要加，即 `dp[i] = dp[i - 1] + nums[i]`；
    - 如果 `dp[i - 1] <= 0`，由于 `nums[i]` 必须选取，加上 0 或者负数，值不会更大，此时不加 `dp[i - 1]` ，即 `dp[i] = nums[i]`。

综上所述：`dp[i] = nums[i] + max(dp[i - 1], 0)`，这里 `max(dp[i - 1], 0)` 表示，如果 `dp[i - 1] <= 0`，则不选择以 `nums[i - 1]` 结尾的连续子数组。

+ **考虑初始值**：以 `nums[0]` 结尾的连续子数组，只有 `nums[0]`，所以 `dp[0] = nums[0]`；
+ **考虑输出值**：题目不是问最后一个状态值，我们需要遍历数组 `dp`，输出最大值。

**参考代码 1**：

```java
public class Solution {

    public int maxSubArray(int[] nums) {
        int n = nums.length;
        // dp[i]：表示以 nums[i] 结尾的连续子数组的最大和
        int[] dp = new int[n];
        dp[0] = nums[0];
        for (int i = 1; i < n; i++) {
            if (dp[i - 1] >= 0) {
                dp[i] = dp[i - 1] + nums[i];
            } else {
                dp[i] = nums[i];
            }
        }

        // 最后需要遍历 dp 数组得到最大值
        int res = dp[0];
        for (int i = 1; i < n; i++) {
            res = Math.max(res, dp[i]);
        }
        return res;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度；
+ 空间复杂度：$ O(n) $， 状态数组的长度为 $ n $。

也可以一边遍历，一边得到 `dp` 数组的最大值，也可以不用真正创建 `dp` 数组，使用一个变量来记录之前的状态值，即：使用滚动变量技巧。

**参考代码 2**：使用滚动变量技巧。

```java
public class Solution {

    public int maxSubArray(int[] nums) {
        int n = nums.length;
        int curSum = nums[0];
        int maxSum = nums[0];
        for (int i = 1; i < n; i++) {
            curSum = Math.max(nums[i], nums[i] + curSum);
            maxSum = Math.max(curSum, maxSum);
        }
        return maxSum;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度；
+ 空间复杂度：$ O(1) $，只使用了常数个额外空间。

可以看到，使用优化空间技巧的代码语义没有那么清晰。是否需要优化空间，很多时候取决于空间是否受限和编程者自己。

如果我们定义 `dp[i]`：以 `nums[i]` 开始的连续子数组的最大和。对称地，就需要倒着遍历。状态转移方程和一些说明在如下的参考代码中。给出这一版定义，只是为了说明状态定义在动态规划问题中非常重要，不同的定义决定了初始化、状态转移方程等。因此在定义状态的时候，一定要准确。

**参考代码 3**：

```java
public class Solution {

    public int maxSubArray(int[] nums) {
        int n = nums.length;
        // dp[i]：表示以 nums[i] 开始的子数组的最大和
        int[] dp = new int[n];
        dp[n - 1] = nums[n - 1];
        int maxSum = dp[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            // dp[i] 要么是当前元素 nums[i] 自己（即：后面的子数组的和小于等于 0）
            // 要么是当前元素 nums[i] 加上以 nums[i + 1] 开始的子数组的最大和（即：后面子数组的和为正，连接起来更大）
            dp[i] = Math.max(nums[i], nums[i] + dp[i + 1]);
            // 在遍历同时更新最大子数组和
            maxSum = Math.max(maxSum, dp[i]);
        }
        return maxSum;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
+ 定义状态的时候，以 `nums[i]` 结尾或者开头这件事情很重要，**固定住一些事情，能够使得状态转移变得容易**，这条经验可以类似地应用到很多动态规划问题的状态定义上；
+ 最后输出的是所有状态中的最大值，而不是最后一个状态值；
+ 优化空间并非动态规划的必要步骤，且优化空间的方法单一，没有什么技巧，读者可根据实际场景（如内存限制、性能需求等）自行决定是否采用，且不容易一次就写对。在面试场景下，通常更关注算法的正确和逻辑清晰，因此可以先写出未优化空间的代码，先保证算法正确，再口述如何优化空间。','17',NULL,'0053-maximum-subarray','2025-06-10 04:53:16','2025-06-17 12:47:03',0,9,false,NULL,'https://leetcode.cn/problems/maximum-subarray/description/',39,6,'',false,'https://leetcode.cn/problems/maximum-subarray/solutions/9058/dong-tai-gui-hua-fen-zhi-fa-python-dai-ma-java-dai/',true,'完成。',NULL),(119,'liweiwei1419','「力扣」第 206 题：反转链表（简单）','## 思路分析

反转链表是链表操作中的经典问题，可以采用迭代和递归两种方法实现。

## 方法一：迭代

首先需要明确，题目不是让我们修改链表结点的值实现反转，而是需要我们修改链表的 `next` 指针指向，如下图所示：


![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1746534404392-306e7ce4-9993-4ae5-b28c-a2cdcd91194e.png)

其中虚线箭头表示了反转前后 `next` 指针的对应关系。要修改一个结点的 `next` 指向，需要：

+ 先记住它原来的后继结点，这是因为：反转的时候需要移动指针继续处理下一个结点；
+ 还需要记住它原来的前驱结点，反转的时候成为新的后继结点。

虽然核心的代码只有 `curNode.next = preNode` 这一句代码，但是它的前后还需要对 `preNode` 、`curNode` 和 `nextNode` 赋值。具体步骤如下：

```java
// 第 1 步：先把 nextNode 保存下来，如果不使用临时变量 nextNode 记住后继结点，修改 currNode.next 后，无法访问原链表的后继结点
nextNode = curNode.next;
// 第 2 步：修改 next 指向
curNode.next = preNode;
// 第 3 步：重置 preNode 和 curNode 变量
preNode = curNode;
curNode = nextNode;
```

核心变量是 `curNode` 和 `preNode` 。`nextNode` 变量在下一轮迭代中可以通过 `curNode.next` 得到，代码写出来正好是轮换交替赋值的形式（每一行等号右边的变量是下一行等号左边的变量，最后 `nextNode` 成为最开始的变量）。当 `curNode` 为 `null` 时，`preNode` 就是新的链表的头结点。

**参考代码 1**：

```java
public class Solution {

    public ListNode reverseList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode preNode = null;
        ListNode curNode = head;
        while (curNode != null) {
            ListNode nextNode = curNode.next;
            curNode.next = preNode;
            preNode = curNode;
            curNode = nextNode;
        }
        return preNode;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是链表的长度，需要遍历链表一次；
+ 空间复杂度：$ O(1) $，只需要常数级别的额外空间。

## 方法二：递归
递归方法使用分而治之思想实现：

+ 拆分：将链表分为两部分：头结点（当前结点）和剩余子链表（`head.next` 开始的链表），如下图所示；



![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1746536656710-6acc4434-1010-4e6f-bfb8-4404e8155ed2.png)




+ 解决：反转剩余子链表；
+ 合并：已反转的子链表的末尾结点的 `next` 指向当前结点。

**编码细节**：

+ 由于我们需要把剩余子链表的末尾结点指向当前结点，因此当前结点的后继结点需要记录下来：`nextNode = headNode.next`；
+ 在「合并」阶段有 3 件事要做：
    - 把剩余子链表的末尾结点 `nextNode` 的 `next` 指向当前结点：`nextNode.next = head`；
    - 把新链表末尾结点的 `next` 指向设置为 `null`，**这一点容易忽略，如果不写会形成循环链表**；
    - 剩余子链表反转以后的头结点是新链表（「合并」完成以后）的头结点。

**参考代码 2**：

```java
public class Solution {

    public ListNode reverseList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode nextNode = head.next;
        // 得到 newNode 作为递归函数的返回值很重要，表示：新链表的头结点就是子链表的头结点
        ListNode newNode = reverseList(nextNode);
        nextNode.next = head;
        // 这里一定要切断引用，否则会出现错误：Error - Found cycle in the ListNode
        head.next = null;
        return newNode;
    }

}
```

**说明**：递归方法需要先来到从原链表的尾结点，从尾结点倒着修改 `next` 指针指向，与迭代解法的处理顺序正好相反。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，需要递归处理每个结点；
+ 空间复杂度：$ O(n) $，递归调用的栈空间大小。

','9',NULL,'0206-reverse-linked-list','2025-06-11 09:15:01','2025-06-14 12:46:51',2,15,false,NULL,'https://leetcode.cn/problems/reverse-linked-list/description/',32,2,'',false,'https://leetcode.cn/problems/reverse-linked-list/solutions/48213/chuan-zhen-yin-xian-di-gui-by-liweiwei1419/',true,'完成！','循环与递归均可。'),(125,'liweiwei1419','「力扣」第 355 题：设计推特（中等）','## 理解题意

这道题目要求设计一个简化版的推特系统，需要支持以下操作：

+ 用户发推文：postTweet
+ 用户关注其他用户：follow
+ 用户取消关注其他用户：unfollow
+ 获取用户最近的 10 条推文，包括自己发的和自己关注的人发的：getNewsFeed

## 思路分析
我们需要高效地存储和查询用户的关注关系，哈希表（映射）非常适合这种键值对映射关系。我们需要两个哈希映射：

+ 用户关注关系映射 `Map<Integer, Set<Integer>>` ，选择哈希集合（`Set`）的原因：
    - 去重保证：系统要求用户不能重复关注同一账号，`Set`的天然去重特性完美满足这一需求；
    - 操作高效：关注（`follow`）和取关（`unfollow`）操作的时间复杂度均为 $ O(1) $，适合高频关系变更场景；
    - 顺序无关：关注列表的排列顺序不影响功能逻辑，无需维护顺序性。
+ 用户推文存储映射 `Map<Integer, List<Tweet>>` ，选择链表结构（`LinkedList`）的原因：
    - 动态扩展：推文数量不可预知，链表无需预分配空间，避免数组扩容开销；
    - 倒序插入高效：新推文直接插入链表头部，时间复杂度 $ O(1) $，天然形成时间倒序排列；
    - 合并操作便捷：获取动态消息流时，只需顺序遍历链表头部，无需维护数组下标等额外状态。

当获取用户新闻推送时，需要合并用户自己及其关注者的最新推文，并按时间降序排列。即我们需要合并多个时间线，获取 Top 10 的推文，这是经典的「多路归并」问题，提示我们可以使用优先队列，每次从优先队列取出最新的推文后，将该推文的下一个（更早的）推文加入优先队列中。

**参考代码**：

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;

class Twitter {

    public Twitter() {
        userTweets = new HashMap<>();
        userFollowings = new HashMap<>();
    }

    // 1、发推文
    public void postTweet(int userId, int tweetId) {
        Tweet tweet = new Tweet(tweetId, timeStamp);
        timeStamp++;
        // 将新推文插入链表头部
        Tweet head = userTweets.get(userId);
        tweet.next = head;
        userTweets.put(userId, tweet);
    }

    // 2、获取推文（自己和关注列表里的最近 10 条）
    public List<Integer> getNewsFeed(int userId) {
        // 使用最大堆，按照时间戳排序
        PriorityQueue<Tweet> maxHeap = new PriorityQueue<>((a, b) -> b.timestamp - a.timestamp);
        // 添加自己的推文
        if (userTweets.containsKey(userId)) {
            maxHeap.offer(userTweets.get(userId));
        }
        // 添加关注者的推文
        Set<Integer> followings = userFollowings.get(userId);
        if (followings != null) {
            for (int followeeId : followings) {
                if (userTweets.containsKey(followeeId)) {
                    maxHeap.offer(userTweets.get(followeeId));
                }
            }
        }

        List<Integer> res = new ArrayList<>();
        int count = 0;
        // 多路归并
        while (!maxHeap.isEmpty() && count < 10) {
            Tweet tweet = maxHeap.poll();
            res.add(tweet.tweetId);
            // 将链表中的下一个推文加入堆
            if (tweet.next != null) {
                maxHeap.offer(tweet.next);
            }
            count++;
        }
        return res;
    }

    // 3、关注
    public void follow(int followerId, int followeeId) {
        if (followerId == followeeId) {
            // 不能关注自己
            return;
        }
        userFollowings.putIfAbsent(followerId, new HashSet<>());
        userFollowings.get(followerId).add(followeeId);
    }

    // 4、取关
    public void unfollow(int followerId, int followeeId) {
        if (userFollowings.containsKey(followerId)) {
            userFollowings.get(followerId).remove(followeeId);
        }
    }

    // 以下是成员变量和成员函数

    private class Tweet {
        int tweetId;
        int timestamp;
        // 链表结构，指向更早的推文
        Tweet next;

        public Tweet(int tweetId, int timestamp) {
            this.tweetId = tweetId;
            this.timestamp = timestamp;
        }
    }

    // 全局使用的时间戳字段，用户每发布一条推文之后 + 1
    private int timeStamp = 0;
    // 用户发布的推文
    private Map<Integer, Tweet> userTweets;
    // 用户关注的人
    private Map<Integer, Set<Integer>> userFollowings;

}
```

**复杂度分析**：

+ 时间复杂度：
    - 发推文（`postTweet`）：$ O(1) $，只需将推文添加到用户自己的推文列表头部；
    - 获取新闻推送（`getNewsFeed`）：$ O(n \log k) $，$ n $ 是关注用户的推文总数，$ k $ 是 10 条最新推文。使用最大堆维护最近的推文；
    - 关注（`follow`）：$ O(1) $，哈希表直接添加关注关系；
    - 取消关注（`unfollow`）：$ O(1) $，哈希表直接移除关注关系。
+ 空间复杂度：$ O(U + T) $，其中 $ U $ 是用户数量， $ T $ 是推文总数。需要存储：每个用户的关注列表 $ O(U) $，所有用户的推文 $ O(T) $，临时堆空间 $ O(k) $，$ k=10 $ 可视为常数。
','9',NULL,'0355-design-twitter','2025-06-11 09:15:01','2025-06-14 13:46:13',1,3,false,NULL,'https://leetcode.cn/problems/design-twitter/description/',32,8,'',false,NULL,true,'完成！','经典多路归并问题，使用优先队列。'),(56,'liweiwei1419','「力扣」第 60 题：排列序列 （困难）','## 思路分析
本题要我们求的排列，其实就是「力扣」第 46 题（全排列）中的某一个排列，我们的思路依然是画出递归树，技巧是：在选出某一个数的时候，**计算剩下的数字可以组成的全排列个数**：**如果它小于 `k` 就跳过（以该数开始的排列都不是我们要找的排列），同时 `k` 减去跳过的排列数，否则就继续产生新的分支**。

我们以「示例 2」：`n = 4`，`k = 9` 为例，画出递归树如下图所示：

![image.png](https://pic.leetcode.cn/1749519569-nMBBaL-image.png)


**编码细节**：

+ 题目中说「给定 $ n $ 的范围是 `[1, 9]`」，我们可以先计算出从 0 到 9 的阶乘，放在一个数组里，需要用到的时候可以根据下标直接获得阶乘值，其中 $ 0!=1 $表示没有数可选的时候，也就是到达叶子结点了，排列数只剩下 1 个；
+ 编码的时候，到底是 +1 还是 -1，大于还是大于等于，这些比较容易把人绕晕，不能靠猜。常用的做法是：代入一个具体的数值，认真调试；
+ 本题在深度优先遍历的时候没有回头的过程，因此 `path` 变量就不需要回溯，这是与其它回溯问题不同的地方。

**参考代码**：

```java
import java.util.Arrays;

public class Solution {

    public String getPermutation(int n, int k) {
        int[] factorial = calculateFactorial(n);
        boolean[] used = new boolean[n + 1];
        Arrays.fill(used, false);
        StringBuilder path = new StringBuilder();
        dfs(0, n, k, path, used, factorial);
        return path.toString();
    }

    private void dfs(int index, int n, int k, StringBuilder path, boolean[] used, int[] factorial) {
        if (index == n) {
            return;
        }

        // 计算还未确定的数字的全排列的个数，第 1 次进入的时候是 n - 1
        int count = factorial[n - 1 - index];
        for (int i = 1; i <= n; i++) {
            if (used[i]) {
                continue;
            }
            if (count < k) {
                k -= count;
                continue;
            }
            path.append(i);
            used[i] = true;
            dfs(index + 1, n, k, path, used, factorial);
            return;
        }
    }

    private int[] calculateFactorial(int n) {
        int[] factorial = new int[n + 1];
        factorial[0] = 1;
        for (int i = 1; i <= n; i++) {
            factorial[i] = factorial[i - 1] * i;
        }
        return factorial;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $。计算阶乘数组的时间复杂度是 $ O(n) $，而在 `dfs` 方法中，每次确定一个数字时，需要遍历 `used` 数组，总共需要确定 `n` 个数字，每次遍历的时间复杂度是 $ O(n) $，因此总的时间复杂度是 $ O(n^2) $；
+ 空间复杂度：$ O(n) $。主要的额外空间开销在于 `used` 数组和 `factorial` 数组，它们的长度都为 $ n + 1 $，因此空间复杂度是 $ O(n) $。','16',NULL,'0060-permutation-sequence','2025-06-10 05:01:06','2025-06-15 20:33:19',1,13,false,NULL,'https://leetcode.cn/problems/permutation-sequence/description/',38,7,'',false,'https://leetcode.cn/problems/permutation-sequence/solutions/10642/hui-su-jian-zhi-python-dai-ma-java-dai-ma-by-liwei/',true,NULL,NULL),(121,'liweiwei1419','「力扣」第 19 题：删除链表的倒数第 N 个结点（中等）','## 思路分析
要删除一个结点，需要来到待删除结点的上一个结点。要删除倒数第 `n` 个结点，需要来到倒数第 `n + 1` 个结点，然后修改它的 `next` 指针指向。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image7007268515943537495.png)


倒数第 `n` 个结点，其实就是正着数第 `L - n + 1` 个结点，待删除结点的上一个结点是正着第 `L - n` 个结点（这里 `L` 是结点总数，本题的标题用 `N`，描述用了 `n`，为避免混淆，我们使用 `L` 表示链表长度）。对于本问题，最直接的解法是：先从头到尾遍历整个链表，统计结点总数 `L`，再次遍历链表，找到第 `L - n` 个结点（即要删除结点的上一个结点），执行删除操作：`prev.next = prev.next.next`。这种解法进行了两次链表遍历，需要单独处理删除头结点的情况（我们放在「进阶」要求里说）。

**对「进阶」要求的思考**：倒数第 `n` 个结点与链表末尾的距离是固定的，如果能用一个指针先走 `n` 步，然后两个指针一起走，当先走的指针到达末尾时，后面的指针正好在倒数第 `n` 个位置。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image12486631276315049707.png)


由于我们要先来到倒数第 `n + 1` 个位置，因此先走的指针应该先走 `n + 1` 步。

还有一个问题需要解决，如果 `n` 等于链表的长度 `L`，即要删除的是头结点，头结点没有上一个结点，需要单独判断。并且当链表只有一个结点且 `n = 1` 时，还需要特殊处理。

事实上，处理链表起始结点的边界问题，有一个常用的技巧，那就是设置 **虚拟头结点**（dummy node），此时所有结点的删除操作都可以用相同的逻辑处理。

**参考代码**：

```java
public class Solution {

    public ListNode removeNthFromEnd(ListNode head, int n) {
        // 创建虚拟头结点，简化删除头结点的情况
        ListNode dummy = new ListNode(-1);
        dummy.next = head;

        ListNode slow = dummy;
        ListNode fast = dummy;
        // 快指针先走 n + 1 步
        for (int i = 0; i <= n; i++) {
            fast = fast.next;
        }

        // 快、慢指针同时前进，直到快指针到达末尾，慢指针最终会停在要删除结点的前一个结点
        while (fast != null) {
            slow = slow.next;
            fast = fast.next;
        }
        // 删除慢指针后面的结点（即倒数第 n 个结点）
        slow.next = slow.next.next;
        // 返回真实头结点
        return dummy.next;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(L) $，这里 $ L $ 是链表的结点总数；
+ 空间复杂度：$ O(1) $。

## 本题总结
+ 删除倒数第 `n` 个结点的核心困难在于：链表是单向链表，不能直接逆向遍历，希望只遍历一次，但不知道链表的总长度的时候，还要直接定位到特定位置。快慢指针技巧就解决了这样的问题。快慢指针技巧还应用在判断链表是否有环、寻找链表的中间结点、寻找两个链表的交点等问题上；
+ 虚拟头结点技巧将原本需要特殊处理的情况转化为统一的处理逻辑，是链表问题中常用的技巧，特别适合涉及结点删除的操作。

','9',NULL,'0019-remove-nth-node-from-end-of-list','2025-06-11 09:15:01','2025-06-14 13:35:22',1,11,false,NULL,'https://leetcode.cn/problems/remove-nth-node-from-end-of-list/description/',32,4,'',false,NULL,true,'完成！','「虚拟头结点」与「快慢指针」技巧应用。'),(102,'liweiwei1419','「力扣」第 525 题：连续数组（中等）','## 思路分析

**暴力解法**：使用两层循环枚举所有可能的区间，然后判断区间里 1 和 0 的个数是否相等，进而计算区间的长度，选出最长；

**优化**：连续子数组的问题，可以考虑通过前缀和求区间和。由于题目要求区间里包含 1 和 0 的个数相等，可以把 0 换成 -1，把 **判断区间里 1 和 0 的个数相等转换为判断区间和等于 0**，更简单。

在《第 1 节 前缀和简介》中，我们提到过：如果相同的前缀和出现过，说明找到了一个区间和为 0。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749633359-hrqruB-image.png)


题目要求的是 1 和 0 个数相等的最长的连续子数组的长度，因此需要记录区间的长度，我们可以使用哈希表，一边遍历一边记录（键：前缀和，值：下标）。由于求的是最长，我们只需要记录前缀和第 1 次出现的下标（注意下面「参考代码」中 `for` 循环里的 `else` 代码，区别于「力扣」第 560 题：和为 K 的子数组），从中选出最大值。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public int findMaxLength(int[] nums) {
        int n = nums.length;
        // 键：前缀和，值：下标
        Map<Integer, Integer> hashMap = new HashMap<>(n);
        // 补充下标 -1 位置的前缀和，键：0，不影响后面计算前缀和，值：需要记录下标，所以是 -1
        hashMap.put(0, -1);
        int res = 0;
        int preSum = 0;
        for (int i = 0; i < n; i++) {
            // 把数组中的 0 都看成 -1
            preSum += nums[i] == 0 ? -1 : 1;
            if (hashMap.containsKey(preSum)) {
                // [j + 1..i] 的长度为 i - j
                res = Math.max(res, i - hashMap.get(preSum));
            } else {
                // 注意：由于题目要求的是「最长长度」，因此只记录前缀和第一次出现的下标
                hashMap.put(preSum, i);
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，算法遍历了一次数组，每一个元素的操作都是常数次的，因此时间复杂度是 $ O(n) $；
+ 空间复杂度：$ O(n) $。

# 总结

+ **前缀和与哈希表** 是解决连续子数组问题的经典组合，尤其适合处理求和、模运算、特定条件（如 0 和 1 数量相等）的场景；
+ **关键点**：合理初始化哈希表、利用数学性质（如模运算转化）、维护首次出现的下标以优化结果；
+ **适用性**：当问题涉及连续子数组且可转化为前缀和差值或模运算时，优先考虑此方法。

| 题目 | 核心转化 | 哈希表键 | 哈希表值 | 特殊处理 |
| --- | --- | --- | --- | --- |
| 和为 K 的子数组 | `preSum[j] - preSum[i] = k` | 前缀和 `preSum` | 出现次数 | 初始化 `(0, 1)` |
| 连续的子数组和 | `(preSum[j] - preSum[i]) % k = 0` | 余数 `remainder` | 首次下标 | 初始化 `(0, -1)`，长度 ≥ 2 |
| 连续数组（0 和 1 相等） | 将 `0` 转为 `-1`，求和为 `0` | 前缀和 `preSum` | 首次下标 | 初始化 `(0, -1)` |

','20',NULL,'0525-contiguous-array','2025-06-11 08:39:04','2025-06-12 13:57:08',1,7,false,NULL,'https://leetcode.cn/problems/contiguous-array/description/',42,3,'',false,'https://leetcode.cn/problems/contiguous-array/solutions/201478/qian-zhui-he-chai-fen-ha-xi-biao-java-by-liweiwei1/',false,NULL,NULL),(117,'liweiwei1419','「力扣」第 4 题：寻找两个正序数组的中位数 （困难）','**阅读提示**：

本题解是 [官方题解](https://leetcode.cn/problems/median-of-two-sorted-arrays/solutions/258842/xun-zhao-liang-ge-you-xu-shu-zu-de-zhong-wei-s-114/) 视频讲解对应的文字题解，对大段文字不感兴趣的朋友（我已经尽量压缩内容了，也把重点给大家标注出来了），也可以看看视频。

本题解分为 4 个部分：

* 思路分析：这部分讲解了思路，是最重要的部分，思路是很简单的：**画一条线，然后看看向左挪一下，还是向右挪一下，直至找到最合适的「中位线」**；
* 编码细节：这部分主要讨论了一些边界情况，比较繁琐，在理解了「思路分析」以后可以自己尝试编码，不一定看我这里写的这么多文字；
* 变量定义说明：我们对变量的定义进行了解释，在清楚了变量定义的前提下，编码就相对容易；
* 参考代码：我们给出了 3 个参考代码，其中：
  * 「参考代码 1」的思路是：在循环体中直接找答案，所以在循环体内要讨论边界情况；
  * 「参考代码 2」和「参考代码 3」是同一种思路，即：退出循环体以后得到答案，所以在循环体外面讨论边界情况。
  * **它们的核心代码片段是很少的**，前后的代码都是一些特殊情况的讨论。

希望本题解能对大家有帮助 `^_^` ！


## 思路分析

直接合并两个有序数组再求中位数虽然可行，但时间复杂度为 $ O(m + n) $，无法满足题目要求的 $ O(\log(m + n)) $。因此，我们需要更高效的算法。

我们先来看只有一个有序数组的时候，中位数的性质。如果只有 1 个有序数组，中位数位于数组的中间，画一条分割线，分割线位于中位数的位置，或者分割线位于两个中位数的中间。

+ **情况 1**：有序数组的长度为奇数，分割线位于中位数的位置，如下图所示，中位数是 8：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749617969-zikRPr-image.png)


+ **情况 2**：有序数组的长度为偶数，分割线位于中间两数的中间，中位数是它们的平均值，如下图所示，中位数是 $ \frac{6 + 8}{2} = 7$ ：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749617981-ImvyAe-image.png)


分割线的特点是：

- 分割线左右两侧元素个数大致相等；
- 分割线左侧的所有元素小于等于分割线右侧的所有元素。

那么当有两个有序数组的时候，我们是不是也可以画这样一条分割线，进而来找到中位数呢？答案是：可以。我们以两个数组的长度之和为偶数为例（奇数数情况类似，不赘述），如下图所示，分割线的左右两侧各有 7 个元素，如果我们画出的分割线满足：**左侧所有元素小于等于右侧所有元素**，那么中位数就由 x1、x2、y1、y2 产生。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618070-STaZlA-image.png)


那么如何判断「左侧所有元素小于等于右侧所有元素」呢？由于 `nums1` 和 `nums2` 均是有序数组，`x1 <= x2`，`y1 <= y2` 显然成立，因此只需满足 `x1 <= y2` 且 `y1 <= x2`，我们称之为「**交叉小于等于关系**」。此时中位数有两个，那就是 `max(x1, y1)` 和 `min(x2, y2)`，根据题意，我们返回它们的平均数。

综上所述，我们的思路是：**尝试画一条分割线**，先满足 **左右两侧元素个数相等（这一点相对容易）**，再看看是否满足 **交叉小于等于关系。找到这条分割线就需要利用本题的单调性**。

我们先尝试在数组 `nums1` 的某个位置画一条线，先保证分割线左右两侧元素个数相等，那么分割线在数组 `nums2` 上的位置也随之确定（两个数组的长度之和是确定的，那么两个数组的长度之和的一半也是确定的）。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618111-iPBYFB-image.png)


我们发现，分割线左边元素的最大值 12 > 分割线右边元素的最小值 8。此时如果我们将分割线在 `nums1` 的位置左移，那么分割线左边元素的最大值越来越大（此时是 14），分割线右边元素的最小值越来越小（此时是 5）。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618117-yHecYP-image.png)


所以我们只能将分割线在 `nums1` 的位置右移，才有可能找到正确的分割线位置，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618125-konVyN-image.png)


这是本题的单调性，因此可以使用二分查找来确定这条分割线的位置。简而言之，就是 **画一条分割线，根据「分割线两个元素大致相等」和「交叉小于等于关系」，利用有序数组的单调性，或者左移，或者右移，直到找到合适的分割线**。

本题最最重要的思想部分我们已经介绍完了，理解了思想以后，下面我们罗列一些编码细节，这些细节其实并不难，大家完全可以尝试自己分析出来。

------

（阅读提示：以上是本题的思路，是重点。编码细节写出来有点多，实际上没多少东西。）



## 编码细节

+ **编码细节 1：两个数组的长度之和奇偶数的讨论**。当两个数组的长度之和为奇数时，中位数只有 1 个，此时分割线不能保证两侧元素个数相等，**其实哪边个数多 1 个都可以**。

  * 如果我们让分割线的右边多一个元素，如下左图，分割线右边的最小值就是中位数；
  * 如果我们让分割线的左边多一个元素，如下右图，分割线左边的最大值就是中位数。

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618137-qsjrmo-image.png)

以下我们都以「让分割线的右边多一个元素」（如上左图的定义）为例展开讨论和展示编码。「让分割线的左边多一个元素」（如上右图的定义）大家可以自己尝试讨论和编码。

+ **编码细节 2**：极端情况下分割线的两侧未必都有值。有些时候，分割线的某一侧可能没有元素。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618152-QUJCfB-image.png)

中位数是由分割线左侧最大值和右侧最小值决定的，我们需要处理这些情况：

+ 如果分割线的左侧没有值，我们需要将缺失的值设置成一个较小的值，好让它在比较最大值的过程中不被选中；
+ 如果分割线的右侧没有值，我们需要将缺失的值设置成一个较大的值，好让它在比较最小值的过程中不被选中。

这样编码能够统一到一般情况。

+ **编码细节 3**：在较短的数组上画分割线。我们以 `nums1` 的长度为 4， `nums2` 的长度为 1 为例。

第 1 轮：分割线是这样画的，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618169-Woeshs-image.png)

分割线左侧最大元素 > 分割线右侧最小元素 ，分割线在 `nums1` 的位置应该左移。

第 2 轮：分割线在 `nums1` 左移后来到了如下图所示位置（由于整数除法下取整的原因，左移到此位置）：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618176-OKMXuk-image.png)


此时我们发现：分割线在 `nums2` 上无处安放。因此，我们需要 **在较短的数组上进行二分查找，这样分割线在较长的数组上至少能够保证其中一侧有值**。

## 变量定义说明

我们定义：

- 有序数组 `nums1` 的长度为 `m`，有序数组 `nums2` 的长度为 `n`；
- 在两个有序数组长度之和 `m + n` 为奇数的时候，画分割线让右边比左边多一个元素，此时分割线右边的最小值就是两个有序数组的中位数，我们以此为前提编码（大家完全可以画分割线让左边比右边多一个元素，此时分割线左边的最大值就是两个有序数组的中位数。讨论与我们这里的描述类似，不再赘述）；
- 有序数组 `nums1` 在分割线左边的元素的最大值设置为 `nums1LeftMax`；
- 有序数组 `nums1` 在分割线右边的元素的最小值设置为 `nums1RightMin`；
- 有序数组 `nums2` 在分割线左边的元素的最大值设置为 `nums2LeftMax`；
- 有序数组 `nums2` 在分割线右边的元素的最小值设置为 `nums2RightMin`；
- 分割线在 `nums1` 右边的第 1 个元素的下标为 `i`，分割线在 `nums1` 右边的第 1 个元素的下标为 `j` 。由于 **数组下标从 0 开始计数**，根据数组下标与元素数量的关系，从下标 `0` 到下标 `i - 1` 一共有 `i` 个元素。因此分割线在第 1 个数组左边的元素个数为 `i`，分割线在第 2 个数组左边的元素个数为 `j`。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749618192-fcmCjp-image.png)


## 参考代码

**参考代码 1**：据以上的分析，在循环体里有可能找到合适的分割线，因此循环可以继续的条件是 `left <= right`，循环体里有 3 个分支（分支顺序无关紧要）：

+ 第 1 个分支：直接返回目标元素的值；
+ 第 2 个分支：排除了 `mid`，向左边继续查找；
+ 第 3 个分支：排除了 `mid`，向右边继续查找。

分割线有可能把 `nums1` 的所有元素都放在左边，因此搜索的范围是 `[0..m]`。

```java
public class Solution {

    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        // 在较短的数组上查找分界线
        if (nums1.length > nums2.length) {
            int[] temp = nums1;
            nums1 = nums2;
            nums2 = temp;
        }

        int m = nums1.length;
        int n = nums2.length;

        // 我们定义分割线左边的元素个数少 1
        int totalLeft = (m + n) / 2;

        // 在 nums1 的区间 [0..m] 里查找恰当的分割线，注意：m 也是搜索的位置
        // 交叉小于等于关系：使得 nums1[i - 1] <= nums2[j] && nums2[j - 1] <= nums1[i]
        int left = 0;
        int right = m;
        // 有可能一下子找到，所以写 <=
        while (left <= right) {
            // 定义 i 是分割线在 nums1 左侧的元素个数
            int i = (left + right) / 2;
            int j = totalLeft - i;

            // 先对极端情况展开讨论：
            // 由于左侧要选出最大值，数组下标越界情况下就应该赋值成一个很小的值
            // 由于右侧要选出最小值，数组下标越界情况下就应该赋值成一个很大的值
            int nums1LeftMax = i == 0 ? Integer.MIN_VALUE : nums1[i - 1];
            int nums1RightMin = i == m ? Integer.MAX_VALUE : nums1[i];
            int nums2LeftMax = j == 0 ? Integer.MIN_VALUE : nums2[j - 1];
            int nums2RightMin = j == n ? Integer.MAX_VALUE : nums2[j];

            // 有可能直接找到
            if (nums1LeftMax <= nums2RightMin && nums2LeftMax <= nums1RightMin) {
                if (((m + n) % 2) == 1) {
                    return Math.min(nums1RightMin, nums2RightMin);
                } else {
                    return (double) ((Math.max(nums1LeftMax, nums2LeftMax) + Math.min(nums1RightMin, nums2RightMin))) / 2;
                }
            } else if (nums1LeftMax > nums2RightMin) {
                // 分割线左边元素太大了，因此需要左移
                // 下一轮搜索的区间 [left..i - 1]
                right = i - 1;
            } else {
                // nums2LeftMax > nums1RightMin
                // 分割线右边元素太小了，因此需要右移
                // 下一轮搜索的区间 [i + 1..right]
                left = i + 1;
            }
        }
        return -1;
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(\log(\min(m, n))) $，其中 $ m $ 和 $ n $ 分别是两个数组的长度；
+ 空间复杂度：$ O(1) $，只使用了常数级别的额外空间。

**说明**：下面给出的两版代码不是优化的思路，仅只是根据目标元素的特点在编码层面做改动，或许能够给大家一些帮助。

下面我们再给出两版代码的写法，其实就只是在思路上做一个转变，即 **将分割线的确定留到退出循环以后**。观察目标元素的表达式：`nums1[i - 1] <= nums2[j] && nums2[j - 1] <= nums1[i]`。

对于「表达式 1」&&「表达式 2」 这种形式，我们可以对其中一个表达式取反，作为其中一个 `if` 语句，剩下的放在 `else` 语句中。大家想一想 `else` 语句是 !「表达式 1」，它包括了目标元素的性质，所以 `mid` 位置需要保留。退出循环以后，分割线就来到了正确的位置。这样的写法，好处是：

+ 在循环体内写两个分支，并且判别条件比较简单；
+ 把一些极端情况的判断放在最后。

**参考代码 2**：对「表达式 1」，即 `nums1[i - 1] <= nums2[j]` 取反，作为 `if` 语句。大家看到 `left = i` 这样的表达式，就知道 `i` 需要上取整，上取整以后循环体内 `nums1[i - 1]` 就不会越界，代码逻辑是正确的。

```java
public class Solution {

    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        if (nums1.length > nums2.length) {
            int[] temp = nums1;
            nums1 = nums2;
            nums2 = temp;
        }

        int m = nums1.length;
        int n = nums2.length;
        // 分割线左边元素个数少 1 个
        int totalLeft = (m + n) / 2;
        // 在 nums1 的区间 [0..m] 里查找分割线，使得 nums1[i - 1] <= nums2[j] && nums2[j - 1] <= nums1[i]
        int left = 0;
        int right = m;
        while (left < right) {
            int i = (left + right + 1) / 2;
            int j = totalLeft - i;
            if (nums1[i - 1] > nums2[j]) {
                // 下一轮搜索的区间 [left..i - 1]
                right = i - 1;
            } else {
                // 下一轮搜索的区间 [i..right]
                left = i;
            }
        }

        int i = left;
        int j = totalLeft - i;
        int nums1LeftMax = i == 0 ? Integer.MIN_VALUE : nums1[i - 1];
        int nums1RightMin = i == m ? Integer.MAX_VALUE : nums1[i];
        int nums2LeftMax = j == 0 ? Integer.MIN_VALUE : nums2[j - 1];
        int nums2RightMin = j == n ? Integer.MAX_VALUE : nums2[j];
        if (((m + n) % 2) == 1) {
            return Math.min(nums1RightMin, nums2RightMin);
        } else {
            return (double) ((Math.max(nums1LeftMax, nums2LeftMax) + Math.min(nums1RightMin, nums2RightMin))) / 2;
        }
    }

}
```

**复杂度分析：**（同「参考代码 1」）。

**参考代码 3**：对「表达式 2」，即 `nums2[j - 1] <= nums1[i]` 取反，作为 `if` 语句。此时 `i` 是下取整的，在循环体内 `j = totalLeft（固定值）- i（较小的数）`，循环体内 `nums2[j - 1]` 就不会越界，代码逻辑是正确的。

```java
public class Solution {

    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        if (nums1.length > nums2.length) {
            int[] temp = nums1;
            nums1 = nums2;
            nums2 = temp;
        }

        int m = nums1.length;
        int n = nums2.length;
        // 分割线左边元素个数少 1 个
        int totalLeft = (m + n) / 2;
        // 在 nums1 的区间 [0..m] 里查找分割线，使得 nums1[i - 1] <= nums2[j] && nums2[j - 1] <= nums1[i]
        int left = 0;
        int right = m;
        while (left < right) {
            int i = (left + right) / 2;
            int j = totalLeft - i;
            if (nums2[j - 1] > nums1[i]) {
                // 下一轮搜索的区间 [i + 1..right]
                left = i + 1;
            } else {
                // 下一轮搜索的区间 [left..i]
                right = i;
            }
        }

        int i = left;
        int j = totalLeft - i;
        int nums1LeftMax = i == 0 ? Integer.MIN_VALUE : nums1[i - 1];
        int nums1RightMin = i == m ? Integer.MAX_VALUE : nums1[i];
        int nums2LeftMax = j == 0 ? Integer.MIN_VALUE : nums2[j - 1];
        int nums2RightMin = j == n ? Integer.MAX_VALUE : nums2[j];
        if (((m + n) % 2) == 1) {
            return Math.min(nums1RightMin, nums2RightMin);
        } else {
            return (double) ((Math.max(nums1LeftMax, nums2LeftMax) + Math.min(nums1RightMin, nums2RightMin))) / 2;
        }
    }

}
```

**复杂度分析：**（同「参考代码 1」）。





','8',NULL,'0004-median-of-two-sorted-arrays','2025-06-11 09:10:31','2025-06-13 03:58:21',1,13,false,NULL,'https://leetcode.cn/problems/median-of-two-sorted-arrays/description/',30,10,'',false,'https://leetcode.cn/problems/median-of-two-sorted-arrays/solutions/15086/he-bing-yi-hou-zhao-gui-bing-guo-cheng-zhong-zhao-/',true,NULL,'可以在循环体内找到。退出循环以后得到答案，代码更简单一点。'),(99,'liweiwei1419','「力扣」第 802 题：找到最终的安全状态（中等）','## 题意分析

本题给的是一个有向图，安全结点的定义是：对于某个结点，它的所有前驱结点，都能够历经有限步骤后，抵达一个没有后继的结点。「示例 2」没有给出示意图，我们根据题意，画出图如下：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1741317210993-87479826-c155-410d-8bf2-c7551f508410.png)

图中结点 1 有一条边指向了自己，即 **题目有定义自环边，结点 1 不是安全结点**，而「示例 1」的结点 6 没有出边，所以它既是终端结点又是安全结点。

## 思路分析
根据以上对示例的分析，如果一个结点处于有向图的环中，那么它便不是安全的。因为 **处于环中结点会不断地循环指向彼此，无法满足「历经有限步到达没有后继结点」的条件**。只有那些不在环内，且它们的前驱结点能按要求到达无后继结点的，才属于安全终点。以「示例 1」为例，如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1741317643836-2b9c64ae-07c3-4260-8893-df7846b6d4a5.png)

检测有向图是否有环提示我们可以使用拓扑排序算法，根据本题而言，我们需要 **从没有出边的顶点开始层层遍历，以下两种方式任选其一**：

+ 定义出度数组，在拓扑排序的过程中，不断更新结点的出度。当处理一个出度为 0 的结点时，需要减少其前驱结点的出度；
+ （「参考代码」采用的方式）在构建有向图的时候，把边的方向全部反向，这样依然可以定义入度数组（保持拓扑排序最原始的样子），在拓扑排序的过程中，需要不断更新结点的入度。当处理一个入度为 0 的顶点时，需要减少其后继结点的入度。

**存在于环中的结点，因为它们被循环指向，入度不可能为 0，就无法被遍历到**。题目要求的结点就是曾经加入队列的结点或者是最终入度数组里入度为 0 的结点。由于题目要求「答案数组中的元素应当按 **升序** 排列」，因此我们可以在拓扑排序结束以后，再遍历一次入度数组，把入度为 0 的结点（这些结点不在环中，是题目要求的「安全结点」）加入结果列表。

**参考代码**：

```java
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Solution {

    public List<Integer> eventualSafeNodes(int[][] graph) {
        int len = graph.length;
        List<List<Integer>> reverseGraph = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            reverseGraph.add(new ArrayList<>());
        }

        // 入度数组
        int[] inDegree = new int[len];
        // 计算入度和构建反向邻接表
        for (int i = 0; i < len; i++) {
            for (int j : graph[i]) {
                reverseGraph.get(j).add(i);
            }
            inDegree[i] = graph[i].length;
        }

        // 初始化队列，将入度为 0 的结点加入队列
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < len; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }
        while (!queue.isEmpty()) {
            int front = queue.poll();
            for (int x : reverseGraph.get(front)) {
                inDegree[x]--;
                if (inDegree[x] == 0) {
                    queue.offer(x);
                }
            }
        }

        // 将最终入度为 0 的结点加入结果列表
        List<Integer> res = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            if (inDegree[i] == 0) {
                res.add(i);
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(V + E) $，这里 $ V $ 为图的顶点总数，$ E $ 为图的边数；
+ 空间复杂度：$ O(V + E) $。

## 本题总结
+ 本题要我们找的「安全结点」是不处于「环」中的结点，而「拓扑排序」就可以帮我们检测是否有「环」；
+ 建立「逆邻接表」是为了通过反向「拓扑排序」，从终止结点（原图出度为 0）出发，逆向标记所有能安全到达终点的结点。

','19',NULL,'0802-find-eventual-safe-states','2025-06-11 08:36:19','2025-06-17 10:27:11',1,29,false,NULL,'https://leetcode.cn/problems/find-eventual-safe-states/description/',41,12,'',false,NULL,true,NULL,NULL),(42,'liweiwei1419','第 18 章 前缀和与哈希表：子数组问题的优化策略','',NULL,NULL,'prefix-sum','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,2,'',true,NULL,true,NULL,'前缀和与哈希表都是空间换时间思想的体现。常见的题型是：用哈希表记录前缀信息，以得到满足某种条件的区间信息。'),(58,'liweiwei1419','「力扣」第 77 题：组合（中等）','## 思路分析

组合问题，为了避免得到重复的结果，需要按照顺序搜索，因此在代码中需要设置搜索起点 `start`。我们从第一个数开始尝试，当选择一个数后，在剩下的数中继续选择下一个数，当组合长度达到 `k` 时，保存结果。以「示例 1」为例，画出递归树如下：

![image.png](https://pic.leetcode.cn/1749520868-FPfkrn-image.png)


还需要注意到：当剩余可选的数字数量不足以凑齐我们需要的组合时，可以提前终止搜索。

如上图所示，在 `[1, 2, 3, 4]` 中选出 2 个数，搜索起点最多为 3，因为如果从 4 开始搜索，还需要 1 个数，但此时没有可以使用的数字了。

又比如，当 `n = 9`，`k = 6` 时，**假设搜索到某一个时刻，刚刚选了数字 7，还需要选 4 个数字**，但剩余可选数字：`[8, 9]`（只有 2 个），明显不够，所以从 7 开始搜索就是浪费时间，我们需要对「剩余可选数字的个数」和「还需要选几个数」的大小关系进行判断。换句话说，如果我们发现剩下的数字「不够用」了，就没必要继续往下找了。

+ 设搜索上界为 `max`，那么 `[max..n]` 范围内的数字个数，即「剩余可选数字的个数」是 `n - max + 1` ；
+ 我们每次选择一个数，在递归方法传递参数的时候，向下传递一层，`k` 减 1，因此「还需要选几个数」仍用 `k` 表示；
+ 为了保证剩下的数字够用，需要满足「剩余可选数字的个数」>= 「还需要选几个数」，即：`n - max + 1 ≥ k`， 解这个不等式，得 `max ≤ n + 1 - k`，得到搜索上界 `max = n + 1 - k`。

通过这样的剪枝，算法效率可以显著提升，特别是在处理较大 `n` 和 `k` 时。

**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>(k);
        dfs(n, k, 1, path, res);
        return res;
    }

    // n：数字范围上限
    // k：还剩几个数要选
    // start：当前搜索的起始数字，以避免重复
    // path：当前路径，表示已选择的数字
    private void dfs(int n, int k, int start, Deque<Integer> path, List<List<Integer>> res) {
        if (k == 0) {
            res.add(new ArrayList<>(path));
            return;
        }
        // 关键剪枝
        int max = n + 1 - k;
        for (int i = start; i <= max; i++) {
            path.addLast(i);
            dfs(n, k - 1, i + 1, path, res);
            path.removeLast();
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(kC_n^k) $，必须生成所有组合数，每个组合需要 $ O(k) $ 时间处理；
+ 空间复杂度：$ O(k^2) $，递归栈的深度最多为 $ k $ 层，路径存储最多 $ k $ 个元素。

根据组合问题的特点：每一个数或者选，或者不选，画出二叉树如下图所示，二叉树最多有 `n` 层。

![image.png](https://pic.leetcode.cn/1749520881-OeWxhY-image.png)


和「参考代码 1」一样，可以应用一个较强的剪枝条件，即「剩余可选数字的个数」>= 「还需要选几个数」。

+ 假设搜索起点是 `start` ，剩余可用的数字范围是 `[start..n]`，共 `n - start + 1` 个数字；
+ 设 `k` 表示还需要选的数字个数；
+ 「剩余可选数字的个数」>= 「还需要选几个数」，即 `n - start + 1 >= k` ，化简得 `start <= n + 1 - k`，即当 `start > n + 1 - k` 时搜索停止。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>(k);
        dfs(1, n, k, path, res);
        return res;
    }

    private void dfs(int start, int n, int k, Deque<Integer> path, List<List<Integer>> res) {
        if (k == 0) {
            res.add(new ArrayList<>(path));
            return;
        }

        if (start > n - k + 1) {
            return;
        }
        // 不选
        dfs(start + 1, n, k, path, res);

        // 选
        path.addLast(start);
        dfs(start + 1, n, k - 1, path, res);
        path.removeLast();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(kC_n^k) $，生成所有组合数，每个组合需要 $ O(k) $ 时间处理；
+ 空间复杂度：$ O(nk) $，递归深度最多 $ n $ 层，路径存储最多 $ k $ 个元素。','16',NULL,NULL,'2025-06-10 10:01:44','2025-06-10 10:01:44',0,0,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(38,'liweiwei1419','第 14 章 回溯算法：全局使用一个变量去尝试所有可能，其实还是 DFS','',NULL,NULL,'backtracking','2025-06-09 12:18:02','2025-06-09 12:18:02',0,1,false,NULL,NULL,22,1,'',true,NULL,true,NULL,'回溯算法就是用共享变量在树或者图上执行一次深度优先遍历，深度优先遍历有回头的过程，所以需要回溯（状态重置或者说回到过去）。'),(96,'liweiwei1419','「力扣」第 752 题：打开转盘锁（中等）','## 思路分析

我们将每个锁状态（如 `0000`）看作图中的一个顶点，每次旋转操作（+1/-1 一位数字）视为顶点间的边。求从起点 `0000` 到目标（`target`）的最短路径。可以画出「图」如下所示：

![](https://minio.dance8.fun/algo-crazy/0752-open-the-lock/temp-image8282405717573626089.png)

其中，所有可能的 4 位密码组合，共 $ 10^4=10000 $ 个顶点，每个顶点有 8 条边（ 4 位数字 × 上下旋转），死锁顶点不可访问。题目要我们求解无权图的最短路径，因此使用广度优先遍历。由于目标状态已知，还可以使用「双向 BFS」。

## 方法一：单向 BFS
+ 从 `0000` 开始，每次生成所有可能的下一步状态；
+ 跳过「死锁状态」和「已访问状态」；
+ 找到「目标状态」时返回当前扩散的层数。

**参考代码 1**：

```java
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

public class Solution {

    public int openLock(String[] deadends, String target) {
        // 将死亡数字存入集合，方便快速查找
        Set<String> deadendSet = new HashSet<>(Arrays.asList(deadends));
        String start = "0000";
        if (start.equals(target)) {
            return 0;
        }
        if (deadendSet.contains(start)) {
            return -1;
        }

        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int steps = 0;
        // 表示「向下旋转」「向上旋转」
        int[] change = new int[]{-1, 1};
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String front = queue.poll();
                if (front.equals(target)) {
                    return steps;
                }
                char[] charArray = front.toCharArray();
                for (int j = 0; j < 4; j++) {
                    // 只能改变一个字符，所以需要暂存，修改以后恢复
                    char origin = charArray[j];
                    for (int c : change) {
                        // 括号里的 + 10 是为了保证括号里是正数，括号外 % 10 是为了保证得到 0 - 9 之间的数
                        charArray[j] = (char) ((charArray[j] - ''0'' + c + 10) % 10 + ''0'');
                        String next = new String(charArray);
                        if (!deadendSet.contains(next) && !visited.contains(next)) {
                            queue.add(next);
                            visited.add(next);
                        }
                        charArray[j] = origin;
                    }
                }
            }
            steps++;
        }
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(b^d) $，这里 $b$ 是分支因子（从一个状态通过单次操作能够到达的新状态的平均数量)，$ b = 8 $（每位  + 1或 -1，$ 4 \times 2=8 $ )， $ d $ 是最短路径步数；
+ 空间复杂度：$ O(b^d) $，队列和已访问集合的空间大小。

## 方法二：双向 BFS

- 同时从起点（`0000`）和终点（`target`）开始逐层扩散；
- 每次选择较小的「队列」进行扩展，此时队列的形态是「哈希表」；
- 当两个「队列」相遇时（当前扩散的单词在另一个队列中，表示相遇）返回步数。

**参考代码 2**：

```java
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Solution {

    public int openLock(String[] deadends, String target) {
        // 将死亡数字存入集合，方便快速查找
        Set<String> deadendSet = new HashSet<>(Arrays.asList(deadends));
        String start = "0000";
        if (start.equals(target)) {
            return 0;
        }
        if (deadendSet.contains(start)) {
            return -1;
        }

        // 这里的 beginSet 和 endSet 类似于「单向 BFS」里的队列，它们交替使用。实际上，为了减少尝试，我们总是让小的集合开始扩散
        Set<String> beginSet = new HashSet<>();
        Set<String> endSet = new HashSet<>();
        beginSet.add(start);
        endSet.add(target);
        // 这里的 visited 就是「单向 BFS」里的 visited，图中存在环，为了避免重复元素被遍历到，需要记住访问过的元素
        Set<String> visited = new HashSet<>();
        visited.add(start);
        visited.add(target);
        int steps = 0;
        // 表示「向下旋转」「向上旋转」
        int[] change = new int[]{-1, 1};
        while (!beginSet.isEmpty()) {
            // 总是从较小的集合开始扩展
            if (beginSet.size() > endSet.size()) {
                Set<String> temp = beginSet;
                beginSet = endSet;
                endSet = temp;
            }

            // 扩散到下一层，等待扩散完成以后，用 beginSet 变量替换它
            Set<String> nextLevel = new HashSet<>();
            for (String current : beginSet) {
                // 生成所有可能的下一状态
                for (int i = 0; i < 4; i++) {
                    for (int c : change) {
                        char[] charArray = current.toCharArray();
                        charArray[i] = (char) (((charArray[i] - ''0'' + c + 10) % 10) + ''0'');
                        String next = new String(charArray);
                        // 如果对面存在当前扩散的字符串，说明双向 BFS 相遇
                        if (endSet.contains(next)) {
                            return steps + 1;
                        }
                        if (!deadendSet.contains(next) && !visited.contains(next)) {
                            visited.add(next);
                            nextLevel.add(next);
                        }
                    }
                }
            }
            beginSet = nextLevel;
            steps++;
        }
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：从 `"0000"` 和 `target` 同时搜索，时间降为 $ O(b^{\frac{d}{2}}) $；
+ 空间复杂度：两端队列存储状态数减少，空间仍为  $ O(b^{\frac{d}{2}}) $。

','19',NULL,'0752-open-the-lock','2025-06-11 08:36:19','2025-06-18 16:47:19',1,6,false,NULL,'https://leetcode.cn/problems/open-the-lock/description/',41,9,'',false,NULL,true,NULL,NULL),(98,'liweiwei1419','「力扣」第 310 题：最小高度树（中等）','## 题意分析

对于一棵树，以不同结点作为根结点时，树的高度可能不同。最小高度树就是指在所有可能的树中，高度最小的那些树。

## 思路分析

直觉上，**越靠外面的结点，我们越不可能把它作为根结点**，即叶子结点一定不会是题目要求的最小高度树的根结点。因此我们可以依次把叶子结点删除，最后剩下的结点就是最小高度树的根结点，这个过程像极了拓扑排序。

可以利用拓扑排序里入度数组的概念，虽然题目中给出的边是无向的，但可以把一条无向边当做有两条有向边，即：**如果一个结点只有 1 条边与它连接，它就是叶子结点**。

我们通过不断地从图中移除叶子结点（**入度为 1 的结点**），逐步缩小图的规模，由于题目让我们求最小高度树的根结点，所以删叶子结点不能把所有结点都删掉，最后剩下的结点（1 个或者 2 个）就是能构建最小高度树的根结点。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1741254799499-214d7c2f-a32b-4360-9cc0-22cf61bd2b19.png)

**参考代码**：

```java
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Solution {

    public List<Integer> findMinHeightTrees(int n, int[][] edges) {
        List<Integer> res = new ArrayList<>();
        if (n <= 2) {
            for (int i = 0; i < n; i++) {
                res.add(i);
            }
            return res;
        }

        // 入度数组，每一次要把入度为 1 的结点删除
        int[] inDegrees = new int[n];
        // 因为是无向图，所以邻接表拿出一条边，两个结点都要存一下
        // 注意：右边就不要写具体的实现类了，等到实例化的时候再写具体的实现类
        List<List<Integer>> adjList = new ArrayList<>(n);
        // 初始化
        for (int i = 0; i < n; i++) {
            adjList.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adjList.get(u).add(v);
            adjList.get(v).add(u);
            inDegrees[u]++;
            inDegrees[v]++;
        }
        Queue<Integer> queue = new LinkedList<>();
        // 入度为 1 的结点入队
        for (int i = 0; i < n; i++) {
            if (inDegrees[i] == 1) {
                queue.offer(i);
            }
        }
        // 不断移除叶子结点，直到剩下 1 个或 2 个结点
        while (n > 2) {
            int size = queue.size();
            n -= size;
            for (int i = 0; i < size; i++) {
                int leaf = queue.poll();
                inDegrees[leaf]--;
                // 把它和它的邻接结点的入度全部减 1
                List<Integer> successors = adjList.get(leaf);
                for (Integer successor : successors) {
                    inDegrees[successor]--;
                    if (inDegrees[successor] == 1) {
                        queue.offer(successor);
                    }
                }
            }
        }

        // 此时队列中的结点就是最小高度树的根结点
        while (!queue.isEmpty()) {
            res.add(queue.poll());
        }
        return res;
    }

}
```

**编码细节**：由于我们需要得到最后的 1 个结点或者 2 个结点作为结果，因此循环可以继续的条件是 `n > 2` ，**出队的时候需要一层一层出队列，因此在出队的时候，需要先把此时队列中当前的结点数 `size` 保存起来，分批次出队**。

**复杂度分析**：本题中边的条数为 $ n - 1 $，因此时间复杂度和空间复杂度是 $ O(V + E) = O(n + n - 1) = O(n) $ 形式。

+ 时间复杂度：$ O(n) $。初始化入度为 0 的集合需要遍历整张图，检查每个顶点和每条边，因此复杂度为 $ O(n) $，然后每个结点出队一次，操作和查询相邻顶点的入度，时间复杂度也为 $ O(n) $；
+ 空间复杂度：$ O(n) $：邻接表的空间复杂度为 $ O(n + n - 1) = O(2n) $。

## 本题总结
本题求解的过程就像剥洋葱一样，把在外面的结点一层一层拿掉，得到被包围在最里层的结点就是题目要求的最小高度树的根结点。把在外面的结点一层一层拿掉这件事情像极了拓扑排序里依次取出入度为 0 的顶点，因此我们还是借助入度数组，把无向边当做两条有向边来看待，因此本题需要依次取出入度为 1 的结点。

','19',NULL,'0310-minimum-height-trees','2025-06-11 08:36:19','2025-06-12 03:51:09',1,5,false,NULL,'https://leetcode.cn/problems/minimum-height-trees/description/',41,11,'',false,'https://leetcode.cn/problems/minimum-height-trees/solutions/14405/tan-xin-fa-gen-ju-tuo-bu-pai-xu-de-si-lu-python-da/',true,NULL,NULL),(93,'liweiwei1419','「力扣」第 127 题：单词接龙（困难）','本节我们介绍的问题可以使用「双向 BFS（Bidirectional BFS）」解决，双向 BFS 是一种优化版的广度优先搜索算法，适用于已知起点和终点的场景。它通过从起点和终点同时进行搜索，显著提升查找效率。 对比通常使用的 BFS：

+ **单向 BFS（通常使用的 BFS）**：单向搜索，从起点逐层扩展直到找到目标；
+ **双向 BFS**：
    - 正向搜索：从起点出发按层扩展；
    - 反向搜索：从终点出发按层扩展；
    - 当两个搜索相遇时，即找到最短路径。

**双向 BFS 的优点是**：

+ **空间效率**：减少搜索空间，避免单向搜索的盲目扩展。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1743105130451-e1a83458-2fa0-4eca-bb1b-43201176c059.png)

可以看到：右侧「双向 BFS」搜索的空间是加重灰色部分，比左边「传统 BFS」的面积要小。

+ **时间效率**：将时间复杂度从 $ O(b^d) $ 优化至 $ O(b^{d/2}) $，这里 `b` 为分支因子，`d` 为深度。

**双向 BFS** 的适用场景：

+ 明确起点和终点的最短路径问题（如「单词接龙」问题）；
+ 状态转移可逆的问题，即无向图。

# 例题 1：「力扣」第 127 题：单词接龙（困难）

!!! info 阅读提示

虽然本题标注为「困难」，其实我们读懂题意以后，看到要我们找最短距离，很容易想到广度优先遍历的思路。本题难在编码，在准备面试、笔试之前需要多写几遍。「单向 BFS」的代码已经有一些代码量了。「双向 BFS」本书认为只需要知道思想就好了，在面试、笔试的时候能写出「双向 BFS」还是有一定难度的。

!!! 

+ 题目地址：[https://leetcode.cn/problems/word-ladder/description/](https://leetcode.cn/problems/word-ladder/description/)


## 思路分析

本题要求从给定的起始单词出发，经过一系列变换，最终到达目标单词，每次变换只能改变一个字母，且变换后的单词必须在给定的单词列表中，需要找出最短变换序列的长度，即最短转换序列中的单词数目。

看到「最短」，提示我们可以使用广度优先遍历，当层层扩散到达目标单词时，经过的路径一定是最短的。

由于目标已知，除了常见的 BFS （单向 BFS）以外，还可以使用「双向 BFS」解决，下面我们分别介绍。

## 方法一：单向 BFS

根据「示例 1」，画出图结构如下：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1743090556042-c22b4e42-9486-48ec-aa4f-1614c5d30231.png)

从 `hit` 到 `cog` 扩散了 4 次，由于题目问我们的是「最短转换序列中的单词数目」，因此单词数目是 5。

**参考代码 1**：这里 `getNextWords` 方法其实不必写成一个函数，用一个列表返回一个单词所有可能的变化，可以在 `ladderLength` 方法中，生成一个单词就进行相应逻辑的处理，这里为了让 `ladderLength` 方法逻辑更清楚一些才这样写。

除掉一些特殊判断，队列、`visited` 的初始化，真正的逻辑就只有：从 `beginWord` 开始扩展出新的单词：

+ 如果它是 `endWord`，返回结果，程序结束；
+ 如果它不是 `endWord`，加入队列且标记为已访问。

即下面代码中的两个 `if` 语句，其实就是标准的广度优先遍历的代码。其它细节我们写成注释放在下面的代码中。

```java
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;

public class Solution {

    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        // 本题还可以不使用 visited，在访问完一个单词以后，从 wordSet 中删除，作用是一样的
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);
        int step = 1;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String currentWord = queue.poll();
                List<String> nextWords = getNextWords(currentWord, wordSet);
                for (String nextWord : nextWords) {
                    if (nextWord.equals(endWord)) {
                        return step + 1;
                    }
                    if (!visited.contains(nextWord)) {
                        queue.add(nextWord);
                        // 注意：添加到队列以后，必须马上标记为「已经访问」
                        visited.add(nextWord);
                    }
                }
            }
            step++;
        }
        return 0;
    }

    private List<String> getNextWords(String word, Set<String> wordSet) {
        List<String> nextWords = new ArrayList<>();
        char[] charArray = word.toCharArray();
        int wordLen = word.length();
        // 尝试对 word 修改每一个字符，得到所有的字符串
        for (int i = 0; i < wordLen; i++) {
            char originChar = charArray[i];
            for (char j = ''a''; j <= ''z''; j++) {
                if (j == originChar) {
                    continue;
                }
                charArray[i] = j;
                String nextWord = String.valueOf(charArray);
                // 在 wordSet 中有的字符才添加进 nextWords，否则 nextWords 里会加入很多单词
                if (wordSet.contains(nextWord)) {
                    nextWords.add(nextWord);
                }
            }
            charArray[i] = originChar;
        }
        return nextWords;
    }

}
```

**编码细节**：

+ 将 `wordList` 存储在一个哈希表 `wordSet` 中，方便快速判断某个单词是否出现在单词列表中；
+ 使用队列进行广度优先遍历，队列中存储的是当前单词；
+ 题目问的是「最短转换序列中单词的数目」，不是「起点经过多少次转换到达终点」，因此初始化的时候 `step` 为 1；
+ 从 `beginWord` 开始，对每个位置的字符进行替换，生成新的单词，如果新单词在字典中，则将其加入队列，并且 **添加到队列以后，必须马上标记为已经访问**，通常的做法是使用哈希表 `visited` 记录已经访问的单词。由于我们已经把 `wordList` 放在一个哈希表 `wordSet` 中，也可以将访问过的单词从哈希表 `wordSet` 中移除，两种方法任选其一就好；
+ 当遇到 `endWord` 时，返回当前路径的单词数目。

**复杂度分析**：

+ 时间复杂度：$O(N * L * 25) = O(N * L)$。假设单词的平均长度为 $L$，单词列表的长度为 $N$。对于每个单词，我们需要生成所有可能的相邻单词（即改变每一个字母为其它 25 个字母），共 $L \times 25$ 种可能。每次生成相邻单词后，需要检查是否在 `wordList`  中（可以用哈希表实现 $O(1)$ 查询）。最坏情况下，我们需要访问所有  $N$ 个单词，每个单词生成 $25L$ 个相邻单词。因此时间复杂度为 $O(N * L * 25) = O(N * L)$；
+ 空间复杂度：$O(N)$，队列中最多存储 $N$ 个单词，哈希表存储 wordList，空间为 $N$ ，因此空间复杂度为 $O(N)$。

## 方法二：双向 BFS

还可以使用「双向 BFS」进一步优化时间复杂度：分别从 `beginWord` 和 `endWord` 交替进行 BFS，当两个方向的搜索相遇时，就找到了最短路径，以减少搜索的空间和时间。

**参考代码 2**：

```java
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {

    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        if (!wordSet.contains(endWord)) {
            return 0;
        }

        // 这是「广度优先遍历」要使用的 visited 变量
        Set<String> visited = new HashSet<>();

        // 分别用左边和右边扩散的「哈希表」代替「单向 BFS」里的「队列」，它们在「双向 BFS」的过程中交替使用
        // 这是因为需要快速判断某个单词是否在对面的「队列」中
        Set<String> beginVisited = new HashSet<>();
        beginVisited.add(beginWord);
        Set<String> endVisited = new HashSet<>();
        endVisited.add(endWord);

        int step = 1;
        while (!beginVisited.isEmpty()) {
            if (beginVisited.size() > endVisited.size()) {
                Set<String> temp = beginVisited;
                beginVisited = endVisited;
                endVisited = temp;
            }

            // nextLevelVisited 在扩散完成以后，会成为新的 beginVisited
            Set<String> nextLevelVisited = new HashSet<>();
            for (String word : beginVisited) {
                List<String> nextWords = getNextWords(word);
                for (String nextWord:nextWords) {
                    if (wordSet.contains(nextWord)) {
                        if (endVisited.contains(nextWord)) {
                            // 检测到在对面的单词列表中，相当于又扩散了一次
                            return step + 1;
                        }
                        if (!visited.contains(nextWord)) {
                            nextLevelVisited.add(nextWord);
                            visited.add(nextWord);
                        }
                    }
                }
            }
            beginVisited = nextLevelVisited;
            step++;
        }
        return 0;
    }

    private List<String> getNextWords(String word) {
        List<String> nextWords = new ArrayList<>();
        char[] charArray = word.toCharArray();
        int wordLen = word.length();
        for (int i = 0; i < wordLen; i++) {
            char originChar = charArray[i];
            for (char j = ''a''; j <= ''z''; j++) {
                if (j == originChar) {
                    continue;
                }
                charArray[i] = j;
                String nextWord = String.valueOf(charArray);
                nextWords.add(nextWord);
            }
            charArray[i] = originChar;
        }
        return nextWords;
    }

}
```

**编码细节**：

- 由于在扩散的时候，需要判断扩散是不是产生了交汇，即某个单词是不是出现在对面的单词列表中，所以对面的单词列表就需要用哈希表存储，交替使用。因此我们使用 `beginVisited` 和 `endVisited`：分别用于正向和反向的广度优先遍历；
- 哈希表 `visited` 的作用和「单向 BFS」一样，都是记录已经访问过的单词，避免重复访问；

- 「双向 BFS」过程：

  - 在每次循环中，选择单词数量较小的那一侧进行扩展，这样可以减少搜索空间；
  - 对于哈希表中的每个单词，对其每个位置的字符进行替换，生成新的单词；
  - 如果新单词在另一个哈希表中，说明两个方向的搜索相遇了，相当于又扩散了一次，返回当前路径长度加 1；
  - 如果新单词在字典中且未被访问过，将其加入下一层的哈希表，并标记为已访问。

**复杂度分析**：

* 时间复杂度：最坏情况下，双向 BFS 的时间复杂度与单向 BFS 相同，为 $O(N * L)$。但在实际应用中，尤其是当解位于中间位置时，双向 BFS 可以显著减少搜索的结点数量。具体来说，如果最短路径长度为 d，单向 BFS 需要搜索大约 $b^d$ 个结点（$b$ 是从一个单词通过改变一个字母能够生成的有效新单词的平均数量），而双向 BFS 只需要搜索大约 $2 * b^{\frac{d}{2}}$ 个结点；
* 空间复杂度：$O(N)$，需要维护两个队列和两个访问集合，空间复杂度仍为 $O(N)$。
','19',NULL,'0127-word-ladder','2025-06-11 08:36:18','2025-06-16 15:37:33',1,1,false,NULL,'https://leetcode.cn/problems/word-ladder/description/',41,6,'',false,'https://leetcode.cn/problems/word-ladder/solutions/276923/yan-du-you-xian-bian-li-shuang-xiang-yan-du-you-2/',true,NULL,NULL),(89,'liweiwei1419','「力扣」第 279 题：完全平方式（中等）','## 思路分析

求和为 `n` 的完全平方数的最少数量，要求「最少」，提示我们可以使用广度优先遍历解决。以「示例 1」`n = 12` 为例，画出示意图如下：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1741412224714-6090e8b1-2776-4403-88fb-3806ae25d9f9.png)

每个结点表示一个剩余需要凑成的数字，从起始结点 `n` 开始，每次减去一个完全平方数得到新的结点，直到达到目标结点 `0`。于是我们把问题转化为图中的搜索问题，广度优先遍历可以保证我们找到的路径是最短的。

**编码细节**：

+ 广度优先遍历需要借助队列实现，队列中保存了待处理的结点，初始时将结点 `n` 加入队列；
+ 由于图中存在环，我们还需要使用 `visited` 数组用于标记某个数字是否已经访问过，并在结点加入队列的时候就标记，避免重复计算。

**参考代码**：

```java
import java.util.LinkedList;
import java.util.Queue;


public class Solution {

    public int numSquares(int n) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(n);
        // 由于图中存在环，所以需要记录哪些结点是否访问过
        boolean[] visited = new boolean[n + 1];
        int step = 0;
        while (!queue.isEmpty()) {
            step++;
            // 每一次扩张，保存当前队列的结点总数
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int front = queue.poll();
                for (int j = 1; j * j <= front; j++) {
                    int next = front - j * j;
                    if (next == 0) {
                        return step;
                    }
                    if (!visited[next]) {
                        queue.offer(next);
                        visited[next] = true;
                    }
                }
            }
        }
        return 0;
    }

}
```

**说明**：「四平方和定理」告诉我们：每个正整数都可以表示为四个整数的平方和（「四平方和定理」已经超出了程序员面试、笔试的范围，大家了解即可）。例如：$ 3 = 1^2 + 1^2 + 1^2 $、$ 7 = 2^2 + 1^2 + 1^2 + 1^2 $、$ 12 = 3^2 + 1^2 + 1^2 + 1^2 $、$ 25 = 5^2 $。广度优先遍历最多扩散 4 次就结束因此，`numSquares` 方法的最后一行 `return 0` 不会被执行到，大家返回任意的整数均可以通过系统测评。

**复杂度分析**：

+ 时间复杂度：$ O(n \sqrt{n}) $，这里 $ n $ 是输入的整数，`for (int j = 1; n - j * j >= 0; j++)` 这一层循环需要时间消耗 $ \sqrt{n} $；
+ 空间复杂度：$ O(n) $，队列和 `visited` 数组的长度为 $ n $。','19',NULL,'0279-perfect-squares','2025-06-11 08:36:18','2025-06-12 05:09:15',1,7,false,NULL,'https://leetcode.cn/problems/perfect-squares/description/',41,2,'',false,NULL,true,NULL,'3333333'),(88,'liweiwei1419','「力扣」第 695 题：岛屿的最大面积（中等）','## 思路分析

+ 岛屿的定义是矩阵中值为 1 的上、下、左、右 4 连通区域的单元格的总数，我们可以遍历每一个单元格，只要是 1，就执行一次广度优先遍历（或者深度优先遍历，「参考代码」以广度优先遍历为例），在结点入队或者出队的时候，记录结点的个数，该值就是岛屿的面积；
+ **注意**：在 **无权图** 中进行广度优先遍历时，在加入结点以后，需要马上标记为已经访问；
+ 由于这道题不用求遍历的起始点到其它结点的最短路径数，因此不需要将当前队列中的结点总数暂存起来，然后再依次取出；
+ 广度优先遍历要向队列中存入相关的数据，有些时候需要将一些数据封装成类，本题需要向队列中传入结点的坐标，可以是一维坐标，也可以是二维坐标。大家可以在「参考代码」的注释中了解二维坐标和一维坐标的相互转换。

**参考代码**：使用二维坐标。

```java
import java.util.LinkedList;
import java.util.Queue;

public class Solution {

    private final static int[][] DIRECTIONS = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    public int maxAreaOfIsland(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[] visited = new boolean[m * n];
        int maxArea = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1 && !visited[getIndex(i, j, n)]) {
                    maxArea = Math.max(maxArea, bfs(grid, i, j, m, n, visited));
                }
            }
        }
        return maxArea;
    }

    private int bfs(int[][] grid, int i, int j, int m, int n, boolean[] visited) {
        int count = 0;
        Queue<Integer> queue = new LinkedList<>();
        int index = getIndex(i, j, n);
        queue.offer(index);
        visited[index] = true;
        while (!queue.isEmpty()) {
            int front = queue.poll();
            // 一维坐标转换为二维坐标
            int curX = front / n;
            int curY = front % n;
            // 在出队时候记录结点个数
            count++;
            for (int[] direction : DIRECTIONS) {
                int newX = curX + direction[0];
                int newY = curY + direction[1];
                int newIndex = getIndex(newX, newY, n);
                if (inArea(newX, newY, m, n) && grid[newX][newY] == 1 && !visited[newIndex]) {
                    queue.offer(newIndex);
                    // 注意：由于图中存在环，入队的时候需要标记为「已经访问」
                    visited[newIndex] = true;
                }
            }
        }
        return count;
    }

    // 二维坐标转换为一维坐标
    private int getIndex(int x, int y, int n) {
        return x * n + y;
    }

    private boolean inArea(int i, int j, int m, int n) {
        return i >= 0 && i < m && j >= 0 && j < n;
    }

}
```

**说明**：在 `bfs` 方法中，我们给出的「参考代码」在出队的时候统计结点个数。如果在结点入队的时候统计结点的个数，初始化时，应该将 `count` 的值设置为 1，因为初始化时已经有 1 个结点在队列中，即 `queue.offer(new int[]{i, j})` 这行代码。

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，这里 $ m $ 表示二维矩阵的行数、$ n $ 表示二维矩阵的列数，每个单元格都会被遍历一次；
+ 空间复杂度：$ O(m \times n) $，数组 `visited` 的大小为 $ m \times n $，队列的大小最多为 $ m \times n $。

本题还可以使用深度优先遍历实现，对于需要遍历的场景，一般而言，深度优先遍历和广度优先遍历都可以实现。','19',NULL,'0695-max-area-of-island','2025-06-11 08:36:18','2025-06-16 14:26:07',1,7,false,NULL,'https://leetcode.cn/problems/max-area-of-island/description/',41,1,'',false,NULL,true,NULL,'很好'),(129,'liweiwei1419','「力扣」第 739 题：每日温度（中等）','## 思路分析

题目要求我们找出：在每一个数的右边，第一个严格大于自己的数与自己的下标之差。

我们以 `temperatures = [27, 24, 23, 26, 19, 22, 26, 23]` 为例。从左向右看，**如果值一直是单调不增（没有说单调递减，是因为有可能出现相邻元素值相等的情况），不能确定已经看到的数的答案**，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1740033442-rrQQhV-image.png)

直到看到 26，之前比它小的数 23、24 的答案这时就可以确定下来，其中：

+ 23 < 26，23 与 26 的下标之差为 1；
+ 24 < 26，24 与 26 的下标之差为 2。

**从左向右看，后看到的数 23 比先看到的数 24 先确定答案**，这提示我们可以使用栈：**还不能确定出结果的数值先存起来，等到可以确定出结果的时候再取出。栈顶元素出栈，表示栈顶元素找到了右边第一个严格大于自己的数（即当前遍历到的数）**。

**编码细节**：

+ 每读到一个数，就与栈顶元素（前提：栈顶非空）比较：如果当前看到数 **小于等于** 栈顶元素，就入栈；否则，栈顶元素出栈，出栈的同时，记录出栈元素的答案；
+ 由于我们需要计算栈顶元素和当前元素的下标之差，可以把遍历到的下标放入栈中，拿到下标以后再从输入数组中得到对应的值；
+ 遍历完成以后，还在栈中的元素，表示它们的右边没有元素比自己大，根据题意，它们对应的结果是 0，由于 Java 中 `int` 类型数组初始化的值就是 0，所以遍历完成以后，可以什么都不用操作。

**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        if (n < 2) {
            return new int[n];
        }

        int[] res = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && temperatures[stack.peekLast()] < temperatures[i]) {
                int index = stack.removeLast();
                res[index] = i - index;
            }
            stack.addLast(i);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组 `temperatures` 的长度，每个元素最多进、出栈一次；
+ 空间复杂度：$ O(n) $。

由于每一次都要判断栈是否为空，这里有一个常见的技巧：在数组的开头放一个很大的数（称为「哨兵」），使得栈内元素永远非空，省去在循环中的非空判断。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] newT = new int[n + 1];
        // 30 <= temperatures[i] <= 100，放 101 就可以了
        newT[0] = 101;
        // 为了省去非空判断，这里需要复制，其实和原来的做法差不多
        System.arraycopy(temperatures, 0, newT, 1, n);
        temperatures = newT;

        int[] res = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        stack.push(0);

        // 注意有效位置从下标 1 开始
        for (int i = 1; i <= n; i++) {
            // 由于有「哨兵」在，查看栈顶元素的时候不用判断是否非空
            while (temperatures[stack.peekLast()] < temperatures[i]) {
                Integer top = stack.removeLast();
                // 有下标偏移，所以需要减 1
                res[top - 1] = i - top;
            }
            stack.addLast(i);
        }
        return res;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
+ 本题由于遍历到的元素值是单调不增的，所以它们需要存起来，直到遇到一个较大的元素，之前比它小的元素的答案就依次确定了下来，**存储和取出数据恰好符合了后进先出的顺序**；
+ 分析这一类问题通常需要找到一个合适的例子，一般题目给出的示例就有典型的。使用栈的问题的典型示例通常是这样的：一开始看到的数据是单调的，之后单调性发生变化，之前遍历到的数据依次得到答案，顺序是后看到的数据先计算答案，所以想到使用栈；
+ 栈中元素 **恰好保持了单调性**，人们习惯上称它为单调栈，但我们不用刻意维护栈中元素的单调性。单调性是这一类问题符合后进先出顺序以后自然形成的结果。单调栈就是我们之前介绍的栈，没有加入更多的操作。

','10',NULL,'0739-daily-temperatures','2025-06-11 09:19:13','2025-06-14 06:16:13',1,8,false,NULL,'https://leetcode.cn/problems/daily-temperatures/description/',34,4,'',false,'https://leetcode.cn/problems/daily-temperatures/solutions/49306/bao-li-jie-fa-dan-diao-zhan-by-liweiwei1419/',true,'完成。','符合「后进先出」规律，所以用栈。（不是为了维护单调性，单调是自然形成的结果。）'),(128,'liweiwei1419','「力扣」第 224 题：基本计算器（困难）','## 思路分析

这道题的「提示」给了很多数据的特点：只有 `''+''`、`''-''`，不用考虑乘和除，并且 `s` 是一个有效的表达式，即不会出现 `((0)` 、`1+1 0 1 -(5-1)` 这样的表达式，问题就简化了很多。我们的目标就只剩下 **计算每一个数去掉括号以后的符号**，和把表示数字的字符串转换为整型。

括号的特点是：

- 左括号的作用是连续的；
- 直到遇到与之匹配的右括号，之前的左括号的作用才消失。

因此我们需要记录「累积的符号」，在遇到左括号的时候记下来，在遇到右括号的时候删除。

从左向右看，在遇到右括号时，**后看到的左括号的作用先消除**，类似「力扣」第 20 题（有效的括号），所以我们需要使用栈。



## 示例演示

我们以 `-(1-(4+5+2)-3)-(6-8)` 为例，展示如何从左向右把括号去掉。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0224-basic-calculator/temp-image7273838403577348357.png)

使用变量 `sign` 表示去掉括号以后「累积的符号」（1 表示 `''+''`，-1 表示 `''-''`），初始化的时候为 1，并且把 `sign` 加入栈中，这是为了让栈非空，且保持和后面的的操作逻辑一致（看到符号需要从栈顶读出 `sign` 的值）：

+ 遇到 `''+''`，`sign` 的值从栈顶读出（需要结合之间「累积的符号」），由于是 `''+''`，保持「累积的符号」不变；
+ 遇到 `''-''`，`sign` 的值先从栈顶读出，然后取反，由于是 `''-''`，「累积的符号」需变号；
+ 遇到 `''(''`，记录 `sign` 的值，即 `sign` 入栈；
+ 遇到 `'')''`，把最近的 `sign` 删除，即 `sign` 出栈）；
+ 遇到空字符，什么都不做；
+ 遇到表示数字的字符，继续向右看，直到遇到非数字，就转换为整形结算。

其它细节我们作为注释放在代码中。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int calculate(String s) {
        int n = s.length();
        int res = 0;
        int sign = 1;

        char[] charArray = s.toCharArray();
        Deque<Integer> stack = new ArrayDeque<>();
        // 保证栈非空，且与后面的操作逻辑一致
        stack.addLast(1);
        for (int i = 0; i < n; i++) {
            if (charArray[i] == '' '') {
                continue;
            } else if (charArray[i] == ''+'') {
                // 需要把之前累积的符号合并到当前，因此读栈顶元素，读到 ''-'' 时同理
                sign = stack.peekLast();
            } else if (charArray[i] == ''-'') {
                sign = -stack.peekLast();
            } else if (charArray[i] == ''('') {
                // 左括号的影响是连续的，因此需要记录下来，直到遇到右括号时删除
                stack.addLast(sign);
            } else if (charArray[i] == '')'') {
                stack.removeLast();
            } else {
                int num = 0;
                while (i < n && charArray[i] >= ''0'' && charArray[i] <= ''9'') {
                    num = 10 * num + charArray[i] - ''0'';
                    i++;
                }
                // 读到了一个非数字的时候，退出 while 循环，for 循环里还有 ++ ，因此需要 -- 来抵消
                i--;
                res += sign * num;
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $， 这⾥ $ n $ 是输⼊数组的⻓度；
+ 空间复杂度：$ O(n) $。

','10',NULL,'0224-basic-calculator','2025-06-11 09:19:13','2025-06-30 13:52:19',1,8,false,NULL,'https://leetcode.cn/problems/basic-calculator/description/',34,3,'',false,NULL,true,'完成。','符合「后进先出」规律，所以用栈。'),(27,'liweiwei1419','第 4 章 递归：分而治之的实现工具','',NULL,NULL,'recursion','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,20,4,'',true,NULL,true,NULL,'所有的「递归」都是「分而治之」，「分而治之」是自顶向下思考问题，先拆分问题，再组合子问题的解。「递归」处理问题的顺序是「深度优先遍历」，在编程中，不需要我们人为处理顺序问题。'),(130,'liweiwei1419','「力扣」第 84 题：柱状图中最大的矩形（困难）','## 思路分析

**暴力解法**：

+ 遍历每一个柱子，将其视为矩形的高；
+ 对于每一个柱子，向左和向右分别扩展，直到遇到高度小于该柱子的柱子为止，记录扩展后的宽度；
+ 计算以该柱子为高、扩展后的宽度为长的矩形面积；
+ 更新最大矩形面积。

暴力解法每根柱子的高度会被重复读取很多次，时间复杂度高，空间复杂度很低，优化的方向是「空间换时间」。

**优化思路**：我们看下面的例子：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image8654996267059886897.png)

读到下标 4 的柱子时，下标 3 和 下标 2 的柱子分别向左、向右延伸的最长距离可以计算出来，这是因为下标 3 的左、右都找到了比它还低的柱子，下标 2 同理，计算的顺序是下标 3 的柱子先计算出来，下标 2 的柱子后计算出来，符合后进先出的顺序，提示我们使用栈。

由于我们在计算最大矩形的面积的时候需要计算下标之差和柱形的高度，在栈中存下标就好了，柱子的高度可以通过下标从数组中得到。

## 示例演示
以「示例 1」为例，从左向右读输入数组，读到下标 1 柱子时，下标 0 柱子能确定的最大矩形可以计算出来了。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image4285156498568188507.png)

它的高度是 2，宽度是 1，面积是 1。接下来程序看到下标为 2、3 的柱子，以下标 1、2、3 柱子为高度的最大矩形还不能确定下来，直到程序看到下标 4 柱子。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image398971686632521841.png)

有下标 4 柱子卡在右边，下标 2 柱子卡在左边，以下标 3 柱子为高度的最大矩形面积是 6。接下来以下标 2 柱子为高度的最大矩形面积也可以确定下来，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image13127546104032884352.png)

它的右边最多到下标 4 柱子，左边有下标 1 柱子卡住，最大面积是 10。接下来程序看到下标 5 柱子，以下标 5 柱子为高度的最大矩形面积可以确定下来，它的右边没有柱子，左边有 4 卡住，最大面积是 3。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image3693262404982308969.png)

到此为止，程序已经读完了输入数组，我们计算除了下标 0、3、2、5 的柱子的答案。 剩下 4 和 1 的柱子的答案也可以计算出来了。

以下标 4 柱子为高度的最大矩形可以延伸到最右边，左边被下标 1 柱子卡住，最大面积是 8，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image937048226752578777.png)

最后，以下标 1 柱子为高度的最大矩形面积也可以确定下来，它可以延伸到最左边和最右边，最大面积是 6，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0084-largest-rectangle-in-histogram/temp-image2979591521177240818.png)

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int largestRectangleArea(int[] heights) {
        int n = heights.length;
        if (n == 1) {
            return heights[0];
        }

        int res = 0;
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            // 这个 while 很关键，因为有可能不止一个柱形的最大宽度可以被计算出来
            while (!stack.isEmpty() && heights[i] < heights[stack.peekLast()]) {
                int curHeight = heights[stack.removeLast()];
                // 当前柱子高度与栈顶高度相等时，不弹出栈顶也没有关系，不影响最终结果，下面这 3 行代码可以删去
                while (!stack.isEmpty() && heights[stack.peekLast()] == curHeight) {
                    stack.removeLast();
                }

                int curWidth;
                if (stack.isEmpty()) {
                    curWidth = i;
                } else {
                    curWidth = i - stack.peekLast() - 1;
                }
                res = Math.max(res, curHeight * curWidth);
            }
            stack.addLast(i);
        }

        // 此时已经读完了数组的元素，栈中还未计算出结果的柱子依次从栈顶出栈，计算逻辑和之前一样
        while (!stack.isEmpty()) {
            int curHeight = heights[stack.removeLast()];
            while (!stack.isEmpty() && heights[stack.peekLast()] == curHeight) {
                stack.removeLast();
            }
            int curWidth;
            if (stack.isEmpty()) {
                curWidth = n;
            } else {
                curWidth = n - stack.peekLast() - 1;
            }
            res = Math.max(res, curHeight * curWidth);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，每个元素进、出栈一次；
+ 空间复杂度：$ O(n) $。

在柱状图首尾各添加一个高度为 0 的虚拟柱子（哨兵），这样：

+ 头部哨兵保证栈永远非空，避免判空操作；
+ 尾部哨兵强制所有有效柱子出栈计算面积，避免最后栈中剩余元素出栈时，把之前的处理逻辑再写一遍。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int largestRectangleArea(int[] heights) {
        int n = heights.length;
        if (n == 1) {
            return heights[0];
        }

        int res = 0;

        int[] newHeights = new int[n + 2];
        newHeights[0] = 0;
        System.arraycopy(heights, 0, newHeights, 1, n);
        newHeights[n + 1] = 0;
        n += 2;
        heights = newHeights;

        Deque<Integer> stack = new ArrayDeque<>(n);
        // 先放入哨兵，在循环里就不用做非空判断
        stack.addLast(0);
        for (int i = 1; i < n; i++) {
            while (heights[i] < heights[stack.peekLast()]) {
                int curHeight = heights[stack.removeLast()];
                int curWidth = i - stack.peekLast() - 1;
                res = Math.max(res, curHeight * curWidth);
            }
            stack.addLast(i);
        }
        return res;
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。','10',NULL,'0084-largest-rectangle-in-histogram','2025-06-11 09:19:13','2025-06-15 20:03:59',1,6,false,NULL,'https://leetcode.cn/problems/largest-rectangle-in-histogram/description/',34,5,'',false,'https://leetcode.cn/problems/largest-rectangle-in-histogram/solutions/142012/bao-li-jie-fa-zhan-by-liweiwei1419/',true,'完成。','符合「后进先出」规律，所以用栈。（不是为了维护单调性，单调是自然形成的结果。）'),(57,'liweiwei1419','「力扣」第 216 题：组合总和 III（中等）','## 思路分析

本题要求每个数字最多使用一次，因此我们需要固定数字的选取顺序（升序）避免重复组合。以「示例 1」为例，画出递归树如下图所示：

![image.png](https://pic.leetcode.cn/1749520215-TXDizR-image.png)


这棵树因为我们使用了较强的剪枝，所以剩得没几个枝叶了。这个重要的剪枝策略是：如果剩余的数值是 `n` ，接下来要选 `k` 个数，**如果最小的 `k`** 个数之和都严格大于 `n`，就把这个分支剪去，如上图标注剪刀的地方就是如此。

**编码细节**：

+ 由于「每个数字最多使用一次」，需要参数 `start` 表示搜索的起点 ，每次递归从 `start + 1` 开始搜索；
+ 需要参数 `path` 记录从根结点到当前遍历结点已经选择的数，保存结果时需深拷贝；
+ `n`、`k`、`start` 等基本类型参数在参数传递中的行为是复制，所以它们不需要回溯。

其它编码细节和计算过程，我们作为注释写在了「参考代码」中：

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        // 提前终止条件：k 比 n 大，或者最大的 k 个数 (10 - k,.., 7, 8, 9) 的和 < n
        if (k > n || n > (19 - k) * k / 2) {
            return result;
        }
        dfs(k, n, 1, new ArrayDeque<>(), result);
        return result;
    }

    private void dfs(int k, int n, int start, Deque<Integer> path, List<List<Integer>> result) {
        if (k == 0) {
            if (n == 0) {
                result.add(new ArrayList<>(path));
            }
            return;
        }

        // 剪枝 1 ：剩余数字不够 k 个，即 [start..9] 区间里的数不足 k 个
        if (10 - start < k) {
            return;
        }
        // 剪枝 2：从 start 开始的最小 k 个数（start, start + 1, .., start + k - 1）的和已经大于剩余值
        if ((2 * start + k - 1) * k / 2 > n) {
            return;
        }
        // 遍历可能的数字
        for (int i = start; i <= 9; i++) {
            // 剪枝 3：当前数字已经大于剩余值
            if (i > n) {
                break;
            }
            path.addLast(i);
            dfs(k - 1, n - i, i + 1, path, result);
            path.removeLast(); 
        }
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(C_9^k) $，组合问题的最坏情况；
+ 空间复杂度：$ O(k) $，递归栈深度和路径长度。

## 本题总结

搜索顺序的合理确定是避免重复解和提高算法效率的首要条件。在组合问题中，为避免生成重复的组合（如 `[1, 2]` 和 `[2, 1]`），我们需要固定元素的选取顺序。通常采用升序搜索。','16',NULL,NULL,'2025-06-10 09:51:20','2025-06-10 09:54:18',0,0,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(28,'liweiwei1419','第 5 章 归并排序与快速排序：分而治之思想的典型应用','',NULL,NULL,'merge-sort-quick-sort','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,20,5,'',true,NULL,true,NULL,'「归并排序」与「快速排序」是学习「递归」的很好的学习材料。'),(127,'liweiwei1419','「力扣」第 71 题：简化路径（中等）','
## 题意分析

这题题目的叙述较长，我们为大家简化一下：题目给我们一个字符串，被 `/` 分隔出来的字符有如下两种类型：

+ 表示目录：例如：英文字母、数字、`_`、`...`、`....`、更多的 `.`；
+ 表示操作：`.` 表示当前目录，`..` 表示返回上一级目录，即 Unix 系统里「相对路径」的概念。

根据「示例 2」，有两个斜杠 `/` 连在一起的情况，此时认为这两个斜杠中间是一个空字符，空字符等价于一个点 `.` ，即什么都不做。

## 思路分析
根据题意，「简化路径」的目的是 **去掉多余的斜杠和目录**。重点在于处理 `..`，回到上一级目录，也就是把最近读到的目录删除（**后看到的数据先删除**），这提示我们可以使用栈。具体做法是：先对字符串根据斜杠 `/` 进行分割，得到字符串数组，然后从左向右遍历字符串数组：

+ 如果遇到字母（表示目录名）就加入栈中；
+ 如果遇到一个点 `.` 或者空格的时候，就什么都不做；
+ 如果遇到两个点 `..`，就将栈顶元素弹出（前提：栈顶非空）。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public String simplifyPath(String path) {
        String[] dirs = path.split("/");
        Deque<String> stack = new ArrayDeque<>();
        for (String dir : dirs) {
            if ("".equals(dir) || ".".equals(dir)) {
                continue;
            }
            // 重点在处理 ..
            if ("..".equals(dir)) {
                if (!stack.isEmpty()) {
                    stack.removeLast();
                }
            } else {
                stack.addLast(dir);
            }
        }

        // 处理栈为空的情况(根目录)
        if (stack.isEmpty()) {
            return "/";
        }

        // 此时栈内存储的就是简化后的路径，需要从左向右拼接
        StringBuilder res = new StringBuilder();
        stack.forEach(dir -> res.append("/").append(dir));
        return res.toString();
    }

}
```

**注意**：如果你使用的是 `ArrayDeque` 的 `push()` 和 `pop()` 表示栈的操作，由于它们分别对应 `addFirst()` 和 `removeFirst()` 方法，此时 `stack` 中需要按照从右到左的顺序拼接。这一点不清楚问题也不大，在拼接路径之间，把 `stack`里的元素打印出来看一下就清楚了。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，最坏情况下，每个字符串进栈一次，出栈一次，表示操作的字符串不用进、出栈；
+ 空间复杂度：$ O(n) $ ，最坏情况下，路径字符串本身就是化简过的，栈中就要存字符串长度这么多的字符串（近似，不包括那些斜杠）。','10',NULL,'0071-simplify-path','2025-06-11 09:19:13','2025-06-15 19:36:26',1,5,false,NULL,'https://leetcode.cn/problems/simplify-path/description/',34,2,'',false,NULL,true,'完成。','符合「后进先出」规律，所以用栈。'),(45,'liweiwei1419','第 21 章 并查集：解决连通性问题的经典数据结构','',NULL,NULL,'union-find','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,5,'',true,NULL,true,NULL,'只问是否连接，不问如何连接。组织成树形结构，找父亲结点。'),(44,'liweiwei1419','第 20 章 位运算：利用二进制优化计算','',NULL,NULL,'bit-manipulation','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,4,'',true,NULL,true,NULL,'位运算有很多技巧，需要一定练习掌握。'),(43,'liweiwei1419','第 19 章 字典树：高效处理字符串匹配问题','',NULL,NULL,'trie','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,3,'',true,NULL,false,NULL,'字典树是一棵多叉树，利用了字符串有公共前缀的特点。边的路径表示字符串的前缀。'),(50,'liweiwei1419','「力扣」第 40 题：组合总和 II（中等）','## 思路分析

这道题与上一问的区别在于：

+ 第 39 题：`candidates` 中的数字没有重复，可以无限制重复选择；
+ 第 40 题：`candidates` 中的数字有重复，并且在每个组合中只能使用一次。

相同点是：相同数字列表的不同排列视为一个结果。为此我们首先对数组排序，这样可以避免产生重复的结果以及剪去没有必要的分支。以「示例 2」为例，画出递归树如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image10106592197427913656.png)


画图的规则是：

+ 每一层按照从小到大的顺序减去 `candidates` 中的数字，相同的数字第 2 次及其出现的分支剪去，因为它们会产生重复结果；
+ 从上到下产生分支的时候，减去的数字在 `candidates` 中的下标是不回头的；
+ 如果减去某个数字以后的值小于等于 0，则跳过后面的数字。这是因为数组已排序，减去后面的数字只会使得结果更小。
+ 所有从根结点到叶子结点 0 的路径就是题目要找的结果。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        int n = candidates.length;
        List<List<Integer>> res = new ArrayList<>();
        // 排序的目的是剪枝和去重
        Arrays.sort(candidates);
        Deque<Integer> path = new ArrayDeque<>(n);
        dfs(candidates, n, 0, target, path, res);
        return res;
    }

    private void dfs(int[] candidates, int n, int begin, int target, Deque<Integer> path, List<List<Integer>> res) {
        if (target == 0) {
            res.add(new ArrayList<>(path));
            return;
        }
        for (int i = begin; i < n; i++) {
            // 大剪枝
            if (target - candidates[i] < 0) {
                break;
            }

            // 小剪枝
            if (i > begin && candidates[i] == candidates[i - 1]) {
                continue;
            }
            path.addLast(candidates[i]);
            // 因为元素不可以重复使用，这里递归传递下去的是 i + 1 而不是 i
            dfs(candidates, n, i + 1, target - candidates[i], path, res);
            path.removeLast();
        }
    }
    
}
```

**复杂度分析：**

+ **时间复杂度**：最坏情况下，我们需要遍历所有可能的组合，时间复杂度为 $ O(2^n) $，其中 $ n $ 是数组 `candidates` 的长度。
+ **空间复杂度**：递归栈的深度最多为 $ n $，因此空间复杂度为 $ O(n) $。

## 本题总结
这道题通过回溯算法和剪枝技巧，能够有效地找到所有符合条件的组合。排序和跳过重复元素的处理是避免重复组合的关键。','16',NULL,'0040-combination-sum-ii','2025-06-10 04:12:19','2025-06-14 15:26:47',1,9,false,NULL,'https://leetcode.cn/problems/combination-sum-ii/description/',38,4,'',false,'https://leetcode.cn/problems/combination-sum-ii/solutions/14753/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-m-3/',true,NULL,NULL),(46,'liweiwei1419','第 22 章 单源最短路径：Dijkstra 与 Bellman-Ford 算法','',NULL,NULL,'shortest-path','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,6,'',true,NULL,false,NULL,'Dijkstra 算法应用于没有负权边的单源最短路径问题。当有负权边时用 Bellman-Ford 算法，它们的基础都是松弛操作。Dijkstra 算法其实就广义上的 BFS 算法（使用优先队列代替普通的队列）。'),(47,'liweiwei1419','第 23 章 最小生成树算法：Kruskal 与 Prim 算法','',NULL,NULL,'minimum-spanning-tree','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,7,'',true,NULL,false,NULL,'它们的基础都是切分定理。Kruskal 算法用的数据结构是并查集，Prim 算法用的数据结构是优先队列。'),(52,'liweiwei1419','「力扣」第 90 题：子集 II（中等）','## 思路分析

由于数组 `nums` 中可能包含重复元素，为了避免生成重复的子集，我们需要先对数组排序。按照一个数选和不选，如果不选一个数，则应该跳过与这个数相同的所有数。以 `nums = [1, 2, 2, 3]` 为例，画出递归树如下：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image12397664251183808436.png)


**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>();
        int n = nums.length;
        dfs(nums, 0, n, path, res);
        return res;
    }

    private void dfs(int[] nums, int start, int n, Deque<Integer> path, List<List<Integer>> res) {
        if (start == n) {
            // 添加当前子集到结果中
            res.add(new ArrayList<>(path));  
            return;
        }

        // 选择当前元素
        path.addLast(nums[start]);
        dfs(nums, start + 1, n, path, res);
        // 撤销选择
        path.removeLast();

        // 不选择当前元素，跳过重复元素
        while (start + 1 < n && nums[start] == nums[start + 1]) {
            start++;
        }
        dfs(nums, start + 1, n, path, res);
    }

}
```

我们也可以按照从小到大的顺序依次选取，如果当前元素与前一个元素相同，则跳过该分支。即搜索起点一样，必然发生重复，此时跳过该分支。以示例 1，`nums = [1, 2, 2]` 为例，画出递归树如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image16059782224575206594.png)


所有的结点组成了题目要求的结果列表。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>();
        int n = nums.length;
        dfs(nums, 0, n, path, res);
        return res;
    }

    private void dfs(int[] nums, int start, int len, Deque<Integer> path, List<List<Integer>> res) {
        res.add(new ArrayList<>(path));
        for (int i = start; i < len; i++) {
            // 剪枝条件，不能写成 i > 0
            if (i > start && nums[i] == nums[i - 1]) {
                continue;
            }
            path.addLast(nums[i]);
            // 从 i + 1 开始继续遍历，按顺序遍历，所以不会重复
            dfs(nums, i + 1, len, path, res);
            path.removeLast();
        }
    }

}
```

**复杂度分析**：（理由同力扣第 78 题思路 2）

+ 时间复杂度：$ O(2^n) $，整棵树的结点个数最多 $ 2^n $ 个；
+ 空间复杂度：$ O(n \times 2^n) $，保存子集需要长度为 $ 2^n $ 的列表，每一个子集的元素最多长度为 $ n $。','16',NULL,'0090-subsets-ii','2025-06-10 04:17:08','2025-06-20 09:24:34',1,13,false,NULL,'https://leetcode.cn/problems/subsets-ii/description/',38,6,'',false,NULL,true,NULL,NULL),(60,'liweiwei1419','第 1 节 循环不变量简介','循环不变量（Loop Invariant）就是变量的定义在 **循环的开始**、**循环的过程中**、**循环终止** 都保持不变的意思。如果你觉得「循环不变量」这个名词太专业了，可以换成 **保持变量的定义不变**。**保持变量的定义不变其实是非常自然的一件事情，即使我们没有单独拿出来说，相信大家自然而然地也会这么做。**

本章节就是和大家介绍 **保持变量的定义不变** 这件事情很重要，当我们清楚了变量的定义以后，写代码的逻辑会变得清晰。

# 问题的由来

初学算法，我们在看别的同学的代码的时候，会遇到这样的现象：A 同学写的代码，初始化的时候 `i = 0`，B 同学的代码，初始化的时候 `i = 1`，他们写的代码都是对的，这不禁让我们思考其中的道理。

这种差异往往与变量的定义紧密相连。所有的算法、代码背后都有其设计的思想，明确变量的定义，才能更清楚代码的实现细节。

循环不变量是代码背后的隐藏逻辑，它决定了变量在不同阶段的取值规则，也决定了算法执行过程中的每一步走向。当我们在分析不同版本的正确代码时，不能只看表面的初始化值差异，更要深入挖掘其背后的定义，即循环不变量是什么。

# 为什么要学习循环不变量

清楚变量的定义，能够帮助我们「轻松」写出正确的代码，不再为代码的编写细节而烦恼。在《第 6 章 快速排序》，编写 `partition` 函数和「递归」函数传参的时候，编写细节比较多。**如果在一开始，我们就把变量定义写清楚，在需要考虑细节的地方，看一眼定义就知道该如何编写**。这种编写代码的过程很酷，大家自己动手写起来就能感受到！

# 如何学习循环不变量

我们在第 2 节《循环不变量习题选讲》里会介绍 4 个问题，这 4 个问题我们都给出了 2 版代码，它们的区别仅仅在于变量的定义不同。

在第 5 章编写快速排序代码的过程中，我们也会再和大家介绍循环不变量的应用：**先确定变量的定义，即循环不变量，然后写出初始化、循环过程中的逻辑先后顺序，最后写返回值，就像是「填空」一样，非常自然，写逻辑是完备的，写完代码以后会有一种很踏实的感觉，而不会出现「代码虽然写对了，但总觉得哪里不太对劲」的感觉**。','3',NULL,NULL,'2025-06-10 13:57:59','2025-06-10 13:57:59',0,0,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(59,'liweiwei1419','循环不变量导读','循环不变量是非常基础的算法知识，大家在学习的时候不要有负担，它很简单，简单到我们会觉得保持变量的定义不变是非常自然的事情。

「循环不变量」主要用于证明算法的正确性，在《算法导论》里大量使用了循环不变量进行论述。例如：《第 2.1 节 插入排序》《第 2.3.1 节 分治法》《第 6.3 节 建堆》《第 7.1 节 快速排序的描述》等。

循环不变量不是什么高深的算法概念，它虽然常常应用于证明算法的正确性，不过我们可以借助它明确变量的定义，**帮助我们编写出逻辑清晰的代码，提高代码的可读性，不再为编写代码的细节而烦恼**。','3',NULL,NULL,'2025-06-10 13:53:01','2025-06-10 13:53:01',0,1,false,NULL,NULL,25,0,'',false,NULL,false,NULL,NULL),(122,'liweiwei1419','「力扣」第 141 题：环形链表（简单）','## 思路分析

本题最直观的解法是：用哈希表记录访问过的结点。

对于「进阶」要求，快慢指针是解决该问题的经典做法：

+ 定义两个指针，一个快指针（每次移动两步），一个慢指针（每次移动一步）；
+ 如果链表中有环，快指针最终会追上慢指针（即两者相遇）；
+ 如果链表中没有环，快指针会先到达链表尾部（null）。

该做法有两个关键点：1、两个指针起点相同；2、两个指针速度差恒为 1 。**这两点保证了快、慢指针能相遇，快指针「绕圈」追上慢指针**。若起点不同，或者速度差不为 1，快指针可能越过慢指针导致无法相遇。

**参考代码**：

```java
public class Solution {

    public boolean hasCycle(ListNode head) {
        if (head == null || head.next == null) {
            return false;
        }

        ListNode slow = head;
        ListNode fast = head.next;

        while (slow != fast) {
            // 如果 fast 到达链表末尾，说明没有环
            if (fast == null || fast.next == null) {
                return false;
            }
            slow = slow.next;
            fast = fast.next.next;
        }
        // slow == fast，说明有环
        return true;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n)  $，这里 $ n $ 是链表的长度，快指针最多跑 $ 2n $ 步；
+ 空间复杂度：$ O(1) $。','9',NULL,'0141-linked-list-cycle','2025-06-11 09:15:01','2025-06-14 13:37:03',1,4,false,NULL,'https://leetcode.cn/problems/linked-list-cycle/description/',32,5,'',false,NULL,true,'完成！','很有技巧的问题：快慢指针，记住解法。'),(101,'liweiwei1419','「力扣」第 523 题：连续的子数组和（中等）','## 思路分析

**暴力解法**：枚举所有长度大于等于 2 的连续子数组，对它们分别求和，并判断连续子数组的和是否是给定整数 `k` 的倍数。

**优化**：连续子区间的问题，可以通过前缀和求区间和。区间和是 `k` 的倍数，换言之，前缀和之差为 `k` 的倍数，进而：**如果两个前缀和对 `k` 取余的结果相同，那么这两个前缀和之间的子数组和一定是 `k` 的倍数**。

因此我们可以使用哈希表记录对 `k` 求模的余数以及它对应的下标。题目要求长度至少为 2，因此 **只记录第 1 次出现的下标，以确保子数组尽可能长**。然后遍历数组，计算当前前缀和对 `k` 求模的余数 `remainder`：

+ 如果 `remainder` 已存在于哈希表中，且当前下标与之前下标的差大于等于 2，则返回 `true`，程序结束；
+ 否则，说明 `remainder` 未出现过，则 `remainder` 和当前下标存入哈希表。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public boolean checkSubarraySum(int[] nums, int k) {
        int n = nums.length;

        // key：区间 [0..i] 里所有元素的和 % k 的余数
        // value：下标 i
        Map<Integer, Integer> hashMap = new HashMap<>();
        // 补充下标 -1 位置的前缀和，键：0，不影响后面计算前缀和，值：需要记录下标，所以是 -1
        hashMap.put(0, -1);
        int remainder = 0;
        for (int i = 0; i < n; i++) {
            remainder = (remainder + nums[i]) % k;
            if (hashMap.containsKey(remainder)) {
                // 判断子数组长度是否至少为 2
                if (i - hashMap.get(remainder) >= 2) {
                    return true;
                }
            } else {
                // 注意：放在 else 中，表示记录对 k 求模取余以后第 1 次出现的下标
                hashMap.put(remainder, i);
            }
        }
        return false;
    }

}
```

**说明**：

+ 设置 `hashMap.put(0, -1)` 的作用：**补充数组在下标 -1 时的定义，这样一来，从下标 0 开始的区间和就可以通过哈希表找到**。键为 0 是显然的，「空」的和为 0，值为 -1 是因为本题关心的是连续子数组的长度，所以记录的是位置（下标）；
+ `for` 循环里写 `else` 的表示：只记录对 `k` 求模取余以后第 1 次出现的下标。区别于「力扣」第 560 题：和为 K 的子数组；
+ `i - hashMap.get(remainder)` 就是好的子数组的长度，可以用一个具体的例子带入验证。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度，只需要遍历数组一次；
+ 空间复杂度：$ O(\min(n, k)) $，主要用于存储哈希表，哈希表中最多存储 $ \min(n, k) $ 个不同的余数。','20',NULL,'0523-continuous-subarray-sum','2025-06-11 08:39:04','2025-06-12 13:56:53',1,11,false,NULL,'https://leetcode.cn/problems/continuous-subarray-sum/description/',42,2,'',false,NULL,false,NULL,NULL),(176,'liweiwei1419','「力扣」第 96 题：不同的二叉搜索树（中等）','测试','动态规划',NULL,NULL,'2025-06-11 09:58:41','2025-06-11 09:58:41',0,1,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(39,'liweiwei1419','第 15 章 动态规划：其实就是表格法','',NULL,NULL,'dynamic-programming','2025-06-09 12:18:02','2025-06-09 12:18:02',0,1,false,NULL,NULL,22,2,'',true,NULL,false,NULL,'动态规划其实还是空间换时间。动态规划的使用前提：重复子问题、最优子结构。状态定义技巧：固定信息与升维。'),(133,'liweiwei1419','「力扣」第 316 题：去除重复字母（中等）','## 题意分析
首先我们解释什么叫「返回的结果最小」，它的意思是：字典树最小。字典序的比较规则是：从字符串的起始位置开始逐字符比较 ASCII 码值，ASCII 码值小的字符字典序小。例如，`abc` 的字典序小于 `acb`。特别地，升序字符串（在字符种类、对应字符个数相等的所有字符串中）的字典序最小。

本题要求我们：返回没有重复字符的字符串，字符保持了它在原字符串中的顺序，且字典序最小。

## 思路分析
根据题意，如果一个字符的字典序比它前面的字符小，并且 **前面的字符在后面还会再次出现**，那么可以移除前面的字符，这是因为 **选择后面的字符可以得到更小的字典序**。例如「示例 1」`s = "bcabc"`： `''a''` 在只出现一次，它 **必须被选取**。有两个 `''b''` 应该如何选取呢？由于每个字母只允许出现 1 次，又必须 **保持它在原始字符串中位置**，因此 **选取 **`a`** 后面的字符 **`b`** 会使得字典序更小** 。同理，有两个相同的字符 `''c''` ，选后一个，输出 `abc`。

得到 `abc` 的过程是这样的：从左向右依次读 `''b''` 和 `''c''` ，发现字典序是递增的，递增的情况下字典序最小，所以它们都留下。直到看到 `''a''`：

+ `''a''` 比最近看到的 `''c''` 字典序小，并且 `''c''` 后面还会出现，此时把 `''c''` 删掉，拿掉以后的字符是 `''b''` ；
+ 同理，`''a''` 比最早看到的 `''b''` 字典序小，并且 `''b''` 后面还会出现，此时把 `''b''` 删掉；
+ `''c''` 后看到，先删掉，符合「后进先出」的顺序，所以使用栈。

综上所述，一个字符被删掉的逻辑是这样的：**后面有字典序更小的字符，且「自己」还会出现**。

接下来还有一种特殊的情况，我们用「示例 2」`s = "cbacdcbc"` 为大家讲解，重点在第 6 步和第 8 步，如下图所示：

![image.png](https://minio.dance8.fun/algo-crazy/0316-remove-duplicate-letters/temp-image7597102530644897797.png)


+ 第 1 步：读到 `''c''`，入栈，此时栈为 `[c]`；
+ 第 2 步：读到 `''b''`，`''b''` 的字典序比栈顶 `''c''` 小，`''c''` 以后还会出现，因此 `''c''` 出栈，`''b''` 入栈，此时栈为 `[b]`；
+ 第 3 步：读到 `''a''`，`''a''` 的字典序比栈顶 `''b''` 小，`''b''` 以后还会出现，因此 `''b''` 出栈，`''a''` 入栈，此时栈为 `[a]`；
+ 第 4 步：读到 `''c''`，`''c''` 的字典序比栈顶 `''a''` 大，`''c''` 入栈，此时栈为 `[a, c]`；
+ 第 5 步：读到 `''d''`，`''d''` 的字典序比栈顶 `''d''` 大，`''d''` 入栈，此时栈中元素 `[a, c, d]`；
+ 第 6 步：读到 `''c''`，**此时栈中已经有 `''c''`，题目要求不能有重复字符，所以舍弃当前看到的 `''c''`**，注意：如果当前遍历到栈中已经有的字符，可以舍弃当前遍历到的重复字符。这里的原因暂时还不那么明显，我们放在第 8 步说；
+ 第 7 步：读到 `''b''`，`''b''` 的字典序比栈顶 `''d''` 小，并且后面不会再出现 `''d''` ，因此 `''b''` 就应该放在这里，`''b''` 入栈，此时栈为 `[a, c, d, b]`；
+ 第 8 步：读到 `''c''`，和第 6 步一样，舍弃它。

下面我们证明：当遍历到当前字符已在栈中存在时，应当直接舍弃当前字符。

+ 理想情况下，栈保持完全单调递增（如 `[a, b, c]`），但实际栈可能呈现 **分段单调递增**（如 `[a, c, d, b]` 可分为 `[a, c, d]` 和 `[b]` 两段），分段现象是由于某些字符（如本例中的 `d`）后续不再出现，必须保留其当前位置。而已存在的字符必然位于某个单调段中；
+ 若舍弃旧字符选择新字符：**会导致该单调段的下一个更大字符前移**（如舍弃第一个 `c` 会让 `d` 前移），使得整体上字典序靠后，因此必须保留栈中现有字符，舍弃新遍历到的重复字符。

对应「示例 2」第 8 步，此时栈状态为 `[a, c, d, b]` 时遇到第二个 `''c''`：

+ 栈中已有 `''c''`，位于 `[a, c, d]` 单调段；
+ 若替换第一个 `''c''`，弹出 `c` 后，`d` 将前移，形成 `[a, d, b]`，字典序 `adbc` 较 `acdb` 靠后，因此必须舍弃新看到的 `''c''`，保持栈现状。

综上所述，除了栈，我们还需要：

+ 记录每个字母最后一次出现的位置，用于判断某个字母以后还会不会出现；
+ 记录已读到字母是否在栈中存在，否则需要遍历栈中元素，时间复杂度增加。

由于「提示」第 2 点说「`s` 由小写英文字母组成」，记录以上两个信息都可以使用数组。其它细节，我们作为注释写在了下面的「参考代码」中。

**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public String removeDuplicateLetters(String s) {
        int n = s.length();
        if (n < 2) {
            return s;
        }

        char[] charArray = s.toCharArray();
        // 记录每个字符出现的最后一个位置
        int[] lastIndex = new int[26];
        for (int i = 0; i < n; i++) {
            lastIndex[charArray[i] - ''a''] = i;
        }

        Deque<Character> stack = new ArrayDeque<>(n);
        // 记录栈中出现的字符
        boolean[] visited = new boolean[26];
        for (int i = 0; i < n; i++) {
            char currentChar = charArray[i];
            // 如果栈中已经存在，就跳过
            if (visited[currentChar - ''a'']) {
                continue;
            }
            // 在 ① 栈非空，② 当前元素字典序 < 栈顶元素，并且 ③ 栈顶元素在以后还会出现，弹出栈元素
            while (!stack.isEmpty() && currentChar < stack.peekLast() && lastIndex[stack.peekLast() - ''a''] > i) {
                char top = stack.removeLast();
                // 弹出栈顶元素的同时，需要将该元素的 visited 状态设置为 false
                visited[top - ''a''] = false;
            }
            stack.addLast(currentChar);
            visited[currentChar - ''a''] = true;
        }

        // 遍历栈，拼接字符串
        StringBuilder stringBuilder = new StringBuilder();
        for (char c : stack) {
            stringBuilder.append(c);
        }
        return stringBuilder.toString();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是字符的长度；
+ 空间复杂度：$ O(n) $ ，最坏情况下，这个字符串本身就是字典序最小的字符串，栈中就要存字符串长度这么多的字符串。

`while` 循环里，每一次弹出栈元素之前，我们都得检查栈是否非空。这里一个通常的做法是在栈里放进一个 **永远不会被弹出** 的元素，这样可以省去栈非空的判断。这里要特别注意，加入了哨兵元素以后，最后导出结果时，不要把全部元素都弹出来。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Stack;

public class Solution {

    public String removeDuplicateLetters(String s) {
        int n = s.length();
        if (n < 2) {
            return s;
        }

        char[] charArray = s.toCharArray();
        int[] lastIndex = new int[26];
        for (int i = 0; i < n; i++) {
            lastIndex[charArray[i] - ''a''] = i;
        }

        Deque<Character> stack = new ArrayDeque<>(n);
        stack.addLast(''a'');
        boolean[] visited = new boolean[26];
        for (int i = 0; i < n; i++) {
            char currentChar = charArray[i];
            if (visited[currentChar - ''a'']) {
                continue;
            }
            // 由于在一开始加入了 ''a''，此时栈一定非空
            while (currentChar < stack.peekLast() && lastIndex[stack.peekLast() - ''a''] > i) {
                char top = stack.removeLast();
                visited[top - ''a''] = false;
            }
            stack.addLast(currentChar);
            visited[currentChar - ''a''] = true;
        }

        stack.removeFirst();
        StringBuilder stringBuilder = new StringBuilder();
        for (char c : stack) {
            stringBuilder.append(c);
        }
        return stringBuilder.toString();
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
+ 如果从左向右看一直是单调递增的，就需要把它们保留，直到遇到一个字典树较小的字符，再依次把之前的字典序较大的、且以后还会出现的字符拿掉。处理字符的顺序是后进先出，所以使用栈；
+ 理解「当遍历到当前字符已在栈中存在时，应当直接舍弃当前字符」的原因：如果丢弃栈中的字符，丢弃字符以后的单调段提前，字典序比原来要靠后。','10',NULL,'0316-remove-duplicate-letters','2025-06-11 09:20:48','2025-06-15 20:26:51',1,9,false,NULL,'https://leetcode.cn/problems/remove-duplicate-letters/description/',34,7,'',false,'https://leetcode.cn/problems/remove-duplicate-letters/solutions/55044/zhan-by-liweiwei1419/',true,'完成。','符合「后进先出」规律。'),(67,'liweiwei1419','「力扣」第 509 题：斐波那契数（简单）','## 思路分析

编码的时候按照题目给出的斐波那契数列的通项公式「自顶向下」递归求解，如下「参考代码 1」所示。

**参考代码 1**：存在大量重复计算，虽然可以通过「力扣」的测评，但并不是最优解。

```java
public class Solution {

    public int fib(int n) {
        if (n < 2) {
            return n;
        }
        return fib(n - 1) + fib(n - 2);
    }
    
}
```

## 发现重复子问题
画出本题的递归树，会 **发现有很多重复的计算**，以 `F(5)` 为例，`F(3)` 计算了 2 次，`F(2)` 计算了 3 次，如下图所示。 

![](https://minio.dance8.fun/algo-crazy/0509-fibonacci-number/temp-image10373011920034269555.png)

相同的子问题在递归树中多次出现，我们称为 **重复子问题**，重复子问题是使用动态规划解决的问题的前提之一（另一个前提是最优子结构，我们将在下一节介绍），题目做多了往往能很快识别到这两个前提。如果仅以解题为目的，无需进行严格的数学证明。

为了避免重复计算，很自然地，采用空间换时间的策略，将子问题的结果存储下来，这种方法被称为「记忆化递归」。

## 记忆化递归
记忆化递归其实是很自然的做法：在递归计算的过程中，将已经计算的子问题的结果存储在一个数据结构中，当需要再次使用该子问题的结果时，直接从数据结构中获取，而不需要再次计算。这里的数据结构通常是数组或者哈希表，数组（通常是一维数组或者二维数组，少数情况下需要用到三维、四维数组）的下标通常有明确的语义：记录了某个规模的子问题的答案。

**参考代码 2**：

```java
import java.util.Arrays;

public class Solution {

    public int fib(int n) {
        if (n < 2) {
            return n;
        }

        // 0 要占一个位置，所以设置 n + 1 个位置
        int[] memo = new int[n + 1];
        memo[0] = 0;
        memo[1] = 1;
        // 还未计算过的值用 -1 表示
        Arrays.fill(memo, -1);
        return fib(n, memo);
    }

    public int fib(int n, int[] memo) {
        if (n < 2) {
            return n;
        }
        if (memo[n] == -1) {
            memo[n] = fib(n - 1) + fib(n - 2);
        }
        return memo[n];
    }

}
```

**说明**：`memo` 是 `memoization` 的缩写，中文通常翻译为「记忆化」或「备忘录」。

## 动态规划：自底向上求解
记忆化递归其实还是自顶向下的思想：把一个大问题拆分成若干个小问题，先求解小问题，组合小问题的解，得到大问题的解。其实这一类问题还可以自底向上求解：从最小的子问题开始，逐步得到更大问题的解，并通过存储子问题的结果（和自顶向下一样，都要记录子问题的结果）避免重复计算，直到得到原问题的解。相比递归的「从上往下分解」，「从下往上构建」更直观，可以少写一些代码（不用编写递归函数），而且有些时候可以优化空间开销。

通过自底向上求解具有重复子问题特点的问题的方法，称为「动态规划」。

**参考代码 3**：

```java
public class Solution {

   
    public int fib(int n) {
        if (n < 2) {
            return n;
        }
        int[] dp = new int[n + 1];

        dp[0] = 0;
        dp[1] = 1;
        for (int i = 2; i < n + 1; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        return dp[n];
    }

}
```

**说明**：`dp` 是 `Dynamic Programming` 的缩写。通常自顶向下的记忆化递归使用的数组（或者其它数据结构）命名为 `memo`，自底向上的动态规划使用的数组命名为 `dp`。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度；
+ 空间复杂度：$ O(n) $。

很多时候，我们对自顶向下和自底向上并不区分，都称为动态规划。其实光看代码，含义就很明确了：

+ 递归 + 记录子问题的结果，是记忆化递归；
+ 像「填表」一样递推，是动态规划。


!!! danger 

**下面是两个形象的比喻：**

+ **「自顶向下」的「记忆化递归」就像是我们绝大多数人的学习路径：面对问题本身求解，遇到不会的地方记下来，以后再遇到，就不需要重新学习了；**
+ **「自底向上」的「动态规划」，就像沿着一条精心设计的路径，循序渐进，从最基础的子问题出发，逐步解决规模更大的问题。在这个过程中，每个新问题都能拆解成我们已经解决过的问题，直至原问题得到解决。**

!!!



虽然记忆化递归也叫动态规划，但如果一个问题既能记忆化递归也能动态规划，**我们绝大多数情况下都写成自底向上的动态规划**。「填表」更有动态规划的味道，大家写多了，就会更习惯递推方式的动态规划，这一点并不绝对，大家现在有个印象就好，记忆化递归也是动态规划。

我们向大家介绍的动态规划问题也全都采用填表的方式，感兴趣的朋友可以自己使用记忆化递归实现。下面我们介绍动态规划中的两个重要概念：状态和状态转移方程。

# 状态与状态转移方程
在动态规划问题中，我们经常会用到两个概念：状态与状态转移方程。其实这两个概念很简单：

+ **状态：子问题的定义**。就像我们编写递归函数，要明确递归函数的定义（参数与返回值的含义）一样。

说到定义这件事，一般来说需要具体问题具体处理，所以需要一定的经验，大家见过了一些经典问题以后就有思路了。值得说明的一点是：状态的定义一定要很准确（我们在《循环不变量》章节和大家介绍过定义准确的重要性），很多时候状态的定义从问题中可以看出来，有一些问题状态定义可能不是题目中问的问题，但一定和题目问的问题相关，这一点我们遇到了对应的问题再和大家解释。

+ **状态转移方程：描述了不同规模子问题之间的关系**，也就是小规模的问题的解如何组成较大规模的问题的解。

!!! info 阅读提示

状态和状态转移方程其实就是给了学术化的名词而已。专有名词的出现主要是为了方便大家交流，希望大家不要有畏难情绪，一开始不熟悉的时候，可以把它们转换成自己熟悉的表述去理解就好。

!!! 

对于斐波拉契数列问题：

+ 状态： `dp[i]` 表示斐波那契数列的第 `i` 项的值（`i` 从 0 开始），初始的时候 `dp[0] = 0`， `dp[1] = 1`；
+ 状态转移方程：根据斐波拉契数列的通项公式，`dp[n] = dp[n - 1] + dp[n - 2]`。

为了增强可读性，我们会将状态作为注释写在代码中，而状态转移方程在代码中就能看出来。

# 其它细节：优化空间
在动态规划问题中，我们通常使用数组等数据结构来存储各个状态的值。然而，随着问题规模的扩大，这些数据结构可能会占用大量内存空间。一些问题有优化空间的可能：通过重复利用已使用的空间，我们可以显著减少内存消耗。这种方法在状态转移仅依赖于有限的前几个状态时尤为有效，从而在不影响算法正确性的前提下，实现空间效率的提升。

优化空间就只有一个思路：**重复使用不再使用的空间**。常见的方法有：滚动数组和滚动变量。当状态转移只依赖于前面有限个状态时，通过不断更新数组中的值来模拟（未优化空间时）状态的转移，而不是为每个状态都开辟新的空间。

本节例题，优化空间的代码如下。

**参考代码 4**：

```java
public class Solution {

    public int fib(int n) {
        if (n < 2) {
            return n;
        }
        int a = 0;
        int b = 1;
        // 最新计算的值
        int c = 0;
        for (int i = 2; i < n + 1; i++) {
            // 新值计算出来以后
            c = a + b;
            // 旧值依次被覆盖，注意顺序：最老的变量先被覆盖
            a = b;
            b = c;
        }
        return c;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $；
+ 空间复杂度：$ O(1) $。

如果采用自顶向下的记忆化递归，子问题的计算顺序不可控，通常需要保留所有的子问题的结果。很多时候，自底向上的动态规划，问题的计算顺序有迹可循，因此可以重复使用不再使用的空间。但我们绝对不是只是为了节约空间而使用自底向上的动态规划，**自底向上体现了子问题的计算顺序**：**每个子问题的解都仅依赖于已计算过的更小规模的子问题**，这是记忆化递归难以直接体现的优势，大家问题做得多了，也许会更习惯自底向上的动态规划写法。

**空间优化在绝大多数情况下，并非必须，由读者自行决定**。

# 对于优化空间的说明
一般而言，在判题系统上做题，甚至是笔试面试中，只需要做到时间复杂度最优。

我们之前和大家提到过：绝大多数情况下，空间复杂度和时间复杂度不能达到同时最优，一般用空间换时间。但凡事都有例外，如果遇到对空间利用有要求的问题，我们再优化空间。

我们说一下优化空间可能会带来的「副作用」：

+ 优化空间 **通常会改变状态的存储方式和计算顺序**，容易引入错误。例如，在使用滚动数组时，要确保状态转移方程的应用顺序和边界条件的处理符合优化后的逻辑；
+ 优化空间虽然可以减少内存占用，但有时 **可能会对时间消耗有一定的影响**。例如，在使用滚动数组时，可能需要额外的计算步骤（计算当前是奇数行还是偶数行，保存上一行被覆盖的若干状态值）来维护状态的正确更新；
+ 优化空间后的 **代码丢失了语义**。优化空间后，很难看出和描述状态定义是什么，在初学的时候，看题解或者他人的代码，如果直接看到空间优化的代码，会比较困惑。此时应该去题解区或者评论区找找未空间优化的代码，进而理解状态以及状态转移方程。

实现优化空间的代码有时候并不容易一次写对，因为它本质上是对原始动态规划过程的「跳步」：省略了中间状态的显式存储，直接通过复用空间来完成状态转移。这种跳步虽然能降低空间复杂度，但也增加了代码的复杂性和调试难度，因此需要更谨慎地处理状态依赖关系，确保逻辑的正确性。针对具体问题，是否需要优化空间，由大家自己决定。

# 动态规划问题的特点
动态规划问题在问法上通常具有一个显著特征：它往往只关注最优值本身，而不涉及最优解的具体构造过程或所有可能的求解路径。如果问题只问我们最优值是多少，而不需要我们得到最优值是怎么来的，这样的问题有可能是使用动态规划解决的（当然也有可能是其它算法或者数据结构，例如求最短、最少，还可以考虑是不是可以用 BFS，我们是想说：动态规划通常只记录最值，以便于状态转移，得到不同规模的子问题的答案）。

动态规划的核心思想是通过存储子问题的解（即用状态变量记录每个子问题的最优值）来避免重复计算，从而提升效率。在这一过程中，我们仅保存子问题的汇总结果（如最大值、最小值或计数），而不会记录达成该结果的具体步骤或所有可能路径。通俗一点说，就是在状态转移的过程中，很多信息被「吃」掉了。

若需要进一步获取最优解的具体构造方法（通常也仅要求给出一种可行方案），我们需要逆向回溯状态转移过程得到，而非枚举所有可能的最优解。这种设计源于动态规划表的本质——它存储的是状态转移的结果，而非完整的决策历史。

# 总结
+ 本节我们通过「斐波拉契数列」问题，介绍了使用动态规划解决的问题的前提之一：重复子问题。即在递归求解的时候，会遇到相同的子问题，这些子问题没有必要重复求解：
    - 此时可以使用记忆化递归，即「递归 + 哈希表（或数组）」记录子问题的解；
    - 也可以通过递推的方式，从最基础的问题开始，一步一步使得原问题得到解决，迭代的方式，看起来就像填表一样，我们称为动态规划。其实，记忆化递归也称为动态规划。
+ **「动态规划」其实还是「拆分问题」与「组合子问题的解」，只不过它不像「分治算法」，「分治算法」拆分出来的子问题没有重复和交集，所以可以借助程序的递归调用栈记录子问题的结果，而不用我们编程干预**；
+ 状态和状态转移方程其实就是「子问题的定义」和「子问题之间的联系」的代名词，为了方便交流和提出的概念；
+ 最后我们指出了：
    - 动态规划问题的问法通常只问最优值，不问决策过程（最优值是怎么来的）；
    - 很多问题还可以优化空间，优化空间本质上就是重复使用不再使用的空间，但优化空间很多时候没有必要，是否优化空间需要具体问题具体分析，取决于编码者。
+ 只要大家充分理解了提出算法的由来，解决的过程和思路其实非常自然。对动态规划的理解可以是这样：
    - 有重复子问题，所以递归求解需要记录答案；
    - 记录答案可以从最小规模的问题开始，逐步递推得到更大规模的问题的答案，直至原问题得到解决。

如何定义子问题其实有一定的规律，我们会在本章后面介绍。

# 练习
+ 「力扣」第 70 题：爬楼梯（简单），题目链接：[https://leetcode.cn/problems/climbing-stairs/](https://leetcode.cn/problems/climbing-stairs/)

**说明**：本题可以当做例题学习，只是斐波拉契数列套了个壳而已。','17',NULL,'0509-fibonacci-number','2025-06-11 08:12:31','2025-06-18 17:04:02',0,44,false,NULL,'https://leetcode.cn/problems/fibonacci-number/description/',39,1,'',false,NULL,true,'完成。',NULL),(35,'liweiwei1419','第 11 章 优先队列：建立在数组上的树结构','',NULL,NULL,'priority-queue','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,4,'',true,NULL,true,NULL,'应用于动态查找最优值，建立在数组上的树形结构，只维护局部最优值，将复杂度降低到对数级别。'),(134,'liweiwei1419','「力扣」第 622 题：设计循环队列（中等）','## 思路分析

本题要我们实现循环队列是这个意思：其实还是实现队列，需要我们实现 `isFull()` 方法，并且要求是「检查循环队列是否已满」。

我们知道数组和链表都可以实现队列，但链表不需要像数组那样，一开始就确定好元素总数，用链表实现的队列其实没有总数的限制。因此本题要我们实现的循环队列特指用数组实现的队列，只不过队列中的真实元素在数组上是循环出现的，其核心机制是通过两个指针变量来维护队列状态，使得入队和出队操作都能在常数时间 $ O(1) $ 内完成：

+ `front` 指针：指向队列首元素的实际存储位置，从队首出队；
+ `rear` 指针：指向下一个可插入位置（队列尾端元素的下一位），从队尾入队。

初始状态下，`front == rear` 表示空队列。数据存储区间遵循 `[front..rear)` 的左闭右开原则，队列元素在底层数组中 **以循环滑动的方式** 移动。

具体操作流程：

+ 入队操作：先将新元素写入 `rear` 指向的位置，然后循环移动 `rear = (rear + 1) % capacity`；
+ 出队操作：先读取 `front` 指向的元素，然后循环移动 `front = (front + 1) % capacity`。

## 示例演示
+ **队列初始化状态**：初始时，`front` 和 `rear` 指针重合，表示队列为空，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image6824473952617454152.png)

+ **入队操作**：依次添加元素 12、3、5、8、11。每次操作时，先将元素赋值到 `rear` 位置，再将 `rear` 右移，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image5609456498135558400.png)

+ **出队操作**：连续出队两个元素 12 和 3。操作时先读取 `front` 位置的元素，再将 `front` 右移。原位置（下标 0 和 1）可被后续入队操作覆盖，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image14050081596479198430.png)

+ **队列循环利用**：继续入队元素 20 和 4 后，`rear` 到达数组末尾。

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image13564447511885418434.png)

此时若再将 22 入队，`rear` 会循环至数组头部，如下图所示，实现空间复用。

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image1147133633056650862.png)

+ **队列满判定（重点）**： 23 入队后，**队列达到「满」状态**，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0622-design-circular-queue/temp-image15236138824930833321.png)

这是因为：此时若 `rear` 再右移一步将与 `front` 重合，**为避免与空队列条件（**`**front == rear**`**）冲突，我们选择故意浪费一个空间，以 **`**(rear + 1) % capacity == front**`** 作为队列满的判定条件**。

**代码实现细节**：

+ 在入队的时候需要保证队列不是满的，在出队和读取元素的时候，需要保证队列不是空的；
+ 以 `(rear + 1) % capacity == front` 作为队列满的判定条件，假设队列的容量是 `capacity` ，底层数组需要开辟 `capacity + 1` 个空间；
+ 在涉及下标 `+1` 或 `-1` 的操作时，为了避免数组越界，可以使用模运算（`%`）自动循环调整，利用 `(index ± 1 + capacity) % capacity` 让指针在数组范围内循环移动，避免判断边界。

**参考代码**：

```java
public class MyCircularQueue {

    private int[] arr;

    private int capacity;

    // front 指向当前队列中最早入队的元素
    private int front;

    // rear 指向下一个添加到队尾的元素
    private int rear;

    public MyCircularQueue(int k) {
        // 始终保持 1 个位置不存有效元素，是为了避免判断队列为空和队列为满的条件冲突
        capacity = k + 1;
        arr = new int[capacity];
        front = 0;
        rear = 0;
    }

    public boolean enQueue(int value) {
        // 队尾为满不可以入队
        if (isFull()) {
            return false;
        }
        arr[rear] = value;
        rear = (rear + 1) % capacity;
        return true;
    }

    public boolean deQueue() {
        // 队尾为空不可以出队
        if (isEmpty()) {
            return false;
        }
        front = (front + 1) % capacity;
        return true;
    }

    public int Front() {
        // 队列非空才可以取出队头
        if (isEmpty()) {
            return -1;
        }
        return arr[front];
    }

    public int Rear() {
        // 队列非空才可以取出队尾
        if (isEmpty()) {
            return -1;
        }
        // 有数组下标的计算一定要考虑是否越界
        return arr[(rear - 1 + capacity) % capacity];
    }

    public boolean isEmpty() {
        return front == rear;
    }

    public boolean isFull() {
        // 有数组下标的计算一定要考虑是否越界
        return (rear + 1) % capacity == front;
    }

}
```

**复杂度分析**：

+ 时间复杂度：每一个方法都使用有限次操作完成，时间复杂度为 $ O(1) $；
+ 空间复杂度：$ O(k) $，这里 $k$ 为队列的容量。



## 本题总结

本题考查了使用数组实现的队列，使用数组可以不用像队列那样频繁地创建结点和销毁结点，缺点就是容量有限制。我们使用数据在数组上循环出现的方式实现了队列。

为了避免队列判空与判满的冲突，我们约定队列满的条件为 `(rear + 1) % capacity == front`。

实际应用中，部分高性能队列（如 `ArrayBlockingQueue`）也采用固定容量，队列满时通过拒绝策略（如抛异常或阻塞）处理新任务。可参考 Java 标准库中的 `Queue` 实现类（如 `ArrayDeque` 或 `LinkedBlockingQueue`），其类名通常反映了底层实现机制（数组或链表）。','11',NULL,'0622-design-circular-queue','2025-06-11 09:20:48','2025-06-15 19:31:58',1,10,false,NULL,'https://leetcode.cn/problems/design-circular-queue/description/',34,8,'',false,'https://leetcode.cn/problems/design-circular-queue/solutions/56619/shu-zu-shi-xian-de-xun-huan-dui-lie-by-liweiwei141/',true,'完成。','有效数据在数组中循环利用。'),(37,'liweiwei1419','第 13 章 哈希表：其实就是数组，快速查找与去重的利器','',NULL,NULL,'hash-table','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,6,'',true,NULL,true,NULL,'查找表数据结构的另一种总实现。思想：空间换时间。哈希函数解决了所有对象映射到整数的问题。'),(136,'liweiwei1419','「力扣」第 232 题：用栈实现队列（中等）','## 思路分析

这道题要求我们用栈实现队列。用栈实现队列，或者用队列实现栈，肯定不是高效的做法，本题通过「逆来顺受」的方式，考查对栈和队列操作理解。

栈是后进先出的数据结构。如果我们对「后进先出」应用两次，即「后进先出」再「后进先出」，就变成了「先进先出」，这种思维方式类似于数学中的「负负得正」。基于这样的逻辑，需要使用两个栈：

+ 元素入队时，总是将数据压入「原始栈」，该栈用于入队，下面称为 `pushStack`；
+ 元素出队时，则从「辅助栈」中进行出队操作，该栈用于出队，下面称为 `popStack`。

如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749855306-KOoXYv-image.png)

**编码细节**：`pop()` 或者 `peek()` 的时候：

+ 如果 `popStack` 非空，直接从 `popStack` 里 `pop` 或者 `peek` 元素；
+ 如果 `popStack` 为空，需要 **一次性** 将 `pushStack` 里面的 **所有** 元素加入 `popStack`。

**注意**： 

+ `pop` 或者 `peek` 元素的时候，一定要判断 `popStack` 是否为空；
+ `popStack` 为空的时候，才能把元素从 `pushStack` 里拿到 `stackPop` 中。如果 `popStack`  里还有元素，从 `pushStack` 里出栈的那个元素就会成为 `stackPop` 的新栈顶元素，就 **打乱了出队的顺序**。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class MyQueue {

    private Deque<Integer> pushStack;
    private Deque<Integer> popStack;

    public MyQueue() {
        pushStack = new ArrayDeque<>();
        popStack = new ArrayDeque<>();
    }

    public void push(int x) {
        // 在任何时候都可以向 pushStack 加入元素
        pushStack.addLast(x);
    }

    public int pop() {
        // 从 popStack 取出元素
        if (!popStack.isEmpty()) {
            return popStack. removeLast();
        }
        // 走到这里是因为 popStack 为空，此时需要将 pushStack 里的所有元素依次放入 popStack
        while (!pushStack.isEmpty()) {
            popStack.addLast(pushStack.removeLast());
        }
        return popStack.removeLast();
    }

    public int peek() {
        // 从 popStack 取出元素
        if (!popStack.isEmpty()) {
            return popStack.peekLast();
        }
        // 走到这里是因为 popStack 为空，此时需要将 pushStack 里的所有元素依次放入 popStack
        while (!pushStack.isEmpty()) {
            popStack.addLast(pushStack.removeLast());
        }
        return popStack.peekLast();
    }

    public boolean empty() {
        // 两个栈都为空，才说明队列为空
        return pushStack.isEmpty() && popStack.isEmpty();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1) $，这里用到「均摊复杂度」分析，的确会有一些操作很耗时，但平均下来，每一个元素进、出 `pushStack` 一次，进、出 `popStack` 一次（最坏的情况不会一直发生，可以均摊到其它操作上），因此时间复杂度仍为 $ O(1) $；
+ 空间复杂度：$ O(n) $，这里 $ n $ 是输入数据的长度。

','11',NULL,'0232-implement-queue-using-stacks','2025-06-11 09:20:48','2025-06-14 06:56:04',1,8,false,NULL,'https://leetcode.cn/problems/implement-queue-using-stacks/description/',34,10,'',false,'https://leetcode.cn/problems/implement-queue-using-stacks/solutions/54448/shi-yong-liang-ge-zhan-yi-ge-zhuan-men-ru-dui-yi-g/',true,'完成。','挺没意思的问题，两次后进先出即先进先出。'),(34,'liweiwei1419','第 10 章 栈与队列：LIFO 和 FIFO 的经典应用','',NULL,NULL,'stack-queue','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,3,'',true,NULL,true,NULL,'后进先出使用栈，按照顺序处理使用队列。'),(138,'liweiwei1419','「力扣」第 239 题：滑动窗口的最大值（困难）','## 思路分析

**暴力解法**：最直观的方法是对于每个窗口，遍历其中的所有元素，找到最大值。对于一个长度为 `n` 的数组，共有 `n - k + 1` 个窗口，每个窗口需要 $ O(k) $ 的时间找到最大值，因此总的时间复杂度为 $ O((n - k + 1) * k) = O(nk) $。对于较大的 `n` 和 `k`，这显然效率不高。

**优化思路**：避免重复计算，就需要记住之前看到的数，即空间换时间，选什么数据结构呢？

容易想到的数据结构是优先队列：使用最大堆，堆顶元素即为当前窗口的最大值。但当窗口滑动时，需要移除离开窗口的元素，而通常的优先队列并不支持删除非最值元素，有一种优先队列叫做索引堆，支持根据索引位置修改元素的值，进而选出最值，符合本题的应用场景，但索引堆属于超纲内容，且还需要自己编码实现。

注意到这样的例子，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848565-kvVYDv-image.png)


**如果新看到的数比之前的数还大（严格大于），那么之前较小的数就不可能成为当前滑动窗口的最大值**，因此可以提前把它们删除，删除它们的顺序是后看到的先删除，这是栈的特点，按照这样的规则，「栈底」元素是滑动窗口的最大值，但我们还需要在滑动窗口的左边界不得不移出的时候把「栈底」删除，因此需要一个支持删除「栈底」的「栈」（加引号是因为此时已经不是栈了），所以我们需要的数据结构是双端队列。

**提示**：对于线性数据结构，如果不是很清楚应该使用栈还是使用队列的时候，可以构造一个单调的示例进行分析，得出是后进先出还是先进先出，本题后进先出和先进先出都需要，所以是双端队列。

## 示例演示
我们使用题目中的示例向大家展示双端队列如何维护滑动窗口的最大值，以下双端队列均简称为队列。

+ 第 1 步：程序看到 1。这时还未形成长度为 3 的窗口，右边界右移 1 格，将 1 从队尾加入队列，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848573-NTOEpg-image.png)


+ 第 2 步：程序看到 3。这时还未形成长度为 3 的窗口，但 3 > 1，**有 3 的存在，1 一定不是现在和以后的滑动窗口的最大值**，所以先将 1 从队尾删除，然后把 3 加入队列，再将滑动窗口的右边界右移 1 格，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848578-EwRlpT-image.png)


+ 第 3 步：程序看到 -1。-1 < 3 ，当 3 到达滑动窗口的左边界而不得不滑出的时候，-1 有可能成为滑动窗口的最大值，因此把 -1 加入队列，当前滑动窗口的最大值在队列的队首，值为 3 ，队列中的数据为：`[3, -1]`，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848586-ixmqGW-image.png)


+ 第 4 步：程序看到 -3。这时 -3 比队列中最近添加的元素 -1 还小，当 3 和 -1 由于到达滑动窗口的左边界而不得不滑出的时候，-3 有可能成为滑动窗口的最大值，因此 -3 需要加入队列，队列中的数据为 `[3, -1, -3]`，当前滑动窗口的最大值在队首，值为 3，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848592-EnHqGM-image.png)


+ 第 5 步：程序看到 5。这时 3 不得不从滑动窗口的左边界滑出，3 从队首出队。又因为 5 > -3，有 5 在右侧，**-3 一定不是现在和以后的滑动窗口的最大值**，把 -3 从队尾删除，此时队列为 `[-1]`。同理，因为 5 > -1，有 5 在右侧， **-1 一定不是现在和以后的滑动窗口的最大值**，把 - 1 从队尾删除，此时队列为 `[5]`，当前滑动窗口的最大值为 5，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848597-iIWTTv-image.png)


+ 第 6 步：程序看到 3。3 < 5，当 5 由于到达滑动窗口的左边界而不得不滑出的时候，3 有可能成为滑动窗口的最大值，因此需要将 3 加入队列，此时队列为 `[5, 3]`，当前滑动窗口的最大值为 5，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848604-JmgdIP-image.png)


+ 第 7 步：程序看到 6。6 > 3，有 6 在右侧，3 一定不是现在和以后的滑动窗口的最大值，把 3 从队尾删除，此时队列为 `[5]`。同理，6 > 5 ，有 6 在右侧，5 一定不是现在和以后的滑动窗口的最大值，把 5 从队尾删除，接着把 6 加入队列，此时队列为 `[6]`。当前滑动窗口的最大值为  6，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848609-wjZMbY-image.png)


+ 第 8 步：程序看到 7。7 > 5 ，有 7 在右侧，6 一定不是现在和以后的滑动窗口的最大值，把 6 从队尾删除，把 7 加入队列，此时队列为 `[7]`。当前滑动窗口的最大值为 7，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749848616-YXnaLP-image.png)


经过以上的步骤，我们得到滑动窗口的最大值是 `[3, 3, 5, 5, 6, 7]`。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Deque;

public class Solution {

    public int[] maxSlidingWindow(int[] nums, int k) {
        int len = nums.length;
        int[] res = new int[len - k + 1];

        Deque<Integer> deque = new ArrayDeque<>(len - k + 1);
        for (int i = 0; i < len; i++) {
            // 判断队首元素是否移出滑动窗口
            if (i >= k && !deque.isEmpty() && deque.peekFirst() == i - k) {
                deque.removeFirst();
            }

            // 依次判断待添加元素是否比队首元素大，注意可以取等号
            while (!deque.isEmpty() && nums[deque.peekLast()] <= nums[i]) {
                deque.removeLast();
            }

            // 加入队列的是下标
            deque.addLast(i);
            if (i >= k - 1) {
                res[i - k + 1] = nums[deque.peekFirst()];
            }
        }
        return res;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(n) $。

## 本题总结
本题中采用的队列需要支持以下关键操作：

+ **队首访问**：队首元素的值，是当前滑动窗口的最大值；
+ **队首移除**：当窗口右移时，需移出超出左边界的过期元素；
+ **队尾维护**：新元素入队前，从队尾移除所有比它小的元素，这些元素后续不可能成为最大值，将可能成为未来窗口最大值的元素加入队尾。

因此我们需要一个双端队列，这种操作规则恰好形成从队首到队尾单调不增的特性，有些资料称此时的队列为「单调队列」。需要大家注意的是：**单调性是我们设计的逻辑的自然结果而非设计前提，即我们不维护单调性。分析出既要满足后进先出，还要满足移出「栈底」元素栈，才使用双端队列是本题的关键**。

','11',NULL,'0239-sliding-window-maximum','2025-06-11 09:20:48','2025-06-14 05:46:13',1,10,false,NULL,'https://leetcode.cn/problems/sliding-window-maximum/description/',34,12,'',false,'https://leetcode.cn/problems/sliding-window-maximum/solutions/13440/zui-da-suo-yin-dui-shuang-duan-dui-lie-cun-suo-yin/',true,'完成。','新来的较大的值使得旧的更小的值永远不可能成为最大值，旧的更小的值可以提前拿掉。'),(32,'liweiwei1419','第 9 章 链表：动态数据结构基础','',NULL,NULL,'linked-list','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,2,'',true,NULL,true,NULL,'线性结构，其元素在物理上不连续存放，查找慢，增删快。'),(41,'liweiwei1419','第 17 章 广度优先遍历与拓扑排序：层级遍历与依赖解析','',NULL,NULL,'breadth-first-search','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,23,1,'',true,NULL,true,NULL,'广度优先遍历像水波纹，逐层扩散。'),(4,'liweiwei1419','「力扣」第 215 题：数组第 k 大的元素（中等）','## 思路分析

本题是经典的「TopK 问题」，典型的解法有快速选择和优先队列。其实快速选择就是根据快速排序分区 (`partition`）操作的返回值应用于本题，起了个名字叫「快速选择」，如果大家熟悉 `partition` 操作，很容易写出代码。

题目要求：找出数组排序后第 `k` 个最大的元素（注意是第 `k` 个最大元素而非第 `k` 个不同元素）。在排序后的数组中：从右往左数是第 `k` 个元素（`k` 从 1 开始），从左往右数是第 `n - k` 个元素（`n` 为数组长度）。

快速选择算法的核心在于利用「快速排序」的分区操作：

+ `partition` ：对区间 `nums[left..right]` 进行 `partition` 操作后，存在下标 `j` 使得：
    - `nums[j]` 已处于最终排序位置；
    - `nums[left..j - 1] ≤ nums[j]`；
    - `nums[j + 1..right] ≥ nums[j]`。

对比题目要求和 `partition`，我们可以根据 `partition` 的返回值 `j` 与目标位置 `n - k` 的关系决定搜索方向：

+ 若 `j == n - k`：找到第 `k` 大元素；
+ 若 `j < n - k`：在右半区继续搜索；
+ 若 `j > n - k`：在左半区继续搜索。

通过不断调整搜索区间边界 `left` 和 `right`，定位目标元素。

**注意事项**：

+ 必须随机选择基准元素元素（`pivot`）以避免极端测试用例导致的性能退化；
+ `partition` 有多种实现方式，经笔者测试，「力扣」的测试用例中有大量重复元素这种测试用例，因此我们选择将等于 `pivot` 的元素等概率分配到区间的头和尾这种写法。大家用三路快排的 `partition` 也是完全可以的，分类讨论的情况多一个而已。

**参考代码**：

```java
import java.util.Random;

public class Solution {

    private final static Random RANDOM = new Random(System.currentTimeMillis());

    public int findKthLargest(int[] nums, int k) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        int target = n - k;
        while (true) {
            int j = partition(nums, left, right);
            if (j == target) {
                return nums[j];
            } else if (j < target) {
                left = j + 1;
            } else {
                right = j - 1;
            }
        }
    }

    private int partition(int[] nums, int left, int right) {
        int randomIndex = left + RANDOM.nextInt(right - left + 1);
        swap(nums, left, randomIndex);
        // nums[left + 1..le) <= pivot，nums(ge..right] >= pivot;
        int pivot = nums[left];
        int le = left + 1;
        int ge = right;
        while (true) {
            while (le <= ge && nums[le] < pivot) {
                le++;
            }
            while (le <= ge && nums[ge] > pivot) {
                ge--;
            }
            if (le >= ge) {
                break;
            }
            swap(nums, le, ge);
            le++;
            ge--;
        }
        swap(nums, left, ge);
        return ge;
    }

    private void swap(int[] nums, int index1, int index2) {
        int temp = nums[index1];
        nums[index1] = nums[index2];
        nums[index2] = temp;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 `n` 是数组的长度，每次分区后，平均只需要处理一半的数组。快速选择算法的时间复杂度分析需要用到数学期望的知识，已经超出了本书的范围，感兴趣的读者朋友们可以参考《算法导论（第三版）第 9 章：中位数和顺序统计量 》的相关内容；
+ 空间复杂度：$ O(1) $，在逐渐缩小搜索区间的过程中只使用到常数个变量。

**说明**：「Top K 问题」的另一种经典的做法是使用优先队列解决，我们会放在第 11 章和大家介绍。','5',NULL,'0215-kth-largest-element-in-an-array-quick-select','2025-06-08 22:10:21','2025-06-12 14:07:48',1,11,false,NULL,'https://leetcode.cn/problems/kth-largest-element-in-an-array/description/',28,3,'',false,'https://leetcode.cn/problems/kth-largest-element-in-an-array/solutions/19607/partitionfen-er-zhi-zhi-you-xian-dui-lie-java-dai/',false,NULL,NULL),(155,'liweiwei1419','「力扣」第 136 题：只出现一次的数字（简单）','## 思路分析

本题需要使用异或（不进位加法）运算的性质：相同数字异或结果为 0，任何数与 0 的异或结果为该数本身。出现两次的元素在异或运算以后为 0，只出现一次的元素留了下来。

**参考代码**：

```java
class Solution {

    public int singleNumber(int[] nums) {
        int res = 0;
        for (int num : nums) {
            res ^= num;
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度；
+ 空间复杂度：$ O(1) $，只使用常数额外空间，符合题目要求。','22',NULL,'0136-single-number','2025-06-11 09:44:19','2025-06-12 07:54:47',1,5,false,NULL,'https://leetcode.cn/problems/single-number/description/',44,1,'',false,NULL,true,NULL,NULL),(158,'liweiwei1419','「力扣」第 268 题：丢失的数字（简单）','## 思路分析

有了前几题的铺垫，我们可以使用「异或」的性质。对一个数字进行偶数次异或，它会抵消为 0，奇数次异或则会保留该数字。将输入数组所有数和 `0` 到 `n` 全部异或一遍，就可以找到缺失的那个数字。相当于有一堆数字，只有一个数只出现一次，剩下的数均出现两次，问题转化为「力扣」第 136 题：只出现一次的数字。

**参考代码**：

```java
class Solution {

    public int missingNumber(int[] nums) {
        int res = nums.length;
        // 遍历的下标 i 正好可以利用上
        for (int i = 0; i < nums.length; i++) {
            res ^= i ^ nums[i];
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度；
+ 空间复杂度：$ O(1) $，只使用了常数个额外变量。','22',NULL,'0268-missing-number','2025-06-11 09:44:19','2025-06-12 09:11:04',1,3,false,NULL,'https://leetcode.cn/problems/missing-number/description/',44,4,'',false,NULL,true,NULL,NULL),(90,'liweiwei1419','「力扣」第 322 题：零钱兑换（中等）','## 思路分析

题目问「最少」，可以尝试使用广度优先遍历解决：将该问题转化为一个图，每个结点代表一个金额，**从一个结点到另一个结点的边（有向边）代表使用一枚硬币进行金额的转换**。以「示例 1」`coins = [1, 2, 5]`，`amount = 11` 为例，画出图如下（大家理解本题可以抽象成一个图的问题就好，不用把所有的顶点和边画出来）：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1745309391143-085df8f6-c8d9-4f1f-96b4-91c5eed26d8b.png)

**编码细节**：

+ 将目标金额 `amount` 作为起始顶点加入队列；
+ 使用数组记录已经访问过的金额，避免相同顶点重复入队；
+ 从队列中取出一个顶点的同时记录当前的步数（即使用的硬币数量）。遍历硬币数组，尝试用每一枚硬币去减少当前金额。如果得到的新金额未被访问过且大于等于 0，则将其加入队列，并标记为已访问；
+ 当剩余金额 `remaining` 为 0 时，返回当前步数；如果队列为空仍未使得剩余金额为 0，则返回 -1。

**参考代码**：

```java
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

public class Solution {

    public int coinChange(int[] coins, int amount) {
        if (amount == 0) {
            return 0;
        }
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[amount + 1];
        visited[amount] = true;
        queue.offer(amount);
        // 这里排序，在对硬币面值的遍历的时候，遇到 next < 0，可以提前结束内层循环
        Arrays.sort(coins);
        int step = 0;
        while (!queue.isEmpty()) {
            step++;
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                Integer current = queue.poll();
                for (int coin : coins) {
                    int remaining = current - coin;
                    if (remaining == 0) {
                        // 剩余金额为 0，表示找到了最短路径
                        return step;
                    }
                    if (remaining < 0) {
                        // 由于 coins 升序排序，后面的面值会越来越大，退出内层循环
                        break;
                    }
                    if (!visited[remaining]) {
                        // 添加到队列的时候，应该立即设置为已访问，否则相同元素会重复入队
                        queue.offer(remaining);
                        visited[remaining] = true;
                    }
                }
            }
        }
        // 进入队列的顶点都出队，都没有使得剩余金额 0，表示凑不出硬币
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(amount \times n) $，其中 `amount` 是目标金额，`n` 是硬币的种类数。在最坏情况下，需要遍历所有可能的金额，并且对于每个金额，需要尝试所有的硬币；
+ 空间复杂度：$ O(amount) $，主要用于存储队列和访问集合。在最坏情况下，队列和访问集合需要存储所有可能的金额。

','19',NULL,'0322-coin-change','2025-06-11 08:36:18','2025-06-16 14:52:58',1,28,false,NULL,'https://leetcode.cn/problems/coin-change/description/',41,3,'',false,NULL,true,NULL,'8888888'),(13,'liweiwei1419','「力扣」第 300 题：最长递增子序列（中等）','!!! info 阅读提示
本题是动态规划的经典问题之一。其中时间复杂度为 $ O(n \log n) $ 的解法需要一定的技巧，通常作为拓展思路的范例，理解其状态设计和优化思想即可，大家不必为「难以独立想到」而困扰。
!!!

## 思路分析
本题中，子序列并不要求这些数在数组中连续，只要求保持相对顺序不变。根据「例 3」可知：「上升」是严格上升。线性问题的状态定义通常是「以 `nums[i]` 结尾」，这样设计使得不同下标的状态之间的联系（即状态转移方程）容易找到。

+ **状态定义**：`dp[i]` 表示以 `nums[i]` 结尾的最长递增子序列的长度；
+ **状态转移方程**：对于每个 `nums[i]`，遍历它之前的所有元素 `nums[j]`（其中 `j < i`)，如果 `nums[i] > nums[j]`，则 `dp[i] = max(dp[i], dp[j] + 1)`；
+ **考虑初始值**：`dp[0] = 1`；
+ **考虑结果**：最终结果为 `dp` 数组中的最大值；
+ **考虑优化空间**：由于 `dp[i]` 需要参考前面所有的状态值，无法再优化空间。

**参考代码 1**：

```java
import java.util.Arrays;

public class Solution {

    public int lengthOfLIS(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return 1;
        }
        
        // dp[i]：以 nums[i] 结尾的最长上升子序列的长度
        int[] dp = new int[n];
        // 如果只有 1 个元素，那么这个元素自己就构成了最长上升子序列，所以设置为 1
        Arrays.fill(dp, 1);
        // 从第 2 个元素开始，逐个写出 dp 数组的元素的值
        int res = dp[0];
        for (int i = 1; i < n; i++) {
            // 找出比当前元素小的哪些元素的最小值
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            res = Math.max(res, dp[i]);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(n) $。

本题 $ O(n \log n) $ 时间复杂度的解法非常经典，它的思想是：**希望递增子序列的结尾元素尽可能小**。因为 **结尾元素越小，后续的元素越有可能接在这个子序列后面，形成更长的递增子序列**。

例如，有两个递增子序列：

+ 子序列 A：`[2, 3, 5]`，结尾元素是 `5`。
+ 子序列 B：`[2, 3, 4]`，结尾元素是 `4`。

如果下一个元素是 `6`，它可以接在 A 和 B 后面。如果下一个元素是 `5`，它只能接在 B 后面。显然，子序列 B 的结尾元素更小，有更大概率形成更长的递增子序列。

基于上面的观察，我们维护一个数组 `tails`，其中** **`**tails[i]**`** 表示长度为 **`**i + 1**`** 的所有递增子序列中，数值最小的结尾元素（这是状态定义）**。该数组的特点是：`tails` 严格递增，对于每个长度，我们只记录最小的结尾元素。

对于每个元素 `nums[i]`（下面的两点叙述了状态转移方程）：

+ 如果它严格大于 `tails` 数组最后的元素，则直接把 `nums[i]` 放在`tails` 数组的最后；
+ 否则在数组 `tails` 中找到第一个大于等于 `nums[i]` 的元素，替换它（当数组 `tails` 中有等于 `nums[i]` 的元素时，什么都不做），从而让对应长度的子序列的结尾元素更小。这个过程可以使用二分查找完成，时间复杂度为 $ O(\log n) $，这里 $ n $ 是数组的长度。

按照上面的规则，数组 `tails` 的长度就是结果。

以「示例 1」的数组 `nums = [10, 9, 2, 5, 3, 7, 101, 18]` 为例：

+ 初始化时 `tails = []`，`size = 0`。
+ 遍历 `nums`：
    - `nums[0] = 10`：`tails = [10]`，`size = 1`。
    - `nums[1] = 9`：小于 `tails` 末尾元素 `10`，替换 `10`，`tails = [9]`，`size = 1`；
    - `nums[2] = 2`：小于 `tails` 末尾元素 `9`，替换 `9`，`tails = [2]`，`size = 1`；
    - `nums[3] = 5`：大于 `tails` 末尾元素 `2`，添加到末尾，`tails = [2, 5]`，`size = 2`；
    - `nums[4] = 3`：小于 `tails` 末尾元素 `5`，替换 `5`，`tails = [2, 3]`，`size = 2`；
    - `nums[5] = 7`：大于 `tails` 末尾元素 `3`，添加到末尾，`tails = [2, 3, 7]`，`size = 3`；
    - `nums[6] = 101`：大于 `tails` 末尾元素 `7`，添加到末尾，`tails = [2, 3, 7, 101]`，`size = 4`；
    - `nums[7] = 18`：小于 `tails` 末尾元素 `101`，替换 `101`，`tails = [2, 3, 7, 18]`，`size = 4`。

最终，`tails` 的长度是 4，即最长递增子序列的长度。

**参考代码 2**：

```java
public class Solution {

    public int lengthOfLIS(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return 1;
        }

        // tail[i]：所有长度为 i + 1 的上升子序列的结尾数值的最小值
        int[] tail = new int[n];
        tail[0] = nums[0];

        // 数组 tail 非空部分的最后一个数的下标（从 0 开始）
        int end = 0;
        for (int i = 1; i < n; i++) {
            if (tail[end] < nums[i]) {
                end++;
                tail[end] = nums[i];
            } else {
                int left = 0;
                int right = end;
                // 找第 1 个大于等于 nums[i] 的位置，更新它
                while (left < right) {
                    int mid = (left + right) / 2;
                    // 小于 nums[i] 一定不是解
                    if (tail[mid] < nums[i]) {
                        // 下一轮搜索区间为 [mid + 1..right]
                        left = mid + 1;
                    } else {
                        // 下一轮搜索区间为 [left..mid]
                        right = mid;
                    }
                }
                // left 与 right 重合的位置就是第 1 个大于等于 nums[i] 的位置，更新它，让它更小
                tail[left] = nums[i];
            }
        }
        return end + 1;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log n) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(n) $。

## 本题总结
本题是动态规划的经典问题，理解状态定义和状态转移方程是关键。数组`tails` 的设计是基于「我们希望递增子序列的结尾元素尽可能小，以便后续元素更容易接上，形成更长的递增子序列」得到。因此可以：

+ 通过维护严格递增的数组 `tails`，快速找到当前元素应该接在哪个子序列后面；
+ 使用二分查找更新数组 `tails` ，将时间复杂度优化到 $ O(n \log n) $。','17',NULL,'0300-longest-increasing-subsequence','2025-06-09 10:36:04','2025-06-20 09:10:40',1,15,false,NULL,'https://leetcode.cn/problems/longest-increasing-subsequence/description/',39,8,'',false,'https://leetcode.cn/problems/longest-increasing-subsequence/solutions/7196/dong-tai-gui-hua-er-fen-cha-zhao-tan-xin-suan-fa-p/',true,'完成。',NULL),(104,'liweiwei1419','「力扣」第 424 题：替换后的最长重复字符（中等）','## 思路分析

**暴力解法**：枚举所有可能的子串，检查每个子串是否可以通过最多替换 `k` 个字符变成全部相同的字符，记录满足条件的最长子串长度。

假设 $ n $ 是输入字符串的长度，枚举所有子串 $ O(n^2) $，每一个统计出现次数最多的字符 $ O(n) $，暴力解法的时间复杂度为 $ O(n^3) $，题目的提示告诉我们字符串长度和 `k` 不会超过 $ 10^5 $，暴力解法在这个数据规模下会超时。

暴力解法存在的问题是：

+ 重复计算：子串 `s[i..j]` 和 `s[i..j + 1]` 有很多重叠部分，暴力解法会重新统计字符频数，效率低；
+ 不必要计算：如果 `s[i..j]` 替换 `<= k` 次不能变成全部相同的字符，则所有更长的子串 `s[i..m]`（`m > j`）也一定不满足，因为需要替换的字符只会更多（**这一点很关键，是本题可以使用滑动窗口的原因**）。

**优化思路**：根据题意可知：由于最多只能替换 `k` 个字符，为了让整个子串变为同一字符，我们应该优先替换出现次数较少的字符，而最终保留的一定是该子串中出现次数最多的字符。

为避免叙述冗长，我们记「当前可替换 `k` 个字符后形成全相同字符的子串」为「窗口有效」，我们判断「窗口有效」的依据是：**窗口长度 <= 出现次数最多的字符个数 + `k`**。

具体做法如下：

+ **窗口扩展阶段**：题目问的是最长长度，因此窗口右边界 `right` 右移，寻找有效的窗口，当新增字符导致所需替换次数超过 `k` 时，窗口无效，停止右移；
+ **窗口收缩阶段**：由于我们只是通过「窗口长度 <= 出现次数最多的字符个数 + `k`」判断窗口的有效性，此时窗口左边界 `left` 仅需右移一位，即恢复了窗口有效性（这一点我们在「参考代码」后还会详细说明），右边界 `right` 继续右移，继续尝试扩展窗口；
+ **结果更新**：整个过程中，窗口的最大长度即为所求的最长长度。

**参考代码**：

```java
public class Solution {

    public int characterReplacement(String s, int k) {
        int n = s.length();
        if (n == 1) {
            return 1;
        }

        // 提示第 2 条说：s 仅由大写英文字母组成。''Z'' 的 ASCII 值为 90，故开辟 91 个空间的数组
        int[] freq = new int[91];
        // 在滑动的过程中，曾经出现的字符频数最多的个数，并非实时准确值
        int maxCount = 0;
        int left = 0;
        int right = 0;
        char[] charArray = s.toCharArray();
        while (right < n) {
            freq[charArray[right]]++;
            // 注意：maxCount 是窗口中曾经出现过的字符频数最大值，它并不是实时
            maxCount = Math.max(maxCount, freq[charArray[right]]);
            // right 在这里 ++ ，在计算子串长度的时候使用 right - left
            right++;
            // 窗口大小 > 重复字符出现次数 + k ，说明重复字符不能填满整个窗口
            if (right - left > maxCount + k) { // 由于只判断 right - left > maxCount + k，left++ 只执行一次就不满足了，因此这里的 if 不用写成 while
                // 使用了 k 次替换，都不能把其它字符全部换成出现频数最多的字符，此时需要左边界右移
                freq[charArray[left]]--;
                left++;
            }
        }
        // 整个过程 [left..right] 组成的窗口不会缩小，并且是平移到数组末尾的，因此 n - left 就是问题的答案
        // 即 [left..n - 1] 是最终窗口停靠的位置，其长度为 n - 1 - left + 1 = n - 1  
        return n - left;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，每个字符最多被处理两次，右指针变量和左指针变量各一次；
+ 空间复杂度：$ O(C) $，这里 $ C $ 是输入字符串 `S` 出现的字符 ASCII 值的范围。

**补充说明**：这里有的朋友可能会有疑问，`maxCount` 的计算有可能不准确，**因为移出的字符可能是之前的最高频字符**，的确是这样。但 **题目只要求我们求出最值，虽然左边界 `left` 右移时 `maxCount` 可能减少，但如果存在更长的有效窗口，右边界 `right` 右移的时候一定可以更新 `maxCount`，因此 `maxCount` 的真正含义是窗口 `[left..right]` 中曾经出现过的字符频数最多的那个值，并非实时的字符频数最大值。**

再看窗口是否有效的判别条件 `right - left > maxCount + k`：

+ 由于我们在统计 `maxCount` 以后马上执行了 `right++` ，`right - left` 表示了此时窗口的长度，`right - left > maxCount + k` 表示窗口无效，注意到 `maxCount` 只增不减，`k` 是常数，`right` 又是一步一步右移而来的，此时 `right - left` 只会比 `maxCount + k` 多 1，在 `if` 的代码块里执行了 `left++` 以后，窗口马上又有效了。注意：**此时仅仅只是根据判别条件有效，并非事实上有效，但不影响最终结果（这句话可以结合我们最后给出的例子进行理解）**。因此，`if` 语句里的代码只会执行一次，而不必把 `if` 语句改成 `while`，并且 `right - left > maxCount + k` 改成 `right - left = maxCount + k + 1` 也是完全可以的。
+ 整个过程左右边界组成的窗口 `[left..right]` 不会收缩，并且在某个阶段看起来是右边界 `right` 移动一步，左边界 `left` 接着移动一步，看起来像是固定长度的窗口的平移，直到窗口的右边界 `right` 来到了字符串的末尾，窗口右边界 `right` 最终停在了 `n - 1` 位置，此时窗口  `[left..n - 1]` 的长度为 `n - left` 即为所求，这样描述很抽象，我们举一个具体例子帮助大家理解。

以 `s = CCCCAAAAABADDDDD`，`k = 1` 为例，滑动窗口算法从开始执行到某个阶段时， `maxCount = 4`，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image3508326491041795347.png)


此时窗口是有效的，右边界 `right` 继续右移一格，窗口就无效了。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image15101971285067153022.png)


根据以上的分析，将左边界 `left` 右移一格，虽然事实上此时窗口无效，但依据代码中的判别条件 `right - left > maxCount + k` ，此时窗口仍然有效，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image3598070572220013003.png)


然后就按照「`right` 右移一格，`left` 左移一格」的方式反复几次以后，滑动窗口来到了如下图所示的状态：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image18409780638730535889.png)

此时 `maxCount = 5`，由于 `k = 1` ，此时窗口右边界 `right` 还可以向右移 2 格，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image3376049599991322816.png)


窗口右边界 `right` 再右移一格，窗口无效，此时 `right - left > maxCount + k`，于是又开始了「`right` 右移一格，`left` 左移一格」的方式，最终这个长度为 7 的窗口 **平移** 到数组的末尾，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image9426097176863551592.png)


我们只是求最长长度的值，即使 `maxCount` 不是实时准确的值，且即使最终窗口停留的位置对应的子串不是有效的，最终窗口的长度就是题目要求的最长长度。

# 总结

+ 实时维护 `maxCount` 是比较困难的，但题目只要求我们求一个最值，所以即使 `maxCount` 已经失效，但我们在右边界、左边界右移的时候都维护了字符频数。如果有更优解，`maxCount` 会在右边界 `right` 右移的时候更新，`maxCount` 更准确的含义是窗口内曾经的最大值，并非实时最大值；
+ 窗口有效的判别条件 `right - left > maxCount + k` 中，`right` 、`maxCount`、`k` 在当前其实都是一个确定的数，`if` 语句内的代码块，`left++` 执行一次以后，`right - left > maxCount + k` 就不成立了，因此在 `maxCount` 未更新时，「窗口」一直保持长度向右平移；
+ `maxCount` 的特点是「只增不减」，因此窗口的长度也是「只增不减」，窗口的右边界最后一定会来到字符串的末尾，因此 `n - left` 即为所求。','6',NULL,'0424-longest-repeating-character-replacement','2025-06-11 09:00:31','2025-07-17 07:33:19',1,13,false,NULL,'https://leetcode.cn/problems/longest-repeating-character-replacement/description/',29,5,'',false,'https://leetcode.cn/problems/longest-repeating-character-replacement/solutions/3696151/hua-dong-chuang-kou-java-by-liweiwei1419-7qlu/',true,NULL,NULL),(70,'liweiwei1419','「力扣」第 62 题：不同路径（中等）','## 思路分析

「机器人每次 **只能向下或者向右** 移动一步」是本题非常重要的前提。根据该前提：走到如下图 A 位置，可以分为两种情况：

![](https://minio.dance8.fun/algo-crazy/0062-unique-paths/temp-image2861764442393005257.png)

+ **情况 1**：先移动到 B 位置，再向下移动一步；
+ **情况 2**：先移动到 C 位置，再向右移动一步。

根据「分类计数加法原理」和「分步计数乘法原理」，得到：走到 A 的不同路径数 = 走到 B 的不同路径数 × 1 + 走到 C 的不同路径数 × 1，其中：

+ 第 1 个 1 表示：从 B 到 A 移动一步就 1 条路径，分步用乘法；
+ 第 2 个 1 表示：从 B 到 C 移动一步就 1 条路径，分步用乘法；

分类用加法，因此两个乘法表达式相加即为所求。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0062-unique-paths/temp-image15084562671429000122.png)

除了在 4 个角落的格子，每个格子都被指向了 2 次，若使用递归求解，会出现重复子问题。有重复子问题，可以使用动态规划求解，我们使用自底向上的方式：

+ **状态定义**：二维数组 `dp[i][j]` 表示机器人到达坐标 `(i, j)` 的不同路径数量；
+ **状态转移方程**：当 `i > 0` 且 `j > 0` 时，`dp[i][j] = dp[i - 1][j] + dp[i][j - 1]`，这里：
    - `dp[i - 1][j]` 表示从上面（机器人向下移动）到达 `(i, j)` 的路径数量；
    - `dp[i][j - 1]` 表示从左边（机器人向右移动）到达 `(i, j)` 的路径数量。
+ **初始化**：走到第 1 行和第 1 列的所有单元格只有一条路径，因此它们设置为 1；
+ **考虑输出**：最后一个状态值 `dp[m - 1][n - 1]` 即为所求。

**参考代码 1**：

```java
public class Solution {

    public int uniquePaths(int m, int n) {
        int[][] dp = new int[m][n];
        // 先计算第一行和第一列
        for (int j = 0; j < n; j++) {
            dp[0][j] = 1;
        }
        for (int i = 1; i < m; i++) {
            dp[i][0] = 1;
        }
        // 再从左到右、从上到下依次计算
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
            }
        }
        return dp[m - 1][n - 1];
    }

}
```

本题的空间可以重复利用，有两种方式：

+ 交替使用数组的两行，这个技巧称为：滚动数组；
+ 就只用一个数组，状态值 `dp[i][j - 1]` 在使用以后马上被覆盖。大家可以想象自己在纸上填表的过程，就 不难想明白。参考代码如下：

**参考代码 2**：使用滚动数组。

```java
import java.util.Arrays;

public class Solution {

    public int uniquePaths(int m, int n) {
        int[][] dp = new int[2][n];
        // 第 1 行全填 1
        Arrays.fill(dp[0], 1);
        // 第 2 行第 1 个别忘了也填上 1
        dp[1][0] = 1;
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[i % 2][j] = dp[(i - 1) % 2][j] + dp[i % 2][j - 1];
            }
        }
        return dp[(m - 1) % 2][n - 1];
    }

}
```

**参考代码 3**：只使用一维数组。

```java
public class Solution {

    public int uniquePaths(int m, int n) {
        int[] dp = new int[n];
        dp[0] = 1;
        for (int i = 0; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[j] += dp[j - 1];
            }
        }
        return dp[n - 1];
    }

}
```

通过这道问题，我们介绍动态规划中的一个重要概念：无后效性。

无后效性是指：**子问题的解一旦确定，就不会受后续决策或状态变化的影响**。后续阶段的求解只依赖于当前状态，而与如何达到该状态无关。是否有后效性不是可以使用动态规划的前提，它是由子问题的定义，即状态的定义决定的。如果我们发现状态的定义有后效性，就需要调整状态的定义，使得动态规划的求解过程没有后效性。

以本题计算 `dp[2][3]` 为例，它只依赖于 `dp[1][3]`（从上方到达的路径数）和 `dp[2][2]`（从左方到达的路径数）。无论机器人通过何种路径到达 `dp[1][3]` 或 `dp[2][2]`，都不会影响 `dp[2][3]` 的计算结果。

从「填表」的过程来看：我们从左上角开始，按顺序（逐行或逐列）计算每个位置的路径数。每个位置的结果仅依赖于其相邻的已经计算的位置，而与后续未计算的位置、之前的计算路径无关。

综上所述，无后效性是：

+ **结果确定性**：每一阶段的结果一旦计算完成，就不会再被修改。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0062-unique-paths/temp-image4540805204197913675.png)

+ **步骤无关性**：只记录每一阶段的结果，而不关心具体的求解路径。

!!! info 阅读提示

「无后效性」概念一开始可能不太好理解，但别着急。随着我们做的动态规划的题目多了，慢慢就会明白它的意思。这里给出一些经验：如果我们定义的状态有后效性，状态转移出现了问题，我们可以把定义中较「模糊」的部分定义清楚，常见的方法有：**给定义增加内容（定义得更具体、固定一些信息），升维度（其实也是固定一些信息，升维拆得更细）**。我们马上要介绍的问题「力扣」第 174 题（地下城游戏，困难）就是按照常规思路定义状态有后效性的情况。

!!! 

## 练习
+ 「力扣」第 63 题：不同路径 II（中等）
    - 题目链接：[https://leetcode.cn/problems/unique-paths-ii/](https://leetcode.cn/problems/unique-paths-ii/)
+ 「力扣」第 64 题： 最小路径和（中等）
    - 题目链接：[https://leetcode.cn/problems/minimum-path-sum/description/](https://leetcode.cn/problems/minimum-path-sum/description/)

下一题我们和大家介绍的问题就是按照常规思路定义状态有后效性的问题。','17',NULL,'0062-unique-paths','2025-06-11 08:12:31','2025-06-18 17:21:30',1,22,false,NULL,'https://leetcode.cn/problems/unique-paths/description/',39,4,'',false,NULL,true,'完成。',NULL);
INSERT INTO "public"."articles" ("id","author","title","content","category","tags","url","created_at","updated_at","like_count","view_count","is_deleted","deleted_at","source_url","parent_id","display_order","path","is_folder","solution_url","book_check","suggestion","one_sentence_solution") VALUES (74,'liweiwei1419','「力扣」第 337 题：打家劫舍 III（中等）','## 思路分析
在动态规划（尤其是树形 DP）中，状态设计常用的思想是：通过增加维度，将原本不确定的决策转化为确定的状态，这样容易找到不同状态之间的联系（即状态转移方程）。

在本题中，对于任意一个结点 `node`，小偷有两种选择：  

+ 偷 `node`：那么它的直接子结点 `node.left` 和 `node.right` 不能偷（否则触发警报）；
+ 不偷 `node`：那么它的子结点 可以偷或不偷，取决于哪种情况收益更高。

这里的「不确定」体现在：  如果只记录 `node` 的偷窃最大值，无法区分是否偷了 `node`，导致无法正确约束子结点的选择；**必须明确 `node` 是否被偷，才能决定子结点的状态。于是我们为每个结点 `node` 定义两个状态：**

+ **状态定义**：
    - `dp[node][0]`：不偷 `node` 时的最大收益；
    - `dp[node][1]`：偷 `node` 时的最大收益。
+ **状态转移方程**：
    - 不偷 `node` (`dp[0]`)：因为当前结点不偷，所以子结点可偷可不偷，取最优解，收益等于左右子结点偷或不偷的最大收益之和（`max(left[0], left[1]) + max(right[0], right[1])`）；
    - 偷 `node` (`dp[1]`)： 因为当前结点偷，为了确保不触发警报，所以子结点一定不能偷，收益等于 `node.val` + 左、右子结点不偷时的收益之和（`left[0] + right[0]`）。

```java
left = dfs(node.left)
right = dfs(node.right)
// 不抢当前结点
dp[node][0] = max(left[0], left[1]) + max(right[0], right[1])  
// 抢当前结点
dp[node][1] = node.val + left[0] + right[0]                    
```

+ **计算顺序**：必须先计算 `left` 和 `right`（后序遍历），否则无法计算 `dp[node][0]` 和 `dp[node][1]`。在后序遍历的时候向上传递两个状态值。其它细节我们作为注意写在了「参考代码」中。

**参考代码**：

```java
public class Solution {

    public int rob(TreeNode root) {
        int[] dp = tryRob(root);
        return Math.max(dp[0], dp[1]);
    }

    private int[] tryRob(TreeNode root) {
        if (root == null) {
            return new int[2];
        }

        int[] left = tryRob(root.left);
        int[] right = tryRob(root.right);

        int[] dp = new int[2];
        // 根结点不打劫 = max(左子树不打劫, 左子树打劫) + max(右子树不打劫, 右子树打劫)
        dp[0] = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);
        // 根结点打劫 = 左右孩子结点都不能打劫
        dp[1] = left[0] + right[0] + root.val;
        return dp;
    }
    
}
```

**复杂度分析：**

+ 时间复杂度：$ O(n) $，每个结点仅被访问一次（后序遍历），每个结点执行常数时间的操作（比较和加法），标准的过程，N 为二叉树结点总数；
+ 空间复杂度：$ O(n) $，递归调用栈的最大深度为 $ n $，如果二叉树是平衡的，空间复杂度为 $ O(\log n) $。

## 本题总结
状态设计的思想通常是：拆分成更细的子问题，**把不确定的事情确定下来**。对于本题来说，偷和不偷就是不确定的事情，于是我们在进行状态设计的时候，就可以将状态规定成：

+ 在偷当前结点的情况下，可以确定孩子结点不偷；
+ 不偷当前结点的情况，孩子结点偷与不偷均可，选最大值。

由于固定了不确定因素，不同规模的子问题的关系容易找到，原问题也得到了解决。
','17',NULL,'0337-house-robber-iii','2025-06-11 08:12:31','2025-06-19 12:47:17',1,7,false,NULL,'https://leetcode.cn/problems/house-robber-iii/description/',39,19,'',false,NULL,true,'完成。',NULL),(178,'liweiwei1419','「力扣」第 216 题：组合总和 III（中等）','## 思路分析

本题要求每个数字最多使用一次，因此我们需要固定数字的选取顺序（升序）避免重复组合。以「示例 1」为例，画出递归树如下图所示：

![image.png](https://minio.dance8.fun/algo-crazy/0216-combination-sum-iii/temp-image130935679610453136.png)


这棵树因为我们使用了较强的剪枝，所以剩得没几个枝叶了。这个重要的剪枝策略是：如果剩余的数值是 `n` ，接下来要选 `k` 个数，**如果最小的 `k` 个数之和都严格大于 `n`，就把这个分支剪去**，如上图标注剪刀的地方就是如此。

**编码细节**：

+ 由于「每个数字最多使用一次」，需要参数 `start` 表示搜索的起点 ，每次递归从 `start + 1` 开始搜索；
+ 需要参数 `path` 记录从根结点到当前遍历结点已经选择的数，保存结果时需深拷贝；
+ `n`、`k`、`start` 等基本类型参数在参数传递中的行为是复制，所以它们不需要回溯。

其它编码细节和计算过程，我们作为注释写在了「参考代码」中：

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> result = new ArrayList<>();
        // 提前终止条件：k 比 n 大，或者最大的 k 个数 (10 - k,.., 7, 8, 9) 的和 < n
        if (k > n || n > (19 - k) * k / 2) {
            return result;
        }
        dfs(k, n, 1, new ArrayDeque<>(), result);
        return result;
    }

    private void dfs(int k, int n, int start, Deque<Integer> path, List<List<Integer>> result) {
        if (k == 0) {
            if (n == 0) {
                result.add(new ArrayList<>(path));
            }
            return;
        }

        // 剪枝 1 ：剩余数字不够 k 个，即 [start..9] 区间里的数不足 k 个
        if (10 - start < k) {
            return;
        }
        // 剪枝 2：从 start 开始的最小 k 个数（start, start + 1, .., start + k - 1）的和已经大于剩余值
        if ((2 * start + k - 1) * k / 2 > n) {
            return;
        }
        // 遍历可能的数字
        for (int i = start; i <= 9; i++) {
            // 剪枝 3：当前数字已经大于剩余值
            if (i > n) {
                break;
            }
            path.addLast(i);
            dfs(k - 1, n - i, i + 1, path, result);
            path.removeLast(); 
        }
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(C_9^k) $，组合问题的最坏情况；
+ 空间复杂度：$ O(k) $，递归栈深度和路径长度。

## 本题总结

搜索顺序的合理确定是避免重复解和提高算法效率的首要条件。在组合问题中，为避免生成重复的组合（如 `[1, 2]` 和 `[2, 1]`），我们需要固定元素的选取顺序，通常采用升序搜索。','16',NULL,'0216-combination-sum-iii','2025-06-11 09:59:30','2025-06-15 20:34:57',1,8,false,NULL,'https://leetcode.cn/problems/combination-sum-iii/description/',38,8,'',false,'https://leetcode.cn/problems/combination-sum-iii/solutions/47700/hui-su-jian-zhi-by-liweiwei1419/',true,NULL,NULL),(103,'liweiwei1419','「力扣」第 76 题：最小覆盖子串（困难）','## 思路分析

这是一道经典的使用滑动窗口解决的问题。我们先介绍暴力解法，再考虑如何优化。

**暴力解法**：按照题目的意思求解：枚举 `s` 中所有长度大于 `t` 的长度的子串，每个子串，检查它是否包含 `t` 中的所有字符：如果子串包含 `t` 中的所有字符，且长度比当前最小覆盖子串的长度小，则更新最小覆盖子串，暴力解法的时间复杂度较高。

**优化思路**：我们用一个具体的例子来说明如何加快计算，假设 `T = "ABCC"`，当我们读取 `S` 中的前 7 个字符时，如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image10938918185465377319.png)

此时如果 `S` 的右边再出现一个 `C` ，我们就找到了一个包含 `T` 的子串。我们继续向右边读 `S` 中的字符，我们又读了两个字符，读到了一个 `C`。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image17226359621952266837.png)

又由于题目要找 **长度最小** 的覆盖子串，这个时候 **左端点固定，长度更长的子串就没有必要看了**，我们应该尝试把左边字符依次拿掉，看看此时 `S` 的子串是否还能包含 `T` 中的所有字符。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image2253412376974538163.png)

把左边的 5 个字符拿掉，`S` 的子串依然包含 T 中的所有字符。此时，我们通过滑动窗口的方式来找到一个最小覆盖子串，其中：

+ 右边界向右移动，让 `S` 的子串中容纳更多的字符，以恰好覆盖 `T`（找到一个覆盖子串）；
+ 左边界向右移动，让 `S` 的子串长度更短，以找到更小的覆盖 `T` 的子串（尝试找到最小覆盖子串）。

左边界向右移动，一旦不能覆盖 `T` 时，再把右边界向右移动，如此交替进行，找到最小覆盖的子串。

**编码细节**：由于 `S` 的 **子串与字符顺序无关**，我们可以把是否覆盖 `T` 这件事情通过 **比较对应字符出现的频数** 来体现，即：如果 `S` 的子串中的每个字符出现的频数都 **大于等于** `T` 中的每个字符出现的频数，就可以说 `S` 的子串覆盖了 `T`。我们使用 `match` 表示当前滑动窗口内已经满足「`S` 的子串中某个字符的出现次数 ≥ `T` 中该字符的出现次数」的字符种类数。换句话说，`match` 跟踪的是在滑动窗口内已经「匹配」了 `T` 中字符的种类的数量。

**参考代码**：本题的代码写出来比较长，但其实核心代码并不多，大家需要多加练习。

```java
public class Solution {

    public String minWindow(String s, String t) {
        int tLen = t.length();
        int sLen = s.length();
        if (sLen < tLen) {
            return "";
        }
        // 在 Java 中，charAt() 方法会检查下标是否越界，在本题中是没有必要的，一般的做法是转换为字符数组
        char[] sCharArray = s.toCharArray();
        char[] tCharArray = t.toCharArray();

        int[] tFreq = new int[128];
        int[] sFreq = new int[128];
        // T 中不同字符的个数
        int distinctCharCountInT = 0;
        for (Character c : tCharArray) {
            if (tFreq[c] == 0) {
                distinctCharCountInT++;
            }
            tFreq[c]++;
        }

        // 最小覆盖子串的起始位置
        int start = 0;
        // 已经匹配的字符种类，匹配：S 中字符个数大于等于 T 中对应的字符的个数
        int match = 0;
        // 最小覆盖子串的长度，初始化为一个较大的值
        int minLen = sLen + 1;

        // 滑动窗口主要逻辑
        int left = 0;
        int right = 0;
        while (right < sLen) {
            char curChar = sCharArray[right];
            if (tFreq[curChar] > 0) {
                // 只关心 T 中有的字符，纳入窗口，对应字符频数增加
                sFreq[curChar]++;
                if (sFreq[curChar] == tFreq[curChar]) {
                    // 只要相等，匹配数加 1
                    match++;
                }
            }

            // 在这里 right++ ，下面计算子串长度的时候可以使用 right - left
            right++;
            while (match == distinctCharCountInT) {
                // 在此处记录最小值
                if (right - left < minLen) {
                    start = left;
                    minLen = right - left;
                }
                char leftChar = sCharArray[left];
                if (tFreq[leftChar] > 0) {
                    sFreq[leftChar]--;
                    if (sFreq[leftChar] < tFreq[leftChar]) {
                        match--;
                    }
                }
                left++;
            }
        }
        return minLen == sLen + 1 ? "" : s.substring(start, start + minLen);
    }

}
```

**复杂度分析**：

+ 时间复杂度： $ O(|S| + |T|) $，这里 $ |S| $ 表示字符串 `S` 的长度，这里 $ |T| $ 表示字符串 `T` 的长度；
+ 空间复杂度：$ O(|S| + |T|) $ ，如果题目没有提示 `S` 和 `T` 所代表的字符是哪些，也没有给出字符的 ASCII 值范围，空间复杂度是 $ O(|S| + |T|) $。本题中我们使用了两个长度为 128 的字符频数数组，此时可以认为空间复杂度是 $ O(1) $。


','6',NULL,'0076-minimum-window-substring','2025-06-11 09:00:30','2025-06-14 14:29:30',1,6,false,NULL,'https://leetcode.cn/problems/minimum-window-substring/description/',29,4,'',false,NULL,true,NULL,NULL),(179,'liweiwei1419','「力扣」第 77 题：组合（中等）','## 思路分析

组合问题，为了避免得到重复的结果，需要按照顺序搜索，因此在代码中需要设置搜索起点 `start`。我们从第一个数开始尝试，当选择一个数后，在剩下的数中继续选择下一个数，当组合长度达到 `k` 时，保存结果。以「示例 1」为例，画出递归树如下：

![image.png](https://minio.dance8.fun/algo-crazy/0077-combinations/temp-image13302131996363883865.png)


还需要注意到：当剩余可选的数字数量不足以凑齐我们需要的组合时，可以提前终止搜索。

如上图所示，在 `[1, 2, 3, 4]` 中选出 2 个数，搜索起点最多为 3，因为如果从 4 开始搜索，还需要 1 个数，但此时没有可以使用的数字了。

又比如，当 `n = 9`，`k = 6` 时，**假设搜索到某一个时刻，刚刚选了数字 7，还需要选 4 个数字**，但剩余可选数字：`[8, 9]`（只有 2 个），明显不够，所以从 7 开始搜索就是浪费时间，我们需要对「剩余可选数字的个数」和「还需要选几个数」的大小关系进行判断。换句话说，如果我们发现剩下的数字「不够用」了，就没必要继续往下找了。

+ 设搜索上界为 `max`，那么 `[max..n]` 范围内的数字个数，即「剩余可选数字的个数」是 `n - max + 1` ；
+ 我们每次选择一个数，在递归方法传递参数的时候，向下传递一层，`k` 减 1，因此「还需要选几个数」仍用 `k` 表示；
+ 为了保证剩下的数字够用，需要满足「剩余可选数字的个数」>= 「还需要选几个数」，即：`n - max + 1 ≥ k`， 解这个不等式，得 `max ≤ n + 1 - k`，得到搜索上界 `max = n + 1 - k`。

通过这样的剪枝，算法效率可以显著提升，特别是在处理较大 `n` 和 `k` 时。

**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>(k);
        dfs(n, k, 1, path, res);
        return res;
    }

    // n：数字范围上限
    // k：还剩几个数要选
    // start：当前搜索的起始数字，以避免重复
    // path：当前路径，表示已选择的数字
    private void dfs(int n, int k, int start, Deque<Integer> path, List<List<Integer>> res) {
        if (k == 0) {
            res.add(new ArrayList<>(path));
            return;
        }
        // 关键剪枝
        int max = n + 1 - k;
        for (int i = start; i <= max; i++) {
            path.addLast(i);
            dfs(n, k - 1, i + 1, path, res);
            path.removeLast();
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(kC_n^k) $，必须生成所有组合数，每个组合需要 $ O(k) $ 时间处理；
+ 空间复杂度：$ O(k^2) $，递归栈的深度最多为 $ k $ 层，路径存储最多 $ k $ 个元素。

根据组合问题的特点：每一个数或者选，或者不选，画出二叉树如下图所示，二叉树最多有 `n` 层。

![image.png](https://minio.dance8.fun/algo-crazy/0077-combinations/temp-image8893457586600124108.png)


和「参考代码 1」一样，可以应用一个较强的剪枝条件，即「剩余可选数字的个数」>= 「还需要选几个数」。

+ 假设搜索起点是 `start` ，剩余可用的数字范围是 `[start..n]`，共 `n - start + 1` 个数字；
+ 设 `k` 表示还需要选的数字个数；
+ 「剩余可选数字的个数」>= 「还需要选几个数」，即 `n - start + 1 >= k` ，化简得 `start <= n + 1 - k`，即当 `start > n + 1 - k` 时搜索停止。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>(k);
        dfs(1, n, k, path, res);
        return res;
    }

    private void dfs(int start, int n, int k, Deque<Integer> path, List<List<Integer>> res) {
        if (k == 0) {
            res.add(new ArrayList<>(path));
            return;
        }

        if (start > n - k + 1) {
            return;
        }
        // 不选
        dfs(start + 1, n, k, path, res);

        // 选
        path.addLast(start);
        dfs(start + 1, n, k - 1, path, res);
        path.removeLast();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(kC_n^k) $，生成所有组合数，每个组合需要 $ O(k) $ 时间处理；
+ 空间复杂度：$ O(nk) $，递归深度最多 $ n $ 层，路径存储最多 $ k $ 个元素。','16',NULL,'0077-combinations','2025-06-11 09:59:30','2025-06-15 20:41:05',1,9,false,NULL,'https://leetcode.cn/problems/combinations/description/',38,9,'',false,'https://leetcode.cn/problems/combinations/solutions/13436/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-ma/',true,NULL,NULL),(177,'liweiwei1419','「力扣」第 46 题：全排列（中等）','回溯是一种算法策略，通过尝试分步选择并在遇到无效解时撤销选择（回退）来搜索所有可能的解。它的特点是：

+ 显式回退：当发现当前路径无法得到解时，撤销上一步或几步的选择；
+ 状态管理：需要维护当前路径的状态（如路径选择、约束条件等）；
+ 目标导向：通常用于求出一个问题所有可能的解。看到「所有」，从算法和编程的视角来看，就是遍历。回溯算法特指采用 **深度优先遍历** 的方式，得到一个问题所有的解。

具体是如何做到的呢？一般来说，使用回溯算法解决的问题都可以画出递归树，我们在递归树上执行深度优先遍历，**在遍历的时候，全局使用一个变量来记录符合题目要求的答案，在变量变化的时候，一旦满足条件，就复制（深拷贝）到结果集中**。为什么叫回溯呢？因为 **深度优先遍历有回头的时刻，因此变量就需要退回成为曾经的值，然后尝试新的可能**。

那为什么不是广度优先遍历呢？如果使用广度优先遍历需要保存的临时变量、存储的中间值太多，创建和销毁这些临时变量也有性能开销。这么说可能有点抽象，我们以「力扣」第 46 题（全排列）为例，向大家介绍回溯算法。

# 例题：「力扣」第 46 题：全排列（中等）

+ 题目地址：[https://leetcode.cn/problems/permutations/description/](https://leetcode.cn/problems/permutations/description/)


## 思路分析

首先画出本题的树形结构。以求数组 `[1, 2, 3]` 的全排列为例，第 1 个数字有 3 种选法，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749609656-OaaUSZ-image.png)


第 2 个数字，在还未选择的两个数中选，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749609669-dzbaCP-image.png)


第 3 个数字只剩下 1 种选法，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749609683-EcXHBJ-image.png)

这是本题的递归树，它的所有叶子结点，就是 `[1, 2, 3]` 的全排列。回溯算法就是通过深度优先遍历的方式，使用一个变量 （我们命名为 `path`，表示从根结点到叶子结点的一条路径，大家也可以使用别的变量名），遍历这棵递归树：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749609712-GIfTpr-image.png)

在遍历到合适的时刻，把变量 `path` 的值记录下来。对于本题，叶子结点就是合适的时刻，下面我们考虑如何编码实现。

**使用一个列表 `path` 记录已经选择的数字**。在深度优先遍历的时候：

+ 从父亲结点到孩子结点，在列表的末尾加入一个数字；
+ 从孩子结点 **回到** 父亲结点，在列表的末尾删除上一个数字，这个数字正是上一步删除的数字。

这个列表只在末尾进行操作，所以该列表是个栈。由于每一步需要选择的数字需要保证在之前从未被选择，因此已经选择过的数字需要被记录下来，常见的做法是使用一个布尔数组 `used`，其长度与原始数字数组的长度相等：

+ 初始化时，将 `used` 数组中的所有元素都设为 `false`，意味着一开始所有数字都处于未被选择的状态。
+ 当在深度优先遍历的过程中选择了某个数字，比如数字数组中的第`i`个数字，那我们就将 `used[i]` 设置为 `true`，表示这个数字已经被当前列表选择；
+ 在后续继续生成排列、尝试往排列里添加下一个数字时，只需遍历 `used` 数组，就能快速知道哪些数字还能被选用，哪些数字已经被用过而不能再重复选择。

**列表 `path` 和数组 `used` 全局只使用一份**，因此：

- 在进入递归函数前，列表 `path` 需要执行添加操作，相应 `used` 数组对应下标的值需要设置为 `true`；
- 在执行完递归函数以后，列表 `path` 需要执行删除操作，相应 `used` 数组对应下标的值需要设置为 `false`。

回到原来的位置相应的变量值也需要恢复成原来的样子（回溯）。

按照上面的分析，写出如下参考代码，一些注意事项我们作为注释写在了代码中：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> permute(int[] nums) {
        int n = nums.length;
        // 记录结果的数组
        List<List<Integer>> res = new ArrayList<>();
        // 由于提示说：1 <= nums.length <= 6，因此不用写 if (len == 0) return res;

        // used 和 path 全局使用，因此作为递归函数的参数一直传递下去
        boolean[] used = new boolean[n];
        Deque<Integer> path = new ArrayDeque<>();

        dfs(nums, 0, n, used, path, res);
        return res;
    }

    /**
     * @param nums  输入数组
     * @param index 当前选择哪个下标的数字
     * @param n   数组的长度，可以从 nums.length 属性中得到，非必须参数，读者可以自己选择是否需要
     * @param used  记录哪些数字已经选择
     * @param path 记录已经选择的数字
     * @param res   记录结果的数组
     */
    private void dfs(int[] nums, int index, int n, boolean[] used, Deque<Integer> path, List<List<Integer>> res) {
        // 全部选择完成的时候，把 path 的结果复制到 res 中
        if (index == n) {
            // 容易错的地方：如果写 res.add(path); 只是添加了 permutation 的地址，permutation 完成 dfs 以后为空，最后 res 全是空数组
            res.add(new ArrayList<>(path));
            return;
        }

        for (int i = 0; i < n; i++) {
            if (used[i]) {
                continue;
            }
            used[i] = true;
            path.addLast(nums[i]);

            // System.out.println("递归之前：" + stack);
            dfs(nums, index + 1, n, used, path, res);
            // 难点：在递归完成以后，递归之前的操作需要撤销

            used[i] = false;
            path.removeLast();
            // System.out.println("递归之后：" + stack);
        }
    }

}
```

**说明**：

+ `Deque<Integer> permutation = new ArrayDeque<>();` 这是 Java 的 `java.util.Stack` 的源代码注释里推荐的写法，我们在讲解中只是为了突出它是个栈，才这样写。大家使用 `ArrayList`（动态数组）、`LinkedList`（双向链表）都是可以的；
+ 递归函数我们命名成 `dfs` 仅供参考，大家完全可以命名成一个更有意义的名字， 在 `dfs` 方法中传递的参数 `nums`、`used` 、`permutation`、`res` 可以作为 `Solution` 类的成员变量，因为它们全局只使用一份，这样就不用作为参数传递下去，大家可以根据自己的编程习惯自行决定；
+ `n` 因为在 `dfs` 方法中会多次用到，所以也作为递归函数的参数传递下去，大家也可以直接从 `nums` 的属性 `nums.length` 属性中得到。经常读取的属性通常会使用一个变量记录下来。这里参考代码的写法也不是必须的，大家可以根据自己的编程习惯自行决定。
+ **重点**：请大家重点理解 `dfs`方法中

```java
if (used[i]) {
    continue;
}
```

的作用， 虽然可以使用 `permutation.contains(nums[i])` （这里 `stack` 声明为 `List`）来判断 `nums[i]` 是否使用过，`permutation.contains(nums[i])` 虽然只有一行代码，但是这行代码做的事情是：遍历 `permutation`，看 `nums[i]` 是否在其中，时间复杂度是 $ O(n) $，因此我们应该用空间换时间：在选择 `nums[i]` 的时候，就把 `used[i]`的值设置为 `true`。

## 本题总结

通过「力扣」第 46 题（全排列）我们看到：回溯算法就是使用一个变量（和若干个辅助的变量）不断尝试，尝试的过程是深度优先遍历，在合适的时刻，把变量的临时状态复制到结果集中，得到一个问题的所有解。

初学的时候，本题有以下 2 个难点：

+ 难点 1：`dfs(nums, index + 1, n, used, path, res);`后面的代码：

```java
used[i] = false;
permutation.removeLast();
```

初学的时候可能会比较难理解。这里建议大家从深度优先遍历的角度去理解：**由于全程使用列表变量 `path` 和 `used` 进行深度优先遍历，递归完成以后，即深度优先遍历从孩子结点回到父亲结点的时候，之前（从父亲结点到孩子结点）的操作需要撤销，因此 `dfs` 之前怎么写，在 `dfs` 之后就写相应的撤销操作**。

**对象类型变量，全程只使用一份，因此 `dfs` 之后就需要撤销，基础类型变量，在参数传递的过程中是复制，因此没有必要回溯**。

+ **难点 2**：`res.add(new ArrayList<>(path));` 这行代码的意思是：把当前 `path` **深拷贝** 一份到 `res`中。大家可以试一下，如果只写 `res.add(path);` 最后会得到 `[[], [], [], [], [], []]`这样的结果，这是因为 深度优先遍历完成以后，`path` 为空。

理解代码最好的方式就是在代码中把变量的值打印出来看一下。通过打印变量理解递归、理解深度优先遍历。大家可以在 `dfs` 函数里的 `for` 循环里增加打印 `path` 变量的语句，即如上参考代码被注释的两行打印代码，看看 `path` 是如何变化的。

```plain
递归之前：[1]
递归之前：[1, 2]
递归之前：[1, 2, 3]
递归之后：[1, 2]
递归之后：[1]
递归之前：[1, 3]
递归之前：[1, 3, 2]
递归之后：[1, 3]
递归之后：[1]
递归之后：[]
(为节约篇幅，后面的打印输出省略。)
```

一个很自然的问题是：为什么不使用广度优先遍历来遍历递归树呢？

我们从时间和空间复杂度两个方面解释：

- 广度优先遍历会平等地遍历每一层的所有结点。而在很多问题中通过深度优先遍历结合剪枝操作，可以跳过一些不可能产生解的分支。深度优先遍历可以根据已经选择的元素个数和问题的要求（约束），判断某个分支是否需要继续遍历，而广度优先遍历很难有效地利用这种剪枝策略，会导致它在很多情况下做了大量无用的遍历。因此广度优先遍历时间复杂度通常也较高；
- 广度优先遍历需要使用队列来存储待访问的结点，在广度优先遍历扩散的层数较多的时候，队列的空间占用会达到指数级，因此空间复杂度可能会因为需要存储大量的中间状态而变得很高。

','16',NULL,'0046-permutations','2025-06-11 09:59:30','2025-06-14 15:23:07',1,11,false,NULL,'https://leetcode.cn/problems/permutations/description/',38,1,'',false,'https://leetcode.cn/problems/permutations/solutions/9914/hui-su-suan-fa-python-dai-ma-java-dai-ma-by-liweiw/',true,NULL,NULL),(75,'liweiwei1419','「力扣」第 543 题：二叉树的直径（简单）','

## 题解题意
题目说：两结点之间路径的 **长度** 由它们之间的「边数」表示。因此结点的数值其实我们在编码的时候不需要关心，只是为了说明示例中的路径。首先，我们需要 **明确直径的定义**。根据题意：下图展示了「路径」的两种情况。

![图 1](https://minio.dance8.fun/algo-crazy/0543-diameter-of-binary-tree/temp-image10267481991878067569.png)

![图 2](https://minio.dance8.fun/algo-crazy/0543-diameter-of-binary-tree/temp-image2324304820334603370.png)

下图黑色结点不是直径，它不能表示成从一个结点走到另一个结点的路径。

![](https://minio.dance8.fun/algo-crazy/0543-diameter-of-binary-tree/temp-image14893280026813527124.png)

从「直径」的定义中我们可以看出：

+ 「直径」一定连接了某个结点；
+ 「直径」可以是弯折的，如「图 1」所示，这里「弯折」的特点是：直径上至少有两个结点位于树的同一层；
+ 「直径」可以是笔直的，如「图 2」所示。

## 思路分析
在 12 章第 4 节《树的典型问题》中，我们介绍了「力扣」第 124 题：二叉树中的最大路径和（困难），本题是和它同样类型的问题。在算法与数据结构中很多概念其实是相通的，动态规划中「无后效性」的概念指导我们在定义状态的时候，需要固定一些信息。「力扣」第 124 题也可以归类为使用动态规划解决的问题，只不过那时我们没有提出动态规划和无后效性这两个概念。

+ **如何设计状态**：可以把不确定的事情确定下来，这样设计状态，容易得到状态转移方程。对于本问题，我们定义状态（子问题）：路径 **只来自某个子树根结点的一侧的最大边数**，即如「图 2」所示。即：定义的路径只允许结点在不同层。虽然我们定义的状态和题目问的直径不是一回事，但是我们在求解我们所定义的不同规模的子问题的过程中，可以找到题目要求的直径。即：虽然题目定义的直径可以弯折，而我们定义的状态是笔直的。**由于笔直的情况可以组成弯折的情况，所以能够解决该问题**。
+ **状态转移**：由于我们固定了路径没有弯折，只来自其中一侧。在解决树的问题时候，经常需要遍历，而深度优先遍历的后序遍历恰好符合了计算规律。左、右子树中较长的路径（在「后序遍历」的时候左、右子树已经计算完成），再加上根结点又形成了一条更长的路径，这是本题的「状态转移」。

![](https://minio.dance8.fun/algo-crazy/0543-diameter-of-binary-tree/temp-image1217627094058179932.png)

子问题（状态）的设计，间接地组成了问题的解。希望通过这道问题，大家可以更深入地体会状态设计的思想：拆分更细一点，把不确定的事情确定下来。目的都是为了找到小规模问题和大规模问题之间的联系，以求得原问题的解。

**参考代码**：

```java
public class Solution {

    private int res = 0;

    public int diameterOfBinaryTree(TreeNode root) {
        dfs(root);
        return res;
    }

    // 递归函数定义：以 node 为根结点的子树的深度
    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int left = dfs(node.left);
        int right = dfs(node.right);
        // 左子树的结果加上右子树的结果就是题目要求的「直径」，在遍历的时候求得最大值
        res = Math.max(res, left + right);
        // 加上根结点形成一条边，所以加 1
        return Math.max(left, right) + 1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，每个结点仅被访问一次；
+ 空间复杂度：$ O(n) $，递归调用栈的最大深度为 $ n $，如果二叉树是平衡的，空间复杂度为 $ O(\log n) $。

## 本题总结
题目中规定的路径可以弯折也可以不弯折，这是不确定的因素。我们在设计状态的时候，可以将是否弯折这件事情固定下来：在设计递归函数的时候，求解不弯折的路径的最长长度，即：

+ 路径必须经过根结点（递归函数的根结点，非整棵树的根结点）；
+ 且路径只能来自根结点的左子树或者右子树。

# 总结
我们通过树形 DP 问题，再次和大家强调状态设计的通用技巧：

+ 增加维度：当单一状态无法覆盖所有可能性时，通过增加维度（如「打家劫舍 I」「打家劫舍 III」的 `[0]/[1]`）明确不同情况；
+ 固定约束条件：通过状态定义显式约束后续决策，如「打家劫舍 III」强制子结点不偷，「二叉树的直径」强制路径只来自根结点的一侧，根结点是路径的端点。
+ 后序遍历保证无后效性：树形 DP 几乎都是用后序遍历：先计算子问题的解，再组合父问题的解，避免重复计算。



','17',NULL,'0543-diameter-of-binary-tree','2025-06-11 08:12:31','2025-06-18 19:04:24',1,10,false,NULL,'https://leetcode.cn/problems/diameter-of-binary-tree/description/',39,20,'',false,NULL,true,'完成。',NULL),(180,'liweiwei1419','「力扣」第 22 题：括号生成（中等）','## 思路分析

以 `n = 2` 为例，画出递归树结构如下：

![image.png](https://minio.dance8.fun/algo-crazy/0022-generate-parentheses/temp-image16133924097908796155.png)


规则是：

+ 如果剩余左括号数量大于等于 1，则产生左分支；
+ 如果剩余右括号数量大于等于 1，则产生右分支；
+ 在尝试生成右分支时，若算上当前尝试添加的右括号后，右括号的数量超过左括号的数量，就对该分支进行剪枝。换句话说：当剩余左括号数量 <  剩余右括号数量时，才产生右分支（左括号用得多的前提下，才使用左括号。左括号和右括号使用数量相等时，不能使用右括号）。
+ 当前左右括号的剩余都为 0 时，就得到一个有效的括号的组合。

**参考代码 1**：

```java
import java.util.ArrayList;
import java.util.List;

public class Solution {

    public List<String> generateParenthesis(int n) {
        List<String> res = new ArrayList<>();
        // 执行深度优先遍历，搜索可能的结果
        dfs("", n, n, res);
        return res;
    }

    /**
     * @param curStr 当前递归得到的结果
     * @param left   左括号还有几个可以使用
     * @param right  右括号还有几个可以使用
     * @param res    结果集
     */
    private void dfs(String curStr, int left, int right, List<String> res) {
        // 因为每一次尝试，都使用新的字符串变量，所以无需回溯
        // 在递归终止的时候，直接把它添加到结果集即可，注意与「力扣」第 46 题、第 39 题区分
        if (left == 0 && right == 0) {
            res.add(curStr);
            return;
        }
        if (left > 0) {
            dfs(curStr + "(", left - 1, right, res);
        }

        if (left < right) {
            dfs(curStr + ")", left, right - 1, res);
        }
    }
    
}
```

**说明**：

+ 字符串有这样的特点，每一次拼接都生成新的字符串；
+ 基本类型变量，在方法传递的时候，其行为是复制。

所以字符串的深度优先遍历可以没有「回溯」的过程，即：每一次尝试都使用新的变量，深度优先遍历回到原来的地方时，使用的是原来的变量值。我们可以在字符串拼接的时候使用 `StringBuilder` 类，参考代码如下，大家可以作对比，相信对回溯算法会有新的认识。

```java
import java.util.ArrayList;
import java.util.List;

public class Solution {

    public List<String> generateParenthesis(int n) {
        List<String> res = new ArrayList<>();
        // 使用 StringBuilder 进行字符串拼接
        dfs(new StringBuilder(), n, n, res);
        return res;
    }

    /**
     * @param curStr 当前递归得到的结果
     * @param left   左括号还有几个可以使用
     * @param right  右括号还有几个可以使用
     * @param res    结果集
     */
    private void dfs(StringBuilder curStr, int left, int right, List<String> res) {
        // 递归终止条件：左右括号都用完
        if (left == 0 && right == 0) {
            res.add(curStr.toString());
            return;
        }

        // 如果还有左括号可用，尝试添加左括号
        if (left > 0) {
            // 添加左括号
            curStr.append("("); 
            dfs(curStr, left - 1, right, res);
            // 回溯，移除最后一个字符
            curStr.deleteCharAt(curStr.length() - 1); 
        }

        // 如果右括号比左括号多，尝试添加右括号
        if (left < right) {
            // 添加右括号
            curStr.append(")"); 
            dfs(curStr, left, right - 1, res);
            // 回溯，移除最后一个字符
            curStr.deleteCharAt(curStr.length() - 1); 
        }
    }

}
```

**说明**：本题的「复杂度分析」涉及到组合数学的「卡特兰数」，已经超出了本书的介绍范围。感兴趣的读者可以自行了解，这里只列出结论。

**复杂度分析**：

+ 时间复杂度：$ O(\frac{4^n}{\sqrt{n}}) $。其中 `n` 是括号的对数。每个有效的括号组合都需要 `2n` 步来生成；
+ 空间复杂度：$ O(n) $。递归栈的深度是 `2n`，因此空间复杂度是 $ O(n) $。

','16',NULL,'0022-generate-parentheses','2025-06-11 09:59:30','2025-06-15 20:42:47',1,7,false,NULL,'https://leetcode.cn/problems/generate-parentheses/description/',38,10,'',false,'https://leetcode.cn/problems/generate-parentheses/solutions/35947/hui-su-suan-fa-by-liweiwei1419/',true,NULL,NULL),(107,'liweiwei1419','「力扣」第 42 题：接雨水（困难）','## 思路分析

这是一道经典且有一定难度的算法题。我们从暴力解法开始，然后介绍空间换时间的做法，最后介绍双指针的做法。

**暴力解法**：根据题目意思，**只要能形成凹槽，就能接住雨水**。因此，对于每个柱子，找到它左边的最大高度和右边的最大高度，然后取两者中的较小值减去当前柱子的高度，就是该柱子能接住的雨水量。这是本题的暴力解法，把暴力解法提交给「力扣」，显示「超出时间限制」。

**参考代码 1（超时）**：

```java
public class Solution {
    
    public int trap(int[] height) {
        int n = height.length;
        int res = 0;
        // 遍历每个柱子
        for (int i = 1; i < n - 1; i++) {
            int leftMax = 0, rightMax = 0;
            // 找到当前柱子左边的最大高度
            for (int j = i; j >= 0; j--) {
                leftMax = Math.max(leftMax, height[j]);
            }
            // 找到当前柱子右边的最大高度
            for (int j = i; j < n; j++) {
                rightMax = Math.max(rightMax, height[j]);
            }
            // 计算当前柱子能接住的雨水量
            res += Math.min(leftMax, rightMax) - height[i];
        }
        return res;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是数组的长度。对于每个柱子，我们需要向左和向右扫描一次来找到最大高度；
+ 空间复杂度：$ O(1) $，只使用了常数级的额外空间。

暴力解法做了很多重复的工作：每一个柱子都要向左向右看一遍最大值（一根柱子的值被重复读取多次），我们可以通过两次遍历，记录下来每一根柱子左边和右边的最高柱子的高度。

**优化思路 1（空间换时间）**：使用两个和原始数组同等长度的数组，扫描两次数组：

+ 从左边向右边扫描：记录当前位置的左边的所有柱形的最高高度；
+ 从右边向左边扫描：记录当前位置的右边的所有柱形的最高高度。

在扫描的过程中，每一格位置的更新，时间复杂度为 $ O(1) $。最后再扫描一次数组区间 `[1..n - 2]` ，针对每一格查询上面两个数组，计算出每个格子能够储存雨水的单位。

**参考代码 2**：

```java
public class Solution {

    public int trap(int[] height) {
        int n = height.length;
        if (n < 3) {
            return 0;
        }

        // leftMax[i] 表示 [0..i) 里柱子的最高高度
        int[] leftMax = new int[n];
        for (int i = 1; i < n; i++) {
            leftMax[i] = Math.max(leftMax[i - 1], height[i - 1]);
        }

        // rightMax[i] 表示 (i..n - 1] 里柱子的最高高度
        int[] rightMax = new int[n];
        for (int i = n - 2; i >= 0; i--) {
            rightMax[i] = Math.max(rightMax[i + 1], height[i + 1]);
        }

        int res = 0;
        for (int i = 1; i < n - 1; i++) {
            // 左右两侧最高高度较低者
            int minHeight = Math.min(leftMax[i], rightMax[i]);
            if (height[i] < minHeight) {
                // 当前高度小于「左右两侧最高高度较低者」时，可以存水
                res += minHeight - height[i];
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $；
+ 空间复杂度：$ O(n) $，使用了两个和原始数组长度相等的数组。

该方法使用空间换时分别记住了左、右侧最高的柱子的高度，遍历了 3 次数组。事实上，根据这个问题的性质，还有更巧妙的办法，**按照一定的计算的顺序**，只需要遍历数组 1 次就能计算出结果。

**优化思路 2（双指针）**：既然每个柱子，我们都要看一看它左边的最大高度和右边的最大高度，那么我们就维护这两个变量好了，记它们分别为 `leftMax` 和 `rightMax`。很显然，下标 `0` 和下标 `n - 1` 位置不存水。

以 `height = [3, 1, 5, 3, 0, 6, 0, 5]` 为例，首先下标 1 位置的存水量可以确定，这是因为：**不论 `height[2..6]` 的数据是什么，下标 1 可以存水的量都是 `min(height[0], height[7]) - height[0] = 2`（想清楚这一点很重要，和「力扣」第 11 题类似理解，大家可以停在这个例子上多想一会儿，或者自己尝试举出几个例子想明白）**，如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image15706018448477813641.png)

下标 1 柱子的特点是：

+ 它的左侧的最高高度 < 它的右侧的最高高度，
+ 它自己的高度 < 它的左侧的最高高度 。满足这两点，就能确定当前位置的存水量。

此时我们的计算范围可以缩小到 `[2..6]`，同时我们更新左侧的最大高度 `leftMax`。根据这一特点，我们可以得出如下计算规则：

+ 当 `leftMax < rightMax` 时，右侧有一个较高的柱子，此时只需要关注左侧的最大高度 `leftMax`，因为 **无论中间还有多高的柱子**，当前左边界 `left` 能接住的雨水量只取决于「左侧的最大高度」和「当前柱子的高度」差。于是我们比较 `height[left]` 和 `leftMax`：
    - 如果 `height[left] < leftMax`，则说明当前柱子低于左侧的最大高度，能接住的雨水量为 `leftMax - height[left]`，将其累加到结果 `res` 中，然后将 `left` 指针右移一位；
    - 如果 `height[left] >= leftMax`，更新 `leftMax` 为 `height[left]`，因为此时当前柱子是左侧到目前为止最高的，它无法接住雨水。
+ 同理，当 `leftMax > rightMax` 时，说明左侧有一个较高的边界，此时只需要关注右侧的最大高度 `rightMax`，然后比较 `height[right]` 和 `rightMax`：
    - 如果 `height[right] < rightMax`，则当前柱子能接住的雨水量为 `rightMax - height[right]`，累加到结果 `res` 中，然后将 `right` 指针左移一位。
    - 如果 `height[right] >= rightMax`，更新 `rightMax` 为 `height[right]`。
+ 当 `leftMax == rightMax` 时，`left` 右移一位或者 `right` 左移一位均可；
+ 当 `left` 与 `right` 重合的时候，还需要再计算一次重合位置的存水量，然后程序结束。参考代码如下：

**参考代码**：

```java
public class Solution {

    public int trap(int[] height) {
        int n = height.length;
        if (n < 3) {
            return 0;
        }

        int leftMax = height[0];
        int rightMax = height[n - 1];
        int left = 1;
        int right = n - 1;
        int res = 0;
        while (left <= right) {
            if (leftMax < rightMax) {
                if (leftMax > height[left]) {
                    res += leftMax - height[left];
                }
                leftMax = Math.max(leftMax, height[left]);
                left++;
            } else {
                if (rightMax > height[right]) {
                    res += rightMax - height[right];
                }
                rightMax = Math.max(rightMax, height[right]);
                right--;
            }
        }
        return res;
    }

}
```

**说明**：该方法仍然需要计算 `leftMax` 和 `rightMax`，但不需要使用两个数组记下来，只需要调整计算顺序，就能得到正确结果。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，只需要遍历一次数组；
+ 空间复杂度：$ O(1) $，只使用了常数的额外空间。

## 本题总结
本题双指针的解法，更巧妙地利用问题本身的特点，使用两个指针变量向中间移动的方式，逐渐缩小的需要计算的范围，有一定的难度。先理解暴力解法和「空间换时间」，再理解双指针的做法会更容易一些。

需要说明的是，时间和空间复杂度往往难以同时优化。而本题的双指针解法却能实现时间与空间复杂度的双优，不过其思路确实具有一定难度。本书建议：在空间限制不严格的情况下，优先保证时间复杂度最优，空间开销可以适当放宽。

','7',NULL,'0042-trapping-rain-water-two-points','2025-06-11 09:00:31','2025-06-15 20:15:07',1,10,false,NULL,'https://leetcode.cn/problems/trapping-rain-water/description/',29,9,'',false,'https://leetcode.cn/problems/trapping-rain-water/solutions/48255/bao-li-jie-fa-yi-kong-jian-huan-shi-jian-zhi-zhen/',true,NULL,NULL),(73,'liweiwei1419','「力扣」第 516 题：最长回文子序列（中等）','## 思路分析

子序列不要求字符在数组中连续，但要求 **保持原始字符的相对顺序**。只要返回最长的长度，不要求具体回文子序列，可以使用动态规划解决。

+ **状态定义**：定义一个二维数组 `dp[i][j]` 表示字符串 `s` 中下标从 `i` 到 `j`（`i` 和 `j` 都可以取到） 的子串 `s[i..j]` 的最长回文子序列的长度；
+ **状态转移方程：**


**情况 1**：如果 `s[i] == s[j]`，如下图所示，灰色部分的值在之前已经计算出来，它的值是 `dp[i + 1][j - 1]`，加上头和尾相同的字符，得 `dp[i][j] = dp[i + 1][j - 1] + 2`；

![](https://minio.dance8.fun/algo-crazy/0516-longest-palindromic-subsequence/temp-image15195410979162066046.png)

**情况 2**：如果 `s[i] != s[j]`，如下图所示，去掉头 **或者** 去掉尾的子串（灰色部分）的最长回文子序列的长度的较大者，就是此时最长回文子序列的长度，得 `dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])`。

![](https://minio.dance8.fun/algo-crazy/0516-longest-palindromic-subsequence/temp-image14766277111916251248.png)

动态规划的计算过程像是在填写一张二维表格的上半部分，`dp[i][j]` 取决于 `dp[i + 1][j - 1]`、`dp[i][j - 1]`、`dp[i + 1][j]` ，需要保证这 3 个值先计算出来。下图是 3 种计算顺序，它们在代码层面上的区别就只是在两个 `for` 循环的代码。

![](https://minio.dance8.fun/algo-crazy/0516-longest-palindromic-subsequence/temp-image7887422983493962022.png)

+ **考虑初始化**：对角线的值可以先计算出来；
+ **考虑输出**：`dp[0][n - 1]` 就是整个字符串的最长回文子序列的长度。

**参考代码 1**：

```java
public class Solution {

    public int longestPalindromeSubseq(String s) {
        int n = s.length();
        if (n < 2) {
            return n;
        }

        // dp[i][j] 表示：子串 s[i..j] 里最长回文子序列的长度
        int[][] dp = new int[n][n];
        // 初始化：对角线上都是 1
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        char[] charArray = s.toCharArray();
        for (int i = n - 2; i >= 0; i--) {
            for (int j = i + 1; j < n; j++) {
                if (charArray[i] == charArray[j]) {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else {
                    dp[i][j] = Math.max(dp[i][j - 1], dp[i + 1][j]);
                }
            }
        }
        return dp[0][n - 1];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是字符串 `s` 的长度；
+ 空间复杂度：$ O(n^2) $。

**参考代码 2**：这里只列出 `for` 循环的代码。

```java
for (int j = 1; j < n; j++) {
    for (int i = j - 1; i >= 0; i--) {
```

**复杂度分析**：（同「参考代码 1」）

**参考代码 3**：这一版代码依次计算出所有长度为 2 、3 知道字符串的长度 `n` 的子区间的状态值。

```java
// 枚举区间的长度 L
for (int L = 2; L <= n; L++) {
    for (int i = 0; i < n; i++) {
        // 固定左端点 i 和区间长度 L 的情况下，可以计算出右端点，根据 L = j - i + 1 得
        int j = L + i - 1;
        // 如果越界，跳出内层循环
        if (j >= n) {
            break;
        }
```

**参考代码 4**：针对「参考代码 1」的优化空间的代码。

```java
public class Solution {

    public int longestPalindromeSubseq(String s) {
        int n = s.length();
        int[] dp = new int[n];

        // 初始化：单个字符的回文子序列长度为1
        for (int i = 0; i < n; i++) {
            dp[i] = 1;
        }

        // 从字符串末尾开始，逐步向前计算
        char[] charArray = s.toCharArray();
        for (int i = n - 2; i >= 0; i--) {
            // 用于保存 dp[i + 1][j - 1] 的值
            int pre = 0;
            for (int j = i + 1; j < n; j++) {
                // 保存当前 dp[j] 的值
                int temp = dp[j];
                if (charArray[i] == charArray[j]) {
                    // dp[i][j] = dp[i + 1][j - 1] + 2
                    dp[j] = pre + 2;
                } else {
                    // dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
                    dp[j] = Math.max(dp[j], dp[j - 1]);
                }
                // 更新 pre 为当前 dp[j] 的旧值
                pre = temp;
            }
        }
        return dp[n - 1];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是字符串 `s` 的长度；
+ 空间复杂度：$ O(n) $。

# 总结
通过本节的两个例题，我们和大家介绍了：

+ 状态设计需贴合问题特性：连续子串关注布尔状态，子序列关注最大长度；
+ 遍历顺序决定计算依赖：动态规划表格的填充方向需确保子问题已解，以满足无后效性；
+ 空间优化依赖状态依赖关系：通过观察状态转移方向压缩存储。','17',NULL,'0516-longest-palindromic-subsequence','2025-06-11 08:12:31','2025-06-18 18:59:03',1,9,false,NULL,'https://leetcode.cn/problems/longest-palindromic-subsequence/description/',39,18,'',false,NULL,true,'完成。',NULL),(76,'liweiwei1419','「力扣」第 416 题：分割等和子集（中等）','## 一、思路分析

本题是典型的动态规划问题，可以转化为经典的「0-1 背包问题」：**是否存在一个子集，其元素之和等于整个数组元素之和的一半**。由于数组只包含正整数，数组元素之和应为偶数。

「0-1 背包问题」有「未优化空间」和「优化空间」两种写法。

## 二、未优化空间写法

> **说明**：「参考代码 1」和「参考代码 2」的关键差别是 `dp[i][j]` 表示的区间是否包含 `nums[i]`，大家任选其一实现就好。

+ **状态定义**：布尔数组 `dp[i][j]` 表示区间 `nums[0..i]` 里是否存在若干个元素的和等于 `j`；
+ **状态转移方程**：
    - 不选 `nums[i]`，如果 `nums[0..i - 1]` 区间里存在若干个元素的和为 `j`；
    - 选择 `nums[i]`，如果 `nums[0..i - 1]` 区间里存在若干个元素的和为 `j - nums[i]`；

以上两种情况都能使得 `dp[i][j] = true`，因此状态转移方程是：`dp[i][j] = dp[i - 1][j] || dp[i - 1][j - nums[i]]`。

+ **考虑初始化**：`nums[0]` 只能填满容量为 `nums[0]` 的背包，二维表格的第 1 行单独填写；
+ **考虑输出**：`dp[n - 1][target]`，这里 `n` 是数组的长度，`target` 是数组元素之和（必须是偶数）的一半。对于本题，在「填表」的时候，如果发现某一行的最后一个值为 `true` 就可以提前结束了。

**参考代码 1**：

```java
public class Solution {

    public boolean canPartition(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum % 2 == 1) {
            return false;
        }

        int target = sum / 2;
        int n = nums.length;
        // dp[i][j]：区间 nums[0..i] 里是否存在若干个元素之和为 j
        boolean[][] dp = new boolean[n][target + 1];
        // 先填第 1 行
        if (nums[0] <= target) {
            dp[0][nums[0]] = true;
        }
        for (int i = 1; i < n; i++) {
            for (int j = 0; j <= target; j++) {
                if (nums[i] <= j) {
                    // 选或者不选有一个为 true 即可
                    dp[i][j] = dp[i - 1][j] || dp[i - 1][j - nums[i]];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
            // 由于状态转移方程的特殊性，提前结束，可以认为是剪枝操作
            if (dp[i][target]) {
                return true;
            }
        }
        return dp[n - 1][target];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \times \text{target}) $：这里 $ n $ 是数组元素的个数，$ \text{target} $ 是数组元素的和的一半；
+ 空间复杂度：$ O(n \times \text{target}) $。

**说明**：如果状态数组的定义是：`dp[i][j]` 表示在前 `i` 个元素（即 `nums[0..i - 1]`，不包括 `nums[i]`）中，是否存在若干个元素之和等于 `j`，那么状态数组的大小为 `(n + 1) x (target + 1)`。这样定义可以把第一行的「填表」逻辑和后面统一起来（其实没有本质差别），初始化的时候：

+ `dp[0][0] = true`：前 0 个元素的和为 0；
+ `dp[0][j] = false`：对于 `j > 0`：前 0 个元素无法组成任何正数和；
+ `dp[i][0] = true`：对于所有 `i`：不选任何元素可以得到和为 0；

在状态转移的时候 `nums[i]` 都替换成 `nums[i - 1]`，最后返回 `dp[n][target]`。

**参考代码 2**：

```java
public class Solution {

    public boolean canPartition(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum % 2 == 1) {
            return false;
        }
        int target = sum / 2;
        int n = nums.length;
        // dp[i][j]：区间 nums[0..i - 1] 里是否存在若干个元素之和为 j
        boolean[][] dp = new boolean[n + 1][target + 1];
        dp[0][0] = true;
        for (int i = 1; i <= n; i++) {
            // 这一行不写也行，因为 for 循环里的 else 语句有 dp[i][j] = dp[i - 1][j] 包含了这一行代码
            dp[i][0] = true;
            for (int j = 0; j <= target; j++) {
                if (nums[i - 1] <= j) {
                    dp[i][j] = dp[i - 1][j] || dp[i - 1][j - nums[i - 1]];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
            // 由于状态转移方程的特殊性，提前结束，可以认为是剪枝操作
            if (dp[i][target]) {
                return true;
            }
        }
        return dp[n][target];
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。

## 三、优化空间写法


**考虑优化空间**：按照「0-1 背包问题」的优化空间策略，有滚动数组和倒着赋值，滚动数组我们省略，这里仅提供倒着赋值的参考代码。

**参考代码 3**： 按照「参考代码 1」的状态定义优化空间。

```java
public class Solution {

    public boolean canPartition(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum % 2 == 1) {
            return false;
        }

        int n = nums.length;
        int target = sum / 2;
        boolean[] dp = new boolean[target + 1];
        if (nums[0] <= target) {
            dp[nums[0]] = true;
        }
        for (int i = 1; i < n; i++) {
            // 倒着计算，防止「上一行」的状态值被覆盖
            for (int j = target; j >= 0; j--) {
                if (nums[i] <= j) {
                    dp[j] = dp[j] || dp[j - nums[i]];
                }
            }
            if (dp[target]) {
                return true;
            }
        }
        return dp[target];
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(n \times \text{target}) $；
+ 空间复杂度：$ O(n \times \text{target}) $，减少了物品维度，无论来多少个数，用一行表示状态就够了。

## 四、类似问题列表

背包问题还有其它种类，我觉得应付面试、笔试掌握到完全背包就可以了，下面的罗列的问题，标注为「困难」的都没有必要掌握。个人建议，经供参考。

### 「力扣」上的 0-1 背包问题

* 「力扣」第 416 题：分割等和子集（中等）；
* 「力扣」第 474 题：一和零（中等）；
* 「力扣」第 494 题：目标和（中等）；
* 「力扣」第 879 题：盈利计划（困难）。


### 「力扣」上的 完全背包问题

* 「力扣」第 322 题：零钱兑换（中等）；
* 「力扣」第 518 题：零钱兑换 II（中等）；
* 「力扣」第 1449 题：数位成本和为目标值的最大数字（困难）。

这里要注意：「力扣」第 377 题：组合总和 Ⅳ，不是「完全背包」问题。','17',NULL,'0416-partition-equal-subset-sum','2025-06-11 08:12:31','2025-06-18 23:33:43',1,8,false,NULL,'https://leetcode.cn/problems/partition-equal-subset-sum/description/',39,21,'',false,'https://leetcode.cn/problems/partition-equal-subset-sum/solutions/13059/0-1-bei-bao-wen-ti-xiang-jie-zhen-dui-ben-ti-de-yo/',true,'完成。',NULL),(106,'liweiwei1419','「力扣」第 15 题：三数之和（中等）','## 思路分析
**暴力解法**：最容易想到的做法是 **枚举** 三数之和的所有情况，时间复杂度为 $ O(n^3) $，这里 $ n $ 为输入数组的长度。还需要处理重复的三元组问题，这会让代码变得更加复杂。

**优化思路**：为了避免暴力解法的高时间复杂度和复杂的去重逻辑，我们可以 **先对数组排序**，让相同的元素排在一起，这样就可以在遍历过程中跳过重复的元素。然后固定一个数 `nums[i]`，用双指针在剩余数组中寻找另外两个数，满足三数之和为 0。

**具体做法（这里的分析同「力扣」第 167 题）**：我们用两个指针变量 `left` 和 `right` 分别指向剩下部分的头和尾，即 `left` 指向最小的数， `right` 指向最大的数，`i` 在某一轮中固定。

+ 如果 `nums[i] + nums[left] + nums[right] = 0`，说明找到了一组解；
+ 如果 `nums[i] + nums[left] + nums[right] > 0`，由于 `nums[right]` 是区间 `[left..right]` 里最大的数，它与区间 `[left..right]` 里最小的数 `nums[left]` 和 `nums[i]` 相加都大于 `0`，所以 `nums[right]` 一定不是三数之一，此时将 `right` 左移；
+ 同理，如果 `nums[i] + nums[left] + nums[right] < 0`，由于 `nums[left]` 是区间 `[left..right]` 里最小的数，它与区间 `[left..right]` 里最大的数 `nums[right]` 和 `nums[i]` 相加都小于 `0`，所以 `nums[left]` 一定不是三数之一，此时将 `left` 右移。

**编码细节**：

+ 由于需要对数组排序，如果枚举第 1 个数都大于 0，后面的数肯定也大于 0，三数之和肯定大于 0，程序可以终止了；
+ 枚举 `i` 的时候，如果连续若干个数相等，只需要保留第 1 个数搜索的结果，后面相同的数搜索的结果会产生重复；
+ `left` 和 `right` 相向移动的时候，为了避免搜索到相同的结果，在找到一组解以后，`left` 右移到和上一次值不同的位置， `right` 左移到和上一次值不同的位置，在代码中分别体现为两个循环语句；

整个代码细节比较多，但其实没有那么难，考虑清楚一些特殊的用例，就不难写出正确的代码。其它细节，我们作为注释写在代码中。

**参考代码**：

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Solution {

    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> res = new ArrayList<>();
        int n = nums.length;
        // 特殊用例判断
        if (n < 3) {
            return res;
        }

        // 排序是去重复的前提
        Arrays.sort(nums);
        // i 枚举到 n - 1 就可以，从 n - 2 开始凑不出 3 个数
        for (int i = 0; i < n - 2; i++) {
            // 因为有序，如果 nums[i] > 0，后面的数一定得不到三数之和为 0
            if (nums[i] > 0) {
                // 注意是 break 不是 continue
                break;
            }

            // 理解这个剪枝非常重要
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }

            int left = i + 1;
            int right = n - 1;
            // 注意：这里是严格小于，因为要找的是不重合的两个数，当 left 和 right 重合的时候，本轮搜索结束
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];

                if (sum == 0) {
                    List<Integer> cur = new ArrayList<>();
                    cur.add(nums[i]);
                    cur.add(nums[left]);
                    cur.add(nums[right]);
                    res.add(cur);

                    // 剪枝，避免 left 和 right 寻找的过程中出现重复
                    while (left < right && nums[left + 1] == nums[left]) {
                        left++;
                    }
                    while (left < right && nums[right - 1] == nums[right]) {
                        right--;
                    }

                    left++;
                    right--;
                } else if (sum > 0) {
                    // 后面的数太大了，让 right 往左走一步试试看
                    right--;
                } else {
                    // sum < 0， 前面的数太小了，让 left 往右走一步试试看
                    left++;
                }
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是输入数组的长度。
    - 排序的时间复杂度为 $ O(n \log n) $；
    - 外层循环枚举 `i` 的时间复杂度为 $ O(n) $，内层循环使用双指针的时间复杂度为 $ O(n) $，合起来为 $ O(n^2) $。综合以上两个复杂度 $ O(n \log n + n^2) = O(n^2) $；
+ 空间复杂度：$ O(1) $。除了存储结果的列表，只使用了常数级别的额外空间。

## 本题总结
本题的难点有 2 个：

+ 想到通过排序去除重复三元组；
+ 理解为什么排序以后，可以使用双指针降低时间复杂度，可以结合「力扣」第 167 题理解。

很多算法问题关键在于想清楚为什么，而不应该只记住解法，**分析、解决问题的过程更重要**。','7',NULL,'0015-3sum','2025-06-11 09:00:31','2025-06-14 14:55:26',1,4,false,NULL,'https://leetcode.cn/problems/3sum/description/',29,7,'',false,'https://leetcode.cn/problems/3sum/solutions/757225/shuang-zhi-zhen-dian-xing-wen-ti-java-go-sl5n/',true,NULL,NULL),(72,'liweiwei1419','「力扣」第 5 题：最长回文子串（中等）','## 思路分析
回文天然具有「状态转移」性质：一个长度大于 2 的回文，去掉头尾字符以后，剩下的部分依然是回文。反之，如果一个字符串头尾两个字符都不相等，那么该字符串一定不是回文，动态规划的状态定义和状态转移根据此得到。

+ **定义状态**：`dp[i][j]` 表示子串 `s[i..j]` 是否为回文子串；
+ **状态转移方程**：根据上面回文性质的叙述，可以得到 `dp[i][j] = (s[i] == s[j]) and dp[i + 1][j - 1]`。看到 `dp[i + 1][j - 1]` 就需要考虑特殊情况：如果去掉 `s[i..j]` 头尾两个字符的子串 `s[i + 1..j - 1]` 的长度小于 2（不构成区间），即 `j - 1 - (i + 1) + 1 < 2` 时，整理得 `j - i < 3`，此时 `s[i..j]` 是否是回文只取决于 `s[i]` 与 `s[j]` 是否相等；
+ **考虑初始化**：单个字符一定是回文串，因此先把对角线初始化为 `true`，即 `dp[i][i] = true`。当 `s[i..j]` 的长度为 2 或者 3 时，只需要判断 `s[i]` 是否等于 `s[j]`，所以二维表格对角线上的数值不会被参考，不设置 `dp[i][i] = true` 也能得到正确答案；
+ **考虑输出**：一旦得到 `dp[i][j] = true`，就记录子串的「长度」和「起始位置」。没有必要截取，这是因为截取字符串也有性能消耗，我们留在最后截取子串。

**参考代码 1**：

```java
public class Solution {

    public String longestPalindrome(String s) {
        int n = s.length();
        if (n < 2) {
            return s;
        }

        int maxLen = 1;
        int begin = 0;

        // dp[i][j]：表示 s[i..j] 是否是回文串
        boolean[][] dp = new boolean[n][n];
        char[] charArray = s.toCharArray();
        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
        }
        for (int j = 1; j < n; j++) {
            for (int i = 0; i < j; i++) {
                if (charArray[i] != charArray[j]) {
                    dp[i][j] = false;
                } else {
                    // 区间 [i + 1..j - 1] 的长度 < 2 
                    if (j - i < 3) {
                        dp[i][j] = true;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1];
                    }
                }

                // 只要 dp[i][j] == true 成立，就表示子串 s[i..j] 是回文，此时记录回文长度和起始位置
                if (dp[i][j] && j - i + 1 > maxLen) {
                    maxLen = j - i + 1;
                    begin = i;
                }
            }
        }
        return s.substring(begin, begin + maxLen);
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^{2}) $，这里 $ n $ 是字符串的长度；
+ 空间复杂度：$ O(n^2) $，使用了二维表格记录所有可能的情况。

**关于「填表」顺序的说明**：由于 `dp[i][j]` 依赖 `dp[i + 1][j - 1]` ，因此需要保证 `dp[i + 1][j - 1]` 先计算出来，下图展示的 4 种填表顺序都是可以的，大家任选其一即可。

![](https://minio.dance8.fun/algo-crazy/0005-longest-palindromic-substring/temp-image10882203322990722861.png)

+ **考虑优化空间**：观察状态转移方程：`dp[i][j] = (s[i] == s[j]) && dp[i + 1][j - 1]`（`dp[i][j]` 的值只依赖于 `dp[i + 1][j - 1]`，即当前行的值只依赖于下一行的值）。在二维表格上，每一个状态值参考的是已经计算出来的左下角的状态值，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0005-longest-palindromic-substring/temp-image6530995680768727227.png)

可以通过 **倒着填表** 的方式将空间复杂度从 $ O(n^2) $ 优化到 $ O(n) $。

**参考代码 2**：这一版代码理解起来可能非常绕，大家可以在纸上模拟二维表格如何计算，进而理解使用一维数组是如何重复使用已经计算过的状态值。实在很难理解，也没有关系，优化空间在很多时候不是必须的。 

```java
public class Solution {

    public String longestPalindrome(String s) {
        int n = s.length();
        if (n < 2) {
            return s;
        }

        int maxLen = 1;
        int begin = 0;

        // 使用一维数组代替二维数组
        boolean[] dp = new boolean[n];
        char[] charArray = s.toCharArray();
        // 从后向前填充 dp 数组
        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= i; j--) {
                if (charArray[i] != charArray[j]) {
                    dp[j] = false;
                } else {
                    if (j - i < 3) {
                        dp[j] = true;
                    } else {
                        dp[j] = dp[j - 1];
                    }
                }

                // 如果 dp[j] == true，表示 s[i..j] 是回文子串
                if (dp[j] && j - i + 1 > maxLen) {
                    maxLen = j - i + 1;
                    begin = i;
                }
            }
        }
        return s.substring(begin, begin + maxLen);
    }

}
```

**说明**：外层循环从后向前遍历 `i`，内层循环从后向前遍历 `j`。这样可以确保在计算 `dp[j]` 时，`dp[j - 1]` 已经被正确更新。

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，其中 $n$ 是字符串的长度，需要遍历所有可能的子串；
+ 空间复杂度：$ O(n) $，使用一维数组代替二维数组。','17',NULL,'0005-longest-palindromic-substring','2025-06-11 08:12:31','2025-06-18 18:44:58',2,58,false,NULL,'https://leetcode.cn/problems/longest-palindromic-substring/description/',39,17,'',false,NULL,true,'完成。',NULL),(141,'liweiwei1419','「力扣」第 295 题：数据流的中位数（困难）','## 思路分析

中位数是指将一组数据 **有序排列** 后，处于中间位置的数。根据题意，当元素总个数是奇数时，中位数只有 1 个，当元素总个数是偶时，中位数是中间两个数的平均值。**要高效计算中位数，关键是要能快速访问排序后数据的中间部分**。

数据流的特点是数据 **动态增加**，我们无法预知所有数据，也无法直接排序（因为每次新数据到来都要重新排序，时间复杂度太高）。我们需要一种能 **动态维护有序中间部分** 的数据结构，优先队列正好满足这个要求。

我们将数据分成较小的一半和较大的一半，那么：中位数就来自 **较小的一半的最大值和较大的一半的最小值**，其中较小的一半的最大值可以用最大堆得到，较大的一半的最小值可以用最小堆得到。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749779097-tbXeAy-image.png)


**编码细节**：

+ **插入操作**：
    - 可以让新元素在最大堆与最小堆里走一遍（让两个数据结构都看到这个新元素，各自调整元素的位置），即：先加入最大堆，再将最大堆的堆顶元素加入最小堆；
    - 在加入元素的同时，看看两个堆的元素总数。我们规定最大堆始终比最小堆多 1 个元素（规定最小堆始终比最大堆多 1 个元素也可以，在查询中位数的的时候就需要做调整）；
    - **如果两个堆的元素总个数是奇数的时候，还需要把最小堆的堆顶元素再放回最大堆，这是因为我们在上一步规定最大堆始终比最小堆多 1 个元素**。
+ **查询中位数**：
    - 如果数据总个数是奇数，让最大堆比最小堆多 1 个元素，此时中位数就是最大堆的堆顶元素（如果插入操作的时候让最小堆比最大堆多 1 个元素，此时中位数就是最小堆的堆顶元素）；
    - 如果数据总个数是偶数，让最大堆和最小堆大小相等，此时中位数是两个堆顶的平均值。
+ 在判断两个堆的元素总是是奇数还是偶数的时候，可以使用两个堆的大小之和，也可以全局维护一个 `size` 变量，具体实现由大家自己决定。

**参考代码**：

```java
import java.util.PriorityQueue;

public class MedianFinder {

    // 定义：元素总个数是奇数的时候，让「最大堆」多 1 个元素

    private int size;
    private PriorityQueue<Integer> maxHeap;
    private PriorityQueue<Integer> minHeap;

    public MedianFinder() {
        size = 0;
        maxHeap = new PriorityQueue<>((x, y) -> y - x);
        minHeap = new PriorityQueue<>();
    }

    public void addNum(int num) {
        size += 1;
        maxHeap.offer(num);
        minHeap.add(maxHeap.poll());
        // 如果两个堆合起来的元素个数是奇数，「最小堆」要拿出堆顶元素给「最大堆」
        if ((size % 2) == 1) {
            maxHeap.add(minHeap.poll());
        }
    }

    public double findMedian() {
        if ((size % 2) == 0) {
            return (double) (maxHeap.peek() + minHeap.peek()) / 2;
        } else {
            return (double) maxHeap.peek();
        }
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(\log n) $，这里 $ n $ 是数据流的元素总数；
+ 空间复杂度：$ O(n) $，两个堆所占用的空间之和为 $ n $。

## 本题总结

+ 「动态」问题场景下求最值，最合适的数据结构是优先队列，结合中位数的特点：排序以后前半部分的最大值、后半部分的最小值，我们需要分别使用最大堆和最小堆；
+ **`addNum` 方法的实现是本题关键的地方，让新添加的元素在两个堆里转一圈，特别是元素个数总数之和为奇数的时候，还要让最小堆拿出一个元素给最大堆，堆中元素的顺序根据各自堆的规则自动调整**。
','5',NULL,'0295-find-median-from-data-stream','2025-06-11 09:24:56','2025-06-13 09:55:55',1,6,false,NULL,'https://leetcode.cn/problems/find-median-from-data-stream/description/',35,3,'',false,NULL,true,NULL,NULL),(139,'liweiwei1419','「力扣」第 215 题：数组中的第 K 个最大元素（中等）','优先队列被广泛应用于解决需要高效处理大量数据、快速获取最大或最小元素的问题。以下是对使用优先队列解决的问题特点的总结：

+ **快速访问最大或最小元素**：优先队列可以在 $ O(1) $ 时间内获取最大或最小元素，适用于合并、排序和选择问题；
+ **动态维护元素**：优先队列支持高效插入和删除操作，适用于需要动态管理元素的场景，如滑动窗口最大值；
+ **处理大量数据**：问题通常涉及多个数组、链表或其他数据结构，需要处理大量元素。

---

## 思路分析
优先队列是「Top K」问题典型的应用场景，用最大堆或者最小堆都可以实现。

### 方法一：使用最大堆
把所有的元素都放入最大堆里，依次执行 `k - 1` 次弹出操作后，堆顶元素即为所求。

**参考代码 1**：

```java
import java.util.Collections;
import java.util.PriorityQueue;

public class Solution {

    public int findKthLargest(int[] nums, int k) {
        // 使用 Collections.reverseOrder() 创建最大堆
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int num : nums) {
            maxHeap.offer(num);
        }
        for (int i = 0; i < k - 1; i++) {
            maxHeap.poll();
        }
        return maxHeap.peek();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n + k \log n) $，建堆 $ O(n) $，每次弹出 $ O(\log n) $；
+ 空间复杂度：$ O(n) $，优先队列的大小。

### 方法二：使用最小堆
当 `n` 远大于 `k` 时，或者无法将所有的元素都一次性放入内存时，使用最小堆维护 `k` 个最大元素，让所有的数在堆里转一圈，大于堆顶的数都留在堆里，最终堆顶元素即为所求。具体做法是：

+ 初始化 `k` 个元素的最小堆，加入前 `k` 个元素；
+ 遍历剩余元素，若当前元素 > 堆顶（即比当前第 `k` 大的元素更大），则替换堆顶；
+ 最终堆顶即为第 `k` 个最大的元素。

**参考代码 2**：

```java
import java.util.Comparator;
import java.util.PriorityQueue;

public class Solution {

    public int findKthLargest(int[] nums, int k) {
        // 使用一个含有 k 个元素的最小堆，PriorityQueue 底层是动态数组，为了防止数组扩容产生消耗，可以先指定数组的长度
        PriorityQueue<Integer> minHeap = new PriorityQueue<>(k, Comparator.comparingInt(a -> a));
        for (int i = 0; i < k; i++) {
            minHeap.offer(nums[i]);
        }
        int n = nums.length;
        for (int i = k; i < n; i++) {
            // 只要当前遍历的元素比堆顶元素大，堆顶弹出，遍历的元素进去
            if (nums[i] > minHeap.peek()) {
                // Java 没有 replace()，所以得先 poll() 出来，然后再放回去
                minHeap.poll();
                minHeap.offer(nums[i]);
            }
        }
        return minHeap.peek();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log k) $，每个元素最多进行一次堆操作；
+ 空间复杂度：$ O(k) $，优先队列的大小。

## 本题总结
最小堆、最大堆的选择依据：

| 场景 | 推荐方法 | 原因 |
| --- | --- | --- |
| 数据量极大（`n ≫ k`） | 最小堆 | 仅需维护 `k` 个元素，空间复杂度 `O(k)` |
| 数据量较小 | 最大堆 | 实现简单，但需要存储所有元素，空间复杂度 `O(n)` |
| 需要在线处理数据流 | 最小堆 | 无需预先知道所有数据，适合流式数据（如实时输入的场景） |','5',NULL,'0215-kth-largest-element-in-an-array','2025-06-11 09:24:56','2025-06-13 09:36:58',1,41,false,NULL,'https://leetcode.cn/problems/kth-largest-element-in-an-array/description/',35,1,'',false,'https://leetcode.cn/problems/kth-largest-element-in-an-array/solutions/19607/partitionfen-er-zhi-zhi-you-xian-dui-lie-java-dai/',true,NULL,NULL),(77,'liweiwei1419','「力扣」第 494 题：目标和（中等）','## 思路分析
本题可以也转化为经典的「01 背包问题」：找到 `nums` 的两个子集，对这个两个子集分解求和，我们分别记为 `sum_pos` 和 `sum_neg`，使得：`sum_pos - sum_neg = target`（等式 1）。

设 `sum` 为数组 `nums` 的总和，于是有：`sum_pos + sum_neg = sum`（等式 2）。

将「等式 1」与「等式 2」相加，得：`2 * sum_pos = sum + target`，整理得：`sum_pos = (sum + target) / 2`。此时问题就转化为在数组 `nums` 中找到一个子集，使得这个子集的和为 `(sum + target) / 2`。这里 `sum + target` 需要是偶数。

还有一个边界条件，那就是如果每个整数前都加 `''+''` ，即 `sum < target` 时，无解，返回 0；同理，如果每个整数前都加 `''-''` ，即 `-sum > target` 时，无解，也返回 0。

接下来使用动态规划求解。

## 方法一：二维数组版
+ **状态定义**：`dp[i][j]`，表示前 `i` 个元素（对应区间 `nums[0..i - 1]` ，不包括 `nums[i]`）中，和为 `j` 的子集的方法数；
+ **状态转移方程**：
    - 如果不选第 `i` 个数字，则 `dp[i][j] = dp[i - 1][j]`；
    - 如果选第 `i` 个数字，且 `j >= nums[i - 1]`，则 `dp[i][j] += dp[i - 1][j - nums[i - 1]]`。
+ **考虑初始化**：
    - `dp[0][0] = 1`，表示前 0 个数字和为 0 的方法数为 1，即什么都不选；
    - 其他 `dp[0][j] = 0`（`j > 0`），因为前 0 个数字无法组成任何正数和。
+ **考虑输出**：最后一个状态值 `dp[n][(sum + target) / 2]` 即为所求。

**参考代码 1**：

```java
public class Solution {

    public int findTargetSumWays(int[] nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        // sum < target || -sum > target 表示全是正号或者负号都无解
        if ((sum + target) % 2 != 0 || sum < target || -sum > target) {
            return 0;
        }
        int S = (sum + target) / 2;
        int n = nums.length;
        // 代码到这里保证了 S + 1 >= 0，原因请见下面的「说明」
        int[][] dp = new int[n + 1][S + 1];
        dp[0][0] = 1;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= S; j++) {
                dp[i][j] = dp[i - 1][j];
                if (nums[i - 1] <= j) {
                    dp[i][j] += dp[i - 1][j - nums[i - 1]];
                }
            }
        }
        return dp[n][S];
    }

}
```

**说明**：这里 `S + 1` 作为数组的下标，我们就需要考虑 `S + 1` 的正负。由于之前我们判断了当 `sum < target || -sum > target` 时无解，因此代码走到 `int[][] dp = new int[n + 1][S + 1];` 这一行时，一定有：`sum >= target` 并且 `-sum <= target` 成立，因此 `target + sum >= 0`，`S = (sum + target) / 2 > 0`。

**复杂度分析**：

+ 时间复杂度： $ O(n \times S) $，其中 `n` 是数组 `nums` 的长度，`S` 是目标和 `(sum + target) / 2`；
+ 空间复杂度： $ O(n \times S) $。

## 方法二：一维数组优化版
**考虑优化空间**：观察二维动态规划的状态转移方程，可以发现 `dp[i][j]` 只依赖于 `dp[i - 1][j]` 和 `dp[i - 1][j - nums[i - 1]]`，因此可以将二维数组优化为一维数组，从后往前更新 `dp` 数组以避免覆盖「当前行」的状态值。

**参考代码 2**：

```java
import java.util.Arrays;

public class Solution {

    public int findTargetSumWays(int[] nums, int target) {
        int sum = Arrays.stream(nums).sum();
        if (sum < Math.abs(target) || (sum + target) % 2 != 0) {
            return 0;
        }
        int S = (sum + target) / 2;
        int[] dp = new int[S + 1];
        dp[0] = 1;
        for (int num : nums) {
            for (int j = S; j >= num; j--) {
                dp[j] += dp[j - num];
            }
        }
        return dp[S];
    }

}
```

**复杂度分析**：

+ 时间复杂度： $ O(n \times S) $，其中 `n` 是数组 `nums` 的长度，`S` 是目标和 `(sum + target) / 2`；
+ 空间复杂度： $ O(S) $。

# 总结
动态规划是 01 背包问题的标准解法，其基本思想是：将问题拆解为子问题，通过求解子问题来构建大问题的解。我们一点一点扩大物品的考虑范围，依次求得所有可能的背包容量下可选择物品的最大价值，状态定义是这么来的。每个物品可选或者不选，由此得到状态转移方程。

对于优化空间：

+ 正序会导致参考错误的状态值，如果 `j` 从小到大更新，`dp[j - w[i]]` 可能已经被当前层的 `i` 更新过；
+ 逆序保证 `dp[j - w[i]]` 来自上一层，即 `i - 1` 时的状态。','17',NULL,'0494-target-sum','2025-06-11 08:12:31','2025-06-19 02:17:19',1,5,false,NULL,'https://leetcode.cn/problems/target-sum/description/',39,22,'',false,NULL,true,'再优化一下。',NULL),(171,'liweiwei1419','「力扣」第 128 题：最长连续序列（困难）','## 思路分析

题目要求找到 **连续** 的数字序列，关键点在于：序列中的数字必须是相邻的，如 `x` 和 `x + 1` 要属于同一组，将数值相邻的数字合并到同一组，并跟踪最大的组大小。

这提示我们需要一种能高效 **合并集合** 与 **查询集合大小** 的数据结构，并查集正好满足需求：

+ **合并**：将相邻的数字（如 `x` 和 `x + 1` 或者 `x - 1`）合并到同一集合；
+ **查找**：快速判断两个数字是否属于同一集合；
+ **维护集合大小**：通过记录每个集合的大小，可以动态更新最长序列长度。

于是我们可以这样做：对每个数字 `x`，检查 `x - 1` 或者 `x + 1` 是否存在于同一个集合中，如果存在，则合并 `x` 、 `x - 1` 或 `x + 1` 所在的集合。**经过一轮遍历，就可以把数值上相邻的数字合并到同一集合**，在合并过程中，维护当前最大集合的大小。**题目要求数值上「连续」是我们想到使用并查集的原因**。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public int longestConsecutive(int[] nums) {
        int n = nums.length;
        if (n < 2) {
            return n;
        }

        UnionFind unionFind = new UnionFind(nums);
        int res = 1;
        for (int num : nums) {
            // 或者 unionFind.contains(num - 1) ，然后 unionFind.union(num, num - 1)
            if (unionFind.contains(num + 1)) {
                res = Math.max(res, unionFind.union(num, num + 1));
            }
        }
        return res;
    }

    // 由于数值是离散的，parent 数组使用哈希表代替
    private class UnionFind {

        private Map<Integer, Integer> parent;
        // 维护以当前结点为根的子树的结点总数
        private Map<Integer, Integer> size;

        public UnionFind(int[] nums) {
            int n = nums.length;
            parent = new HashMap<>(n);
            size = new HashMap<>(n);

            for (int num : nums) {
                // 将每个数字视为独立的集合，即父结点指向自己
                parent.put(num, num);
                size.put(num, 1);
            }
        }

        // union 方法返回了以合并以后的连通分量的结点个数
        public int union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);

            if (rootX == rootY) {
                return 0;
            }

            int sizeX = size.get(rootX);
            int sizeY = size.get(rootY);

            int sum = sizeX + sizeY;
            if (sizeX < sizeY) {
                parent.put(rootX, rootY);
                size.put(rootY, sum);
            } else {
                parent.put(rootY, rootX);
                size.put(rootX, sum);
            }
            return sum;
        }

        public int find(int x) {
            while (x != parent.get(x)) {
                // 实现了路径压缩，底下那些结点错了没有关系，根结点对就可以了
                parent.put(x, parent.get(parent.get(x)));
                x = parent.get(x);
            }
            return x;
        }

        // 新增 contains 方法
        public boolean contains(int x) {
            return parent.containsKey(x);
        }
    }

}
```

**说明：**

+ 并查集初始化：将数组中的每个元素初始化为一个独立的集合，由于数组中的数值范围较广，且有负数，为了避免浪费空间和处理负数，我们将并查集的底层结构设置为哈希表；
+ 在合并的时候：遍历数组中的每个元素 `num`，以下二者都可以将数值上连续的数字合并在一个集合中，大家选择其中之一就好：
    - 如果 `num + 1` 也在输入数组中，将 `num` 和 `num + 1` 所在的集合合并；
    - 如果 `num - 1` 也在输入数组中，将 `num` 和 `num - 1` 所在的集合合并；
+ 维护集合的结点个数：在合并的时候，返回合并以后的集合的大小，取最大值即为最长连续序列的长度。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度。虽然并查集的合并和查找操作的时间复杂度接近常数，但在最坏情况下可能会达到 $ O(\alpha(n)) $，其中 $ \alpha(n) $ 是阿克曼函数的反函数，非常接近常数，因此总的时间复杂度为 $ O(n) $；
+ 空间复杂度：$ O(n) $，主要用于存储并查集的 `parent` 和 `size` 数组。

## 本题总结
由于输入数组都是整数，题目又要求连续和求连续的长度，我们可以将连续的数字看作一个集合，利用并查集来合并这些集合，最后找出最大集合的大小。

**通过本题我们可以再次体会何时使用并查集**：

+ **问题涉及动态分组**（如合并集合、查询连通性）。
+ **需要高效处理相邻/连续关系**（如连续序列、岛屿连通问题）。
+ **数据离散但范围较大**（用哈希表代替数组存储父结点）。

在本题中，并查集通过 **隐式建立数字间的连续关系**，巧妙地避免了排序或暴力搜索，实现了高效的最长序列查找。','23',NULL,'0128-longest-consecutive-sequence','2025-06-11 09:46:05','2025-06-12 14:59:30',1,3,false,NULL,'https://leetcode.cn/problems/longest-consecutive-sequence/description/',45,3,'',false,NULL,false,NULL,NULL),(142,'liweiwei1419','「力扣」第 105 题：从前序与中序遍历序列构造二叉树（中等）','
## 题意分析
这道题要求我们根据一棵树的前序遍历与中序遍历构造二叉树，如果树中有重复元素，那么题目中的前序遍历和中序遍历就指代不明，所以「提示」的第 4 点说：`preorder` 和 `inorder` 均 **无重复** 元素。	

## 思路分析
我们以「示例 1」为例分析本题的思路。根据前序遍历的定义，`**preorder**`** 的第 1 个结点一定是二叉树的根结点**，因此可以在 `inorder` 中找根结点的位置，根结点把 `inorder` 分成了两个部分：

+ 第 1 部分：左边是左子树，本例中只有 1 个结点，9；
+ 第 2 部分：右边是右子树的所有结点，它们是 15、20、7。

再回到 `preorder` 中，根据 `inorder` 中左子树和右子树的结点个数，可以得到 `preorder` 中左、右子树的划分。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1740379799957-cf349cf1-c4b4-4d5e-a29b-aa52158461fd.png)

可以通过递归，用 `preorder` 和 `inorder` 构造根结点的两个子树。在编码的之前，我们还需要做一些简单的计算。

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749726220176-e02081b6-88c7-4468-bf57-33dac6a67b26.png)

由于需要频繁地查询 `preorder` 的第 1 个结点在 `inorder` 中出现的位置，可以先把 `inorder` 的值和下标通过哈希表存起来（这里利用了树中没有重复元素的特点），哈希表我们会在第 13 章向大家介绍。

**参考代码 1**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        int n = inorder.length;
        // 记录中序遍历的值和下标的对应关系
        Map<Integer, Integer> hashMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            hashMap.put(inorder[i], i);
        }
        return buildTree(0, n - 1, 0, n - 1, hashMap, preorder);
    }

    private TreeNode buildTree(int preLeft, int preRight, int inLeft, int inRight, Map<Integer, Integer> hashMap, int[] preorder) {
        if (preLeft > preRight || inLeft > inRight) {
            return null;
        }
        // 前序遍历序列的第一个结点是根结点
        int pivot = preorder[preLeft];
        TreeNode root = new TreeNode(pivot);
        int pivotIndex = hashMap.get(pivot);
        // 递归构建左右子树
        root.left = buildTree(preLeft + 1, pivotIndex - inLeft + preLeft, inLeft, pivotIndex - 1, hashMap, preorder);
        root.right = buildTree(pivotIndex - inLeft + preLeft + 1, preRight, pivotIndex + 1, inRight, hashMap, preorder);
        return root;
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(n) $，这里 $ n $ 是二叉树的结点个数；
+ 空间复杂度：$ O(n) $，记录哈希表存储 `inorder` 的值和下标的对应关系需要空间 $ O(n) $，递归方法调用栈的空间是 $ O(\log n) $。

其实前序遍历其实还是深度优先遍历，因此 `preLeft` 的值是递增的，还原二叉树的整个过程是：

+ 依次创建前序遍历的结点；
+ 找到中序遍历序列中左右子树的下标区间，通过递归的方式把结点挂接上去。

这样可以减少下标的计算和参数的传递。

**参考代码 2**：代码的语义没有「参考代码 1」那么直观，可解释性差一点，容易把人绕进去。大家能够理解「参考代码 1」就好了。

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    private int preIndex = 0;

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        Map<Integer, Integer> hashMap = new HashMap<>();
        int n = inorder.length;
        for (int i = 0; i < n; i++) {
            hashMap.put(inorder[i], i);
        }
        return buildTree(preorder, 0, n - 1, hashMap);
    }

    private TreeNode buildTree(int[] preorder, int inStart, int inEnd, Map<Integer, Integer> hashMap) {
        if (inStart > inEnd) {
            return null;
        }

        // 前序遍历的第一个结点是根结点
        TreeNode root = new TreeNode(preorder[preIndex]);
        // 移动到下一个待处理的结点
        preIndex++;
        // 找到根结点在中序遍历中的位置
        int inIndex = hashMap.get(root.val);
        root.left = buildTree(preorder, inStart, inIndex - 1, hashMap);
        root.right = buildTree(preorder, inIndex + 1, inEnd, hashMap);
        return root;
    }

}
```

**编码细节：**`preIndex` 的作用：

- 它是一个成员变量，记录 `preorder` 当前处理到的位置；
- 每次递归调用时，`preIndex` 会自动递增，确保每次处理的都是 `preorder` 的下一个结点；
- 由于 `preIndex` 是全局递增的，左、右子树的根结点会自动取 `preorder` 的下一个值。

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
利用前序遍历确定根结点，利用中序遍历分割左右子树。具体来说：

+ 前序遍历 `preorder` 的第一个元素一定是当前子树的根结点；
+ 中序遍历 `inorder` 中，根结点左边的所有元素属于左子树，右边的所有元素属于右子树；
+ 通过递归分别构建左子树和右子树。','13',NULL,'0105-construct-binary-tree-from-preorder-and-inorder-traversal','2025-06-11 09:27:50','2025-06-12 19:15:30',2,8,false,NULL,'https://leetcode.cn/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/',36,1,'',false,'https://leetcode.cn/problems/construct-binary-tree-from-preorder-and-inorder-traversal/solutions/8946/qian-xu-bian-li-python-dai-ma-java-dai-ma-by-liwei/',true,NULL,NULL),(143,'liweiwei1419','「力扣」第 236 题：二叉树的最近公共祖先（中等）','## 题意分析

二叉树的特点是：除了根结点，其余结点都只有一个父亲结点。

本题中，祖先结点的定义是：一个结点向上走 （只会有唯一的一条路径），沿途经过的结点是它的祖先结点。

两个结点向上走，最先相遇的那个结点就是它们的最近公共祖先结点。

## 思路分析
清楚了最近公共祖先的定义以后。我们需要知道树的信息，至少要把树的结点都看一遍，即：遍历树的结点。**有一种遍历方式是一直向上看**，那就是后序遍历。于是可以先对左、右子树进行遍历，然后再根据左右、子树的返回值判断当前结点是不是最近公共祖先结点，具体判断规则如下：

+ 如果遍历到了 `p` 和 `q` 之一，向上传递（题目的「提示」的第 4 条说 `p != q`），当然遍历到空结点，也就是叶子结点的左、右结点，向上传递 `null`；
+ 如果左、右子树返回有且只有一个不为空，把这个非空的结点传上去；
+ 如果左、右子树都返回 `null`，说明 `p` 和 `q` 都不在左、右子树树中，向上传递 `null`；
+ 如果左、右子树的返回值都不为空，当前结点就是最近公共祖先结点，向上传递当前结点。一次深度优先遍历以后，就能得到 `p` 和 `q` 的最近公共祖先结点。

我们「示例 1」中的树为例，`p = 6`、`q = 7` 为例，展示后序遍历是如何完成本题的。

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749728534309-6164f0de-7c34-4c03-bd15-3305b4f32908.png)

**参考代码**：

```java
public class Solution {

    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null || root == p || root == q) {
            return root;
        }

        // 后序遍历
        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);

        // 这一句特别重要，如果左边和右边都非空，把当前结点传递「上去」
        if (left != null && right != null) {
            return root;
        }

        // 代码能走到这里，left 和 right 至少有一个为空，下面的这种写法包含了 left 和 right 同时为空的情况
        if (left == null) {
            return right;
        }
        return left;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是结点个数，每个结点只访问一次；
+ 空间复杂度：$ O(n) $，最坏情况下，树退化成链表，即栈里需要树的结点这么多的空间。

##  本题总结
+ 由于题目要找的最近公共祖先是两个结点向上走最先汇合的结点，后序遍历恰好符合了这一点，因此使用后序遍历的方式向上传递信息；
+ **后序遍历向上传递左右孩子结点的信息，是非常重要的概念**，其思想是分而治之。很多树的问题，基本都可以使用后序遍历解决；
+ 后序遍历是通过编写递归代码实现的。我们再次和大家强调，递归是工具，我们能用递归帮我们解决问题就好。不要因为递归有栈溢出的风险，就不用递归。应该具体问题具体分析，如果不用递归，很多树和图的编程问题都不能方便地编码实现。

','13',NULL,'0236-lowest-common-ancestor-of-a-binary-tree','2025-06-11 09:27:51','2025-06-13 14:57:43',1,12,false,NULL,'https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/description/',36,2,'',false,NULL,true,NULL,NULL),(170,'liweiwei1419','「力扣」第 200 题：岛屿数量（中等）','## 思路分析

这道题需要将上、下、左、右相邻的字符 `''1''` 视为一个整体，这正是并查集的应用场景。题目问岛屿数量，这也是并查集可以回答的问题。

我们可以遍历二维矩阵：

+ 如果是陆地（`''1''`），则与周围的陆地进行合并；
+ 如果是水域（`''0''`），可以将所有水域连接到虚拟结点 `dummy`，这样水域部分在并查集中会被视为一个连通分量。由于设置了虚拟结点，最后返回岛屿个数的时候，需要将虚拟结点代表的水域分量去掉，即 **岛屿个数 = 连通分量个数 -1**。

**编码细节**：

+ **方向优化**：只检查右侧和下方的相邻格子，避免重复合并；
+ **一维索引转换**：将二维坐标 `(i, j)` 转换为一维索引 `i * n + j`，其中 `n` 是列数。

**参考代码**：

```java
public class Solution {

    public int numIslands(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] directions = new int[][]{{0, 1}, {1, 0}};
        // size 的值也是虚拟结点 dummy 的下标
        int size = rows * cols;
        // 多开一个空间，把 ''0'' 都与虚拟结点连在一起
        UnionFind unionFind = new UnionFind(size + 1);
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == ''1'') {
                    for (int[] direction : directions) {
                        int newX = i + direction[0];
                        int newY = j + direction[1];
                        if (inArea(newX, newY, rows, cols) && grid[newX][newY] == ''1'') {
                            unionFind.union(getIndex(i, j, cols), getIndex(newX, newY, cols));
                        }
                    }
                } else {
                    unionFind.union(getIndex(i, j, cols), size);
                }
            }
        }
        return unionFind.getCount() - 1;
    }

    private boolean inArea(int x, int y, int rows, int cols) {
        return x >= 0 && x < rows && y >= 0 && y < cols;
    }

    private int getIndex(int x, int y, int cols) {
        return x * cols + y;
    }

    private class UnionFind {

        private int[] parent;
        // 连通分量个数
        private int count;

        public int getCount() {
            return count;
        }

        public UnionFind(int n) {
            count = n;
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            while (x != parent[x]) {
                // 只实现了路径压缩，并且是隔代压缩
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) {
                return;
            }
            parent[rootX] = rootY;
            count--;
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(mn \cdot \log (mn)) $。其中 $ m $ 和 $ n $ 分别为行数和列数。我们这里只使用了「路径压缩」优化，每次「合并」与「查询」操作的平均时间复杂度为 $ O(\log (mn)) $；
+ 空间复杂度：$ O(mn) $，这是并查集需要使用的空间。

## 本题总结

+ **虚拟水域结点**：统一处理所有 `''0''`，简化逻辑；
+ **方向优化**：仅检查右和下，避免重复合并；
+ **路径压缩**：提升 `find` 操作效率；
+ **精简代码**：省略按秩合并。','23',NULL,'0200-number-of-islands-union-find','2025-06-11 09:46:05','2025-06-11 09:46:05',0,7,false,NULL,'https://leetcode.cn/problems/number-of-islands/description/',45,2,'',false,NULL,false,NULL,NULL),(183,'liweiwei1419','「力扣」第 79 题：单词搜索（中等）','## 思路分析

使用回溯算法：遍历网格，找到与单词首字母匹配的位置作为起点，从该位置开始，向四个方向（上、下、左、右）递归搜索，每次访问过的位置要标记，避免重复使用，如果某个方向匹配失败，回溯并尝试其它方向。

**参考代码 1**：

```java
public class Solution3 {

    private static final int[][] DIRECTIONS = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}};

    public boolean exist(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;

        boolean[][] visited = new boolean[m][n];
        char[] charArray = word.toCharArray();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (dfs(i, j, 0, m, n, visited, board, charArray)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean dfs(int x, int y, int index, int m, int n, boolean[][] visited, char[][] board, char[] charArray) {
        if (index == charArray.length - 1) {
            return board[x][y] == charArray[index];
        }
        if (board[x][y] == charArray[index]) {
            visited[x][y] = true;
            for (int[] direction : DIRECTIONS) {
                int newX = x + direction[0];
                int newY = y + direction[1];
                if (inArea(newX, newY, m, n) && !visited[newX][newY]) {
                    if (dfs(newX, newY, index + 1, m, n, visited, board, charArray)) {
                        return true;
                    }
                }
            }
            visited[x][y] = false;
        }
        return false;
    }

    private boolean inArea(int x, int y, int m, int n) {
        return x >= 0 && x < m && y >= 0 && y < n;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，需遍历整个网格；
+ 空间复杂度：$ O(m \times n) $，递归栈的深度。

优化常源于特殊情况的针对性处理，如快速排序对有序数组和有大量重复元素的 `pivot` 优化。同理，本题中优先处理稀有字符可显著提升效率。

+ 若目标单词含稀有字符（如 `''B''` 仅出现 2 次，而 `''A''` 出现 20 次），优先从 `''B''` 开始搜索，最多只需尝试 2 个起点，而非 20 个；
+ 如果起点字符匹配概率低，DFS 会更快失败，避免深入无意义的路径。

因此，优先从出现频率低的字符开始搜索，能更快触发失败条件，减少整体计算量。

**参考代码 2**：

```java
public class Solution {

    private static final int[][] DIRECTIONS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public boolean exist(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;
        char[] charArray = word.toCharArray();
        int wordLen = word.length();
        // 优化 1：单词长度超过网格总单元格数
        if (wordLen > m * n) {
            return false;
        }
        // 优化 2：检查字符频率是否匹配
        // z 的 ASCII 为 122，因此数组开 123 个空间
        int[] boardCount = new int[123];
        int[] wordCount = new int[123];
        for (char[] row : board) {
            for (char c : row) {
                boardCount[c]++;
            }
        }
        // 检查单词中的字符是否都存在于网格中
        for (char c : charArray) {
            wordCount[c]++;
            if (wordCount[c] > boardCount[c]) {
                return false;
            }
        }

        // 优化 3：是否反向搜索
        boolean shouldSearchBackward = wordCount[charArray[0]] > wordCount[charArray[wordLen - 1]];
        char startChar = shouldSearchBackward ? charArray[wordLen - 1] : charArray[0];
        int startIndex = shouldSearchBackward ? wordLen - 1 : 0;
        int step = shouldSearchBackward ? -1 : 1;
        boolean[][] visited = new boolean[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == startChar) {
                    if (dfs(i, j, startIndex, step, m, n, board, charArray, visited)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // step、m、n、board、charArray、visited 全局共享，可以设置成为成员变量
    private boolean dfs(int x, int y, int index, int step, int m, int n, char[][] board, char[] charArray, boolean[][] visited) {
        if (index == (step > 0 ? charArray.length - 1 : 0)) {
            return board[x][y] == charArray[index];
        }

        if (board[x][y] == charArray[index]) {
            visited[x][y] = true;
            for (int[] direction : DIRECTIONS) {
                int newX = x + direction[0];
                int newY = y + direction[1];
                if (inArea(newX, newY, m, n) && !visited[newX][newY]) {
                    if (dfs(newX, newY, index + step, step, m, n, board, charArray, visited)) {
                        return true;
                    }
                }
            }
            visited[x][y] = false;
        }
        return false;
    }

    private boolean inArea(int x, int y, int m, int n) {
        return x < m && y < n && x >= 0 && y >= 0;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，需遍历整个网格；
+ 空间复杂度：$ O(m \times n) $，递归栈的深度。','16',NULL,'0079-word-search','2025-06-11 10:01:20','2025-06-15 20:46:10',1,3,false,NULL,'https://leetcode.cn/problems/word-search/description/',38,12,'',false,'https://leetcode.cn/problems/word-search/solutions/12096/zai-er-wei-ping-mian-shang-shi-yong-hui-su-fa-pyth/',true,NULL,NULL),(149,'liweiwei1419','「力扣」第 220 题：存在重复元素 III（困难）','## 思路分析

+ **暴力解法**：枚举所有下标差不超过 `indexDiff` 的下标对 `(i, j)`，一旦发现 `nums[i]` 与 `nums[j]` 的差值绝对值小于等于 `valueDiff`，就返回 `true`。不过这种方法的时间复杂度是 $ O(n^2) $，$ n $ 为数组长度，在数组规模较大时会超时。
+ **优化思路**：空间换时间，记住看过的数。

题目要求下标之差不超过 `indexDiff`，我们可以把与当前遍历的数 `a` 下标之差不超过 `indexDiff` 全部放进一个数据结构中，如果这个数据结构中有与 `a` 的数值之差的绝对值小于等于 `valueDiff` 的数，返回 `true`；

这个数据结构我们需要比较数值的大小，还要支持删除元素（与当前下标之差大于 `indexDiff` 的数值需要从数据结构中删除），最合适的数据结构是二叉搜索树，下面我们具体解释。

为了方便叙述，我们记 `nums[i] = a`，`nums[j] = b`，把不等式 `abs(a - b) <= valueDiff` 去掉绝对值符号再移项，得到：`a - valueDiff <= b <= a + valueDiff`。

这里假设 `a` 是当前遍历到的元素，我们希望之前遍历过的、且与 `a` 的下标之差小于等于 `indexDiff` 的元素中，有数值落在 `[a - valueDiff..a + valueDiff]` 这个区间内的，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749632248-xrtzZM-image.png)


而二叉搜索树提供的 `ceiling` 和 `floor` 函数，正好能帮我们解决这个问题：

+ `ceiling` 函数可以找出大于等于某个值的最小元素，
+ `floor` 函数能找出小于等于某个值的最大元素。

借助这两个函数（之一），就能高效判断之前遍历过的元素中是否有满足条件的数，以下两种方法选择一种就好。

**方法一**： 如果我们找到了比 `a - valueDiff` 大的最小的数，这个数不能太大，还需要它比 `a + valueDiff` 小，也就是判断二叉搜索树中是否存在 `b` 属于区间 `[a - valueDiff..a + valueDiff]`。

**参考代码 1**：

```java
import java.util.TreeSet;

public class Solution {

    public boolean containsNearbyAlmostDuplicate(int[] nums, int indexDiff, int valueDiff) {
        TreeSet<Long> treeSet = new TreeSet<>();
        int len = nums.length;
        for (int i = 0; i < len; i++) {
            // 查找大于等于 nums[i] - valueDiff 的最小值
            Long ceiling = treeSet.ceiling((long) nums[i] - (long) valueDiff);
            if (ceiling != null && ceiling <= ((long) nums[i] + (long) valueDiff)) {
                return true;
            }
            treeSet.add((long) nums[i]);
            if (i >= indexDiff) {
                treeSet.remove((long) nums[i - indexDiff]);
            }
        }
        return false;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log(indexDiff)) $，其中 $ n $ 是数组的长度。对于每个元素，在有序集合中进行查找和插入操作的时间复杂度为 $ O(\log(\min(n, indexDiff))) $。
+ 空间复杂度：$ O(indexDiff) $，主要用于存储有序集合中的元素，其大小最大为 `indexDiff + 1`。

**方法二**：如果我们找到了比 `nums[j] + valueDiff` 小的最大的数，这个数不能太小，还需要它比 `a - valueDiff` 大。

**参考代码 2**：

```java
import java.util.TreeSet;

public class Solution {

    public boolean containsNearbyAlmostDuplicate(int[] nums, int indexDiff, int valueDiff) {
        int len = nums.length;
        TreeSet<Long> set = new TreeSet<>();
        for (int i = 0; i < len; i++) {
            // 查找小于等于 nums[i] + valueDiff 的最大值
            Long floor = set.floor((long) nums[i] + (long) valueDiff);
            if (floor != null && floor >= (long) nums[i] - (long) valueDiff) {
                return true;
            }
            set.add((long) nums[i]);
            // 如果滑动窗口的大小超过了 indexDiff，移除最早加入的元素
            if (i >= indexDiff) {
                set.remove((long) nums[i - indexDiff]);
            }
        }
        // 遍历完数组都没有找到满足条件的元素对，返回 false
        return false;
    }

}
```

**复杂度分析**：（同「参考代码 1」）。

## 本题总结
+ 整体思路：保持长度为 `indexDiff + 1` 的窗口在数组上滑动，把窗口里的数全添加进二叉搜索树；
+ 遍历到数 `a` 的时候，看看二叉搜索树中有没有使得 `a - valueDiff <= b <= a + valueDiff` 的数 `b`（以下二者选其一）：
    - 看看有没有大于等于 `a - valueDiff` 的最小数（`ceiling`），它还小于等于 `a + valueDiff` ，说明 `b` 存在；
    - 或者看看有没有小于等于 `a + valueDiff` 的最大数（`floor`），它还大于等于 `a - valueDiff` ，说明 `b` 存在。','14',NULL,'0220-contains-duplicate-iii','2025-06-11 09:27:51','2025-06-12 18:05:28',1,9,false,NULL,'https://leetcode.cn/problems/contains-duplicate-iii/description/',36,8,'',false,'https://leetcode.cn/problems/contains-duplicate-iii/solutions/13681/hua-dong-chuang-kou-er-fen-sou-suo-shu-zhao-shang-/',true,NULL,NULL),(100,'liweiwei1419','「力扣」第 560 题：和为 K 的子数组（中等）','## 思路分析

**暴力解法**：最直观的方法是使用两层循环枚举所有可能的子数组，然后计算每个子数组的和，统计等于 `k` 的个数。参考代码省略。

**优化 1（通过前缀和得到区间和）**：暴力解法有重复计算，我们可以通过计算前缀和得到区间和。

**参考代码 1**：可以通过测评，但时间复杂度高，非最优解。

```java
public class Solution {

    public int subarraySum(int[] nums, int k) {
        int n = nums.length;
        // preSum[i] 表示 nums[0..i) 的所有元素的和
        int[] preSum = new int[n + 1];
        preSum[0] = 0;
        for (int i = 0; i < n; i++) {
            preSum[i + 1] = preSum[i] + nums[i];
        }

        int count = 0;
        for (int left = 0; left < n; left++) {
            for (int right = left; right < n; right++) {
                // 区间和 [left..right]，注意下标偏移
                if (preSum[right + 1] - preSum[left] == k) {
                    count++;
                }
            }
        }
        return count;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，其中 $ n $ 是数组的长度，使用两层循环枚举所有可能的子数组；
+ 空间复杂度：$ O(n) $，前缀和数组需要开辟 $ n + 1 $ 个空间。

其实还可以 **使用哈希表记住之前的前缀和**，通过一次遍历中，通过一边查找、一边记录解决问题。

**优化 2（使用哈希表记住前缀和信息）**： 我们给出两点提示：

+ **提示 1**： 假设当前位置前缀和为 `preSum`，如果之前出现过前缀和为 `preSum - k` ，那么我们就找到了一个区间和为 `k` 的子数组。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749633772-munOoM-image.png)



**提示**：「力扣」上非常经典的问题：第 1 题（两数之和），就利用了类似的思想：在遍历数组的时候，同时判断：如果之前出现过 `target - nums[i]` ，那么我们就找到了和为 `target` 的两个数，否则把遍历到的数组的值 `nums[i]` 存入哈希表。


+ **提示 2**： 假设当前得到的前缀和为 `preSum`，之前有多少个值 `preSum - k` 的前缀和，就能找到多少个区间和为 `k` 的连续子区间。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749633787-hYaPgy-image.png)


即：每一个值为 `preSum - k` 的前缀和，都对应了一个区间和为 `k` 的连续子数组。

综上所述，设计算法流程如下：

+ 用哈希表记录前缀和的出现次数，键：前缀和，值：出现次数；
+ 遍历时，先查询 `preSum - k` 在哈希表中是否存在，如果存在，就累加对应的次数到结果变量；
+ 遍历的同时，在哈希表中更新当前 `preSum` 的计数。

**参考代码 2**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public int subarraySum(int[] nums, int k) {
        int count = 0;
        int preSum = 0;
        // key：前缀和，value：key 对应的前缀和的个数
        Map<Integer, Integer> hashMap = new HashMap<>();
        // 补充：下标 -1 位置的「前缀和」为 0，个数位 1，这样就可以得到从下标 0 开始的区间和信息
        hashMap.put(0, 1);
        for (int num : nums) {
            // 计算当前「前缀和」
            preSum += num;
            // 检查前缀和 preSum - k 是否出现过，出现过几次就找个几个和为 k 的连续子数组
            if (hashMap.containsKey(preSum - k)) {
                count += hashMap.get(preSum - k);
            }
            // 维护「哈希表」的定义
            hashMap.put(preSum, hashMap.getOrDefault(preSum, 0) + 1);
        }
        return count;
    }

}
```

**说明：**初始化时设置 `hashMap.put(0, 1)` 的作用是：补充数组在下标 -1 位置的「前缀和」信息。在下标 -1 位置没有值，所以赋值为 0，不影响后面的前缀和计算，由于题目中关心的是次数，所以键 0 对应的值是 1。这样一来，**从下标 0 开始的区间和就可以通过哈希表找到**。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组的长度，只需要遍历数组一次；
+ 空间复杂度：$ O(n) $，主要用于存储哈希表，哈希表中最多存储 $ n $ 个不同的前缀和。

**补充说明**：有的朋友可能会有疑问，这道题是连续子数组的问题，是否可以用「滑动窗口」来做呢？

通常情况下，滑动窗口适用于处理满足特定单调性的问题，比如在连续子数组的和随着窗口的扩大或缩小呈现单调递增或递减时。但在本题中，不能使用滑动窗口，原因如下：

+ **单调性条件不满足**

滑动窗口算法的核心在于利用窗口的滑动（扩大或缩小）来寻找满足条件的子数组，这依赖于问题具有单调性。例如，在计算连续子数组的最大/最小和、最长/最短满足条件的子数组等问题中，当窗口右移时，窗口内元素的和是单调递增的；当窗口左移时，窗口内元素的和是单调递减的。

而在本题中，**数组中的元素可能包含负数**。当数组中存在负数时，随着窗口的扩大，窗口内元素的和并不一定是单调递增的；随着窗口的缩小，窗口内元素的和也不一定是单调递减的。这种情况下，我们无法通过简单地移动窗口的左右边界来确定满足和为 `k` 的子数组。

+ **无法明确窗口的移动规则**

在滑动窗口算法中，我们需要根据当前窗口内元素的和与目标值的大小关系来决定窗口是扩大还是缩小。当窗口内元素的和小于目标值时，我们通常会扩大窗口；当窗口内元素的和大于目标值时，我们会缩小窗口。

但在本题中，由于元素可能为负数，即使当前窗口内元素的和大于 `k`，我们也不能简单地缩小窗口，因为后续加入负数可能会使和再次等于 `k`。例如，数组 `[1, 5, -3, 2]`，目标值 `k = 3`，当窗口为 `[1, 5]` 时，和为 `6` 大于 `3`，如果按照滑动窗口的常规做法缩小窗口，就会错过后续可能满足条件的子数组 `[5, -3, 2]`。

综上所述，由于数组中元素可能为负数，导致和不具有单调性，无法明确窗口的移动规则，所以不能直接使用滑动窗口算法来解决「和为 K 的子数组」问题，而「前缀和结合哈希表」的方法则不受元素正负的影响，能够有效地解决本题。

## 本题总结

+ 如果「当前的前缀和（`preSum`）」比「之前的前缀和（`preSum - k`）」多 `k` ，则找到了一个和为 `k` 的区间；
+ 之前有多少个前缀和比当前前缀和少 `k` ，就对应了有多少个区间和为 `k`，因此需要在哈希表中记录前缀和的个数。

','20',NULL,'0560-subarray-sum-equals-k','2025-06-11 08:39:04','2025-06-12 13:48:36',1,7,false,NULL,'https://leetcode.cn/problems/subarray-sum-equals-k/description/',42,1,'',false,'https://leetcode.cn/problems/subarray-sum-equals-k/solutions/247577/bao-li-jie-fa-qian-zhui-he-qian-zhui-he-you-hua-ja/',false,NULL,NULL),(172,'liweiwei1419','「力扣」第 765 题：情侣牵手（困难）','## 思路分析

这道题要求我们计算最少需要多少次交换，使得所有情侣都能相邻坐在一起，关键在于如何高效地分组和计算交换次数。本题想到使用并查集有点烧脑，我们一点一点为大家分析。

首先，一对情侣被拆开了，肯定影响到另一対情侣，这种影响具有连续性，**不能牵手的情侣呈现出首位相连的情况**。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749637660-oVFPWi-image.png)

把它们交换到可以牵手的位置，至少需要「情侣对数 - 1」这么多次（2 对情侣交换 1 次，3 对情况交换 2 次，……）。因此我们就想知道 `n` 对情侣有多少对是这样可以连在一起的，换句话说，就是这 `n` 对情侣在一个连通分量中，由此想到使用并查集。

接下来的问题是如何判断情侣是否可以牵手呢？我们利用的是 **正整数除法向下取整** 的特性，根据题意，一对情侣的编号是「偶数」和「偶数 + 1」，它们除以 2 得到的数值相等，这是题目给我们的性质。

接下来我们把输入数组里，相邻位置的数值 / 2 的位置进行合并，**合并是为了得到有多少对情侣是那种「首尾相连、错误落座」的情况**，可以得到输入数组里有多少个连通分量。

那么总的交换次数是多少呢？我们假设有 `n` 个连通分量，每一个连通分量都需要这个连通分量里情侣对数 - 1 这么多次交换，那么总的交换次数就是「情侣对数 - 连通分量个数」。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749637668-tJcbsN-image.png)


**参考代码**：

```java
public class Solution {

    public int minSwapsCouples(int[] row) {
        int n = row.length;
        int N = n / 2;
        UnionFind unionFind = new UnionFind(N);
        for (int i = 0; i < N; i++) {
            // 如果相邻两个人是情侣，则什么都没有发生
            // 如果相邻两个人不是情侣，则把它们进行「合并」
            unionFind.union(row[2 * i] / 2, row[2 * i + 1] / 2);
        }
        return N - unionFind.count;
    }

    private class UnionFind {
        private int[] parent;
        private int count;

        public UnionFind(int n) {
            count = n;
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            while (x != parent[x]) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) {
                return;
            }
            parent[rootX] = rootY;
            count--;
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度： $ O(n \log n) $，这里 $ n $ 是输入数组的长度，$ O(2n \log 2n) = O(n \log n)  $；
+ 空间复杂度：$ O(n) $，并查集底层使用的数组长度为 $ 2n $，$ O(2n) = O(n) $。

## 本题总结

- 本题需要注意到不能牵手的情侣，其实是首尾相连、交错落座的，我们使用并查集把它们连起来，还利用了本题的特点：情侣的编号是正整数，一对情侣的编号是「偶数」和「偶数 + 1」），它们除以 2 得到的数值相等；
- 我们还注意到，每一个连通分量需要「情侣对数 - 1」次交换，才能让情侣各自回到可以牵手的位置。因此「总的情侣对数 - 连通分量个数」就是题目问的交换次数。

','23',NULL,'0765-couples-holding-hands','2025-06-11 09:46:05','2025-06-12 15:12:01',1,6,false,NULL,'https://leetcode.cn/problems/couples-holding-hands/description/',45,4,'',false,NULL,false,NULL,NULL),(186,'liweiwei1419','「力扣」第 387 题：字符串中的第一个唯一字符（简单）','## 思路分析

题目要我们找第一个不重复的字符，所以在遍历到一个字符的时候，需要知道这个字符之后是否出现过。因此，我们需要先遍历一次字符串，统计每个字符出现的次数。然后再遍历一次字符串，第 1 个只出现了 1 次的字符的下标即为所求。

统计每个字符出现的次数，这件事情可以交给哈希表来做。由于每一个字符都有一个 ASCII 值（是整数），且「提示」中说「`s` 只包含小写字母」。我们可以把每一个字符对应的 ASCII 值减去字母 `a` 的 ASCII 值，得到一个 0 到 25 范围内的整数，把这个整数作为数组的下标，于是可以使用长度为 26 的整数数组来记录字符串 `s` 中的字符出现的次数。 

**参考代码 1**：

```java
public class Solution {

    public int firstUniqChar(String s) {
        int[] hashMap = new int[26];
        char[] charArray = s.toCharArray();
        for (char c : charArray) {
            hashMap[c - ''a'']++;
        }
        int len = s.length();
        for (int i = 0; i < len; i++) {
            if (hashMap[charArray[i] - ''a''] == 1) {
                return i;
            }
        }
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是字符串 `s` 的长度；
+ 空间复杂度：$ O(∣C∣) $，其中 $ C $ 是字符集，$ ∣C∣ $表示字符集里字符的种类个数。

由于每一次计算下标都要 `- ''a''`，干脆就多开一点空间，`z` 的 ASCII 值是 122，所以使用长度为 123 的数组即可。

**参考代码 2**：

```java
public class Solution {

    public int firstUniqChar(String s) {
        int[] hashMap = new int[123];
        char[] charArray = s.toCharArray();
        for (char c : charArray) {
            hashMap[c]++;
        }
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (hashMap[charArray[i]] == 1) {
                return i;
            }
        }
        return -1;
    }

}
```

**复杂度分析**：同「参考代码 1」。

## 本题总结

如果键是正整数，且范围不大，可以使用数组代替哈希表。哈希表的底层也是数组。','15',NULL,'0387-first-unique-character-in-a-string','2025-06-11 18:57:32','2025-06-12 13:11:08',1,10,false,NULL,'https://leetcode.cn/problems/first-unique-character-in-a-string/description/',37,2,'',false,NULL,true,NULL,'如果映射到整数很方便，干脆就用数组代替哈希表。'),(144,'liweiwei1419','「力扣」第 124 题：二叉树中的最大路径和（困难）','## 理解题意

本题虽然被标记为「困难」，但经过我们深入分析以后，会发现其实是有规律可循的，等到我们学习了「动态规划」以后，还可以用「动态规划」的视角再来回顾本题。

本题的核心在于理解 **二叉树路径** 的独特定义，这里的路径需要满足：

+ **不回头**：路径不能重复经过同一结点；
+ **不断开**：路径必须是连续的边连接；
+ **任意方向**：可以从上到下，也可以从下到上，甚至「拐弯」。

因此本题的路径实际上可以理解为：在树中选择两个结点，然后分别从这两个结点向上走，直到它们的「最近公共祖先」而形成的一条「折线」，如下图所示。

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1740488889526-18af6dab-cbde-4c08-81c5-406283af41a6.png)

# 思路分析
在「理解题意」我们指出了，两个结点向上走（根据树的定义，除了根结点以外，每个结点有唯一父结点，因此向上走只会有一个方向），直到相遇，形成的「折线」为路径。这里「向上走」就蕴含了解决本题的思想：后序遍历。我们强调过好几次了，后序遍历即：向上传递信息。向上传什么、结点如何处理两棵子树传递上来的信息是我们接下来要考虑的问题。

树的问题天然地有递归结构，可以使用「分而治之」的算法思想解决，如何拆分问题是我们需要关注的。

最大路径有可能经过任意一个结点，因此我们就需要求出经过任意一个结点的路径的结点值的和。这么说太「模糊」，也太「大」了，需要拆分地更细、更小一点，我们可以把求出路径这件事情拆分得更细致一点，就容易找到它们之间的联系。既然路径可能来自每个子树的根结点的左子树，也可能来自每个子树的根结点的右子树，那么我们就把子问题定义为：**分别求出每个结点左子树的最大路径和右子树的最大路径**。只求一边，然后综合左、右子树的结果。以下图这棵树为例：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749796157865-27fc2c75-df27-4052-abe2-c936e0a3acc1.png)

我们统一把数值标记在了每个结点的右上角位置，来表示此时左右子树已经遍历完成了，即在「后序」的位置，向上传递了当前结点的值（**当前结点必须选**，因为我们要求出经过所有的结点的情况）+ **max(左子树的最大路径和, 右子树的最大路径和, 0)**。

**注意**：max(左子树的最大路径和, 右子树的最大路径和, 0) 的含义是只选一侧，如果传递上来的是负数，则丢弃。我们还需要再向上传递信息，如果把两棵子树的结果都加起来了，再加上向上传递的路径，就不符合题目规定的路径的定义。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749795297115-a985709e-52d0-4c37-ac70-22eaea206031.png)

题目定义的路径可以来自左边，也可以来自右边，这件事情可以在遍历的时候求出。后序遍历接受传递上来的数据只取二者之中最大的，当然如果两边传上来的都是负数，两边可以都不要。

具体代码细节如下：

+ 设 `dfs(node)` 表示以 `node` 为根的子树中，包含 `node` 的只来自左 **或者** 右子树的最大路径和；
+ 对于每个结点 `node`，`dfs(node)` 的值可以通过以下公式得到：`dfs(node) = max(0, dfs(node.left)) + max(0, dfs(node.right)) + node.val`，这里使用 `max(0, dfs(node.left))` 是为了忽略负的路径和，因为负的路径和不会对最大路径和有贡献；
+ 在递归的过程中，维护一个全局变量 `res` 来记录遍历过程中找到的最大路径和，`res` 就需要把左、右子树传递上来的数据都加上，并在每个结点处更新这个全局变量。

**参考代码**：

```java
public class Solution {

    private int res;

    public int maxPathSum(TreeNode root) {
        // 找最大值，初始化的时候需要赋值成最小值
        res = Integer.MIN_VALUE;
        dfs(root);
        return res;
    }

    // 规定 node 必须被选取，并且以 node 为根节点，并且路径只来自其中一颗子树
    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }
        // 这里体现了「后序遍历」，先递归求解左、右子树
        // 由于结点的值有可能为负数，因此如果子树得到的路径是负数，可以舍弃，表现为：和 0 取最大值
        int leftSubTreeSum = Math.max(0, dfs(node.left));
        int rightSubTreeSum = Math.max(0, dfs(node.right));

        // 在深度优先遍历的过程中选出最大值
        res = Math.max(res, node.val + leftSubTreeSum + rightSubTreeSum);
        // node.val 必须被选择体现在这里，并且向上传递左右子树中的较大者
        return node.val + Math.max(leftSubTreeSum, rightSubTreeSum);
    }
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 为二叉树的结点总数，整个算法其实就是对二叉树进行一次深度优先遍历；
+ 空间复杂度：$ O(n) $，空间复杂度为二叉树的高度，最坏情况下二叉树成为链表，空间复杂度为 $ O(\log n) $。

##  本题总结
+ 本题如果是第一次做，可能会觉得有难度。首先需要理解题意，对路径的定义的理解非常关键，由于路径的定义是「向上走」，因此使用后序遍历求解；
+ 其次是递归函数的设计，这里我们把路径 **拆成了一些非常特殊的情况，固定了一些因素**，它们是：路径是直的，并且以递归函数的结点为根结点，这样定义是为了方便计算，它们能组成复杂的情况；
+ **拆的时候我们拆得更细致，且固定了一些信息（经过根结点、只来自一侧）。接收左、右子树的传上来的信息也只接收一侧。在遍历的过程中，可以组合出题目定义的路径的值，从中选出最大值**；
+ 事实上本题也被归类成为树形动态规划问题。虽然我们还没有介绍动态规划，但本题后序遍历和拆分成更细致的子问题、固定信息，是很常见的算法思想。本题的思路非常常见，需要大家反复琢磨，我们在《动态规划》章节还会介绍类似的问题。','13',NULL,'0124-binary-tree-maximum-path-sum','2025-06-11 09:27:51','2025-06-13 14:52:28',1,3,false,NULL,'https://leetcode.cn/problems/binary-tree-maximum-path-sum/description/',36,3,'',false,NULL,true,NULL,NULL),(109,'liweiwei1419','「力扣」第 704 题：二分查找（简单）','# 例题 2：「力扣」第 704 题：二分查找（简单）
+ 题目链接：[https://leetcode.cn/problems/binary-search/description/](https://leetcode.cn/problems/binary-search/description/)



## 思路分析

由于 **数组是有序的，且无重复元素**，我们可以在数组的开始和末尾分别设置变量 `left` 和 `right` ，再根据 `left` 和 `right` 中间位置的值 `nums[mid]` 与目标元素 `target` 的大小关系，确定目标元素在左半部分还是右半部分，进而更新左右边界，缩小搜索范围，如此下去，直到找到目标元素，或确定目标元素不存在。

根据中间元素 `nums[mid]` 与目标元素 `target` 的大小关系，可以分为以下 3 种情况：


- **情况 1**：如果 `nums[mid] = target`，说明找到了目标元素，返回 `mid` ；
- **情况 2**：如果 `nums[mid] < target`，说明 `mid` 以及 `mid` 的 **左边** 的所有元素一定都比 `target` 小，下一轮搜索区间是 `[mid + 1..right]`，此时设置 `left = mid + 1`。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749619567-YAMAiU-image.png)


- **情况 3**：如果 `nums[mid] > target`，说明 `mid` 以及 `mid` 的 **右边** 的所有元素一定都比 `target` 大，下一轮搜索区间是 `[left..mid - 1]`，因此设置 `right = mid - 1`。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749619586-ECWiBK-image.png)


在 `left` 与 `right` 重合的时候，`left` 与 `right` 重合位置的数值还未被程序看到，还需要继续查找下去，因此循环可以继续的条件是 `left <= right`。程序退出循环时，说明区间里不存在目标元素，返回 -1。

**参考代码**：

```java
class Solution {

    public int search(int[] nums, int target) {
        int len = nums.length;
        int left = 0;
        int right = len - 1;
        // 在 [left..right] 里查找 target
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] > target) {
                // 下一轮搜索区间：[left..mid - 1]
                right = mid - 1;
            } else {
                // 此时：nums[mid] < target
                // 下一轮搜索区间：[mid + 1..right]
                left = mid + 1;
            }
        }
        return -1;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $，这里 $ n $ 是数组的长度；
+ 空间复杂度：$ O(1) $。

# 总结

本节给出的 2 个例题是典型的二分查找的问题：

+ 「力扣」第 374 题：猜数字大小（简单）：**查找一个有范围的整数**；
+ 「力扣」第 704 题：二分查找（简单）：在有序数组中查找符合条件的目标元素的值或者下标。

它们的共同特点是：**可以写出一个判别语句，在循环体中直接找到目标元素**，当没有找到的时候，或者向左边继续查找，或者向右边继续查找。在循环体中把搜索区间分成 3 个部分：

+ 第 1 个部分（中间）：只有一个元素 `mid`；
+ 第 2 个部分（左边区间）：`[left..mid - 1]`；
+ 第 3 个部分（右边区间）：`[mid + 1..right]`。

代码写出来是这样的：

```java
public int binarySearch(int[] nums, int target) {
    int left = 0;
    int right = nums.length - 1;
    whlile (left <= right) {
        int mid = (left + right) / 2;
        if ( 某个 mid 与 target 的表达式 ) {
            return mid;
        } else if ( 某个 mid 与 target 的表达式 ) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1;
}
```

代码的特点是循环可以继续的条件是 `left <= right`，当 `left` 与 `right` 重合的时候还要继续执行循环体。「力扣」第 374 题由于题目保证了搜索范围里一定有解，所以循环可以继续的条件写成 `left < right`。

大家可千万不要认为二分查找的代码都是上面这种固定写法，**具体问题需要具体分析**。下一节我们向大家介绍二分查找的 2 道经典问题，借此向大家介绍其它类型问题二分查找的代码是怎么写出来的。





','8',NULL,'0704-binary-search','2025-06-11 09:10:31','2025-06-12 15:56:17',1,6,false,NULL,'https://leetcode.cn/problems/binary-search/description/',30,2,'',false,NULL,true,NULL,'可以在循环体内找到。'),(184,'liweiwei1419','「力扣」第 51 题：N 皇后（困难）','## 思路分析

我们先尝试画出递归树，思路是：逐行放置皇后，确保每行只有一个皇后。在逐行放置皇后的过程中，检查当前要放置的皇后和之前行放置的皇后不在同一列、不在同一主对角线方向（从左上到右下）上、不在同一副对角方向（从右上到左下）上。以 4 皇后问题为例，画出递归树如下：

![image.png](https://minio.dance8.fun/algo-crazy/0051-n-queens/temp-image18401202043638357337.png)

**编码细节**：由于我们是一行一行放置的，行的位置肯定不冲突，也不需要记录，需要记录的是之前的行放置的皇后在哪一列、哪个主对角线和哪个副对角线。

- 记录列相对简单，有 `n` 个列，使用长度为 `n` 的布尔数组就好；
- 如何记录之前的皇后摆放在哪条主对角线上呢？我们依然是画图分析，如下图所示：

- `n × n` 的棋盘有 `n + (n - 1)` 条主对角线，主对角线上的元素的特点是：**横坐标 - 纵坐标的值是确定的、且是唯一的**（如下左图所示）；
- 因此如果某个皇后可以放置在下标为 `row` 的行和下标为 `col` 的列，那么它占据的主对角线的下标应该为 `row - col`；
- 由于数组的下标值不能为负数，因此给所有的 `row - col` 都加上 `n - 1` 。

![image.png](https://minio.dance8.fun/algo-crazy/0051-n-queens/temp-image11407273286002582727.png)

- 类似地，记录之前的皇后摆放在哪条副对角线上：

- `n × n` 的棋盘有 `n + (n - 1)` 条副对角线，副对角线上的元素的特点是：**横坐标 + 纵坐标的值是确定的、且是唯一的**（如上右图所示）；
- 因此如果某个皇后可以放置在下标为 `row` 的行和下标为 `col` 的列，那么它占据的副对角线的下标应该为 `row + col`；

- 我们使用变量 `path` （一维列表）记录棋盘， `path` 的下标代表放置皇后位置的横坐标，`path` 的值代表对应的放置皇后位置的纵坐标，在递归深度到达 `n`，即每一行每一列都摆放上皇后，且 `n` 个皇后不能互相攻击的时候，把一维列表转换为二维棋盘。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<String>> solveNQueens(int n) {
        List<List<String>> res = new ArrayList<>();
        boolean[] cols = new boolean[n];
        boolean[] main = new boolean[2 * n - 1];
        boolean[] sub = new boolean[2 * n - 1];
        Deque<Integer> path = new ArrayDeque<>();
        dfs(0, n, path, cols, main, sub, res);
        return res;
    }

    private void dfs(int row, int n, Deque<Integer> path, boolean[] cols, boolean[] main, boolean[] sub, List<List<String>> res) {
        if (row == n) {
            // 深度优先遍历到下标为 n，表示 [0.. n - 1] 已填完，得到了一个结果
            List<String> board = convert2board(path, n);
            res.add(board);
            return;
        }

        // 针对下标为 row 的每一列，尝试是否可以放置
        for (int col = 0; col < n; col++) {
            if (!cols[col] && !main[row - col + n - 1] && !sub[row + col]) {
                path.addLast(col);
                cols[col] = true;
                main[row - col + n - 1] = true;
                sub[row + col] = true;

                dfs(row + 1, n, path, cols, main, sub, res);

                sub[row + col] = false;
                main[row - col + n - 1] = false;
                cols[col] = false;
                path.removeLast();
            }
        }
    }

    private List<String> convert2board(Deque<Integer> path, int n) {
        List<String> board = new ArrayList<>();
        for (Integer num : path) {
            StringBuilder row = new StringBuilder();
            row.append(".".repeat(n));
            row.replace(num, num + 1, "Q");
            board.add(row.toString());
        }
        return board;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n!) $，第一行尝试 $ n $ 种放法，第二行尝试 $ n - 1 $ 种放法，但受限于不能同列同对角线，实际比 $ n! $ 小一些；
+ 空间复杂度：$ O(n) $，使用了 3 个布尔数组，大小分别为 $ n $、$ 2n - 1 $、$ 2n - 1 $ 。

## 本题总结

使用三个布尔数组检测冲突。
','16',NULL,'0051-n-queens','2025-06-11 10:01:20','2025-06-15 20:52:51',1,18,false,NULL,'https://leetcode.cn/problems/n-queens/description/',38,13,'',false,'https://leetcode.cn/problems/n-queens/solutions/21986/gen-ju-di-46-ti-quan-pai-lie-de-hui-su-suan-fa-si/',true,NULL,NULL),(147,'liweiwei1419','「力扣」第 230 题：二叉搜索树中第 K 小的元素（中等）','## 思路分析

二叉搜索树的中序遍历结果是升序序列，因此可以通过中序遍历找到第 `k` 小的元素，不用全部遍历完二叉搜索树，在遍历的同时对结点计数，遍历一个结点，计数器 + 1，直到计数为 `k` 时，就 找到了第 `k` 小的元素。

**参考代码 1**：递归实现。

```java
class Solution {
    
    private int count = 0;
    private int result = 0;
    
    public int kthSmallest(TreeNode root, int k) {
        inorder(root, k);
        return result;
    }
    
    private void inorder(TreeNode node, int k) {
        if (node == null) {
            return;
        }
        inorder(node.left, k);
        count++;
        if (count == k) {
            result = node.val;
            return;
        }
        inorder(node.right, k);
    }
    
}
```

「进阶」问题的思路：若二叉搜索树频繁插入/删除且需高效查询第 `k` 小元素，可在结点中维护子树结点数量（也可以在外部使用哈希表维护结点计数，支持频繁修改和高效查询），通过类似快速选择的方式实现 $ O(h) $ 时间复杂度的查询（这里 $ h $ 为树高）。插入/删除时需同步更新子树结点数，保持结构平衡（如 AVL 树或红黑树）可优化 $ h $ 为 $ O(\log n) $。

由于涉及到插入/删除操作，「力扣」的测评机制我们无法修改 `TreeNode` 的结点结构和内置的 `insert` 和 `delete` 操作，我们在外部使用哈希表维护结点计数，给出如下参考代码。**核心思想是维护子树结点数量**。

**参考代码 2**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    private Map<TreeNode, Integer> countMap = new HashMap<>();

    public int kthSmallest(TreeNode root, int k) {
        // 首次使用需要初始化 countMap
        if (countMap.isEmpty()) {
            calculateCount(root);
        }

        TreeNode node = root;
        while (node != null) {
            int leftCount = getCount(node.left);
            if (k <= leftCount) {
                node = node.left;
            } else if (k == leftCount + 1) {
                return node.val;
            } else {
                k -= (leftCount + 1);
                node = node.right;
            }
        }
        // 根据题意不会执行到这里
        return -1;
    }

    // 插入结点后调用此方法更新计数
    public void insert(TreeNode root, int val) {
        // 实际插入操作（标准 BST 插入）
        TreeNode newNode = insertNode(root, val);
        // 重置计数（可以从新结点向上更新，这里简化为全树重新计算）
        countMap.clear();
        calculateCount(root);
    }

    // 删除结点后调用此方法更新计数
    public void delete(TreeNode root, int val) {
        // 实际删除操作（标准 BST 删除）
        root = deleteNode(root, val);
        // 重置计数
        countMap.clear();
        calculateCount(root);
    }

    // --- 辅助方法 ---
    private int getCount(TreeNode node) {
        return node == null ? 0 : countMap.getOrDefault(node, 0);
    }

    private void calculateCount(TreeNode node) {
        if (node == null) {
            return;
        }
        calculateCount(node.left);
        calculateCount(node.right);
        int total = 1 + getCount(node.left) + getCount(node.right);
        countMap.put(node, total);
    }

    private TreeNode insertNode(TreeNode node, int val) {
        if (node == null) {
            return new TreeNode(val);
        }
        if (val < node.val) {
            node.left = insertNode(node.left, val);
        } else if (val > node.val) {
            node.right = insertNode(node.right, val);
        }
        return node;
    }

    private TreeNode deleteNode(TreeNode node, int val) {
        if (node == null) {
            return null;
        }

        if (val < node.val) {
            node.left = deleteNode(node.left, val);
        } else if (val > node.val) {
            node.right = deleteNode(node.right, val);
        } else {
            if (node.left == null) {
                return node.right;
            }
            if (node.right == null) {
                return node.left;
            }
            TreeNode minNode = findMin(node.right);
            node.val = minNode.val;
            node.right = deleteNode(node.right, node.val);
        }
        return node;
    }

    private TreeNode findMin(TreeNode node) {
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }

}
```','14',NULL,'0230-kth-smallest-element-in-a-bst','2025-06-11 09:27:51','2025-06-13 15:29:54',0,4,false,NULL,'https://leetcode.cn/problems/kth-smallest-element-in-a-bst/description/',36,7,'',false,NULL,false,NULL,NULL),(145,'liweiwei1419','「力扣」第 297 题：二叉树的序列化与反序列化（困难）','## 思路分析

二叉树的序列化与反序列化是一个经典的问题，树的问题很多时候至少需要把树的结点都看一遍，「都看一遍」这件事情就叫做遍历，因此序列化与反序列化都可以通过深度优先遍历和广度优先遍历来实现。接下来，我们解决好空结点的问题就好了，可以用特殊符号（如`#`）表示空结点。

以下序列化和反序列化，对于深度优先遍历和广度优先遍历都适用：

+ **序列化**：在遍历过程中，将结点的值依次添加到字符串中，结点值之间用逗号（`,`）分隔；
+ **反序列化**：按照序列化的规则反序列化即可，将序列化后的字符串按逗号（`,`）分割成数组。如果遇到特殊符号（如`#`），则表示当前结点为空结点。

下面的图是一个具体的例子，分别使用深度优先遍历和广度优先遍历，将序列化结果表示出来：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1740493312670-bec12e2b-977d-42f7-b169-57102be95ff8.png)

这里值得说明的是：对于图中的这棵树，使用深度优先遍历序列化的结果需要记录所有的空结点，而使用广度优先遍历序列化的结果本来是：`1,2,5,3,4,#,6,#,#,#,#,#,#,`，我们看到最后一层有大量的 `#,`，几乎占据了一半空间的序列化结果，把它们全部去掉也能反序列化还原出二叉树，读者可以结合我们给出的「参考代码 2」，编写具体的测试用例来理解这件事情。

**参考代码 1**： 使用深度优先遍历序列化和反序列化。

```java
class TreeNode {

    int val;
    TreeNode left;
    TreeNode right;

    TreeNode(int x) {
        val = x;
    }

}
```

```java
import java.util.LinkedList;
import java.util.Queue;


public class Codec {

    // 序列化方法
    public String serialize(TreeNode root) {
        if (root == null) {
            return "";
        }
        StringBuilder stringBuilder = new StringBuilder();
        dfs(root, stringBuilder);
        return stringBuilder.toString();
    }

    private void dfs(TreeNode node, StringBuilder stringBuilder) {
        if (node == null) {
            // 空结点使用 # 表示
            stringBuilder.append("#").append(",");
            return;
        }
        // 前序遍历，先添加当前结点值
        stringBuilder.append(node.val).append(",");
        dfs(node.left, stringBuilder);
        dfs(node.right, stringBuilder);
    }

    // 反序列化方法
    public TreeNode deserialize(String data) {
        if (data.length() == 0) {
            return null;
        }

        String[] split = data.split(",");
        Queue<String> queue = new LinkedList<>();
        for (String str : split) {
            queue.offer(str);
        }
        return dfs(queue);
    }

    private TreeNode dfs(Queue<String> queue) {
        if (queue.isEmpty()) {
            return null;
        }
        String front = queue.poll();
        if ("#".equals(front)) {
            return null;
        }
        TreeNode root = new TreeNode(Integer.parseInt(front));
        root.left = dfs(queue);
        root.right = dfs(queue);
        return root;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是二叉树的结点数，序列化和反序列化过程都需要遍历所有结点；
+ 空间复杂度：$ O(n) $，用于存储序列化后的字符串和递归调用栈。

**参考代码 2**：使用广度优先遍历序列化和反序列化。

**说明**：广度优先遍历最后一行的结点的子结点肯定是空结点，它们可以不必序列化。这是因为在反序列化的时候，依然是挂接空结点。「移除末尾的 `#,` 和 `,` 」和「挂接空结点」都有开销，因此是否「移除末尾的 `#,` 和 `,` 」由大家自己决定，见「参考代码 2」的注释。

```java
import java.util.LinkedList;
import java.util.Queue;

public class Codec {

    // 序列化二叉树
    public String serialize(TreeNode root) {
        if (root == null) {
            return "";
        }

        StringBuilder stringBuilder = new StringBuilder();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();
            if (node != null) {
                stringBuilder.append(node.val).append(",");
                queue.offer(node.left);
                queue.offer(node.right);
            } else {
                stringBuilder.append("#,");
            }
        }

        // 以下的移除操作可选
        // 移除末尾多余的 "#,"
        while (stringBuilder.length() > 0 && stringBuilder.charAt(stringBuilder.length() - 2) == ''#'') {
            stringBuilder.setLength(stringBuilder.length() - 2);
        }
        // 再移除末尾的 ","
        stringBuilder.setLength(stringBuilder.length() - 1);
        return stringBuilder.toString();
    }

    // 反序列化二叉树
    public TreeNode deserialize(String data) {
        if (data.isEmpty()) {
            return null;
        }

        String[] nodes = data.split(",");
        TreeNode root = new TreeNode(Integer.parseInt(nodes[0]));
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int i = 1;
        int n = nodes.length;
        while (!queue.isEmpty() && i < n) {
            TreeNode front = queue.poll();
            // 处理左孩子结点
            if (!nodes[i].equals("#")) {
                front.left = new TreeNode(Integer.parseInt(nodes[i]));
                queue.offer(front.left);
            }
            i++;
            // 处理右孩子结点
            if (i < n && !nodes[i].equals("#")) {
                front.right = new TreeNode(Integer.parseInt(nodes[i]));
                queue.offer(front.right);
            }
            i++;
        }
        return root;
    }

}
```

**复杂度分析**：

+ 时间复杂度：序列化和反序列化均为 $ O(n) $，其中 $ n $ 是二叉树的结点数量，每个结点仅被处理一次；
+ 空间复杂度：$ O(n) $，队列在最坏情况下需要存储所有叶子结点（约 $ \frac{n}{2} $ 个），且序列化结果字符串长度与结点数成正比。

# 总结

树形问题的解法通常基于深度优先或广度优先遍历框架，其中后序遍历尤为关键——它通过自底向上传递信息，天然契合分治思想。当问题需要整合左右子树结果或涉及「向上传递」性质时（如计算子树特征、路径问题等），后序遍历往往是最优选择。

','13',NULL,'0297-serialize-and-deserialize-binary-tree','2025-06-11 09:27:51','2025-06-13 14:57:10',1,5,false,NULL,'https://leetcode.cn/problems/serialize-and-deserialize-binary-tree/description/',36,4,'',false,NULL,true,NULL,NULL),(146,'liweiwei1419','「力扣」第 98 题：验证二叉搜索树（中等）','# 例题 1：「力扣」第 98 题：验证二叉搜索树（中等）
+ 题目地址：[https://leetcode.cn/problems/validate-binary-search-tree/description/](https://leetcode.cn/problems/validate-binary-search-tree/description/)



## 思路分析
经过编码测试，本题描述中「有效二叉搜索树定义」中的「小于」和「大于」都不包含「等于」的情况，如果在面试中，对于题意有不明确的地方，需要向面试官询问。因此本题中，如果左子树（或者右子树）中包含了等于当前结点的数，都不满足二叉搜索树的定义。

树的问题，很多时候需要把树的结点都看一遍，因此就需要遍历，遍历有深度优先遍历和广度优先遍历。二叉搜索树的性质和广度优先遍历没什么关系，所以需要进行深度优先遍历。

我们知道二叉搜索树的中序遍历是有序的，因此用中序遍历最简单，但其实使用前序遍历和后序遍历，在遍历的时候传递相应的信息，也能实现二叉搜索树的判断，下面我们依次介绍。

### 方法一：中序遍历

可以先遍历（使用中序遍历）一遍二叉搜索树，把所有结点的值保存在一个动态数组中（因为二叉搜索树的结点数事先不知道），再检查数组是否升序，代码我们省略。更高效的做法是：在中序遍历过程中，实时维护一个 `prev` 变量记录前一个访问的结点。每次访问当前结点时，检查当前结点的值是否严格大于 `prev` 结点的值：若不满足，立即判定为无效二叉搜索树；若满足，则更新 `prev` 为当前结点，继续遍历。

**参考代码 1**：

```java
public class Solution {

    // 前一个结点的引用
    private TreeNode prev = null;

    public boolean isValidBST(TreeNode root) {
        return inorder(root);
    }

    private boolean inorder(TreeNode node) {
        if (node == null) {
            return true;
        }

        if (!inorder(node.left)) {
            return false;
        }

        // 在中序遍历的时候，检查当前结点的值是否大于等于它的前一个结点
        if (prev != null && node.val <= prev.val) {
            return false;
        }
        // 记录前一个结点
        prev = node;
        return inorder(node.right);
    }

}
```

### 方法二：前序遍历
**以前序遍历的视角看，是向下看**，就需要告诉左、右子树一些信息：

+ 告诉左子树，你的最大值不能比我还大，即：当前结点的值是左子树的上界；
+ 告诉右子树，你的最小值不能比我还小，即：当前结点的值是右子树的下界。

因此在遍历的时候，就需要携带上下界信息。

**参考代码 2**：

```java
public class Solution {

    public boolean isValidBST(TreeNode root) {
        return preorder(root, null, null);
    }

    private boolean preorder(TreeNode node, Integer lower, Integer upper) {
        if (node == null) {
            return true;
        }
        // 在前序遍历的时候检查是否符合二叉搜索树的性质
        if (lower != null && node.val <= lower) {
            return false;
        }
        if (upper != null && node.val >= upper) {
            return false;
        }
        // 根据 BST 的定义，遍历左子树的时候，当前结点的值是上界，遍历右子树的时候，当前结点的值是下界
        return preorder(node.left, lower, node.val) && preorder(node.right, node.val, upper);
    }

}
```

### 方法三：后序遍历
**以后序遍历的视角看，是向上看**，此时我们已经遍历完左、右子树，可以根据左、右子树返回的信息，再检查当前结点的值，判断是否符合二叉搜索树的定义。与「前序遍历」相对应：

+ 左子树的最大值应该比当前结点的值还小；
+ 右子树的最小值应该比当前结点的值还大。

因此我们在遍历的时候，就需要向上传递最小值和最大值。「提示」的第 2 点说：$-2^{31} \le \text{Node.val} \le 2^{31} - 1$，因此在表示「空」的时候就需要比 int 类型的范围还大的整型。其它细节我们作为注释写在「参考代码 3」中。

**参考代码 3**：

```java
public class Solution {

    public boolean isValidBST(TreeNode root) {
        return postorder(root) != null;
    }

    // 返回 long[2]: {min, max}，如果无效则返回 null
    private long[] postorder(TreeNode node) {
        if (node == null) {
            // 空树不影响 BST 性质，返回 {MAX_VALUE, MIN_VALUE} 确保不影响父结点比较
            return new long[]{Long.MAX_VALUE, Long.MIN_VALUE};
        }

        long[] left = postorder(node.left);
        long[] right = postorder(node.right);
        // 如果左、右子树无效，或者当前结点不满足 BST 条件，则返回 null
        if (left == null || right == null || node.val <= left[1] || node.val >= right[0]) {
            return null;
        }

        // 当前子树的最小值是 min(左子树最小值, 当前结点值)
        long min = Math.min(left[0], node.val);
        // 当前子树的最大值是 max(右子树最大值, 当前结点值)
        long max = Math.max(right[1], node.val);
        return new long[]{min, max};
    }

}
```

**复杂度分析**：

+ 时间复杂度：所有方法的时间复杂度都是 $O(n)$，这里 $n$ 是二叉搜索树的结点的个数，需要访问所有结点一次；
+ 空间复杂度：在最坏情况下（树退化为链表）为 $O(n)$。

## 本题总结

+ 中序遍历是最直观，编码最容易的解法，中序遍历是从左向右看；
+ 前序遍历是向下传递信息，向下看；
+ 后序遍历是接收左、右子树传递上来的信息，是向上看。

前、中、后序遍历，其实都是深度优先遍历，通过本题的介绍，希望大家能够对前、中、后序遍历有更深刻的认识。

','14',NULL,'0098-validate-binary-search-tree','2025-06-11 09:27:51','2025-06-12 19:53:38',1,5,false,NULL,'https://leetcode.cn/problems/validate-binary-search-tree/description/',36,5,'',false,NULL,true,NULL,NULL),(192,'liweiwei1419','「力扣」第 96 题：不同的二叉搜索树（中等）','测试','动态规划',NULL,NULL,'2025-06-12 21:17:43','2025-06-12 21:17:43',0,0,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(157,'liweiwei1419','「力扣」第 260 题：只出现一次的数字 III（中等）','## 思路分析

常见的使用哈希表（空间复杂度不符合要求）和排序（时间复杂度不符合要求）的做法我们就不赘述了。我们直接介绍位运算的做法：**有两个数字只出现一次，直接对整个数组进行异或操作会得到这两个数字的异或结果，而不是它们本身**。位运算的做法是：将这两个数分开，因此我们需要找到一个区分这两个数字的特征。

假设题目中只出现一次的数是 3 和 5， `3 ^ 5 = 6`，6 的二进制表示为 `0110`（我们只写出最低 4 位），**6  的二进制表示中为 `1` 的位表示：3 和 5 在这一位上不同（联系异或运算的定义，如果相同，则异或的结果为 0）**。

我们可以选择其中的任意一个是 1 的位作为区分标准。一般来说，选择最低位的 1 即可，因为可以使用 `n & (-n)` 得到最低位的 1 ，于是我们使用掩码 `mask = 2`（二进制表示为 `0010`）将输入数组分成两组：

- 二进制从低到高数第 2 位为 0 的在一组；
- 二进制从低到高数第 2 位为 1 的在一组。

**现在每组里只有一个数「落单」了**。分组的同时可以进行异或操作，就能分别得到只出现一次的两个数字。

以「示例 1」为例，`nums = [1, 2, 1, 3, 2, 5]`，先对所有的数字进行异或，得到 6，使用掩码 `mask = 2` 对 `nums` 分组：

- `1`：`001` & `010` = `000` ，第 2 位是 0，分到第 1 组；
- `2`：`010` & `010` = `010` ，第 2 位是 1，分到第 2 组；
- `1`：`001` & `010` = `000` ，第 2 位是 0，分到第 1 组；
- `3`：`011` & `010` = `010` ，第 2 位是 1，分到第 2 组；
- `2`：`010` & `010` = `010` ，第 2 位是 1，分到第 2 组；
- `5`：`101` & `010` = `000` ，第 2 位是 0，分到第 1 组。

分到第 1 组的 3 个数是：1、1、5，分到第 2 组的 3 个数是：2、3、2。在分组的同时进行异或操作，就得到了只出现一次的两个数 3 和 5。

**参考代码**：

```java
public class Solution {

    public int[] singleNumber(int[] nums) {
        int diff = 0;
        for (int num : nums) {
            diff ^= num;
        }
        // 只出现 1 次的两个数异或的结果，再得到二进制最低位的 1
        diff &= -diff;

        int[] res = new int[2];
        for (int num : nums) {
            if ((num & diff) == 0) {
                res[0] ^= num;
            } else {
                res[1] ^= num;
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ **时间复杂度**：$ O(n) $，其中 `n` 是数组的长度。我们遍历数组两次，第一次计算异或总和，第二次分组异或。
+ **空间复杂度**：$ O(1) $，只使用了常数个额外变量。','22',NULL,'0260-single-number-iii','2025-06-11 09:44:19','2025-06-12 09:09:40',1,6,false,NULL,'https://leetcode.cn/problems/single-number-iii/description/',44,3,'',false,NULL,true,NULL,NULL),(12,'liweiwei1419','「力扣」第 32 题：最长有效括号（困难）','## 思路分析

这道题只让我们求出最长有效括号的长度，没有让我们求出最长有效括号具体是什么，可以尝试使用动态规划求解。根据之前的线性 DP 问题状态定义，在定义状态的时候，固定以 `s[i]` 结尾，便于推导状态转移方程。

+ **定义状态**：`dp[i]` 表示以 `s[i]` 结尾的最长有效括号子串的长度；
+ **状态转移方程**：如果结尾字符是左括号，一定不是有效括号子串，即：当 `s[i] == ''(''` 时，`dp[i] = 0`。能与之前的状态产生联系的前提是 `s[i] = '')''`，并且我们还需要看 `s[i - 1]` 是左括号还是右括号，下面我们分别讨论：

**情况 1**：如果 `s[i - 1] == ''(''`，那么 `dp[i] = dp[i - 2] + 2`（**注意**：下标 `i - 2` 有可能越界，需单独讨论），如下图所示：

![](https://minio.dance8.fun/algo-crazy/0032-longest-valid-parentheses/temp-image14027057822546729377.png)

**情况 2**：如果 `s[i - 1] == '')''`，`s[i]` 只能与更靠前的左括号匹配，更靠前的左括号下标是 `i - dp[i - 1] - 1`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0032-longest-valid-parentheses/temp-image12947716348995695921.png)

因此还需要满足 `s[i - dp[i - 1] - 1] == ''(''` ，此时才有 `dp[i] = dp[i - 1] + dp[i - dp[i - 1] - 2] + 2`（**注意**：下标 `i - dp[i - 1] - 1` 有可能越界，需要单独讨论）。

+ **考虑初始化**：单个字符无法形成有效括号，`dp[0] = 0`；
+ **考虑输出结果**：遍历 `dp` 数组，最大值即为所求。

**参考代码**：

```java
public class Solution {

    public int longestValidParentheses(String s) {
        int n = s.length();
        if (n < 2) {
            return 0;
        }

        char[] charArray = s.toCharArray();
        int res = 0;
        int[] dp = new int[n];
        dp[0] = 0;
        for (int i = 1; i < n; i++) {
            if (charArray[i] == '')'') {
                if (charArray[i - 1] == ''('') {
                    dp[i] = 2 + (i - 2 >= 0 ? dp[i - 2] : 0);
                } else {
                    // s.charAt(i - 1) == '')''
                    int index = i - dp[i - 1] - 1;
                    if (index >= 0 && charArray[index] == ''('') {
                        dp[i] = 2 + dp[i - 1] + (index - 1 >= 0 ? dp[index - 1] : 0);
                    }
                }
            }
            res = Math.max(res, dp[i]);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是字符串的长度，只需要遍历一次字符串；
+ 空间复杂度：$ O(n) $，使用长度为 $ n $ 的数组保存中间结果。

## 本题总结
我们只需要讨论当前遍历到的最后一个字符 `s[i]` 是右括号的时候，前一个字符 `s[i - 1]` 是左括号还是右括号：

+ 如果 `s[i - 1]` 是左括号，则更新 `dp[i]`；
+ 如果 `s[i - 1]` 是右括号，则检查之前是否有与之匹配的 `''(''`，如果有，则更新 `dp[i]`。

注意下标越界的时候需要单独讨论。

# 总结
+ 动态规划问题的关键在于如何定义状态。初学者往往难以立即掌握状态定义的技巧，这需要通过积累解题经验和参考优秀解法（如「力扣」题解区）来逐步培养。随着练习量的增加，对状态定义的直觉会自然提升；
+ 状态定义的常用技巧：
    - 固定不确定因素：通过将状态中的下标 i 定义为某个结尾位置，使状态表示更具体；
    - 升维处理复杂情况：当问题需要分类讨论时，增加 dp 数组的维度可以更准确地描述状态，从而更容易满足无后效性要求。
+ **注意事项：**
    - 无后效性：状态定义需确保当前状态仅依赖已解决的子问题，不受未来决策影响；
    - 分类讨论：复杂问题可能需要分情况处理状态转移（如乘积最大子数组中的正负数情况）；
    - 空间与时间权衡：在面试或竞赛中，通常优先保证正确性和可读性，空间优化并非必需。

通过掌握这些核心原则和技巧，可以系统性地解决各类动态规划问题，逐步提升解题能力。

','17',NULL,'0032-longest-valid-parentheses','2025-06-09 10:28:04','2025-06-18 18:07:36',1,13,false,NULL,'https://leetcode.cn/problems/longest-valid-parentheses/description/',39,13,'',false,NULL,true,'完成。',NULL),(132,'liweiwei1419','「力扣」第 42 题：接雨水（困难）','## 思路分析

我们在「双指针」的章节曾经介绍过本题的解法：**形成凹槽是能储存雨水的原因**，这是本题的关键。

我们从左向右，一根柱子一根柱子看，观察何时会形成凹槽。当凹槽形成时，就计算当前凹槽能储存的雨水的量。为了更方便看出规律，我们使用一个有代表性的例子（一开始单调递减，然后遇到一个较高的柱子）向大家说明，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0042-trapping-rain-water/temp-image4409985142068288324.png)

从左向右读，在读到下标 4 的柱子之前，是单调递减的，不会形成凹槽，直到读到下标 4 的柱子时，才形成了凹槽。此时我们把凹槽部分的区域进行切割，切割成如上图所示的矩形，方便计算它们的面积并求和，计算出矩形面积的顺序是「从右向左」的（如上图标注的 ① ② ③），这提示我们需要使用栈。

那么如何计算每个柱子对应的矩形面积呢？我们是在出栈的时候计算能存水的面积，该面积与 3 个柱子有关：当前遍历到的柱子、当前栈顶柱子、当前栈顶出栈以后的新栈顶柱子，通过它们的高度和下标计算矩形的面积。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0042-trapping-rain-water/temp-image14886593563252514363.png)

其中：

+ 矩形的底 = 「当前遍历到的柱子」的高度与「弹出栈顶元素以后的新栈顶柱子」的距离，栈顶的两侧都比栈顶高，所以能存水，这一点比较抽象，可以结合「示例演示」理解；
+ 矩形的高 = 「当前遍历到的柱子」的高度与「弹出栈顶元素以后的新栈顶柱子」的高度的较小者（木桶原理：较小者决定高度），再减去「当前栈顶柱子」的高度。

我们既需要知道下标，又需要知道柱形的高度，因此在栈中需要存的是下标，通过下标获得柱形的高度。

## 示例演示
根据上面的分析，我们把出栈元素的序号与之对应的水的面积标注出来，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0042-trapping-rain-water/temp-image4327242852851092287.png)

计算存水的面积与「双指针」解法不同：双指针是一个柱子一个柱子看能存水多少，而栈的方法是「从下往上」看能存水多少。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public int trap(int[] height) {
        int n = height.length;
        if (n < 3) {
            return 0;
        }

        int area = 0;
        Deque<Integer> stack = new ArrayDeque<>(n);
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && height[stack.peekLast()] < height[i]) {
                // 作为底部支撑的那个柱形的下标
                Integer bottomIndex = stack.removeLast();
                // 出栈以后，如果栈为空，说明不能形成凹槽，此时跳过
                if (stack.isEmpty()) {
                    break;
                }

                // 新栈顶和 i 之间的长度为底，即 [stack.peekLast() + 1..i - 1] 的长度
                int width = i - 1 - stack.peekLast();
                int currentHeight = Math.min(height[stack.peekLast()], height[i]) - height[bottomIndex];
                area += (width * currentHeight);
            }
            // 栈中存下标
            stack.addLast(i);
        }
        return area;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，所有的元素进栈一次，出栈一次；
+ 空间复杂度：$ O(n) $，栈中最多存 $ n $ 个元素。
','10',NULL,'0042-trapping-rain-water','2025-06-11 09:20:48','2025-06-15 20:13:25',1,12,false,NULL,'https://leetcode.cn/problems/trapping-rain-water/description/',34,6,'',false,'https://leetcode.cn/problems/trapping-rain-water/solutions/48255/bao-li-jie-fa-yi-kong-jian-huan-shi-jian-zhi-zhen/',true,'完成。','符合「后进先出」规律，所以用栈。（不是为了维护单调性，单调是自然形成的结果。）'),(97,'liweiwei1419','「力扣」第 210 题：课程表 II（中等）','## 思路分析

本题其实就是拓扑排序的「原题」，题目中的有向边是通过 `prerequisites` 数组给出的，其中每一个元素 `[to, from]` 表示有向边是 `from -> to` ，按照拓扑排序的广度优先遍历方式去实现就好了。拓扑排序的知识点我们在《第 6 节 拓扑排序简介》里已经介绍了，大家可以结合下面的参考代码和编码细节进行理解。

**参考代码**：

```java
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Solution {

    public int[] findOrder(int numCourses, int[][] prerequisites) {
        // 邻接表，存储图结构，adjList[i] 表示课程 i 的后续课程列表，这里图的结构是「邻接表」形式
        List<List<Integer>> adjList = new ArrayList<>(numCourses);
        for (int i = 0; i < numCourses; i++) {
            adjList.add(new ArrayList<>());
        }

        // 初始化入度数组和邻接表
        int[] inDegree = new int[numCourses];
        for (int[] prerequisite : prerequisites) {
            int from = prerequisite[1];
            int to = prerequisite[0];
            adjList.get(from).add(to);
            inDegree[to]++;
        }

        // 队列用于存储入度为 0 的课程
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < numCourses; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        // 记录课程学习顺序
        int[] res = new int[numCourses];
        // 当前结果集列表里的元素个数，既可以作为 res 数组的下标，又可以用于判断是否所有顶点都入队
        int count = 0;
        while (!queue.isEmpty()) {
            // 当前入度为 0 的结点
            Integer front = queue.poll();
            res[count] = front;
            count++;

            List<Integer> successors = adjList.get(front);
            for (Integer nextCourse : successors) {
                inDegree[nextCourse]--;
                // 马上检测该结点的入度是否为 0，如果为 0，加入队列
                if (inDegree[nextCourse] == 0) {
                    queue.offer(nextCourse);
                }
            }
        }

        if (count == numCourses) {
            return res;
        }
        // 如果最终学习顺序的课程数不等于总课程数，说明存在环，无法完成所有课程
        return new int[0];
    }

}
```

**编码细节**：参考代码在队列元素出队的时候记录结果。大家也可以在元素入队的时候记录结果，入度为 0 的顶点一旦被加入队列，就说明它已经满足排序条件（无前置依赖），两种方式任选其一即可。如果大家选择在元素入队的时候记录结果，在初始化队列时也要加上相应的代码。

**复杂度分析**：

+ 时间复杂度：$ O(V + E) $，其中 $ V $ 是顶点数，即课程总数 `numCourses`，$ E $ 是边数，即数组 `prerequisites` 的大小；
+ 空间复杂度：$ O(V + E) $，存储邻接表的空间复杂度为 $ O(V + E) $，入度数组和队列的空间复杂度为 $ O(V) $。

','19',NULL,'0210-course-schedule-ii','2025-06-11 08:36:19','2025-06-16 14:58:10',1,59,false,NULL,'https://leetcode.cn/problems/course-schedule-ii/description/',41,10,'',false,'https://leetcode.cn/problems/course-schedule-ii/solutions/8431/tuo-bu-pai-xu-shen-du-you-xian-bian-li-python-dai-/',true,NULL,NULL),(82,'liweiwei1419','「力扣」第 55 题：跳跃游戏（中等）','

## 思路分析
这道题要求我们判断是否能够通过一系列跳跃到达数组的末尾，跳跃次数不限制。根据题意可知：如果数组 `nums` 里所有的元素都大于等于 1，一定可以到达最后一个下标。如果数组 `nums` 有 0 ，就得「看之前的下标 + 对应的数值」能不能越过这个 0。以「示例 2」为例，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0055-jump-game/temp-image48059972440066283.png)

根据题意和对示例的分析，我们知道：

+ 如果某个位置不可达，那么从该位置往后的所有位置都不可达；
+ 每次跳跃时，我们应该尽可能选择能够到达最远位置，这样可以覆盖更远的位置。

于是我们可以维护表示 **当前能够到达的最远位置** 的变量 `maxReach`。对于数组中的每个位置，检查：

+ 当前位置是否可达：如果当前位置 `i` 大于 `maxReach`，说明无法到达当前位置，返回 `false`；
+ 更新最远可达位置：如果当前位置可达，计算从当前位置出发能够到达的最远位置，即 `i + nums[i]`，并更新 `maxReach`；
+ 判断是否到达终点：如果在任何时候 `maxReach` 大于或等于数组的最后一个下标，说明可以到达终点，返回 `true`。

求所有的 `i + nums[i]` 的最大值，每一步只看「眼前」，所以是贪心算法。

**参考代码**：

```java
public class Solution {

    public boolean canJump(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return true;
        }

        int maxReached = 0;
        // 数组的最后一个值可以不看
        for (int i = 0; i < n - 1; i++) {
            // 判断当前位置是否能达到
            if (i > maxReached) {
                return false;
            }

            // 读取 nums[i] 更新 maxReached
            maxReached = Math.max(maxReached, i + nums[i]);
            if (maxReached >= n - 1) {
                return true;
            }
        }
        return false;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这是 $ n $ 是数组 `nums`  的长度；
+ 空间复杂度：$ O(1) $。','18',NULL,'0055-jump-game','2025-06-11 08:20:34','2025-06-16 14:37:37',1,7,false,NULL,'https://leetcode.cn/problems/jump-game/description/',40,4,'',false,NULL,true,'完成。',NULL),(193,'liweiwei1419','「力扣」第 96 题：不同的二叉搜索树（中等）','测试','动态规划',NULL,NULL,'2025-06-12 21:17:52','2025-06-12 21:17:53',0,2,false,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(185,'liweiwei1419','「力扣」第 706 题：设计哈希映射（简单）','## 思路分析
本题让我们实现的是简易版本的哈希映射，`key` 和 `value` 都是 int 类型。题目最后的「提示」说： `0 <= key, value <= 106`，`key` 是非负整数，因此我们可以直接使用数组来实现。

**参考代码 1**：使用数组实现简单哈希映射。

```java
class MyHashMap {
    
    private int[] map;

    public MyHashMap() {
        map = new int[1000001]; // 题目说明 key 的范围是 0-10^6
        Arrays.fill(map, -1); 	// 初始化为 -1 表示不存在
    }
    
    public void put(int key, int value) {
        map[key] = value;
    }
    
    public int get(int key) {
        return map[key];
    }
    
    public void remove(int key) {
        map[key] = -1;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(1)  $，所有操作均是 $ O(1)  $；
+ 空间复杂度：$ O(1)  $，使用固定大小的数组。

如果我们不想使用那么大的空间，就需要设计哈希函数，这里我们的哈希函数选择简单的取模运算。哈希表的大小选择为 769，这是因为：

+ 769 是一个质数，使用质数作为哈希表大小可以减少哈希冲突，当键的分布不均匀时，质数能提供更好的分散性；
+ 对于一般的应用场景，769 提供了足够大的空间来分散键，既不会太小（导致频繁冲突），也不会太大（浪费内存）；
+ 769 也是许多标准库实现中常用的经验值，在 Java 的 `HashMap` 实现中，默认初始容量是 16，但扩容时也常使用质数。

数组的长度变短了，就有可能会发生哈希冲突，哈希冲突的解决，我们使用链表法或二叉搜索树法。

**参考代码 2**：使用链表法解决哈希冲突。

```java
class MyHashMap {
    
    private static final int BASE = 769;
    
    private LinkedList<Pair<Integer, Integer>>[] data;

    public MyHashMap() {
        data = new LinkedList[BASE];
        for (int i = 0; i < BASE; i++) {
            data[i] = new LinkedList<>();
        }
    }
    
    public void put(int key, int value) {
        int h = hash(key);
        for (Pair<Integer, Integer> pair : data[h]) {
            if (pair.getKey() == key) {
                pair.setValue(value);
                return;
            }
        }
        data[h].offerLast(new Pair<>(key, value));
    }
    
    public int get(int key) {
        int h = hash(key);
        for (Pair<Integer, Integer> pair : data[h]) {
            if (pair.getKey() == key) {
                return pair.getValue();
            }
        }
        return -1;
    }
    
    public void remove(int key) {
        int h = hash(key);
        for (Pair<Integer, Integer> pair : data[h]) {
            if (pair.getKey() == key) {
                data[h].remove(pair);
                return;
            }
        }
    }

    private int hash(int key) {
        return key % BASE;
    }
    
    private static class Pair<K, V> {
        private K key;
        private V value;
        
        public Pair(K key, V value) {
            this.key = key;
            this.value = value;
        }
        
        public K getKey() {
            return key;
        }
        
        public V getValue() {
            return value;
        }
        
        public void setValue(V value) {
            this.value = value;
        }
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：平均情况：$ O(1) $，最坏情况：$ O(n) $（所有元素哈希到同一个桶），这里 $ n $ 是放入哈希映射的所有元素的大小；
+ 空间复杂度：$ O(n) $。

**参考代码 3**：使用二叉搜索树优化查找，在 Java 中 `TreeMap` 是红黑树，红黑树是一种（自平衡的）二叉搜索树。

```java
class MyHashMap {
    
    private static final int BASE = 769;
    
    private TreeMap<Integer, Integer>[] data;

    public MyHashMap() {
        data = new TreeMap[BASE];
        for (int i = 0; i < BASE; i++) {
            data[i] = new TreeMap<>();
        }
    }
    
    public void put(int key, int value) {
        int h = hash(key);
        data[h].put(key, value);
    }
    
    public int get(int key) {
        int h = hash(key);
        return data[h].getOrDefault(key, -1);
    }
    
    public void remove(int key) {
        int h = hash(key);
        data[h].remove(key);
    }

    private int hash(int key) {
        return key % BASE;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：平均情况：$ O(\log n) $，最坏情况：$ O(n) $，退化成链表；
+ 空间复杂度：$ O(n) $。

## 本题总结
如果 `key` 范围已知且不大，就使用数组就好了，简单且高效。其它情况，需要使用链表、或者二叉搜索树来解决哈希冲突。','15',NULL,'0706-design-hashmap','2025-06-11 18:57:31','2025-06-13 04:47:54',1,4,false,NULL,'https://leetcode.cn/problems/design-hashmap/description/',37,1,'',false,NULL,true,NULL,'哈希表的底层就是数组（或者说动态数组）。'),(105,'liweiwei1419','「力扣」第 167 题：两数之和 II - 输入有序数组（简单）','## 思路分析

**暴力解法**：枚举所有两个数的组合，这种暴力的解法 **没有利用到数组有序这个条件**，时间复杂度不符合题目要求。

**优化思路**：注意到「提示」第 3 条：`numbers` 按 **非递减顺序** 排列，我们可以尝试让数组的最小值与最大值相加：即开始的时候我们让两个指针变量（分别记为 `left` 和 `right`）位于数组的头和尾，此时：

+ `nums[left]` 是区间 `[left..right]` 中最小的数；
+ `nums[right]` 是区间 `[left..right]` 中最大的数。

按照最小值与最大值之和与 `target` 的关系可以分成如下 3 种情况：

+ **情况 1**：如果两数之和等于 `target`，我们找到了答案；
+ **情况 2**：如果两数之和小于 `target`，**最小的数与最大的数之和都小于 `target`，最小的数一定不是两数之和的其中一个（最小的数太小了）**，如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image4023345103673996331.png)

问题就转化为：在区间 `[left + 1..right]` 里查找和为 `target` 的两个数，一下子排除了很多暴力解法需要考虑的情况。

+ **情况 3**：如果两数之和大于 `target`，**最大的数与最小的数之和都大于 `target`，最大的数一定不是两数之和的其中一个（最大的数太大了）**，如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image5474547080260427346.png)

问题就转化为：在区间 `[left..right - 1]` 里查找和为 `target` 的两个数。

**参考代码**：

```java
public class Solution {

    public int[] twoSum(int[] numbers, int target) {
        int n = numbers.length;
        int left = 0;
        int right = n - 1;
        while (left < right) {
            int sum = numbers[left] + numbers[right];
            if (sum == target) {
                return new int[]{left + 1, right + 1};
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        return new int[]{};
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(1) $，只使用了常数个变量。

## <font style="color:rgb(38, 38, 38);">本题总结</font>
由于输入数组有序（非严格递增），在区间 `[left..right]` 里，`nums[left]` 是最小的数，`nums[right]` 是最大的数：

+ 如果 `nums[left] + nums[right] < target`，对于 `nums[left]` 而言，即使与该区间内最大的数 `nums[right]` 相加，结果仍小于 `target`，所以该区间内的其它数与 `nums[left]` 相加也一定小于 `target`，所以可以排除 `nums[left]`，接下来问题就转化为：在区间 `[left + 1..right]` 中继续寻找满足条件的两数；
+ 同理，如果 `nums[left] + nums[right] > target`，对于 `nums[right]` 而言，即使与该区间内最小的数 `nums[left]` 相加，结果仍大于 `target`，所以该区间内的其它数与 `nums[right]` 相加也一定大于 `target`，所以可以排除 `nums[right]`，接下来问题就转化为：在区间 `[left..right - 1]` 中继续寻找满足条件的两数。

这是本题可以使用双指针解法的原因。

','7',NULL,'0167-two-sum-ii-input-array-is-sorted','2025-06-11 09:00:31','2025-06-14 14:51:17',1,10,false,NULL,'https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/description/',29,6,'',false,'https://leetcode.cn/problems/two-sum-ii-input-array-is-sorted/solutions/3695620/shuang-zhi-zhen-java-by-liweiwei1419-qy8f/',true,NULL,NULL),(68,'liweiwei1419','「力扣」第 322 题：零钱兑换（中等）','## 思路分析

题目只问最优值是多少，没有问最优具体解，一般情况可以考虑使用动态规划解决。本题的最优子结构形式比较明显，以「示例 1」为例：

凑成面值为 11 的最小硬币数可以由以下三者的最小值得到：

+ 凑成面值为 10 的最小硬币数（如果可以凑出，递归求解） + 面值为 1  的这一枚硬币；
+ 凑成面值为 9 的最小硬币数（如果可以凑出，递归求解） + 面值为 2 的这一枚硬币；
+ 凑成面值为 6  的最小硬币数（如果可以凑出，递归求解） + 面值为 5 的这一枚硬币。

我们画出递归树如下图所示：

![](https://minio.dance8.fun/algo-crazy/0322-coin-change-dp-unbounded-knapsack/temp-image4680238465632421866.png)

!!! info 阅读提示

分析动态规划问题，和解决绝大多数算法问题一样，可以在纸上画草稿分析，打开思路。

!!!


可以看出递归求解该问题，有大量 **重复子问题**，需要综合考虑 **所有** 可能的情况，即具有 **最优子结构**。感兴趣的朋友可以尝试写出「记忆化递归」的代码，这里我们仅介绍「自底向上」的「动态规划」的写法。

我们尝试直接将问题的问法定义成状态，题目问凑成总金额 `amount` 所需要的最少硬币数，我们也按照这样的问法定义状态。

+ **状态定义**： `dp[i]` 表示凑成金额 `i` 所需要的最少硬币个数；
+ **状态转移方程**：对于每个金额 `i`（从 `1` 到 `amount`），遍历所有的硬币面额 `coin`（`coin` 取自 `coins` 数组），如果当前硬币面额 `coin` 小于等于金额 `i`，那么可以尝试使用该硬币来凑成金额 `i`，此时更新 `dp[i]` 的值为所有 `dp[i - coin] + 1` 中的最小值，即 `dp[i] = min(dp[i], dp[i - coin] + 1)`。这里 `dp[i - coin]` 表示凑成金额 `i - coin` 所需要的最少硬币个数（也就是之前已经计算好的状态值），再加上使用当前硬币 `coin`，1 个硬币，所以是 + 1；
+ **考虑初始值**：当金额 `i` 为 `0` 时，不需要任何硬币就能凑成，所以 `dp[0] = 0`。对于其它金额的初始情况，由于要找的是最小值，我们可以先将 `dp` 数组中除 `dp[0]` 以外的值设置为一个不可能的较大值（比如 `amount + 1`，因为即使用所有面额为 `1` 的硬币来凑，个数是 `amount`， `amount + 1` 就是一个不可能的较大值），表示暂时还未确定其最少硬币个数；
+ **考虑输出**：最后判断 `dp[amount]` 的值，如果它仍为初始的时候设置的较大值，说明无法凑出给定的金额 `amount`，返回 `-1`；否则返回 `dp[amount]`，它就是凑成总金额 `amount` 所需的最少硬币个数。
+ **考虑优化空间**：被参考的状态值 `dp[i - coin]` 中有变量 `coin` ，`coin` 是硬币面额，由于访问的位置不固定，无法像斐波那契数列那样只用两三个变量滚动计算，因此无法优化空间。

这里我们给出记忆化递归和动态规划两版代码，以后我们介绍的例题都只给出动态规划的代码。

**参考代码 1**：

```java
import java.util.Arrays;

public class Solution {
    
    public int coinChange(int[] coins, int amount) {
        // memo[i] 表示凑成金额 i 所需的最少硬币数
        int[] memo = new int[amount + 1];
        Arrays.fill(memo, -2); // 初始化为 -2（表示未计算）
        return dfs(coins, amount, memo);
    }

    private int dfs(int[] coins, int amount, int[] memo) {
        // 金额为 0，不需要硬币
        if (amount == 0) {
            return 0; 
        }
        // 无法凑成
        if (amount < 0) {
            return -1; 
        }

        if (memo[amount] != -2) {
            // 直接返回已计算的结果
            return memo[amount]; 
        }
        // 注意：因为要比较的是最小值，初始化的时候就得赋值成为一个不可能的、较大的值
        int minCoins = amount + 1;
        for (int coin : coins) {
            int res = dfs(coins, amount - coin, memo);
            if (res != -1) {
                // 选择最小的硬币数
                minCoins = Math.min(minCoins, res + 1); 
            }
        }

        memo[amount] = (minCoins == amount + 1) ? -1 : minCoins;
        return memo[amount];
    }
}
```

**复杂度分析**：

+ 时间复杂度：$ O(amount \times n) $，其中 `n` 是硬币种类数（记忆化后每个 `amount` 只计算一次）；
+ 空间复杂度：$ O(amount) $，`memo` 数组 + 递归栈。

**参考代码 2**：

```java
import java.util.Arrays;

public class Solution {

    public int coinChange(int[] coins, int amount) {
        // 给 0 占位
        int[] dp = new int[amount + 1];
        // 注意：因为要比较的是最小值，初始化的时候就得赋值成为一个不可能的、较大的值
        // 初始化
        Arrays.fill(dp, amount + 1);
        dp[0] = 0;
        for (int i = 1; i <= amount; i++) {
            for (int coin : coins) {
                if (i - coin >= 0 && dp[i - coin] != amount + 1) {
                    dp[i] = Math.min(dp[i], 1 + dp[i - coin]);
                }
            }
        }
        // 如果不能凑出，根据题意返回 -1
        if (dp[amount] == amount + 1) {
            dp[amount] = -1;
        }
        return dp[amount];
    }
  
}
```

**复杂度分析：**

+ 时间复杂度：$ O(amount \times n) $。这里有两层循环，外层循环遍历金额从 `1` 到 `amount`，共 `amount` 次，内层循环遍历硬币面额数组 `coins`，假设硬币面额的种类数为 `n`，所以总的时间复杂度为 $ O(amount \times n) $；
+ 空间复杂度：$ O(amount) $。定义了长度为 `amount + 1` 的状态数组保存中间状态，所以空间复杂度为 $ O(amount) $。

## 总结
+ 动态规划其实没有为问题本身设计什么特殊的解法，和递归（深度优先遍历）一样，动态规划也是考虑了 **所有** 可能的情况，逐步组合出原问题的最优解，动态规划问题可以自底向上通过递推求解；
+ 若状态转移方程正确（如 `dp[i] = min(dp[i], dp[i - coin] + 1)`），则天然满足最优子结构，面试中通常无需显式证明，但需能解释转移方程的合理性；
+ 本题不优化空间的原因：由于状态转移方程中 `dp[i]` 依赖于 `dp[i - coin]`，而 `coin` 是变量，直接复用空间会导致编码复杂性和潜在的错误风险。

# 练习
+ 「力扣」第 279 题：完全平方数（中等）；
    - 题目地址：[https://leetcode.cn/problems/perfect-squares/description/](https://leetcode.cn/problems/perfect-squares/description/)
+ 「力扣」第 343 题：整数拆分（中等）。
    - 题目地址：[https://leetcode.cn/problems/integer-break/description/](https://leetcode.cn/problems/integer-break/description/)','17',NULL,'0322-coin-change-dp','2025-06-11 08:12:31','2025-06-20 08:57:43',0,328,false,NULL,'https://leetcode.cn/problems/coin-change/description/',39,2,'',false,NULL,true,'完成。',NULL),(92,'liweiwei1419','「力扣」第 994 题：腐烂的橘子（中等）','## 思路分析

题目问「直到单元格中没有新鲜橘子为止所必须经过的最小分钟数」，看到「最小」，提示我们可以使用「广度优先遍历」：将初始的腐烂橘子加入队列，然后模拟每分钟腐烂橘子的扩散过程，每一轮扩散会让相邻的新鲜橘子变为腐烂橘子，直到「队列为空」或者「没有新鲜橘子」为止。

**编码细节**：

- **初始化队列和统计新鲜橘子数量**：遍历网格，将初始的腐烂橘子（值为 2）加入队列，队列元素为一个包含行、列的数组，统计新鲜橘子（值为 1）的数量；
- **广度优先遍历过程**：从队列中取出一个腐烂橘子，遍历其 4 个相邻位置。如果相邻位置是新鲜橘子，则将其变为腐烂橘子，新鲜橘子数量减 1，将新的腐烂橘子加入队列，时间加 1，并更新分钟数；
- **判断结果**：如果队列为空后，新鲜橘子数量为 0，说明所有新鲜橘子都已腐烂，返回分钟数；否则返回 -1；

**参考代码**：

```java
import java.util.LinkedList;
import java.util.Queue;

public class Solution {

    public int orangesRotting(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        // 相邻的橘子才会腐烂
        int[][] directions = {{-1, 0}, {0, -1}, {1, 0}, {0, 1}};
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];
        // 计算新鲜橘子的个数
        int count = 0;
        // 初始化的时候，把腐烂的橘子加入队列
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    count++;
                } else if (grid[i][j] == 2) {
                    queue.offer(new int[]{i, j});
                }
            }
        }

        int step = 0;
        while (!queue.isEmpty()) {
            // 注意：一定要在这里判断，否则 step 开始自增，影响结果
            if (count == 0) {
                // 如果当前没有新鲜的橘子，就没有可以扩散的区域了
                break;
            }

            step++;
            int curSize = queue.size();
            for (int i = 0; i < curSize; i++) {
                int[] front = queue.poll();
                int x = front[0];
                int y = front[1];
                for (int[] direction : directions) {
                    int newX = x + direction[0];
                    int newY = y + direction[1];
                    if (inArea(newX, newY, m, n) && !visited[newX][newY] && grid[newX][newY] == 1) {
                        queue.offer(new int[]{newX, newY});
                        visited[newX][newY] = true;
                        count--;
                    }
                }
            }
        }

        if (count > 0) {
            // 此时说明，好的橘子是一个「孤岛」，不会被坏橘子污染到
            return -1;
        }
        return step;
    }

    private boolean inArea(int i, int j, int m, int n) {
        return 0 <= i && i < m && 0 <= j && j < n;
    }

}
```

**复杂度分析**：

+ **时间复杂度**：$ O(m \times n) $，其中 $ m $ 和 $ n $ 分别是网格的行数和列数，需要遍历整个网格，并且每个单元格最多被访问一次；
+ **空间复杂度**：$ O(m \times n) $，主要是队列的空间，最坏情况下队列中可能存储所有的单元格。','19',NULL,'0994-rotting-oranges','2025-06-11 08:36:18','2025-06-12 09:53:13',1,3,false,NULL,'https://leetcode.cn/problems/rotting-oranges/description/',41,5,'',false,NULL,true,NULL,NULL),(69,'liweiwei1419','「力扣」第 120 题：三角形最小路径和（中等）','## 思路分析
本题的重点在于：**每一步只能移动到下一行中相邻的结点上**。这一点非常关键，大家在理解这道问题的解法的时候，如果有卡住的地方，可以再回顾题目中的这个条件。我们以「示例 1」为例，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image5250788411674791119.png)

先计算到达第 2 层的所有结点的最小路径和。由于第 1 层只有 1 个结点，那么到达第 2 层的 2 个结点的最小路径和，就分别是第 1 层结点的值加上第 2 层各个结点自身的值。

下面计算第 3 层的所有结点的最小路径和，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image2120292937397676705.png)

+ 到达第 1 个结点 6 的最小路径和只能从第 2 层第 1 个结点 3 得到，即 5 + 6 = 11；
+ 到达第 2 个结点 5 的最小路径和，由第 2 层两个结点的最小路径和较小的那个（这里是结点 3 的最小路径和 5）加上自身的值 5 得到，即 5 + 5 = 10；
+ 到达第 3 个结点 7 的最小路径和只能从第 2 层第 2 个结点 4 得到，即 6 + 7 = 13。

下面计算第 4 层，具体的计算过程就不赘述了，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image8462949313763535788.png)

综上所述：

+ 两侧的结点的最小路径和只能来自上一层边缘结点已经计算好的最小路径和 + 自身的值；
+ 中间的结点的最小路径和来自上一层已经计算好的两个最小路径和中的较小者 + 自身的值。

下面我们按照动态规划问题的思考步骤，罗列 要点

+ **状态定义**：`dp[i][j]` 表示到第 `i` 行第 `j` 列的最小路径和；
+ **状态转移方程**：`dp[i][j] = Math.min(dp[i - 1][j - 1], dp[i - 1][j]) + triangle.get(i).get(j)` ，数组下标为负数，即 `i - 1 < 0` 和 `j - 1 < 0` 的情况需单独讨论；
+ **考虑初始化**：第 1 行第 1 列的值 `triangle.get(0).get(0)` 就是初始化的状态值；
+ **考虑输出**：最后一行 `dp` 数组中的最小值就是自顶向下的最小路径和。

**参考代码 1**：

```java
import java.util.List;

public class Solution {

    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        int[][] dp = new int[n][n];
        // dp[i][j] 表示：到第 i 行第 j 列的最小路径和
        dp[0][0] = triangle.get(0).get(0);

        for (int i = 1; i < n; i++) {
            // 按照「从上到下」的顺序计算的时候，两侧的数值需要单独计算
            dp[i][0] = dp[i - 1][0] + triangle.get(i).get(0);
            for (int j = 1; j < i; j++) {
                dp[i][j] = Math.min(dp[i - 1][j - 1], dp[i - 1][j]) + triangle.get(i).get(j);
            }
            dp[i][i] = dp[i - 1][i - 1] + triangle.get(i).get(i);
        }

        int res = dp[n - 1][0];
        for (int i = 1; i < n; i++) {
            res = Math.min(res, dp[n - 1][i]);
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：双重循环遍历三角形，时间复杂度为 $ O(n^2) $，其中 `n` 是三角形的行数。
+ 空间复杂度：使用了一个二维数组 `dp`，其大小和三角形的元素个数相同，空间复杂度为 $ O(n^2) $。

我们求解这个问题，**状态的定义满足无后效性，即：一旦确定了到达某个位置的最小路径和，它不会因为后续的决策而改变**。即：一旦计算出 `dp[i][j]` 的值，它只取决于 `dp[i - 1][j - 1]` 和 `dp[i - 1][j]` 的值（这里假设 `i - 1`、`j - 1` 都大于等于 0），而不会受到后续行或列的影响。

这意味着我们可以按照一定的顺序（如「自顶向下」或「自底向上」，这里指在三角形中的计算方向，不是记忆化递归的「自顶向下」和动态规划的「自底向上」）计算最小路径和，且前面计算的结果可以作为后续计算的基础，**后续计算不会对前面已经计算的结果产生影响，满足无后效性**。

+ **考虑优化空间**：因为计算 `dp[i][j]` 时只用到 `dp[i - 1][j - 1]` 和 `dp[i - 1][j]`，因此可以优化空间复杂度，将二维数组优化为一维数组，优化后空间复杂度为 $ O(n) $。计算过程如下：先把最后一层的数值赋值到一维数组，如下图所示。

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image490498691755192834.png)

接着计算倒数第 2 层，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image14552931048099701006.png)

每一个结点都有两个孩子结点，选其中较小者和自己相加，接着计算倒数第 3 层，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image17227844876965099818.png)

最后计算根结点，如下图所示。

![](https://minio.dance8.fun/algo-crazy/0120-triangle/temp-image6019543485509804679.png)

!!! info 阅读提示

由于纸张不便展示计算过程，我们建议大家在纸上进行模拟，进而体会：通过「自底向上」计算，重复使用一维数组空间，不会覆盖将来还要用到值。

!!! 

这里从倒数第二行开始向上遍历，直接在状态数组（初始化为输入数据最后一行的值）上进行修改，从而降低空间复杂度，同时也避免了三角形两侧的数值需要单独计算的情况。优化空间后的代码如下：

**参考代码 2**： 从下到上计算。

```java
import java.util.List;

public class Solution {

    public int minimumTotal(List<List<Integer>> triangle) {
        int n = triangle.size();
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = triangle.get(n - 1).get(i);
        }

        for (int i = n - 2; i >= 0; i--) {
            for (int j = 0; j <= i; j++) {
                dp[j] = Math.min(dp[j], dp[j + 1]) + triangle.get(i).get(j);
            }
        }
        return dp[0];
    }
}
```

我们也可以多开一个空间，初始化的过程就可以合并到状态转移的过程中。

**参考代码 3**：

```java
import java.util.List;

public class Solution {

    public int minimumTotal(List<List<Integer>> triangle) {
        int len = triangle.size();
        int[] dp = new int[len + 1];
        for (int i = len - 1; i >= 0; i--) {
            for (int j = 0; j < i + 1; j++) {
                dp[j] = Math.min(dp[j], dp[j + 1]) + triangle.get(i).get(j);
            }
        }
        return dp[0];
    }
}
```

## 本题总结
「每一步只能移动到下一行中相邻的结点上」是解决本题的关键，当前状态值来自上一行相邻两个位置（如果有的话）的最小值加上自身的值。

初学动态规划时，可以像本题一样，拿一个具体的例子，再草稿纸上进行手动计算，相信通过一定量的练习，可以理解动态规划的设计思想，其实就是「空间换时间」和「组合子问题的解」。

在做题的时候，没有必要严格论证「重叠子问题」和「最优子结构」，下面是通常的解题步骤：

+ 定义清楚状态，可以作为注释写在代码中；
+ 状态转移方程通常可以体现在代码中；
+ 考虑清楚初始的值；
+ 考虑清楚返回值是什么，有些时候是最后一个状态值，有些时候还需要一些计算（例如对所有的「状态」求最值）才能得到返回值；
+ 优化空间不是必须的，取决于题目对空间的要求。','17',NULL,'0120-triangle','2025-06-11 08:12:31','2025-06-18 17:10:46',1,28,false,NULL,'https://leetcode.cn/problems/triangle/description/',39,3,'',false,NULL,true,'完成。',NULL),(95,'liweiwei1419','「力扣」第 773 题：滑动谜题（困难）','## 思路分析
本题是一个状态搜索问题。目标是通过移动空白块（用 `0` 表示）将拼图从初始状态转换为目标状态 `[[1,2,3],[4,5,0]]`。假设初始状态为 `board = [[1, 0, 3], [2, 4, 5]]`，即字符串状态为 `"103245"`。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0773-sliding-puzzle/temp-image11346149563299193435.png)

题目问「最少可以通过多少次移动解开谜板」，有「最少」关键字，提示我们可以使用广度优先遍历，而且目标状态已知，还可以使用「双向 BFS」。

**编码细节**：

- 将二维数组 `board` 展开成一维字符串来表示一个状态，例如 `board = [[1, 2, 3], [4, 5, 0]]` 可以表示为字符串 `"123450"`。这样做的好处是方便在哈希表中存储和比较不同的状态；
- 对于一个长度为 6 的字符串，`''0''` 的位置可以是 0 到 5。我们使用一个表示方向的数组 `DIRECTIONS` 罗列数字 `''0''` 位于哪个位置时，它可以移动到的位置列表。例如，当 `''0''` 在位置 0 时，它只能移动到位置 1、3；当 `''0''` 在位置 2 时，它可以移动到位置 1、5 等。如下图所示，黑色格子表示 `''0''` 可以移动到的位置：


![](https://minio.dance8.fun/algo-crazy/0773-sliding-puzzle/temp-image3027965756969431178.png)

## 方法一：单向 BFS
从初始状态开始，使用队列存储待扩展的状态，每次从队列中取出一个状态，将其所有可能的下一步状态加入队列，直到找到目标状态或队列为空。

**参考代码 1**：

```java
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

public class Solution {

    private static final String TARGET = "123450";
    // 方向数组，用于表示空白块的移动方向
    private static final int[][] DIRECTIONS = {{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}};

    public int slidingPuzzle(int[][] board) {
        // 将初始的 board 转换为字符串
        StringBuilder stringBuilder = new StringBuilder();
        for (int[] row : board) {
            for (int num : row) {
                stringBuilder.append(num);
            }
        }
        String start = stringBuilder.toString();
        // 如果初始状态就是目标状态，直接返回 0
        if (TARGET.equals(start)) {
            return 0;
        }

        Queue<String> queue = new LinkedList<>();
        queue.offer(start);
        Set<String> visited = new HashSet<>();
        visited.add(start);
        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (TARGET.equals(current)) {
                    return steps;
                }

                // 找到 ''0'' 的位置
                int zeroIndex = current.indexOf(''0'');
                // 遍历所有相邻位置
                for (int neighborIndex : DIRECTIONS[zeroIndex]) {
                    // 交换 zeroIndex 和 neighborIndex
                    String next = swap(current, zeroIndex, neighborIndex);
                    if (!visited.contains(next)) {
                        queue.offer(next);
                        visited.add(next);
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    // 交换字符串中两个位置的字符
    private String swap(String s, int i, int j) {
        char[] chars = s.toCharArray();
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
        return new String(chars);
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(b^d) $，这里 $ b $ 是分支因子（从一个状态通过单次操作能够到达的新状态的平均数量），数字 `0` 的位置最多有 4 种移动方向（中、边、角），因此 $ b \approx 2 \sim 3 $，$ d $ 是最短路径步数；
+ 空间复杂度：$ O(b^d) $，存储队列和已访问状态。

## 方法二：双向 BFS
从初始状态和目标状态同时开始进行广度优先遍历，使用两个队列（在代码中队列的形态是哈希表，这是因为需要快速判断在对面的队列中是否出现，元素顺序无关紧要）分别存储两个方向的待扩展状态，当两个方向的搜索相遇时，即找到了最少移动次数。

**参考代码 2：**

```java
import java.util.HashSet;
import java.util.Set;

public class Solution {

    private static final String TARGET = "123450";
    // 方向数组，用于表示空白块的移动方向
    private static final int[][] DIRECTIONS = {{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}};

    public int slidingPuzzle(int[][] board) {
        // 将初始的 board 转换为字符串
        StringBuilder stringBuilder = new StringBuilder();
        for (int[] row : board) {
            for (int num : row) {
                stringBuilder.append(num);
            }
        }
        String start = stringBuilder.toString();
        if (TARGET.equals(start)) {
            return 0;
        }

        // 双向 BFS
        Set<String> visited = new HashSet<>();
        Set<String> beginSet = new HashSet<>();
        Set<String> endSet = new HashSet<>();
        beginSet.add(start);
        endSet.add(TARGET);

        int steps = 0;
        while (!beginSet.isEmpty() && !endSet.isEmpty()) {
            // 总是从较小的集合开始扩展
            if (beginSet.size() > endSet.size()) {
                Set<String> temp = beginSet;
                beginSet = endSet;
                endSet = temp;
            }

            Set<String> nextLevel = new HashSet<>();
            for (String current : beginSet) {
                if (endSet.contains(current)) {
                    return steps;
                }
                visited.add(current);
                int zeroIndex = current.indexOf(''0'');
                for (int neighborIndex : DIRECTIONS[zeroIndex]) {
                    String next = swap(current, zeroIndex, neighborIndex);
                    if (!visited.contains(next)) {
                        nextLevel.add(next);
                    }
                }
            }
            beginSet = nextLevel;
            steps++;
        }
        return -1;
    }

    // 交换字符串中两个位置的字符
    private String swap(String s, int i, int j) {
        char[] chars = s.toCharArray();
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
        return new String(chars);
    }

}
```

**复杂度分析**：

+ 时间复杂度：从初始和目标状态同时搜索，时间降为 $ O(b^{\frac{d}{2}}) $ ；
+ 空间复杂度：两端队列存储状态数减少，空间仍为  $ O(b^{\frac{d}{2}}) $。','19',NULL,'0773-sliding-puzzle','2025-06-11 08:36:19','2025-06-18 16:42:28',1,15,false,NULL,'https://leetcode.cn/problems/sliding-puzzle/description/',41,8,'',false,NULL,true,NULL,NULL),(71,'liweiwei1419','「力扣」第 174 题：地下城游戏（困难）','
## 思路分析

我们先强调题目中的关键点，以便于大家理解这道问题解法的合理性。

+ **棋盘数值**：每个单元格 `dungeon[i][j]` 中的整数可能为正、负或零。如果 `dungeon[i][j]` 只有是正数和零，本题就是「力扣」第 64 题：最小路径和。
+ **骑士行动规则**：骑士只能向右或向下移动。这一规则限制了可能的路径；
+ **生命值限制**：骑士的生命值不能降至 1 以下，这是整个问题的核心约束。

一个比较容易想到的计算顺序是类似「力扣」第 64 题（最小路径和）的计算顺序：从左到右，从上到下。

## 正向推导有后效性
但是由于 `dungeon[i][j]` 中有负数，因此如果选择左边和上面单元格中的较小者，可能会受到「**生命值限制**」，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image15555224378806426734.png)

此时应该选择从 11 到 -5。这就是「从左到右，从上到下」这种计算顺序产生的「后效性」：**后面遇到的数值影响了前面计算的结果**。我们再说得详细一点：

+ 如果图中 `dungeon[i][j] = 1` ，则最优路径从上面（3）到下面；
+ 如果图中 `dungeon[i][j] = -5` ，因为需要保证骑士的健康点大于 0，则最优路径从左边（11）到右边。

即 `dungeon[i][j]` 的值影响了之前最优路径的选择，因此「从左到右，从上到下」这种计算顺序 **有后效性**。

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image1928285032189632421.png)

于是我们尝试从右下角反向推导。

## <font style="color:#000000;">从右下角反向推导</font>
定义状态数组 `dp[i][j]` 表示从 `(i, j)` 位置出发到达右下角所需的最小健康点数。根据题目叙述「**骑士的初始健康点数为一个正整数。如果他的健康点数在某一时刻降至 0 或以下，他会立即死亡**」，有 `dp[i][j] > 0`，这一点很重要。 

以「示例 1」为例，`dungeon[2][2] = -5`，要保证到 `(2, 2)` 至少有 1 个健康点，骑士至少需要有 6 个健康点，计算过程为：`dp[2][2] + (-5) = 1`，得 `dp[2][2] = 6`。 如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image13502552411248664768.png)

计算 `dp[2][1]`：由 `(2, 1)`只能去 `(2, 2)`。`dungeon[2][1] = 30`，增加 30 个健康点，而到 `(2, 2)` 至少需要 6 个健康点，所以在 `(2, 1)` 骑士只需要有 1 个健康点。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image7895595413812587513.png)

即：`dungeon[i][j]`是正数或者零，且移动的目标位置也是正数时，`dp[i][j] = 1`。

计算 `dp[2][0]`：同理 `dungeon[2][0] = 10`，`dp[2][1] = 1`，意思是在 `(2, 0)`能加 10 个健康点，到 `(2, 1)` 至少需要 1 个健康点，所以在 `(2, 0)` 骑士也只需要有 1 个健康点。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image7570598876268717008.png)

计算 `dp[1][2]`：`dungeon[1][2] = 1`，`dp[2][2] = 6` 表示到 `(2, 2)` 至少要有 6 个健康点，骑士在 `(1, 2)` 至少需要有 5 个健康点。计算过程为 `dp[1][2] + 1 = 6`，因此 `dp[1][2] = 5`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image16178819554959371127.png)

计算 `dp[1][1]`：`(1, 1)`需要的最少健康点取决于 `dp[1][2]` 和 `dp[2][1]` 中较小者。这里 `dp[1][2] = 5 > dp[2][1] = 1`，表示从 `(1, 1)` 到 `(2, 1)` 骑士自身需要的最少健康点数较少，计算 `dp[1][1] + dungeon[1][1] = dp[2][1]`，得 `dp[1][1] = 1 - (-10) = 11`。 如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image16814972248731412648.png)

计算 `dp[1][0]`：`(0, 1)` 需要的最少健康点取决于 `dp[1][1]` 和 `dp[2][0]` 中较小者。这里 `dp[1][1] = 11 > dp[2][0] = 1`，表示从 `(1, 0)` 到 `(2, 0)` 骑士自身需要的最少健康点数较少，计算 `dp[1][0] + dungeon[1][0] = dp[2][0]`，得 `dp[1][0] = 1 - (-5) = 6`。 如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image17588738279008247622.png)

计算 `dp[0][2]`：`(0, 2)`只能去向 `(1, 2)`，而 `dungeon[0][2] = 3`，则 `dp[0][2] = 2`，计算过程为 `dp[0][2] + dungeon[0][2] = dp[1][2]`。 如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image15725620975752380960.png)

计算 `dp[0][1]`：比较 `dp[0][2]` 和 `dp[1][1]` ，`dp[0][2]`较小，则骑士从 `(0, 1)` 到 `(0, 2)`需要更少的健康点，计算 `dp[0][1] + dungeon[0][1] = dp[0][2]`，得 `dp[0][1] = 2 - (-3) = 5`。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image18062641885819233824.png)

计算 `dp[0][0]`，`dp[0][1] < dp[1][0]`，则骑士从 `(0, 0)` 到 `(0, 1)` 需要更少的健康点，计算 `dp[0][0] + dungeon[0][0] = dp[0][1]`，得 `dp[0][0] = 5 - (-2) = 7`。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image8660654863214101604.png)

## <font style="color:#000000;">反向推导的合理性</font>
当我们从右下角开始反向推导时，对于 `(i, j)` 位置，它的状态只依赖于其右侧 `(i, j + 1)` 位置和下方 `(i + 1, j)` 位置（假设 `i < m - 1` 且 `j < n - 1`）。具体来说：

+ 右下角（`i = m - 1`，`j = n - 1`）：如果其值大于等于 0，则只需 1 生命值；如果小于 0，先需要补上把它变为 0 需要的健康点数（该负数的绝对值），再加 + 1，保证其实至少有 1 个健康点。因此，需要 1 减去该位置的值作为初始生命值。
+ 最后一行（`i = m - 1`）：从右向左计算，`dp[m - 1][j]` 的值只取决于 `dp[m - 1][j + 1]` 和 `dungeon[m - 1][j]`。因为我们要保证骑士从 `(m - 1, j)` 位置到达 `(m - 1, j + 1)` 时至少有 1 点健康点，所以 `dp[m - 1][j] = max(1, dp[m - 1][j + 1] - dungeon[m - 1][j])`。
+ 最后一列（`j = n - 1`）：从下往上计算，`dp[i][n - 1]` 的值只取决于 `dp[i + 1][n - 1]` 和 `dungeon[i][n - 1]`，即 `dp[i][n - 1] = max(1, dp[i + 1][n - 1] - dungeon[i][n - 1])`。
+ 中间的格子 `(i, j)`（`i < m - 1` 且 `j < n - 1`）：它可以从下方或者右方过来，而我们已经计算出了 `dp[i + 1][j]` 和 `dp[i][j + 1]` 的最小初始生命值，那么为了确保骑士从 `(i, j)` 出发能安全到达终点，我们需要考虑从 `(i, j)` 出发选择较优（所需初始生命值更小）的后续路径，因此 `dp[i][j] = max(1, min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j])`。

按照上面的分析，我们就可以根据已经计算出的后续位置的最小初始生命值，来准确计算当前位置所需的最小初始生命值。

![](https://minio.dance8.fun/algo-crazy/0174-dungeon-game/temp-image1883844425293531056.png)

+ **状态定义**：`dp[i][j]` 表示从位置 `(i, j)` 到达终点所需的最小初始生命值；
+ **状态转移方程**：`dp[i][j] = max(1, min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j])`；
+ **初始化**：`dp[m - 1][n - 1] = max(1, 1 - dungeon[i][j])`（至少需要 1 点生命值），最后一行和最后一列的初始化逻辑我们上面也描述了；
+ **输出值**：`dp[0][0]`。

**参考代码**：

```java
public class Solution {

    public int calculateMinimumHP(int[][] dungeon) {
        int m = dungeon.length;
        int n = dungeon[0].length;
        // dp[i][j] 表示从 (i, j) 位置到达右下角所需的最小初始生命值
        int[][] dp = new int[m][n];
        // 初始化右下角
        dp[m - 1][n - 1] = Math.max(1, 1 - dungeon[m - 1][n - 1]);
        // 处理最后一行，从右向左推导
        for (int j = n - 2; j >= 0; j--) {
            dp[m - 1][j] = Math.max(1, dp[m - 1][j + 1] - dungeon[m - 1][j]);
        }
        // 处理最后一列，从下向上推导
        for (int i = m - 2; i >= 0; i--) {
            dp[i][n - 1] = Math.max(1, dp[i + 1][n - 1] - dungeon[i][n - 1]);
        }
        // 处理中间的格子
        for (int i = m - 2; i >= 0; i--) {
            for (int j = n - 2; j >= 0; j--) {
                // 从下和右两个方向取最小所需生命值，再减去当前格子的消耗或增益，确保生命值不小于 1
                dp[i][j] = Math.max(1, Math.min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j]);
            }
        }
        return dp[0][0];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，我们需要遍历整个二维地牢矩阵，矩阵大小为 $ m $ 行 $ n $ 列，每个网格点只计算一次，没有重复计算，从右下角向左上角反向 DP 计算，确保每个点处理一次；
+ 空间复杂度：$ O(m \times n) $，需要一个与原矩阵相同大小的二维数组来存储 DP 状态，可以优化到 $ O(\min(m,n)) $，标准解法通常使用 $ O(m \times n) $。
+ **考虑优化空间**：可以按行或按列处理，只保存一行或一列的数据，选择较小的维度可以进一步节省空间，可以按行或按列处理，只保存一行或一列的数据，处理顺序必须保持不变（从右下到左上）。

**参考代码 2**：

```java
public class Solution {
    
    public int calculateMinimumHP(int[][] dungeon) {
        // 如果列数小于行数，转置矩阵以优化空间
        if (dungeon[0].length < dungeon.length) {
            dungeon = transpose(dungeon);
        }
        return calculateWithRowDP(dungeon);
    }
    
    private int calculateWithRowDP(int[][] dungeon) {
        int m = dungeon.length;
        int n = dungeon[0].length;
        int[] dp = new int[m];
        
        // 初始化右下角
        dp[m - 1] = Math.max(1, 1 - dungeon[m - 1][n - 1]);
        
        // 处理最后一列
        for (int i = m - 2; i >= 0; i--) {
            dp[i] = Math.max(1, dp[i + 1] - dungeon[i][n - 1]);
        }
        
        // 从右向左逐列处理
        for (int j = n - 2; j >= 0; j--) {
            // 更新当前列的最后一行
            dp[m - 1] = Math.max(1, dp[m - 1] - dungeon[m - 1][j]);
            
            // 从下向上更新当前列
            for (int i = m - 2; i >= 0; i--) {
                dp[i] = Math.max(1, Math.min(dp[i], dp[i + 1]) - dungeon[i][j]);
            }
        }
        
        return dp[0];
    }
    
    // 矩阵转置方法
    private int[][] transpose(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] transposed = new int[n][m];
        
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                transposed[j][i] = matrix[i][j];
            }
        }
        
        return transposed;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $；
+ 空间复杂度：$ O(\min(m,n)) $。

## 本题总结

在本题中，由于生命值的限制，当前状态不仅依赖于之前的状态，还受到未来路径的影响，如果按照常规思路定义状态，从左到右，从上到下计算，就有后效性。

为了消除后效性，我们通过 **改变状态定义、调整计算顺序** 来将问题转化为满足「无后效性」的形式。

本题按照逆序方式计算就无后效性，这是因为 **每一步的计算结果都考虑了终点值的正负**。

# 总结

动态规划问题的通用解题思路是：

+ 定义状态：明确 `dp` 数组的含义，通常固定某些因素（如以 `i` 结尾）；
+ 状态转移：根据问题特点，推导状态如何从子问题转移而来；
+ 初始化：处理边界条件，确保递推起点正确；
+ 输出结果：根据问题要求，从 `dp` 数组中提取最终答案（如最大值或最后一个状态值）；
+ 空间优化：根据状态依赖关系，考虑使用滚动变量或降维技巧优化空间复杂度。','17',NULL,'0174-dungeon-game','2025-06-11 08:12:31','2025-06-18 17:28:48',1,46,false,NULL,'https://leetcode.cn/problems/dungeon-game/description/',39,5,'',false,NULL,true,'完成。',NULL),(91,'liweiwei1419','「力扣」第 542 题：01 矩阵（中等）','本节介绍的「多源 BFS」的核心思想是 **通过引入一个虚拟的超级源点，将多个起点的问题转化为从该虚拟源点出发的「单源 BFS」问题**。这个技巧可以简化多起点情况的处理，使其能够直接套用标准的广度优先遍历算法。

具体实现时，我们通常不需要显式创建虚拟结点，而是将所有起点初始时都加入队列，并将它们的距离设为 0（相当于这些结点都与虚拟源点相连）。这样就能保证 BFS 会同时从所有起点开始向外扩展。

# 例题 1：「力扣」第 542 题：01 矩阵（中等）
+ 题目地址：[https://leetcode.cn/problems/01-matrix/description/](https://leetcode.cn/problems/01-matrix/description/)


## 思路分析
题目问「`mat` 中对应位置元素到最近的 0 的距离」，有「最近」提示我们可以使用广度优先遍历。具体思路如下：

+ 首先遍历矩阵，将所有值为 0 的位置加入队列，这些位置到最近的 0 的距离就是 0。同时，将其它位置的距离初始化为一个不可能是结果的特殊值，这里设置成 -1 表示未访问；
+ 然后从队列中取出元素，对其上、下、左、右四个相邻位置进行检查。如果相邻位置未被访问过（值为 -1），则更新该位置的距离为当前位置的距离加 1，并将该相邻位置加入队列；
+ 重复步骤 2，直到队列为空。

**参考代码**：

```java
import java.util.LinkedList;
import java.util.Queue;


public class Solution {

    public int[][] updateMatrix(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == 0) {
                    // 从为 0 的地方开始向外扩散
                    queue.add(getIndex(i, j, n));
                } else {
                    // 设置成一个特殊值，说明当前这个坐标的位置还没有被扩散到
                    matrix[i][j] = -1;
                }
            }
        }

        int[][] directions = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}};
        // 从为 0 的地方开始进行广度优先遍历
        while (!queue.isEmpty()) {
            // 当前的位置，一开始的时候，"0" 正好，到 "0" 的距离也是 0 ，符合题意
            Integer head = queue.poll();

            int currentX = head / n;
            int currentY = head % n;

            // 现在要往 4 个方向扩散
            for (int i = 0; i < 4; i++) {
                int newX = currentX + directions[i][0];
                int newY = currentY + directions[i][1];
                // 在有效的坐标范围内，并且还没有被访问过
                if (inArea(newX, newY, m, n) && matrix[newX][newY] == -1) {
                    matrix[newX][newY] = matrix[currentX][currentY] + 1;
                    queue.add(getIndex(newX, newY, n));
                }
            }
        }
        return matrix;
    }

    private int getIndex(int x, int y, int n) {
        return x * n + y;
    }

    private boolean inArea(int x, int y, int m, int n) {
        return x >= 0 && x < m && y >= 0 && y < n;
    }

}
```

**说明**：

+ 由于本题就是让我们在输入矩阵上修改，此时不需要另外使用 `visited` 数组记录哪些顶点被访问过；
+ 初始化距离矩阵时，将所有值为 0 的位置的距离设为 0，并加入队列，其它位置设为 -1 表示未访问；
+ 在检查新位置是否合法时，要确保新位置的坐标在矩阵的范围内，并且该位置未被访问过（距离为 -1）。

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，其中 $ m $ 是矩阵的行数，$ n $ 是矩阵的列数，每个位置最多被访问一次；
+ 空间复杂度：$ O(m \times n) $，主要用于队列和距离矩阵的存储。','19',NULL,'0542-01-matrix','2025-06-11 08:36:18','2025-06-16 14:56:40',1,7,false,NULL,'https://leetcode.cn/problems/01-matrix/description/',41,4,'',false,NULL,true,NULL,'你'),(94,'liweiwei1419','「力扣」第 126 题：单词接龙 II（困难）','
## 思路分析
和「力扣」第 127 题：单词接龙（困难）一样，本题需要使用广度优先遍历找到「最短转换序列」，题目要求我们找出 **所有** 从 `beginWord` 到 `endWord` 的最短转换序列，这一点提示我们需要使用回溯算法。因此我们需要先 **把图结构通过广度优先遍历构建出来**，即：**记录每个单词的前驱结点或者后继结点**，再通过回溯算法把所有的最短路径找出来。经过测试，记录后继结点的方式不能通过测试，我们以记录每个单词的前驱结点 `prevWords` 向大家讲解。

**在广度优先遍历建图的时候需要注意几点细节**：

+ **细节 1：同一层级的边的关系不能记录，因为经过同一层不是最短路径，如下图所示：**

![](https://minio.dance8.fun/algo-crazy/0126-word-ladder-ii/temp-image2192502000988427437.png)

+ **细节 2：两个单词可以转换到同一个单词，需要记录下来，因为题目要求得到所有的路径，如下图所示：**

![](https://minio.dance8.fun/algo-crazy/0126-word-ladder-ii/temp-image9554156707061393211.png)

我们和大家多次强调过，进行广度优先遍历的时候，当一个单词加入队列以后，需要马上标记为已经访问，即加入哈希表（或者数组）`visited` 中，以避免相同的元素重复入队。

但本题要求我们记录边的关系，以上图为例：`cog` 的前驱是 `dog` 和 `log`，因此 `prevWords` 需要记录 `dog → cog` 和 `log → cog`，在记录其中一条边的同时，`cog` 还不能马上加入 `visited` ，**需等待另一条边也记录到 `prevWords` 以后，才能把 `cog` 加入 `visited`** ，因此我们还需要一个哈希表作为缓冲**，这里我们命名为 `currentLevelVisited`，即当前层级使用的「哈希表」，这一层的所有单词都访问完才加入 `visited`，具体做法请见「参考代码」。

**参考代码**：主函数 `findLadders` 其实就做了两件事：先执行广度优先遍历构建图，在广度优先遍历能够找到目标单词的情况下，再执行 DFS。

在 `bfs` 方法里，`queue` 和 `visited` 都是我们常见的使用 BFS 的数据结构，只是我们额外地使用了 `currentLevelVisited`，针对当前这一层的单词，**如果某个扩展出来的单词在 `visited` 和 `currentLevelVisited` 中都不存在，就加入 `queue` 和 `currentLevelVisited`，这一层的单词全处理完成以后，才把  `currentLevelVisited` 全部加入 `visited`**。即：`currentLevelVisited` 仅用于当前层，确保同一层的单词不会重复入队，但仍能记录所有可能的前驱。

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

public class Solution {

    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        Set<String> wordSet = new HashSet<>(wordList);
        List<List<String>> res = new ArrayList<>();
        if (!wordSet.contains(endWord)) {
            return res;
        }

        Map<String, List<String>> prevWords = new HashMap<>();
        boolean found = bfs(beginWord, endWord, wordSet, prevWords);
        if (found) {
            Deque<String> path = new ArrayDeque<>();
            path.addFirst(endWord);
            dfs(beginWord, endWord, prevWords, path, res);
        }
        return res;
    }

    private boolean bfs(String beginWord, String endWord, Set<String> wordSet, Map<String, List<String>> prevWords) {
        boolean found = false;

        Queue<String> queue = new LinkedList<>();
        queue.offer(beginWord);
        Set<String> visited = new HashSet<>();
        visited.add(beginWord);
        Set<String> currentLevelVisited = new HashSet<>();
        while (!queue.isEmpty()) {
            int size = queue.size();
            currentLevelVisited.clear();
            for (int i = 0; i < size; i++) {
                String currentWord = queue.poll();
                List<String> nextWords = getNextWords(currentWord, wordSet);
                for (String nextWord : nextWords) {
                    if (nextWord.equals(endWord)) {
                        // 只标记找到了，还需要完成这一层前驱关系的建立，才能退出循环
                        found = true;
                    }
                    if (!visited.contains(nextWord)) {
                        if (!currentLevelVisited.contains(nextWord)) {
                            queue.offer(nextWord);
                            currentLevelVisited.add(nextWord);
                        }
                        // 记录前驱
                        prevWords.computeIfAbsent(nextWord, a -> new ArrayList<>()).add(currentWord);
                    }
                }
            }
            visited.addAll(currentLevelVisited);
            if (found) {
                return true;
            }
        }
        return false;
    }

    private void dfs(String beginWord, String endWord, Map<String, List<String>> prevWords, Deque<String> path, List<List<String>> res) {
        if (endWord.equals(beginWord)) {
            res.add(new ArrayList<>(path));
            return;
        }
        // 不作此判断会报空指针异常
        if (!prevWords.containsKey(endWord)) {
            return;
        }
        for (String precursor : prevWords.get(endWord)) {
            path.addFirst(precursor);
            dfs(beginWord, precursor, prevWords, path, res);
            path.removeFirst();
        }
    }

    private List<String> getNextWords(String word, Set<String> wordSet) {
        List<String> nextWords = new ArrayList<>();
        char[] charArray = word.toCharArray();
        int wordLen = word.length();
        for (int i = 0; i < wordLen; i++) {
            char originChar = charArray[i];
            for (char j = ''a''; j <= ''z''; j++) {
                if (j == originChar) {
                    continue;
                }
                charArray[i] = j;
                String nextWord = String.valueOf(charArray);
                if (wordSet.contains(nextWord)) {
                    nextWords.add(nextWord);
                }
            }
            charArray[i] = originChar;
        }
        return nextWords;
    }

}
```

本题的复杂度分析非常「复杂」，已经超出了我们面对算法笔试、面试的要求。并且「双向 BFS」经过笔者尝试，也一直遇到超时，且代码也超出了我们面对算法笔试、面试的要求，在这里都省略。','19',NULL,'0126-word-ladder-ii','2025-06-11 08:36:19','2025-06-18 16:25:02',1,3,false,NULL,'https://leetcode.cn/problems/word-ladder-ii/description/',41,7,'',false,'https://leetcode.cn/problems/word-ladder-ii/solutions/277612/yan-du-you-xian-bian-li-shuang-xiang-yan-du-you--2/',true,NULL,NULL),(162,'liweiwei1419','「力扣」第 231 题：2 的幂（简单）','## 思路分析

2 的幂次方在二进制表示中只有一个 1。如下表所示：

| 十进制 | 二进制 |
| --- | --- |
| $ 1 = 2^0 $ | 1 |
| $ 2 = 2^1 $ | 10 |
| $ 4 = 2^2 $ | 100 |
| $ 8 = 2^2 $ | 1000 |


我们可以使用 `n & (n - 1)` 去掉 `n` 的最低位的 1，如果 `n` 是 2 的幂次方，去掉唯一的 1 后结果是 0。同时需要检查 `n` 是否大于 0，因为：

+ 0 也满足 `(n & (n - 1)) == 0` ，但 0 不是 2 的幂次方；
- 二进制最高位是 1 的数（`10000000 00000000 00000000 00000000`），其值为负数，也满足 `(n & (n - 1)) == 0` ，但它不是 2 的幂次方。

**参考代码**：

```java
public class Solution {

    public boolean isPowerOfTwo(int n) {
        return n > 0 && (n & (n - 1)) == 0;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1) $；
+ 空间复杂度：$ O(1) $。

','22',NULL,'0231-power-of-two','2025-06-11 09:44:19','2025-06-12 10:16:18',1,4,false,NULL,'https://leetcode.cn/problems/power-of-two/description/',44,8,'',false,NULL,true,NULL,NULL),(161,'liweiwei1419','「力扣」第 421 题：数组中两个数的最大异或值（中等）','## 思路分析

和「异或」相关的的位运算问题，通常可以考虑逐位构建问题的答案。对于本题，可以从最高位（第 31 位）开始，逐步向下处理每一位。

为什么从高位构建呢？因为求最大值，高位的值能是 1 就应当尽量是 1。

这里需要用到「异或」运算的性质：如果 `a ^ b = c`，那么 `a ^ c = b` 且 `b ^ c = a`，如果有 `a ^ b = c`，即：**任意两个数「异或」得到第三个数**。联系「异或」运算的定义：不进位加法，以及性质：一个数与自己异或等于 0。

**证明**：如果 `a ^ b = c`，在等式两边同时异或 `b` ，得 `a ^ b ^ b = c ^ b = a`，在等式两边同时异或 `a` ，得 `a ^ b ^ a = c ^ a = b`（证完）。

大家可以结合「参考代码」中的注释进行理解：

**参考代码**：

```java
import java.util.HashSet;
import java.util.Set;

public class Solution {

    public int findMaximumXOR(int[] nums) {
        int res = 0;
        int mask = 0;

        // 每一位的确定都要使用新的哈希表，为此在循环外初始化，每一轮循环结束清空
        Set<Integer> hashSet = new HashSet<>();
        for (int i = 31; i >= 0; i--) {
            // mask 每一轮的样子是这样的：
            // 1000 0000 0000 0000 0000 0000 0000 0000
            // 1100 0000 0000 0000 0000 0000 0000 0000
            // 1110 0000 0000 0000 0000 0000 0000 0000
            // 1111 0000 0000 0000 0000 0000 0000 0000
            mask = mask | (1 << i);
            for (int num : nums) {
                // 用 & 依次提取最高位
                hashSet.add(num & mask);
            }

            // 这里先假定该位是 1，所以用变量 temp
            int temp = res | (1 << i);
            for (Integer prefix : hashSet) {
                if (hashSet.contains(prefix ^ temp)) {
                    // 如果 temp 与某个前缀的异或结果也在哈希表中，说明 temp 是结果的前缀
                    res = temp;
                    break;
                }
            }
            hashSet.clear();
        }
        return res;
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(32 n) = O(n) $，这里 $ n $是输入数组的长度；
+ 空间复杂度：$ O(n) $，我们使用一个哈希表用于存储所有数字。

## 本题总结

+ 位运算的问题可以考虑从最高位到低位，一位一位构建问题的答案；
+ 本题利用的「异或」运算的性质，如果 `a ^ b = c`，那么 `a ^ c = b` 且 `b ^ c = a`，可以简单记为：如果有其中一个等式成立，任意两数异或的结果是第三个数；
+ 本题采用的是假设修正法：假设某一位是 1 ，一旦满足某个条件，就跳出循环，否则假设不成立。

','22',NULL,'0421-maximum-xor-of-two-numbers-in-an-array','2025-06-11 09:44:19','2025-06-12 09:41:16',1,5,false,NULL,'https://leetcode.cn/problems/maximum-xor-of-two-numbers-in-an-array/description/',44,7,'',false,NULL,true,NULL,NULL),(86,'liweiwei1419','「力扣」第 322 题：零钱兑换（中等）','## 思路分析
在本章《第 2 节 最优子结构》中我们了本题动态规划的解法。本题还可以看作是一个完全背包问题：

+ 「硬币面额」对应「物品的重量」；
+ 题目说「你可以认为每种硬币的数量是无限的」，与完全背包「每种物品可以选择任意数量」对应；
+ 「总金额 `amount` 」对应「背包的容量」；
+ 「凑出金额的最少硬币数」对应「装满背包的最小物品数量」。

我们给出两种解法，分别是二维数组版（便于直观理解）和一维数组优化版。

## 方法一：二维数组版
+ 状态定义：`dp[i][j]` 表示用前 `i` 种硬币（对应区间 `coins[0..i - 1]`）凑出金额 `j` 的最小数量;
+ 状态转移方程：
    - 不选当前硬币：`dp[i][j] = dp[i - 1][j]`；
    - 选当前硬币：`dp[i][j] = dp[i][j - coins[i - 1]] + 1`（注意第一维坐标是 `i` 不是 `i - 1`，体现无限使用）。

**参考代码 1**：

```java
import java.util.Arrays;

public class Solution {
    
    public int coinChange(int[] coins, int amount) {
        int n = coins.length;
        int[][] dp = new int[n + 1][amount + 1];
        // 初始化
        for (int j = 1; j <= amount; j++) {
            // 初始化为一个不可能的较大的数
            dp[0][j] = amount + 1; 
        }
        // 金额为 0 需要 0 个硬币
        dp[0][0] = 0;
        // 一行一行填表，因此使用 coins 的长度 n 作为循环变量
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= amount; j++) {
                if (coins[i - 1] <= j) {
                    // 完全背包的核心：选当前硬币时，状态从 dp[i][j - coin] 转移
                    dp[i][j] = Math.min(dp[i - 1][j], dp[i][j - coins[i - 1]] + 1);
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }
        return dp[n][amount] == amount + 1 ? -1 : dp[n][amount];
    }
    
}
```

**复杂度分析：**

+ 时间复杂度：$ O(n \cdot \text{amount}) $，其中 $ n $ 是硬币种类数，即数组 `coins` 的长度， `amount` 是总金额；
+ 空间复杂度：$ O(n \cdot \text{amount}) $，状态数组的大小为 $ (n + 1) \times (amount + 1) $。

## 方法二：一维数组优化版
由于状态转移 `dp[i][j]` 参考的是 `dp[i][j - coins[i - 1]]` 的值，可以只使用一维数组，内层循环正序遍历。

**参考代码 2**：

```java
import java.util.Arrays;

public class Solution {

    public int coinChange(int[] coins, int amount) {
        int[] dp = new int[amount + 1];
        Arrays.fill(dp, amount + 1);
        dp[0] = 0;
        // 只在一维数组上覆盖填表，外层变量使用 coins
        for (int coin : coins) {
            for (int i = coin; i <= amount; i++) {
                dp[i] = Math.min(dp[i], dp[i - coin] + 1);
            }
        }

        if (dp[amount] == amount + 1) {
            dp[amount] = -1;
        }
        return dp[amount];
    }
    
}
```

**复杂度分析：**

+ 时间复杂度：$ O(n \cdot \text{amount}) $，其中 $ n $ 是硬币种类数，即数组 `coins` 的长度， `amount` 是总金额；
+ 空间复杂度：$ O(\text{amount}) $，状态数组的大小为 `amount + 1`。','17',NULL,'0322-coin-change-dp-unbounded-knapsack','2025-06-11 08:12:31','2025-06-19 01:43:07',1,16,false,NULL,'https://leetcode.cn/problems/coin-change/description/',39,23,'',false,NULL,true,'完成。',NULL),(182,'liweiwei1419','「力扣」第 200 题：岛屿数量（中等）','## 思路分析

我们可以采用深度优先遍历（DFS）或广度优先遍历（BFS）算法来解决该问题。具体做法是：遍历整个二维网格矩阵，当发现值为 `''1''` 的网格单元时，使用 DFS/BFS，将所有连通（相邻）的 `''1''` 标记为「已访问」，岛屿计数器加 1。通过这种标记机制确保每个岛屿只被统计一次。

由于网格中可能存在环状结构，必须对已访问的节点进行标记，主要存在两种实现方案：

+ **标准做法（推荐）**：使用独立的布尔型访问矩阵 `visited`，将访问过的坐标标记为 `true`，好处是：不修改原始输入数据，符合工程规范。虽然使用了 $ O(m \times n) $ 额外空间，但时间复杂度还是 $ O(m \times n) $ ，我们和大家介绍过：时间复杂度最优，空间复杂度不滥用即可；
+ **原地修改**：修改输入矩阵中的 `''1''` 为 `''0''`。节省额外空间，需要确认题目允许修改输入数据，额外空间其实还是  $ O(m \times n) $，因为递归调用栈的深度可能还是 $ O(m \times n) $。

关于广度优先遍历的解法将在《第 17 章 第 3 节 广度优先遍历习题选讲 1》中介绍。

**参考代码**：

```java
public class Solution {

    private static final int[][] DIRECTIONS = {{-1, 0}, {0, -1}, {1, 0}, {0, 1}};

    public int numIslands(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        int count = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (!visited[i][j] && grid[i][j] == ''1'') {
                    dfs(i, j, m, n, grid, visited);
                    count++;
                }
            }
        }
        return count;
    }

    private void dfs(int i, int j, int m, int n, char[][] grid, boolean[][] visited) {
        visited[i][j] = true;
        for (int k = 0; k < 4; k++) {
            int newX = i + DIRECTIONS[k][0];
            int newY = j + DIRECTIONS[k][1];
            if (inArea(newX, newY, m, n) && grid[newX][newY] == ''1'' && !visited[newX][newY]) {
                dfs(newX, newY, m, n, grid, visited);
            }
        }
    }

    private boolean inArea(int x, int y, int m, int n) {
        return x >= 0 && x < m && y >= 0 && y < n;
    }

}
```

**说明**：方向数组 `DIRECTIONS` 和 `inArea` 属于编程规范，在这里仅供参考。

**复杂度分析：**

+ 时间复杂度：$ O(m \times n) $，需遍历整个网格；
+ 空间复杂度：$ O(m \times n) $，递归栈的深度。','16',NULL,'0200-number-of-islands','2025-06-11 10:01:19','2025-06-15 20:44:41',1,3,false,NULL,'https://leetcode.cn/problems/number-of-islands/description/',38,11,'',false,'https://leetcode.cn/problems/number-of-islands/solutions/12299/dfs-bfs-bing-cha-ji-python-dai-ma-java-dai-ma-by-l/',true,NULL,NULL),(84,'liweiwei1419','「力扣」第 376 题：摆动序列（中等）','## 思路分析
只需要关注极值点的位置，这是因为 **单调递增 / 递减的中间点不会增加摆动序列的长度**。即如果一直是上升趋势，我们只关注上升过程中的最高点，接下来看到一个较小的数，产生摆动的可能性就越大。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0376-wiggle-subsequence/temp-image11784734526630492720.png)

在每一步我们只需要关注上一步是上升还是下降（用变量 `prevTrend` 表示，1 表示上升，0 表示下降）和这一步是上升还是下降（用变量 `currTrend` 表示，1 表示上升，0 表示下降），如果 `currTrend != prevTrend`，则表示已经越过了一个极值点，摆动序列的长度 + 1。其它细节大家可以结合「参考代码」理解。

**参考代码**：

```java
public class Solution {

    public int wiggleMaxLength(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return 1;
        }

        // 至少有一个元素
        int count = 1;
        // 0 表示初始状态，1 上升，-1 下降
        int prevTrend = 0;

        for (int i = 1; i < nums.length; i++) {
            // 初始时假设 nums[i] = nums[i - 1]，也可以使用如下代码
            // int currTrend = Integer.compare(nums[i], nums[i - 1]);
            int currTrend = 0;
            if (nums[i] - nums[i - 1] > 0) {
                currTrend = 1;
            } else if (nums[i] - nums[i - 1] < 0) {
                currTrend = -1;
            }

            // 只有当趋势发生变化时，且不是从平坦状态转为上升 / 下降
            if (currTrend != 0 && currTrend != prevTrend) {
                count++;
                prevTrend = currTrend;
            }
        }
        return count;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是序列的长度，我们只需要遍历该序列一次；
+ 空间复杂度：$ O(1) $。我们只需要常数空间来存放若干变量。','18',NULL,'0376-wiggle-subsequence','2025-06-11 08:20:34','2025-06-16 14:44:18',1,7,false,NULL,'https://leetcode.cn/problems/wiggle-subsequence/description/',40,6,'',false,NULL,true,'完成。',NULL),(189,'liweiwei1419','「力扣」第 447 题：回旋镖的数量（中等）','
## 题意分析
首先我们需要明确什么是「回旋镖」：在本题中，回旋镖是指平面上三个不同的点 `i`、`j`、`k`，满足点 `i` 到点 `j` 的距离等于点 `i` 到点 `k` 的距离。也就是说，**以点 **`**i**`** 为中心，至少存在两个其它点到它的距离相同**。

## 思路分析
+ 我们可以枚举每一个点 `i`，对于每个点 `i`，我们都将其作为潜在的回旋镖中心点，计算它到其它所有点的距离，并统计每个距离出现的次数；
+ 对于某个距离 `d`，如果有 `m` 个点到点 `i` 的距离都为 `d`，那么从这 `m` 个点中任选 2 个点与点 `i` 组成回旋镖的方案数为 $ A_m^2 = m * (m - 1) $，这里使用排列是因为`(j, k)` 和 `(k, j)` 被认为是不同的回旋镖。

## 示例演示

以输入 `[[0, 0], [1, 0],[2, 0]]` 为例：

- 选择点 `[0, 0]` 作为中心点：到 `[1, 0]` 的距离平方是 1，到 `[2, 0]` 的距离平方是 4，没有重复距离，贡献 0 个回旋镖；
- 选择点 `[1, 0]` 作为中心点：到 `[0, 0]` 的距离平方是 1，到 `[2, 0]` 的距离平方是 1，距离 1 出现 2 次，贡献 $2 \times 1 = 2$ 个回旋镖；
- 选择点 `[2, 0]` 作为中心点：到 `[0, 0]` 的距离平方是 4，到 `[1, 0]` 的距离平方是 1，没有重复距离，贡献 0 个回旋镖。


最终结果是 2 个回旋镖。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public int numberOfBoomerangs(int[][] points) {
        int res = 0;
        // 用于记录每个距离出现的次数，对于每个中心点 i，哈希表可以帮助我们快速统计相同距离的点的数量
        Map<Integer, Integer> hashMap = new HashMap<>();
        // 遍历每一个点作为回旋镖的中心点
        for (int[] point : points) {
            for (int[] other : points) {
                // 计算当前点到其它所有点的距离
                int distance = distance(point, other);
                // 更新该距离出现的次数
                hashMap.put(distance, hashMap.getOrDefault(distance, 0) + 1);
            }

            // 遍历每个距离的出现次数，计算回旋镖的数量
            for (int count : hashMap.values()) {
                res += count * (count - 1);
            }
            hashMap.clear();
        }
        return res;
    }

    // 为了避免浮点数精度问题，我们直接存储距离的平方，这样既保证了准确性又避免了开方运算
    private int distance(int[] point1, int[] point2) {
        // 计算两点之间的距离的平方，避免开方运算带来的精度问题
        int diffX = point1[0] - point2[0];
        int diffY = point1[1] - point2[1];
        return diffX * diffX + diffY * diffY;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，其中 $ n $ 是点的数量。对于每个点，我们需要遍历其它所有点以计算距离，因此总的时间复杂度为 $ O(n^2) $；
+ 空间复杂度：$ O(n) $，主要用于存储每个距离出现的次数，最坏情况下，所有点到当前点的距离都不同，需要 $ O(n) $ 的空间。','15',NULL,'0447-number-of-boomerangs','2025-06-11 18:57:32','2025-06-13 04:52:26',1,12,false,NULL,'https://leetcode.cn/problems/number-of-boomerangs/description/',37,5,'',false,NULL,true,NULL,'哈希表用于计数'),(11,'liweiwei1419','「力扣」第 713 题：乘积小于 K 的子数组（中等）','## 思路分析

题目中的关键字：正整数、连续子数组。

**暴力解法**：枚举所有的输入数组的连续子数组，逐个判断它们的乘积是否严格小于 `k`。暴力解法没有利用到 **输入数组是正整数数组**。

**优化思路**：由于 **输入数组是正整数数组**，因此：

- 如果一个连续子数组的所有元素的乘积都严格小于 `k`，那么这个连续子数组的子集（同样也是连续子数组）的乘积也一定严格小于 `k`，也就是说，此时我们没有必要枚举长度更短的连续子数组；
- 如果一个连续子数组的所有元素的乘积大于等于 `k`，包含它的更长的子数组的乘积一定也大于等于 `k`，也就是说，此时我们没有必要枚举长度更长的连续子数组。 

**以上两点是本题可以使用滑动窗口解决的原因**。我们可以在找到乘积小于等于 `k` 的最长的连续子数组的过程中，统计乘积小于等于 `k` 的连续子数组的个数。具体来说，就是：在右边界向右扩展的时候，数出 **以右边界结尾** 的乘积小于等于 `k` 的连续子数组的个数，其值等于此时窗口的长度。

为什么是 **以右边界结尾** 呢？因为在右边界右移（此时同时判断了乘积是否小于 `k`）的时候计数，可以保证不重不漏。以题目中给出的「示例 1」为例，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image7841407125779302403.png)


```java
public class Solution {

    public int numSubarrayProductLessThanK(int[] nums, int k) {
        // 特殊用例判断
        if (k <= 1) {
            return 0;
        }
        int n = nums.length;
        int left = 0;
        int right = 0;
        int count = 0;
        int product = 1;
        // nums[left..right) 里所有元素的乘积严格小于 k
        while (right < n) {
            product *= nums[right];
            // 在这里 right++，因此在累加 count 的时候，加上 right - left
            right++;
            while (product >= k) {
                product /= nums[left];
                left++;
            }
            count += (right - left);
        }
        return count;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组的长度。`right` 需要遍历输入数组一次，绝大多数情况下，`left` 还没有遍历到数组的末尾就停了下来；
+ 空间复杂度：$ O(1) $。

## 本题总结

+ 本题的重要前提是 `nums[i] >= 1` 和要求的结果（连续子数组的个数）；
+ 连续子数组的乘积，可以在窗口滑动的过程中，以 $ O(1) $ 的时间复杂度计算出来；
+ 本题的难点在于计数，我们在右边界右移的时候，如果连续子数组的乘积小于 `k` ，由于左边界固定，可以一下子数出以右边界结尾的、乘积小于 `k` 的连续子数组的个数。
','6',NULL,'0713-subarray-product-less-than-k','2025-06-09 10:08:12','2025-06-14 14:21:55',1,12,false,NULL,'https://leetcode.cn/problems/subarray-product-less-than-k/description/',29,3,'',false,'https://leetcode.cn/problems/ZVAVXX/solutions/976629/hua-dong-chuang-kou-java-by-liweiwei1419-p81h/',true,NULL,NULL),(165,'liweiwei1419','「力扣」第 477 题：汉明距离总和（中等）','## 思路分析

直接计算所有数对之间的汉明距离会导致平方级别的时间复杂度，这在数据量较大时效率很低。我们可以采用 **按位统计** 的方法优化：

+ 对于每一个二进制位（共 32 位），统计数组中数字在该位上是 1 的个数，记为 `count`；
+ 每个 1 都会和所有 0 形成汉明距离。应用「分步计数乘法原理」，从所有 1 中选出 1 个数，有 `count` 种选法，再从所有 0 中选出 1 个数，有 `n - count` 种选法，因此汉明距离总和为 `count * (n - count)`；
+ 将所有位的计算结果累加，就是最终的总汉明距离。

**参考代码**：

```java
class Solution {

    public int totalHammingDistance(int[] nums) {
        int total = 0;
        int n = nums.length;

        // 遍历每一位，int 类型共 32 位
        for (int i = 0; i < 32; i++) {
            int bitCount = 0;
            // 统计当前位为 1 的数字个数
            for (int num : nums) {
                bitCount += (num >> i) & 1;
            }
            // 当前位的汉明距离总和
            total += bitCount * (n - bitCount);
        }

        return total;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，其中 $ n $ 是数组长度，虽然有一个 32 的常数因子，但在时间复杂度的定义下，视为常数 1；
+ 空间复杂度：$ O(1) $，只使用了常数个额外空间。','22',NULL,'0477-total-hamming-distance','2025-06-11 09:44:19','2025-06-12 11:28:37',1,5,false,NULL,'https://leetcode.cn/problems/total-hamming-distance/description/',44,11,'',false,NULL,true,NULL,NULL),(10,'liweiwei1419','「力扣」第 96 题：不同的二叉搜索树（中等）','## 思路分析

我们用小规模的例子研究一般规律，以 `n = 5` 为例，如下图所示：

![](https://minio.dance8.fun/algo-crazy/0096-unique-binary-search-trees/temp-image4587935120785150456.png)

可以观察到到：对于给定的 `n`，不同的二叉搜索树数量与如何选择根结点以及左右子树的构成有关，且左右子树的构建是独立的（互不影响）。

题目只问结果，不问具体的二叉搜索树形态，可以考虑使用动态规划解决。

+ **状态定义**：`dp[i]` 表示以 `1 ... i` 为结点组成的不同的二叉搜索树的数量（`i` 从 1 开始）；
+ **状态转移方程**：对于 `n` 个结点，我们可以选择任何一个结点作为根结点。

假设我们选择第 `k` 个结点作为根结点，那么左子树将由 `1 ... k - 1` 组成，右子树将由 `k + 1 ... n` 组成，左右子树的构建是独立的，应用分步计数原理，以第 `k` 个结点为根结点的二叉搜索树的数量为 `dp[k - 1] * dp[n - k]`。

`n` 个结点的同的二叉搜索树的数量，可以分为 1 作为根结点、2 作为根结点、……、`n` 作为根结点，应用分类计数原理，最终的结果就是将所有可能的根结点的情况相加，即：`dp[n] = dp[0] * dp[n - 1] + dp[1] * dp[n - 2] + ... + dp[n - 1] * dp[0]`。其中，`dp[0] = 1`，表示空树的情况（这里可以代入具体的状态转移去理解，设置为 1 也是合理的）。

**参考代码 1**：

```java
public class Solution {

    public int numTrees(int n) {
        int[] dp = new int[n + 1];
        // 想清楚这个值很关键
        dp[0] = 1;
        dp[1] = 1;
        for (int i = 2; i <= n; i++) {
            // 这里 j 表示左子树的元素个数，最小是 0 ，最大是 i - 1
            // 左边子树 + 右边子树 = i - 1
            // i - j - 1 表示的是右边子树元素个数
            for (int j = 0; j < i; j++) {
                // 用 * 是因为分步计数乘法原理，用 + 是分类计数加法原理
                dp[i] += dp[j] * dp[i - j - 1];
            }
        }
        return dp[n];
    }
    
}
```

**复杂度分析：**

+ 时间复杂度：$ O(n^2) $，需要两层循环计算 `dp` 数组；
+ 空间复杂度：$ O(n) $，用于存储 `dp` 数组。

根据左右子树的对称性，代码还可以优化：

**参考代码 2：**

```java
public class Solution {

    public int numTrees(int n) {
        int[] dp = new int[n + 1];
        // 乘法因子的单位是 1
        dp[0] = 1;
        dp[1] = 1;

        for (int i = 2; i < n + 1; i++) {
            for (int j = 0; j < i / 2; j++) {
                dp[i] += 2 * (dp[j] * dp[i - j - 1]);
            }
            if (i % 2 == 1) {
                dp[i] += dp[i / 2] * dp[i / 2];
            }
        }
        return dp[n];
    }
    
}
```

**复杂度分析：**（同「参考代码 1」）。

## 本题小结
本题中状态转移方程乘法是分步计数原理，加法是分类计数原理，它们是计数的依据。','17',NULL,'0096-unique-binary-search-trees','2025-06-09 07:21:13','2025-06-18 17:52:07',0,35,false,NULL,'https://leetcode.cn/problems/unique-binary-search-trees/description/',39,11,'',false,NULL,true,'完成。',NULL),(33,'liweiwei1419','「力扣」第 11 题：盛最多水的容器（中等）','## 思路分析

**暴力解法**：利用木桶原理，「左右两侧高度较低的那块木板的高度」和「底边的宽度」决定了盛水的容器的容积。遍历左边木板的高度和右边木板的高度，在遍历的过程中求最大值，代码如下：

**参考代码 1（超时）**：

```java
public class Solution {

    public int maxArea(int[] height) {
        int n = height.length;
        if (n < 2) {
            return 0;
        }
        int res = 0;
        // 下标尾 n - 1 的矩形没有右边，所以循环可以继续的条件是 i < n - 1
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                res = Math.max(res, Math.min(height[i], height[j]) * (j - i));
            }
        }
        return res;
    }
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n^2) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(1) $。

**优化思路**：观察到以下两点：

+ 容器能够盛水的容量，除了底部的宽度之外，只和它的左边木板和右边木板的高度相关，**和它中间的柱子的高度无关**。如下图所示：

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image13629845345878613351.png)

也就是说：**中间那些柱子和此时较短的柱子（图中是最左边柱子）围城容器能够盛水的容量没有必要计算出来**。

+ 在底边宽度固定的情况下，由于水的高度由左右两边高度的较小者决定。因此，**只有将较小者向中间移动，才有可能遇到更高的木板，使得盛水的容量增大**。较高的那块木板往里面走，只可能让盛水越来越少。

![](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image11775775964714870880.png)

综上可知，通过左右两个指针变量协同向中间移动的方式进行，可以得到最优解。

**参考代码 2**：

```java
public class Solution {

    public int maxArea(int[] height) {
        int n = height.length;
        if (n < 2) {
            return 0;
        }

        int left = 0;
        int right = n - 1;
        int res = 0;
        while (left < right) {
            int minHeight = Math.min(height[left], height[right]);
            res = Math.max(res, minHeight * (right - left));
            if (height[left] == minHeight) {
                left++;
            } else {
                right--;
            }
        }
        return res;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是输入数组的长度；
+ 空间复杂度：$ O(1) $ 。','7',NULL,'0011-container-with-most-water','2025-06-09 19:22:03','2025-06-14 14:57:35',1,10,false,NULL,'https://leetcode.cn/problems/container-with-most-water/description/',29,8,'',false,'https://leetcode.cn/problems/container-with-most-water/solutions/3695637/shuang-zhi-zhen-java-by-liweiwei1419-xy9t/',true,NULL,NULL),(19,'liweiwei1419','第 0 部分 写在前面的话','这是《算法也疯狂》书籍的配套网站，作为对书本内容的补充。


',NULL,NULL,'home','2025-06-09 04:14:34','2025-07-26 18:14:49',3,491,false,NULL,NULL,0,0,'',false,NULL,false,NULL,NULL),(15,'liweiwei1419','「力扣」第 1143 题：最长公共子序列（中等）','

## 思路分析
最长公共子序列（Longest Common Subsequence，LCS）是非常经典的动态规划问题，注意：题目问的是子序列，子串要求字符连续，而子序列只需保持相对顺序。我们将前缀子串作为状态的定义，由空字符串开始，逐步推导，得到两个字符串的结果。

+ **状态定义**：
    - 定义一个二维数组 `dp`，`dp[i][j]` 表示 `text1` 的前 `i` 个字符（即 `text1[0..i - 1]`）和 `text2` 的前 `j` 个字符（即 `text2[0..j - 1]`）的最长公共子序列长度；
    - 这样定义的原因是：空串处理相对容易，`dp[0][j] = 0` 和 `dp[i][0] = 0` 直接表示一个字符串为空时的最长公共子序列的长度为 0，无需额外边界判断；
    - 此时需注意下标偏移问题：状态数组的下标比对应字符串多 1。
+ **状态转移方程**：根据 `text1` 和 `text2` 的前缀子串的 **末尾的** 两个字符 `text1[i - 1]` 与 `text2[j - 1]` 是否相等，分类讨论如下：
    - 如果 `text1[i - 1] == text2[j - 1]`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/1143-longest-common-subsequence/temp-image3095601482207546628.png)

黑色部分的最长公共子序列的长度 + 1 ，就是此时最长公共子序列的长度。此时最长公共子序列的长度由 `text1[0:i - 2]` 与 `text2[0:j - 2]` 的最长公共子序列的长度得到，它的值是 `dp[i - 1][j - 1]`，再加上末尾相同的字符，所以 `dp[i][j] = dp[i - 1][j - 1] + 1`。

如果 `text1[i - 1] != text2[j - 1]`，如下图所示：

![](https://minio.dance8.fun/algo-crazy/1143-longest-common-subsequence/temp-image13123094000387236331.png)

此时最长公共子序列的长度，有两种情况：

**情况 1**：如上左图黑色部分是 `text1[0:i - 2]` 与 `text2[0:j - 1]` 的最长公共子序列的长度，它的值是 `dp[i - 1][j]`。

**情况 2**：如上右图黑色部分是 `text1[0:i - 1]` 与 `text2[0:j - 2]` 的最长公共子序列的长度，它的值是 `dp[i][j - 1]`。

它们二者之中较大者为所求，即 `dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])`。

+ **考虑初始化**：空字符串和任意字符串的公共子序列的长度为 0；
+ **考虑输出**：`dp[m][n]` 就是 `text1` 和 `text2` 的最长公共子序列的长度，其中 `m` 和 `n` 分别是 `text1` 和 `text2` 的长度。

**参考代码 1**：未优化空间的代码。

```java
public class Solution {

    public int longestCommonSubsequence(String text1, String text2) {
        int m = text1.length();
        int n = text2.length();
        // dp[i][j]：长度为 i 的 text1 前缀字符串与长度为 j 的 text2 前缀字符串的最长公共子串的长度
        // 字符串的问题需要考虑空串，所以多开一行，多开一列
        int[][] dp = new int[m + 1][n + 1];
        // 初始化
        for (int i = 0; i <= m; i++) {
            dp[i][0] = 0;
        }
        for (int j = 0; j <= n; j++) {
            dp[0][j] = 0;
        }

        // 由于通过下标访问字符的 charAt() 方法每一次都会去检查下标是否越界
        // 通常，字符串的遍历先将字符串转为字符数组
        char[] charArray1 = text1.toCharArray();
        char[] charArray2 = text2.toCharArray();
        // 递推开始
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                // 以 dp 表格为基准，访问字符串下标需要减 1
                if (charArray1[i - 1] == charArray2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + 1;
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }
        return dp[m][n];
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $，其中 `m` 和 `n` 分别是 `text1` 和 `text2` 的长度。我们需要填充一个 `m x n` 的二维数组；
+ 空间复杂度：$ O(m \times n) $，我们需要一个 `m x n` 的二维数组来存储中间结果。

**考虑优化空间**：使用滚动数组（感兴趣的朋友可以自行尝试）或者「保留上一行有限个变量」的方式（「参考代码 2」）将空间复杂度优化到 $ O(\min(m, n)) $，这一点非必需，由大家自己决定。

**参考代码 2**：优化空间的代码， 在状态转移的过程中，上一行的 `dp[i - 1][j]` 会被覆盖，所以在填写当前行的时候，需要使用一个变量（这里命名为 `prev`）保存它。

```java
public class Solution {

    public int longestCommonSubsequence(String text1, String text2) {
        int m = text1.length();
        int n = text2.length();

        // 优化：让 text2 始终是较短的字符串，空间复杂度从 O(m*n) 降为 O(min(m, n))
        if (m < n) {
            return longestCommonSubsequence(text2, text1);
        }
        // 转为字符数组，提高访问速度（比 charAt() 稍快）
        char[] charArray1 = text1.toCharArray();
        char[] charArray2 = text2.toCharArray();
        // 空间优化：只用一维数组 dp[j]，表示上一行和当前行的状态
        // dp[j] 表示 text1[0..i - 1] 和 text2[0..j - 1] 的 LCS 长度
        int[] dp = new int[n + 1];
        for (int i = 1; i <= m; i++) {
            // prev 保存 dp[i - 1][j - 1] 的值，因为会被覆盖
            int prev = 0;
            for (int j = 1; j <= n; j++) {
                // 保存当前 dp[i - 1][j] 的值，留给下一轮 j + 1 使用
                int temp = dp[j];
                if (charArray1[i - 1] == charArray2[j - 1]) {
                    // 字符匹配：LCS 长度 = 左上角值 + 1
                    dp[j] = prev + 1;
                } else {
                    // 字符不匹配：继承上方或左方的较大值
                    dp[j] = Math.max(dp[j], dp[j - 1]);
                }
                // 更新 prev 为 dp[i - 1][j]，供下一轮使用
                prev = temp;
            }
        }
        // dp[n] 即 text1 和 text2 的完整 LCS 长度
        return dp[n];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(m \times n) $；
+ 空间复杂度：$ O(\min(m, n)) $。

为了优化空间，我们做了更多的操作，也丢失了状态数组的语义。一般情况下，我们没有必要优化空间，在面试、笔试中直接写出优化空间的代码也有一定难度。','17',NULL,'1143-longest-common-subsequence','2025-06-09 10:50:33','2025-06-18 18:21:05',1,8,false,NULL,'https://leetcode.cn/problems/longest-common-subsequence/description/',39,14,'',false,NULL,true,'完成。',NULL),(140,'liweiwei1419','「力扣」第 23 题：合并 K 个升序链表（困难）','## 思路分析

「合并 `K` 个链表」是优先队列的经典应用，算法领域称之为「多路归并」，思路其实很简单，类似于「归并排序」的「合并两个有序数组」。

由于链表是有序的，我们每一次都选出所有链表的第一个结点中值最小的结点，这件事可以交给一个有 `K` 个元素的最小堆，选出以后链表的第 2 个元素「替补」上来（移除堆顶元素后再添加元素），堆自己会调整内部结构，再选出一个最小值，它是 `K` 个链表中第 2 小的结点，依次进行下去，直到最小堆为空。如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749778707-xQvoCD-image.png)

**参考代码**：

```java
import java.util.Comparator;
import java.util.PriorityQueue;

public class Solution {

    public ListNode mergeKLists(ListNode[] lists) {
        int K = lists.length;
        if (K == 0) {
            return null;
        }

        PriorityQueue<ListNode> minHeap = new PriorityQueue<>(K, Comparator.comparingInt(o -> o.val));
        // 将每个链表的头结点加入最小堆
        for (ListNode head : lists) {
            if (head != null) {
                minHeap.offer(head);
            }
        }

        ListNode dummyNode = new ListNode(-1);
        ListNode currentNode = dummyNode;
        while (!minHeap.isEmpty()) {
            // 注意：这里我们选择的操作是先从优先队列里拿出最小的元素，然后再添加
            // 事实上，如果优先队列有提供 replace 操作，应该优先选择 replace
            ListNode smallest = minHeap.poll();
            currentNode.next = smallest;
            currentNode = currentNode.next;
            if (smallest.next != null) {
                minHeap.offer(smallest.next);
            }
        }
        return dummyNode.next;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log k) $，其中 $ n $ 是所有链表结点总数，$  k $ 是链表数量（即有多少个链表），每次堆操作需要 $ O(\log k) $ 时间。
+ 空间复杂度：$ O(k) $，优先队列中最多存储 $ k $ 个结点。
','12',NULL,'0023-merge-k-sorted-lists','2025-06-11 09:24:56','2025-06-13 09:42:28',1,8,false,NULL,'https://leetcode.cn/problems/merge-k-sorted-lists/description/',35,2,'',false,'https://leetcode.cn/problems/merge-k-sorted-lists/solutions/9053/tan-xin-suan-fa-you-xian-dui-lie-fen-zhi-fa-python/',true,NULL,NULL),(31,'liweiwei1419','第 8 章 动态数组：只是个障眼法，其实还是静态数组','',NULL,NULL,'dynamic-array','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,1,'',true,NULL,true,NULL,'动态数组解决了数组长度固定的问题，其实就是加入了对真实存储数据的长度的检测，在不同长度时间点，更换了底层数组，动态数组其实还是数组。'),(79,'liweiwei1419','「力扣」第 561 题：数组拆分（简单）','## 思路分析

根据题意，配对的每一组中的较大值会被丢弃。**数组中最大的数肯定被丢弃，要使得最终的和最大，数组中第二大的数一定要与数组中最大的数配对，才能被保留下来**。此类推，要让结果最大只有一种配对方案：对数组进行排序，所有的 `nums[i]` 和 `nums[i + 1]`（其中 `i` 从 0 开始）配对，对所有的 `nums[i]` 求和就能使得最终的和最大。

证明：选取偶数下标的元素能使和最大。

采用反证法。设排序后的数组为 $ [a_1, a_2, a_3, a_4, \cdots, a_{2n - 1}, a_{2n}] $，其中 $ a_1 \le a_2 \le a_3 \le ... \le a_{2n} $。假设存在一种更优的配对方式，使得最小值之和更大。

假如我们不按照相邻元素配对，而是将 $ a_1 $ 和 $ a_3 $ 配对， $ a_2 $ 和 $ a_4 $ 配对。那么第一对的最小值是 $ a_1 $，第二对的最小值是$ a_2 $。而按照相邻元素配对，即 $ (a_1, a_2) $ 和 $ (a_3, a_4) $ ，第一对的最小值还是 $ a_1 $，第二对的最小值是 $ a_3 $，$ a_3 \ge a_2 $，说明相邻元素配对得到的最小值之和是最大的。

排序以后，每一步只需要看「眼前」，取下标为偶数的值相加即可，所以是贪心算法。

**参考代码**：

```java
import java.util.Arrays;

public class Solution {

    public int arrayPairSum(int[] nums) {
        int n = nums.length;
        Arrays.sort(nums);
        int res = 0;
        for (int i = 0; i < n; i += 2) {
            res += nums[i];
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log n) $，主要来自排序操作，其中 $ n $ 是数组的长度；
+ 空间复杂度：$ O(\log n) $，这里 $ \log n $ 是排序使用的栈空间，除此之外，只使用了常数空间。

## 本题总结

按照相邻元素配对（即选取偶数下标的元素作为每一对的最小值），可以使得最终的和最大。','18',NULL,'0561-array-partition','2025-06-11 08:20:34','2025-06-16 14:34:36',1,23,false,NULL,'https://leetcode.cn/problems/array-partition/description/',40,1,'',false,NULL,true,'完成。',NULL),(168,'liweiwei1419','「力扣」第 50 题：Pow(x, n) （中等）','## 思路分析

题目让我们求幂：

+ 幂的乘法性质 $ x^{(a + b)} = x^a \times x^b $ 和 $ x^{(2a)} = (x^a)^2 $ 提示我们：可以把指数拆解为二进制形式；
+ 下面用一个具体例子来解释：`10` 的二进制是 `1010`（省略最高 24 位），即 $ 10 = 2^3 + 2^1 $，所以 $ x^{10} = x^{(8 + 2)} = x^8 \times x^2 $；
+ 我们可以通过 **不断平方 `x` 得到 `x^1, x^2, x^4, x^8, ...`，然后根据 `n` 的二进制位是否为 1 决定是否乘入结果**；
+ 根据「示例 3」，我们还需要处理指数为负数的情况，具体细节请见「参考代码」。

**参考代码：**

```java
public class Solution {

    public double myPow(double x, int n) {
        // 处理 n 为 Integer.MIN_VALUE 的情况，直接取反会溢出，转为 long 避免溢出
        long N = n;
        if (N < 0) {
            x = 1 / x;
            N = -N;
        }

        double res = 1.0;
        while (N > 0) {
            if ((N & 1) == 1) {
                res *= x;
            }
            x *= x;
            // 右移一位，相当于 N /= 2
            N >>= 1;
        }
        return res;
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(\log n) $，`n` 每次被除以 2（二进制位数）；
+ 空间复杂度：$ O(1) $，仅使用常数空间。','22',NULL,'0050-powx-n','2025-06-11 09:44:19','2025-06-12 15:29:10',1,8,false,NULL,'https://leetcode.cn/problems/powx-n/description/',44,14,'',false,'https://leetcode.cn/problems/powx-n/solutions/7225/ba-zhi-shu-bu-fen-kan-zuo-er-jin-zhi-shu-python-da/',true,NULL,NULL),(80,'liweiwei1419','「力扣」第 343 题：整数拆分（中等）','## 思路分析
本题要求将一个给定的正整数 `n` 拆分成至少两个正整数的和，使拆分后的整数乘积最大，求最大乘积。为了找到最优的拆分方案，我们可以从较小的数分析，观察规律：

+ 对于 `n = 2`，只能拆分成 `1 + 1`，乘积为 `1`；
+ 对于 `n = 3`，可以拆分成 `1 + 2`，乘积为 `2`；
+ 对于 `n = 4`，可以拆分成 `2 + 2`，乘积为 `4`（也可以拆分成 `1 + 3`，乘积为 `3`，但拆分成 `2 + 2` 更优）；
+ 对于 `n = 5`，可以拆分成 `2 + 3`，乘积为 `6`（比拆分成其它情况的乘积都大）；
+ 对于 `n = 6`，可以拆分成 `3 + 3`，乘积为 `9`（比拆分成 `2 + 2 + 2` 的乘积 `8` 更大）；

通过以上分析，可以发现以下规律：

+ 应尽量多拆出数字 `3`，但有一个「分界线」，计算 $ 3(n - 3) \ge 2 (n - 2) $(找到 $ n $在何时拆分出 3 比拆分出 2 更好)，得 $ n \ge 5 $，也就是说：当 $ n \ge 5 $ 时，拆分出 3 比拆分出 2 更好。并且在此时 $ 3(n - 3) \ge n $ （整理得 $ 2n \ge 9 $，在 $ n \ge 5 $ 时显然成立）成立，说明：当 $ n \ge 5 $ 时，拆分出 3 比不拆分好。综上，拆出 3 比拆出其它数字和不拆更优，所以应尽量多拆出数字 3；
+ 剩余 $ n < 5 $的情况单独处理即可：数字 4 拆成 2 + 2 ，数字 2 和 3 不拆分。

对于 `n` ，每一步只考虑当 $ n \ge 5 $ 时，把尽可能多的 3 拆出来相乘，当 $ n < 5 $ 时单独处理，所以是贪心算法。

**参考代码**：

```java
public class Solution {
    
    public int integerBreak(int n) {
        if (n < 4) {
            return n - 1;
        }
        if (n == 4) {
            return 4;
        }

        int quotient = n / 3;
        int remainder = n % 3;

        if (remainder == 0) {
            // n 可以被 3 整除，全部拆分为 3，
            return (int) Math.pow(3, quotient);
        } else if (remainder == 1) {
            // 注意：应视为余数为 4，拆分为 quotient - 1 个 3 和一个 4
            return (int) Math.pow(3, quotient - 1) * 4;
        }
        // 余数为 2，拆分为 quotient 个 3 和一个 2
        return (int) Math.pow(3, quotient) * 2;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，最多需要循环 $ \frac{n}{3} $ 次；
+ 空间复杂度：$ O(1) $，只使用了常数级别的额外空间。','18',NULL,'0343-integer-break','2025-06-11 08:20:34','2025-06-16 14:35:16',1,7,false,NULL,'https://leetcode.cn/problems/integer-break/description/',40,2,'',false,NULL,true,'完成。',NULL),(64,'liweiwei1419','「力扣」第 27 题：移除元素（简单）','## 思路分析
别看题目叙述挺长，其实思路还是使用一个变量 `i` 遍历输入数组，再使用一个变量 `j` 赋值。变量 `i` 在遍历的时候，`nums[i]` 等于 `val` 的时候什么都不做，`nums[i]` 不等于 `val` 的时候赋值，具体变量的定义和赋值的细节，我们作为注释写在了代码中。

**参考代码 1**：

```java
public class Solution {

    public int removeElement(int[] nums, int val) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        // 循环不变量：nums[0..j) != val，j 指向了下一个要赋值的元素的位置
        int j = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] != val) {
                nums[j] = nums[i];
                j++;
            }
        }
        return j;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，只需要遍历一次数组；
+ 空间复杂度：$ O(1) $，只使用了常数个变量。

**参考代码 2**：

```java
public class Solution {

    public int removeElement(int[] nums, int val) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        // 循环不变量：nums[0..j] != val，j 指向了刚刚赋值过的元素的位置
        int j = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] != val) {
                j++;
                nums[j] = nums[i];
            }
        }
        return j + 1;
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。','3',NULL,'0027-remove-element','2025-06-10 14:35:13','2025-06-10 14:54:25',2,30,false,NULL,'https://leetcode.cn/problems/remove-element/description/',25,0,'',false,NULL,false,NULL,NULL),(78,'liweiwei1419','「力扣」第 518 题：零钱兑换 II（中等）','## 思路分析

本题可以套用完全背包问题的模型，对应关系如下：

+ 「硬币面额」对应「物品的重量」；
+ 「总金额 `amount`」对应「背包的容量」； 
+ 「每种硬币可以无限使用」 对应「完全背包中物品可以无限选取」。

本题要我们求「凑出金额的组合数」，在状态转移的时候是求和，而不是求最值（标准完全背包问题求的是最值）。

+ **状态定义**：`dp[i][j]`：表示使用前 `i` 种硬币（即 `coins[0..i - 1]`）凑出金额 `j` 的组合数。
+ **状态转移方程**：对于当前状态 `dp[i][j]`，考虑是否选择第 `i` 种硬币（面额为 `coins[i - 1]`）：
    - 不选当前硬币：组合数等于仅使用前 `i - 1` 种硬币凑出金额 `j` 的组合数：`dp[i][j] = dp[i - 1][j]`;
    - 选当前硬币（前提：`j >= coins[i - 1]`），组合数等于使用前 `i` 种硬币凑出剩余金额 `j - coins[i - 1]` 的组合数（因为硬币可以无限使用）：`dp[i][j] += dp[i][j - coins[i - 1]]`，注意：这里是 `dp[i][...]` 而非 `dp[i - 1][...]`，体现完全背包的「无限选取」特性。
+ **考虑初始化：**
    - `dp[0][0] = 1`：凑出金额 `0` 的组合数为 `1`，即什么都不选；  
    - `dp[0][j] = 0`（`j > 0`）：没有硬币可选时，无法凑出任何正数金额。
+ **考虑输出**：输出是 `dp[n][amount]`。

我们给出两种解法，分别是二维数组版（便于直观理解）和一维数组优化版。

## 方法一：二维数组版

**参考代码 1**：

```java
public class Solution {

    public int change(int amount, int[] coins) {
        if (amount == 0) {
            return 1;
        }
        int n = coins.length;
        int[][] dp = new int[n + 1][amount + 1];
        // 初始化：凑出金额 0 的组合数为 1（即什么都不选）
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= amount; j++) {
                if (coins[i - 1] <= j) {
                    // 选当前硬币的组合数 + 不选当前硬币的组合数
                    dp[i][j] = dp[i - 1][j] + dp[i][j - coins[i - 1]];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }
        return dp[n][amount];
    }

}
```

**复杂度分析：**

+ 时间复杂度：$ O(n \times \text{amount}) $，其中 `n` 是硬币种类数；
+ 空间复杂度：$ O(n \times \text{amount}) $。

## 方法二：一维数组优化版
根据状态转移方程：`dp[i][j]` 参考的是 `dp[i - 1][j]`(`i - 1` 表示上一行，`j` 在正上方) 和 `dp[i][j - coins[i - 1]]`（这里是 `i` 表示当前行），所以可以使用一维数组，正着遍历。

**参考代码 2**：对于当前金额 `j`，如果选择面额为 `coin` 的硬币，则组合数等于 `dp[j] += dp[j - coin]`（即当前组合数加上不选当前硬币时的组合数）。

```java
public class Solution {

    public int change(int amount, int[] coins) {
        if (amount == 0) {
            return 1;
        }
        int n = coins.length;
        int[] dp = new int[amount + 1];
        // 凑出金额 0 的组合数为 1（即什么都不选）
        dp[0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= amount; j++) {
                if (coins[i - 1] <= j) {
                    // 选当前硬币的组合数 + 不选当前硬币的组合数
                    dp[j] += dp[j - coins[i - 1]];
                }
            }
        }
        return dp[amount];
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \times \text{amount}) $；
+ 空间复杂度：$ O(\text{amount}) $。','17',NULL,'0518-coin-change-ii','2025-06-11 08:12:31','2025-06-19 01:28:18',1,10,false,NULL,'https://leetcode.cn/problems/coin-change-ii/description/',39,24,'',false,'https://leetcode.cn/problems/coin-change-ii/solutions/26257/dong-tai-gui-hua-wan-quan-bei-bao-wen-ti-by-liweiw/',true,'完成。',NULL),(148,'liweiwei1419','「力扣」第 450 题：删除二叉搜索树中的节点（中等）','## 思路分析

删除二叉搜索树中的结点的思路是：找其它结点代替它，并且还保持了二叉搜索树的性质。直观上看，二叉搜索树的性质的性质拿一根竖线从左到右扫描二叉搜索树，扫过的结点的值是递增的。

需要考虑 3 种情况：

+ 被删除的结点是叶子结点：此时直接删除即可，因为删除它，树不会「断开」；
+ 被删除的结点只有一个子结点：用它子结点替代它，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749799558-jahrlz-image.png)


+ 被删除的结点有两个子结点：需要找到其右子树中的最小结点（或左子树中的最大结点）来替代它，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749799565-LrShvs-image.png)


**参考代码 1**：用后继结点（右子树的最小结点）代替被删除结点。

```java
public class Solution {

    public TreeNode deleteNode(TreeNode root, int key) {
        if (root == null) {
            return null;
        }
        if (root.val < key) {
            // 要删除的结点在右子树
            root.right = deleteNode(root.right, key);
            return root;
        } else if (root.val > key) {
            // 要删除的结点在左子树
            root.left = deleteNode(root.left, key);
            return root;
        } else {
            if (root.left == null) {
                return root.right;
            }
            if (root.right == null) {
                return root.left;
            }
            // 左右子树均非空，用右子树中最小的结点代替自己
            TreeNode successor = new TreeNode(minNode(root.right).val);
            // 值替换
            root.val = successor.val;
            // 通过复用代码把后继结点删除
            root.right = deleteNode(root.right, successor.val);
            return root;
        }
    }

    private TreeNode minNode(TreeNode node) {
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }

}

```

**复杂度分析：**

+ 时间复杂度：当二叉搜索树是平衡二叉搜索树时：$ O(\log n) $，最坏情况下，二叉搜索树退化成链表时，$ O(n) $，这里 $ n $ 是二叉搜索树的结点总数。
    - 查找目标结点，平均情况：$ O(\log n) $（当树的高度平衡时，树高 h ≈ log n），最坏情况：$ O(n) $（退化成链表时）
    - 删除结点后的调整：叶子结点：直接删除，$ O(1) $，单子树：用子树替换，$ O(1) $，左右子树均存在：需找前驱（左子树最右）或后继（右子树最左），最多遍历 $ n $ 层，$ O(n) $；
+ 空间复杂度：即递归栈空间的大小，当二叉搜索树是平衡二叉搜索树时：$ O(\log n) $，最坏情况下，二叉搜索树退化成链表时，$ O(n) $。

**参考代码 2**：用前驱结点（左子树的最大结点）代替被删除结点。

```java
public class Solution {

    public TreeNode deleteNode(TreeNode root, int key) {
        if (root == null) {
            return null;
        }
        if (root.val < key) {
            // 要删除的结点在右子树
            root.right = deleteNode(root.right, key);
            return root;
        } else if (root.val > key) {
            // 要删除的结点在左子树
            root.left = deleteNode(root.left, key);
            return root;
        } else {
            if (root.left == null) {
                return root.right;
            }
            if (root.right == null) {
                return root.left;
            }
            // 左右子树均非空，用左子树中最大的结点代替自己
            TreeNode predecessor = maxNode(root.left);
            root.val = predecessor.val;
            root.left = deleteNode(root.left, predecessor.val);
            return root;
        }
    }

    private TreeNode maxNode(TreeNode node) {
        if (node.right == null) {
            return node;
        }
        return maxNode(node.right);
    }

}
```','14',NULL,'0450-delete-node-in-a-bst','2025-06-11 09:27:51','2025-06-13 15:27:18',1,7,false,NULL,'https://leetcode.cn/problems/delete-node-in-a-bst/',36,6,'',false,'https://leetcode.cn/problems/delete-node-in-a-bst/solutions/16157/yong-qian-qu-huo-zhe-hou-ji-jie-dian-zi-shu-dai-ti/',true,NULL,NULL),(135,'liweiwei1419','「力扣」第 641 题：设计循环双端队列（中等）','## 思路分析

本题依然是要求长度固定，双端循环队列比循环队列多出来的两个方法是：队首入队 `insertFront()`，队尾出队 `deleteLast()`，可以采用类似「力扣」第 622 题（设计循环队列）的方式实现。「力扣」第 622 题中定义的 `front` 和 `rear` 只能循环右移，本题我们还要分别给它们加上循环左移的逻辑。

+ 队首入队：由于 `front` 指向第一个队首元素，因此需要先将 `front` 左移一个单位，然后再赋值。同样注意：
    - 先做判断，在队列不是满的时候，才可以入队；
    - `front` 左移一个单位要避免数组下标越界和处理循环。
+ 队尾出队：由于 `rear` 指向 **队尾元素的下一个元素**，因此需要将 `rear` 左移一个单位即可。同样注意：
    - 先做判断，在队列非空的时候，才可以出队；
    - `rear` 左移一个单位同样要避免数组下标越界和处理循环。

**参考代码**：

```java
public class MyCircularDeque {

    private int[] arr;
    private int capacity;
    private int front;
    private int rear;

    public MyCircularDeque(int k) {
        capacity = k + 1;
        arr = new int[capacity];
        front = 0;
        rear = 0;
    }

    public boolean insertFront(int value) {
        if (isFull()) {
            return false;
        }
        front = (front - 1 + capacity) % capacity;
        arr[front] = value;
        return true;
    }

    public boolean insertLast(int value) {
        if (isFull()) {
            return false;
        }
        arr[rear] = value;
        rear = (rear + 1) % capacity;
        return true;
    }

    public boolean deleteFront() {
        if (isEmpty()) {
            return false;
        }
        front = (front + 1) % capacity;
        return true;
    }

    public boolean deleteLast() {
        if (isEmpty()) {
            return false;
        }
        rear = (rear - 1 + capacity) % capacity;
        return true;
    }

    public int getFront() {
        if (isEmpty()) {
            return -1;
        }
        return arr[front];
    }

    public int getRear() {
        if (isEmpty()) {
            return -1;
        }
        return arr[(rear - 1 + capacity) % capacity];
    }

    public boolean isEmpty() {
        return front == rear;
    }

    public boolean isFull() {
        return (rear + 1) % capacity == front;
    }

}
```

**复杂度分析**：

+ 时间复杂度：时间复杂度：每一个方法都使用有限次操作完成，时间复杂度为 $ O(1) $；
+ 空间复杂度：$ O(k) $，这里 $k$ 为队列的容量。','11',NULL,'0641-design-circular-deque','2025-06-11 09:20:48','2025-06-15 19:33:18',1,4,false,NULL,'https://leetcode.cn/problems/design-circular-deque/description/',34,9,'',false,'https://leetcode.cn/problems/design-circular-deque/solutions/56620/shu-zu-shi-xian-de-xun-huan-shuang-duan-dui-lie-by/',true,'完成。','有效数据在数组中循环利用。'),(36,'liweiwei1419','第 12 章 二叉树与二叉搜索树：高效查找与动态维护','',NULL,NULL,'tree','2025-06-09 12:18:02','2025-06-09 12:18:02',0,0,false,NULL,NULL,21,5,'',true,NULL,true,NULL,'后序遍历（向上传递信息）是非常重要的解题思想，其实还是分而治之的思想。二叉搜索树综合了链表（增删快）和有序（查找快）的特点实现了查找表这种数据结构。'),(156,'liweiwei1419','「力扣」第 137 题：只出现一次的数字 II（中等）','## 思路分析

本题有 2 个常见的思路：

- 使用哈希表统计每个数字出现的次数，需要额外的哈希表来存储计数，空间复杂度不符合题目要求；
- 先对数组进行排序，然后检查相邻元素，相同的数字会连续出现 3 次，由于要排序，排序的时间复杂度不符合题目要求。

位运算的核心思想是利用整数的二进制表示逐位处理。对于此类「统计数字出现次数」的问题，位运算提供了一种高效的解决方式：

- 对于整数的每一个二进制位，统计数组中所有数字在该位上 1 的个数；
- 如果某一位上 1 的个数不是 3 的倍数，则说明只出现一次的数字在该位上为 1；
- 通过一位一位地遍历，即可重构出只出现一次的数字。

统计每一位上 1 出现的次数，把出现 3 次的位舍弃掉。只出现了 1 次的数，通过按位与的方式累加到 `res` 变量中。

这么说可能还是有点抽象。打一个不怎么恰当的比方：假设你需要统计全班同学对某议题的投票情况。已知全班有 `n` 位学生，每人可以投赞成或反对，除了某一位特立独行的学生，其他所有学生都 3 人一组抱团投票（即每组 3 人投票完全相同），你需要找出那个单独投票的学生的选项。你可以这样做：如果某一议题的赞成票总数不是 3 的倍数，说明那个单独投票的学生在这一议题上投了一票。反之，如果某一议题的赞成票总数是 3 的倍数，说明单独投票的学生没有投此议题。

**参考代码**：

```java
public class Solution {

    public int singleNumber(int[] nums) {
        int res = 0;
        for (int i = 0; i < 32; i++) {
            int sum = 0;
            for (int num : nums) {
                sum += (num >> i) & 1;
            }
            if (sum % 3 != 0) {
                res |= (1 << i);
            }
        }
        return res;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(32n) = O(n) $，其中 $ n $ 是数组长度；
+ 空间复杂度：$ O(1) $。','22',NULL,'0137-single-number-ii','2025-06-11 09:44:19','2025-06-12 08:49:01',2,16,false,NULL,'https://leetcode.cn/problems/single-number-ii/description/',44,2,'',false,NULL,true,NULL,NULL),(159,'liweiwei1419','「力扣」第 191 题：位 1 的个数（简单）','## 思路分析

可以使用一个掩码 `mask` 逐位检查 `n` 的每一位是否为 1。具体步骤如下：

+ 初始化掩码 `mask = 1`，其二进制表示为 `0000...0001`；
+ 由于 int 类型整数是 32 位，我们需要循环 32 次：
    - 用当前 `mask` 与 `n` 做「按位与」运算，如果结果不为 0，说明该位是 1；
    - 每次循环后将 `mask` 左移一位，继续检查下一位；
    - 统计所有为 1 的位数。

**参考代码 1**：

```java
public class Solution {

    public int hammingWeight(int n) {
        // 计数变量，记录 1 的个数
        int count = 0;
        // 初始掩码，二进制为 000...0001
        int mask = 1;
        for (int i = 0; i < 32; i++) {
            // 检查当前位是否为 1
            if ((n & mask) != 0) {
                count++;
            }
            // 掩码左移一位，检查下一位
            mask <<= 1;
        }
        return count;
    }

}
```

我们还可以使用位运算的技巧 `n & (n - 1)` ：把 `n` 的最低位的 1 变成 0。每次执行 `n &= (n - 1)` 都会消去一个 1，直到 `n` 变为 0，统计操作的次数即可。

**参考代码 2**：

```java
public class Solution {

    public int hammingWeight(int n) {
        int count = 0;
        while (n != 0) {
            // 消去最低位的 1
            n &= n - 1;
            count++;
        }
        return count;
    }

}
```

**复杂度分析**：

* 时间复杂度：最坏情况：$O(32) = O(1)$，因为整数固定 32 位，最多循环 32 次。平均情况：$O(k)$，`k` 是 `n` 的二进制中 1 的位数；
* 空间复杂度：$O(1)$，只用了常数个额外变量。','22',NULL,'0191-number-of-1-bits','2025-06-11 09:44:19','2025-06-12 09:58:08',1,9,false,NULL,'https://leetcode.cn/problems/number-of-1-bits/description/',44,5,'',false,NULL,true,NULL,NULL),(163,'liweiwei1419','「力扣」第 342 题：4 的幂（简单）','## 思路分析

4 的幂的性质是：首先是 2 的幂，其次 1 出现在其二进制表示的奇数位上。

如何判断这个 1 在奇数位上呢？可以用奇数位上全是 1 的数与该数进行与运算，与运算后不为 0 ，则表示 1 在奇数位上。

奇数位上全是 1 的数的二进制表示是：`0101 0101 0101 0101 0101 0101 0101 0101`，用 `0x` 前缀写成 16 进制，即 `0x55555555`。

**参考代码**：

```java
public class Solution {

    public boolean isPowerOfFour(int n) {
        // 检查是否是 2 的幂且 1 在奇数位
        // return n > 0 && (n & (n - 1)) == 0 && (n & 0b01010101010101010101010101010101) != 0;
        return n > 0 && (n & (n - 1)) == 0 && (n & 0x55555555) != 0;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1) $；
+ 空间复杂度：$ O(1) $。','22',NULL,'0342-power-of-four','2025-06-11 09:44:19','2025-06-12 11:09:13',1,6,false,NULL,'https://leetcode.cn/problems/power-of-four/description/',44,9,'',false,NULL,true,NULL,NULL),(169,'liweiwei1419','「力扣」第 990 题：等式方程的可满足性（中等）','## 题意分析

题目给我们一系列等式和不等式，然后问我们这些等式和不等式组成的变量之间的关系是否有冲突。如果没有冲突，说明等式和不等式的关系是正确的，返回 `true` ，否则返回 `false`。

## 思路分析
如果一个问题带有传递性，可以考虑使用并查集完成。由于 **等式相等具有传递性**，所有相等的变量属于同一个集合，这一点提示我们这是连通性问题，可以使用并查集完成。设计算法如下：

+ 先遍历所有等式，将等式两边的变量进行合并；
+ 再遍历所有不等式，检查不等式的两个变量是否在同一个连通分量里。如果是，返回 `false` 表示有矛盾。如果所有检查都没有矛盾，返回 `true`。

**参考代码**：这里使用了路径压缩的隔代压缩优化。

```java
public class Solution {

    public boolean equationsPossible(String[] equations) {
        UnionFind unionFind = new UnionFind(26);

        for (String equation : equations) {
            char[] charArray = equation.toCharArray();
            if (charArray[1] == ''='') {
                int index1 = charArray[0] - ''a'';
                int index2 = charArray[3] - ''a'';
                unionFind.union(index1, index2);
            }
        }

        for (String equation : equations) {
            char[] charArray = equation.toCharArray();
            if (charArray[1] == ''!'') {
                int index1 = charArray[0] - ''a'';
                int index2 = charArray[3] - ''a'';
                if (unionFind.isConnected(index1, index2)) {
                    // 如果在同一个集合中，表示等式有矛盾，根据题意，返回 false
                    return false;
                }
            }
        }
        // 如果检查了所有不等式，都没有发现矛盾，返回 true
        return true;
    }

    private class UnionFind {

        private int[] parent;

        public UnionFind(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            while (x != parent[x]) {
                // 只使用了「路径压缩」，且是「隔代压缩」
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            parent[rootX] = rootY;
        }

        public boolean isConnected(int x, int y) {
            return find(x) == find(y);
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n \log C) $，这里 $ n $ 是等式的数量，$ C $ 是变量的总数， $ C \leq 26 $，我们只使用了路径压缩，每个等式合并与查找的时间复杂度是 $ O(\log C) $；
+ 空间复杂度：$ O(C) $，数组 `parent` 的大小是 $ C $。

## 本题总结

这问题的传递性是我们想到可以使用并查集的原因，并查集只回答是否连在一起，并不回答如何连在一起，也恰好是本题适用的场景。

','23',NULL,'0990-satisfiability-of-equality-equations','2025-06-11 09:46:04','2025-06-12 14:55:50',1,66,false,NULL,'https://leetcode.cn/problems/satisfiability-of-equality-equations/description/',45,1,'',false,NULL,false,NULL,NULL),(160,'liweiwei1419','「力扣」第 201 题：数字范围按位与（中等）','## 思路分析

「按位与」运算，只要参与的位上有 0 ，结果就是 0。一个区间里的数，相邻的位上出现 0 简直太正常了。我们用一个表格展示这件事情：

| 十进制 | 二进制（省略前面的 24 个 0） |
| --- | --- |
| 161 | `1010 0001` |
| 162 | `1010 0010` |
| 163 | `1010 0011` |
| 164 | `1010 0100` |
| 165 | `1010 0101` |
| 166 | `1010 0110` |
| 167 | `1010 0111` |
| 168 | `1010 0100` |
| 169 | `1010 0101` |
| 170 | `1010 0110` |


因此，一个区间里的数按位与只有 **高位** 是不变的，「按位与」以后的值是它们在高位上 **相同前缀** 的值。如上表所示，区间 `[161.. 170]` 按位与的结果的「二进制」是 `1010 0000`，即 160。

**参考代码 1**：

```java
public class Solution {

    public int rangeBitwiseAnd(int left, int right) {
        int count = 0;
        while (left < right) {
            // 右移把低位消去
            left >>= 1;
            right >>= 1;
            count++;
        }
        // 再左移相应的次数，低位补 0，就能找到公共前缀
        return left << count;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1) $，因为整数位数固定（例如 32 位），最多只需要 32 次移位操作。
+ 空间复杂度：$ O(1) $，只使用了常数个额外变量。

联系我们介绍过的 `n & (n - 1)` 可以把最低位的 1 消去，每次操作都会去掉 `right` 的一个 1，直到 `right <= left`，此时的 `right` 就是公共前缀。

**参考代码 2**：

```java
public class Solution {

    public int rangeBitwiseAnd(int left, int right) {
        while (left < right) {
            right &= (right - 1);
        }
        return right;
    }

}
```

**复杂度分析**：（同「参考代码 1」）

## 本题总结

区间内所有数字按位与的结果就是这些数字的公共二进制前缀，后面补零。','22',NULL,'0201-bitwise-and-of-numbers-range','2025-06-11 09:44:19','2025-06-12 09:24:25',1,4,false,NULL,'https://leetcode.cn/problems/bitwise-and-of-numbers-range/description/',44,6,'',false,NULL,true,NULL,NULL),(51,'liweiwei1419','「力扣」第 78 题：子集（中等）','## 思路分析

以求 `[1, 2, 3]` 的子集为例，**按照一个数选和不选**，画出递归树如下；

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image7082732664476701787.png)

如上图所示，所有的叶子结点是问题的答案。

+ 需要的状态变量：
    - 当前考虑的是第几个数，即：数组 `nums` 的下标，我们命名为 `index`；
    - 从根结点到叶子结点的路径 `path`，容易知道，它是一个栈。

**参考代码 1**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> subsets(int[] nums) {
        int n = nums.length;
        List<List<Integer>> res = new ArrayList<>();
        Deque<Integer> path = new ArrayDeque<>();
        dfs(nums, n, 0, path, res);
        return res;
    }

    private void dfs(int[] nums, int n, int index, Deque<Integer> path, List<List<Integer>> res) {
        if (index == n) {
            // 注意：由于全程使用一份变量 path，所以这里需要复制
            res.add(new ArrayList<>(path));
            return;
        }

        // 选 nums[index]
        path.addLast(nums[index]);
        dfs(nums, n, index + 1, path, res);
        path.removeLast();

        // 不选 nums[index]
        dfs(nums, n, index + 1, path, res);
    }

}
```

符合我们画出的树形图。

**复杂度分析**：

+ 时间复杂度：$ O(n \times 2^n) $，这里 $ n
 $ 为数组的长度，叶子结点一共有 $ 2^n $ 个，树的高度为 $ n $；
+ 空间复杂度：$ O(n \times 2^n) $，理由同时间复杂度。保存子集需要长度为 $ 2^n $ 的列表，每一个子集的元素最多长度为 $ n $。

仍以求 `[1, 2, 3]` 的子集为例，**按照每一层选出一个数产生分支**，由于结果集中认为 `[1, 2]` 与 `[2, 1]` 是重复元素，我们需要按照顺序选取元素，画出递归树如下：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image3389635652680445103.png)


**可以看到所有的结点（包括非叶子结点，包括根结点）都是问题的答案。**

需要的状态变量：

+ 从数组 `nums` 的哪一个下标开始搜索 `start`；
+ 从根结点到叶子结点的路径 `path`。

**参考代码 2**：

```java
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class Solution {

    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> res = new ArrayList<>();
        int n = nums.length;
        Deque<Integer> path = new ArrayDeque<>();
        dfs(nums, 0, n, path, res);
        return res;
    }

    private void dfs(int[] nums, int begin, int n, Deque<Integer> path, List<List<Integer>> res) {
        // 在遍历的过程中，收集符合条件的结果
        res.add(new ArrayList<>(path));
        for (int i = begin; i < n; i++) {
            path.addLast(nums[i]);
            dfs(nums, i + 1, n, path, res);
            path.removeLast();
        }
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(2^n) $，整棵树的结点个数一共是 $ 2^n $ 个；
+ 空间复杂度：$ O(n \times 2^n) $，保存子集需要长度为 $ 2^n $ 的列表，每一个子集的元素最多长度为 $ n $。','16',NULL,'0078-subsets-dfs','2025-06-10 04:15:13','2025-07-09 15:01:59',1,11,false,NULL,'https://leetcode.cn/problems/subsets/description/',38,5,'',false,'https://leetcode.cn/problems/subsets/solutions/7812/hui-su-python-dai-ma-by-liweiwei1419/',true,NULL,NULL),(190,'liweiwei1419','「力扣」第 380 题：O(1) 时间插入、删除和获取随机元素（中等）','## 思路分析
题目要求每个函数的平均时间复杂度为 $ O(1) $，这样的数据结构只有哈希表或者数组，因此在 `insert` 和 `remove` 方法中都需要使用哈希表。又由于题目要求我们实现 `getRandom` 函数，且时间复杂度是 $ O(1) $ ，此时还需要把 `val` 放在一个数组中，利用随机数得到数组的下标，因为我们不知道数组中最多存多少个元素，所以这里数组应该选择动态数组，即 Java 中的 `java.util.ArrayList` 。

综上所述，我们需要两个数据结构：

+ 动态数组 `java.util.ArrayList`：记录插入 `RandomizedSet` 的 `val`，支持 $ O(1) $ 的随机访问；
+ 哈希表 `java.util.HashMap`：记录插入 `RandomizedSet` 的 `val` 和在动态数组中对应的下标，支持 $ O(1) $ 的查找。

下面是 3 个方法的具体操作：

+ `insert`：先到哈希映射中查找 `val` 是否存在，如果不存在，在动态数组的末尾插入，同时在哈希表中记录 `val` 和下标的关系；
+ `remove`：先到哈希映射中查找 `val` 是否存在，如果存在，找到其在动态数组中的下标，把动态数组末尾元素覆盖到待删除元素的位置（这是因为数组在末尾操作的时间复杂度是 $ O(1) $ ），并删除哈希映射中 `val` 和下标的对应关系。通过将最后一个元素移到被删除位置，避免了数组中间删除的 $ O(n) $ 开销，只需要更新被移动元素的索引，其他元素索引不受影响；
+ `getRandom()`：使用随机数生成器生成一个数组范围内的随机下标，返回该下标对应的元素。

**参考代码**：注意事项作为注释写在了代码中。

```java
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

class RandomizedSet {

    private static final Random RANDOM = new Random(System.currentTimeMillis());

    private List<Integer> vals;
    private Map<Integer, Integer> hashMap;

    public RandomizedSet() {
        vals = new ArrayList<>();
        hashMap = new HashMap<>();
    }

    public boolean insert(int val) {
        if (hashMap.containsKey(val)) {
            return false;
        } else {
            // 将元素添加到数组末尾
            hashMap.put(val, vals.size());
            vals.add(val);
            return true;
        }
    }

    public boolean remove(int val) {
        if (hashMap.containsKey(val)) {
            int index = hashMap.get(val);
            int lastValue = vals.getLast();

            // 注意：先设置，再删除。如果此时数组中只有一个元素，先删除，再设置会导致数组下标越界
            vals.set(index, lastValue);
            vals.removeLast();

            // 注意：先更新，再删除。如果此时哈希表中只有一个键值对，先删除再更新，等价于没有删除
            hashMap.put(lastValue, index);
            hashMap.remove(val);
            return true;
        } else {
            return false;
        }
    }

    public int getRandom() {
        int randomIndex = RANDOM.nextInt(vals.size());
        return vals.get(randomIndex);
    }

}
```

**复杂度分析**：

+ 时间复杂度：插入、删除和随机获取元素的操作的平均时间复杂度均为 $ O(1) $；
+ 空间复杂度：$ O(n) $，其中 $ n $ 是集合中元素的数量。主要用于存储数组和哈希表。

## 本题总结
要实现常数时间复杂度的插入、删除和随机获取元素操作，我们可以结合使用数组和哈希表：

+ **数组**：用于存储元素，方便随机访问元素。
+ **哈希表**：用于存储元素及其在数组中的索引，这样可以在 $ O(1) $ 时间内判断元素是否存在，以及获取元素在数组中的位置。','15',NULL,'0380-insert-delete-getrandom-o1','2025-06-11 18:57:32','2025-06-13 04:53:33',1,5,false,NULL,'https://leetcode.cn/problems/insert-delete-getrandom-o1/description/',37,6,'',false,NULL,true,NULL,'数组在末尾操作，这里用动态数组，O(1) 时间肯定要用哈希表'),(126,'liweiwei1419','「力扣」第 20 题：有效的括号（简单）','## 思路分析

根据题意，括号是成对出现的，左括号必须与相同类型的右括号匹配，**从左向右看**，**后出现的左括号先匹配**，这一点提示我们可以使用栈。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0020-valid-parentheses/temp-image5015648835147623285.png)

我们可以在遇到左括号的时候，**在栈中存入与之匹配的右括号**。这样一来，在遍历到右括号的时候，就可以和栈顶元素比较：如果相等，则完成一次匹配；如果不相等，则可以直接得到结论：字符串不是有效的括号。

最后还需要注意：在 `s` 中的字符遍历完成以后，还需要判断栈中元素是否为空，为空表示所有的括号都按照后进先出的顺序得到了匹配，否则字符串不是有效的括号。

**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    public boolean isValid(String s) {
        // 括号必须成对出现
        if (s.length() % 2 != 0) {
            return false;
        }
        Deque<Character> stack = new ArrayDeque<>();
        for (char c : s.toCharArray()) {
            if (c == ''{'') {
                stack.addLast(''}'');
            } else if (c == ''('') {
                stack.addLast('')'');
            } else if (c == ''['') {
                stack.addLast('']'');
            } else if (stack.isEmpty() || stack.removeLast() != c) {
                return false;
            }
        }
        return stack.isEmpty();
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $ ，$ n $ 是字符串 `s` 的长度；
+ 空间复杂度：$ O(n) $，最差情况下，字符串的一半字符要进入栈中。','10',NULL,'0020-valid-parentheses','2025-06-11 09:19:13','2025-06-30 13:37:25',1,14,false,NULL,'https://leetcode.cn/problems/valid-parentheses/description/',34,1,'',false,NULL,true,'完成。','符合「后进先出」规律，所以用栈。'),(164,'liweiwei1419','「力扣」第 371 题：两整数之和（中等）','## 思路分析

这道题的解法记住就好了。既然不能使用加法，就可以考虑使用不进位的加法：异或运算。而「进位」这件事，由于「异或运算」在 `1 ^ 1 = 0`，**而「与」运算 `1 & 1 = 1` 正好弥补了这一点，而「进位」用左移 1 位来表示即可**。步骤如下：

+ **计算不进位的和**：使用异或运算 `a ^ b`，这可以得到不考虑进位时的和；
+ **计算进位**：使用与运算 `a & b` 然后左移一位 `<< 1`，这可以得到所有需要进位的位置；
+ **将两者相加**：将不进位的和与进位相加，这个步骤本身又是一个加法，需要循环进行，**直到进位为 0**。

假设 `a = 5` (`0101`), `b = 3` (`0011`)，计算过程如下表所示：

![image.png](https://pic.leetcode.cn/1749698532-PoMmAF-image.png)


**参考代码**：

```java
public class Solution {

    public int getSum(int a, int b) {
        while (b != 0) {
            // 计算进位
            int carry = a & b;
            // 计算不进位的和
            a = a ^ b;
            // 将进位左移一位，准备下一轮相加
            b = carry << 1;
        }
        return a;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(1) $，因为整数位数固定（32 位），最多进行 32 次循环；
+ 空间复杂度：$ O(1) $，只使用了常数个额外变量。

## 本题总结

题目不允许用加法，所以使用不进位的加法「异或」，而「进位」通过「与」运算以后左移 1 位得到。由于进位的影响可能是连续的，因此需要使用循环。


','22',NULL,'0371-sum-of-two-integers','2025-06-11 09:44:19','2025-06-12 11:22:40',1,5,false,NULL,'https://leetcode.cn/problems/sum-of-two-integers/description/',44,10,'',false,NULL,true,NULL,NULL),(166,'liweiwei1419','「力扣」第 338 题：比特位计数（简单）','## 思路分析

+ 最简单直观的方法，创建一个长度为 `n + 1` 的数组（因为要从 0 算到 `n`），对于每个数字，直接计算它的二进制表示中有多少个 1，把结果存入数组；
+ 更高效的做法，需要使用位运算的技巧：`n & (n - 1)` 可以去掉其二进制表示的最后一个 1，也就是说：**`n` 和 `n & (n - 1)` 的二进制表示只相差最低位的一个 1**，利用这个关系，可以快速计算每一个整数的答案。即：**一个较大整数的答案参考了一个较小整数数的答案**，这是动态规划：
    - **状态定义**：`dp[i]` 表示整数 `i` 的二进制表示中 1 的个数；
    - **状态转移方程**：`n` 和 `n & (n - 1)` 的二进制表示只相差最低位的一个 1，这句话就是状态转移方程，即 `dp[i] = dp[i & (i - 1)] + 1`。

**参考代码**：

```java
public class Solution {

    public int[] countBits(int n) {
        int[] dp = new int[n + 1];
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            // 「二进制」只有 1 个的时候，结果 1
            if ((i & (i - 1)) == 0) {
                dp[i] = 1;
                continue;
            }
            dp[i] = dp[i & (i - 1)] + 1;
        }
        return dp;
    }

}

```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，每一个整数只需要 $ O(1) $的时间复杂度计算出结果；
+ 空间复杂度：$ O(1) $。除了记录答案的数组以外，需要的额外空间为常数。

## 本题总结

动态规划的做法就是利用 **已经计算过的结果** 来加速计算，本题需要利用位运算的性质：`n & (n - 1)` 可以去掉 `n` 的最后一个 1，所以 `dp[i]` 参考了 `dp[i & (i - 1)]` 的答案。','22',NULL,'0338-counting-bits','2025-06-11 09:44:19','2025-06-12 15:17:43',1,5,false,NULL,'https://leetcode.cn/problems/counting-bits/description/',44,12,'',false,NULL,true,NULL,NULL),(194,'liweiwei1419','「力扣」第 96 题：不同的二叉搜索树（中等）','测试','动态规划',NULL,NULL,'2025-06-19 03:03:51','2025-06-19 12:43:20',0,0,true,NULL,NULL,NULL,0,'',false,NULL,false,NULL,NULL),(83,'liweiwei1419','「力扣」第 45 题：跳跃游戏 II（困难）','

## 思路分析
为了最小化跳跃次数，我们需要在每一步选择能让未来跳得最远的策略。换句话说就是：**到达某个位置，能跳 2 步就不跳 3 步**。以「示例 1」为例，在下标 0 个位置（`nums[0] = 2`）时，我们有两个选择：

+ 跳到下标 1 位置（`nums[1] = 3`）：从该位置出发，下一步最多可以跳到下标 4 位置（1 + 3 = 4）；
+ 跳到下标 2 位置（`nums[2] = 1`）：从该位置出发，下一步最多可以跳到下标 3 位置（2 + 1 = 3）。如下图所示：

![](https://minio.dance8.fun/algo-crazy/0045-jump-game-ii/temp-image18256974462445002993.png)

选择跳到下标 1 位置更优，因为它能让以后跳得更远。即 **在每一步的跳跃选项中，选择能在下一步覆盖范围最大的位置，从而减少总跳跃次数**。

我们再重复一下思路：根据题意，当前所在的位置 `i` 能直接跳到 `[i + 1, i + 2, ..., i + nums[i]]`，下一步的最优选择是：在 `[i + 1, ..., i + nums[i]]` 范围内，选择 `j`，使得 `j + nums[j]` 最大（即下一步能覆盖最远）。

下面我们用反证法证明：假设存在一个更优的策略，其中某一步不选择 `j + nums[j]` 最大的点，而选 `j''`（`j'' + nums[j''] < j + nums[j]`），那么由于 `j''` 的覆盖范围更小，可能需要在后续额外跳跃才能覆盖 `j + nums[j]` 能直接覆盖的范围。这样总跳跃次数可能比我们的策略更多，矛盾。因此，选择 `j + nums[j]` 最大的点是最优的。

在编码的时候，需要维护两个关键变量：

+ `currentEnd`：当前跳跃能到达的最远位置。
+ `farthest`：在当前跳跃范围内，从任意位置出发下一步能到达的最远位置。

**遍历数组**：

+ 对于每一个位置，更新 `farthest`；
+ 当遍历到 `currentEnd` 时，表示已经完成了一次跳跃，此时：跳跃次数 `jumps` 加 1，将 `currentEnd` 更新为 `farthest`，表示下一次跳跃的范围；
+ 如果 `currentEnd` 已经可以到达或超过数组末尾，直接返回当前跳跃次数。

**参考代码**：

```java
public class Solution {
    
    public int jump(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return 0;
        }
        int jumps = 0;
        int currentEnd = 0;
        int farthest = 0;
        // 能调到 n - 1 即可，n - 1 位置就不用再计算了
        for (int i = 0; i < n - 1; i++) {
            // 在当前跳跃范围内，计算下一步能到达的最远位置
            farthest = Math.max(farthest, i + nums[i]);
            // 到达当前跳跃的边界时，进行一次跳跃
            if (i == currentEnd) {
                jumps++;
                currentEnd = farthest;
                // 如果已经能跳到或超过最后一个位置，直接返回跳跃次数
                if (currentEnd >= n - 1) {
                    break;
                }
            }
        }
        return jumps;
    }
    
}
```

**说明**：在变量 `i` 遍历到 `currentEnd` 的过程中，`farthest` 还在更新，直到 `i == currentEnd` 时，才跳一步，并且将当前跳跃能到达的最远位置 `currentEnd` 更新为 `farthest` ，这样能保证总跳跃次数最少，还可以结合上面的「示例 1」理解。

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组 `nums` 的长度，只需遍历一次数组；
+ 空间复杂度：$ O(1) $，仅使用了常数个额外变量。','18',NULL,'0045-jump-game-ii','2025-06-11 08:20:34','2025-06-16 14:41:31',1,11,false,NULL,'https://leetcode.cn/problems/jump-game-ii/description/',40,5,'',false,NULL,true,'完成。',NULL),(54,'liweiwei1419','「力扣」第 50 题：Pow(x, n)（中等）','## 思路分析

如果按照定义计算幂，时间复杂度是线性级别的。加快计算的方式就是逐步拆开，再倒回来求值。即如果要求 $ 2^{100} $，将其转换为计算 $ 4^{50} $，本来要计算 100 次乘法，转换以后只需要计算 50 次，一直这样拆下去，直到不能拆分为止，这是分而治之的算法思想。

以计算 $ 2^7 $ 为例，画出递归树如下：

![](https://minio.dance8.fun/algo-crazy/0050-powx-n-dfs/temp-image17442028727031960400.png)

+ 如果 `n` 是偶数，**其值等于「底数平方，指数减半」**；
+ 如果 `n` 是奇数，拆成 `1 + (n - 1)` ，此时 `n - 1` 是偶数，在下一轮递归中可以按照上一步规则计算。

那么这棵树，什么时候出现叶子结点呢？当 `n = 0` 或者 `n = 1` 时：

+ 当 `n = 0` 是，返回 `1`，因为任何数的 `0` 次幂都是 `1`；
+ 当 `n = 1` 时，返回 `x`，因为任何数的 `1` 次幂都是它本身。

另外，我们还要处理 `n` 是负数的情况，可以将其转换为正数幂的倒数，即 `1 / pow(x, -n)`。

**参考代码**：

```java
public class Solution {

    public double myPow(double x, int n) {
        long N = n;
        if (N < 0) {
            return myPow(1 / x, -N);
        }
        return myPow(x, N);
    }

    private double myPow(double x, long n) {
        if (n == 0) {
            return 1;
        }
        
        // 下面这 3 行可以不写，因为它可以合并到 n % 2 == 1 里面
        if (n == 1) {
            return x;
        }
        if (n % 2 == 1) {
            return x * myPow(x * x, n / 2);
        }
        return myPow(x * x, n / 2);
    }

}
```

**说明**：将 `n` 从 `int` 类型转换为 `long` 类型（命名为 `N`）的原因是为了处理 `n` 的极端情况，特别是当 `n` 取到 `Integer.MIN_VALUE` 时，如果直接取负数 `-n`，会导致整数溢出，因为 `2147483648` 超出了 `int` 的正数范围（`int` 的最大值是 `2147483647`），因此 `-Integer.MIN_VALUE` 仍然是 `Integer.MIN_VALUE`（因为溢出），这会导致无限递归或错误的结果。

**复杂度分析**：

+ 时间复杂度：$ O(\log n) $，每次递归都将问题规模减半；
+ 空间复杂度：$ O(\log n) $，递归调用栈的深度为 $ \log n $。

## 本题总结
希望大家通过这道问题可以理解：我们借助函数调用的机制，把还未计算出的问题暂时存起来，再在合适的时候拿出来继续解决，这样的存储、取出、计算的顺序是函数调用机制帮我们完成的，我们不用自己写一个栈来实现。','2',NULL,'0050-powx-n-dfs','2025-06-10 04:51:38','2025-07-14 16:55:17',6,62,false,NULL,'https://leetcode.cn/problems/powx-n/description/',27,0,'',false,'https://leetcode.cn/problems/powx-n/solutions/7225/ba-zhi-shu-bu-fen-kan-zuo-er-jin-zhi-shu-python-da/',false,'可以写出两版参考代码。',NULL),(167,'liweiwei1419','「力扣」第 78 题：子集（中等）','## 思路分析

我们在《第 1 节 位运算简介》里和大家介绍过：一个 $n$ 位二进制数，对应一个 $n$ 位布尔数组。因此从 0 到 $n$ 位二进制数的最大值 1111 （这里以 $n = 4$ 为例）的每一个整数，分别对应了一个 $n$ 位布尔数组，它们也分别对应了长度为 $n$ 的数组的一个子集，其中第 `i` 位为 1 表示选 `nums[i]`，为 0 表示不选。
以 `nums = [1, 2, 3]` 为例，用 32 位二进制表示如下表所示：

| 32 位二进制                               | 子集        |
| ----------------------------------------- | ----------- |
| `0000 0000 0000 0000 0000 0000 0000 0000` | `[]`        |
| `0000 0000 0000 0000 0000 0000 0000 0001` | `[1]`       |
| `0000 0000 0000 0000 0000 0000 0000 0010` | `[2]`       |
| `0000 0000 0000 0000 0000 0000 0000 0011` | `[1, 2]`    |
| `0000 0000 0000 0000 0000 0000 0000 0100` | `[3]`       |
| `0000 0000 0000 0000 0000 0000 0000 0101` | `[1, 3]`    |
| `0000 0000 0000 0000 0000 0000 0000 0110` | `[2, 3]`    |
| `0000 0000 0000 0000 0000 0000 0000 0111` | `[1, 2, 3]` |




**参考代码**：

```java
import java.util.ArrayList;
import java.util.List;

public class Solution {

    public List<List<Integer>> subsets(int[] nums) {
        int n = nums.length;
        int size = 1 << n;
        List<List<Integer>> res = new ArrayList<>();
        // 遍历所有可能的二进制掩码
        for (int mask = 0; mask < size; mask++) {
            List<Integer> subset = new ArrayList<>(n);
            for (int j = 0; j < n; j++) {
                // 检查每一位是否为 1
                if ((mask & (1 << j)) == 0) {
                    continue;
                }
                subset.add(nums[j]);
            }
            res.add(subset);
        }
        return res;
    }

}
```

**编码细节**：

+ `mask` 从 `0` 到 $ 2^n - 1 $，即所有可能的子集状态；
+ 对每个 `mask`，检查其二进制表示的每一位 `i`，如果 `(mask & (1 << i)) != 0`，表示选 `nums[i]`，加入当前子集。

**复杂度分析**：

+ 时间复杂度：$ O(n \cdot 2^n) $，这里 $ n $ 是输入数组的长度，长度为 $ n $ 的数组的子集总数是 $ 2^n $，每个子集最多需要 $ O(n) $ 时间生成；
+ 空间复杂度：$ O(n \cdot 2^n) $，存储所有子集的结果。','22',NULL,'0078-subsets','2025-06-11 09:44:19','2025-06-12 15:25:31',1,4,false,NULL,'https://leetcode.cn/problems/subsets/description/',44,13,'',false,NULL,true,NULL,NULL),(62,'liweiwei1419','「力扣」第 80 题：删除排序数组中的重复项 II（中等）','## 思路分析

要求每个元素最多出现 2 次，也就是说：**下标相差 2 的元素，其值不能相等**。我们可以使用两个变量 `i` 和 `j` ，其中 `i` 遍历整个数组，`j` 在原数组上赋值，指向即将赋值的位置。一旦发现当前要赋值的元素与它的下标相差 2 的元素值的不相等时，就赋值，即 **始终保持了下标相差为 2 的元素，它们的值不相等**，保证了相同元素最多出现 2 次。如下图所示：

![image.png](https://minio.dance8.fun/algo-crazy/0080-remove-duplicates-from-sorted-array-ii/temp-image7178687962891291851.png)

代码实现细节方面，我们就不赘述了，与「力扣」第 26 题一样，我们给出两版参考代码。

**参考代码 1**：定义 `nums[0..j)` 是有序的，并且相同元素最多保留 2 次。通过比较 `nums[i]` 和 `nums[j - 2]` 确保每个元素最多保留两次。

```java
public class Solution {

    public int removeDuplicates(int[] nums) {
        int n = nums.length;
        if (n < 2){
            return n;
        }

        // 循环不变量：nums[0..j) 是有序的，并且相同元素最多保留 2 次
        // j 指向下一个要赋值的元素的位置
        int j = 2;
        for (int i = 2; i < n; i++) {
            if (nums[i] != nums[j - 2]){
                nums[j] = nums[i];
                j++;
            }
        }
        return j;
    }
    
}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，只需要遍历一次数组；
+ 空间复杂度：仅使用了常数级别的额外空间（如 `i` 和 `j` 指针变量），所以空间复杂度为 $ O(1) $。

**参考代码 2**：定义 `nums[0..j]` 是有序的，并且相同元素最多保留 2 次。

```java
public class Solution {

    public int removeDuplicates(int[] nums) {
        int n = nums.length;
        if (n < 2){
            return n;
        }

        // 循环不变量：nums[0..j] 是有序的，并且相同元素最多保留 2 次
        // j 已经赋值过的元素的最后一个位置
        int j = 1;
        for (int i = 2; i < n; i++) {
            if (nums[i] != nums[j - 1]){
                j++;
                nums[j] = nums[i];
            }
        }
        return j + 1;
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。
','3',NULL,'0080-remove-duplicates-from-sorted-array-ii','2025-06-10 14:31:32','2025-07-26 18:07:21',1,75,false,NULL,'https://leetcode.cn/problems/remove-duplicates-from-sorted-array-ii/description/',25,0,'',false,NULL,false,NULL,NULL),(137,'liweiwei1419','「力扣」第 225 题：用队列实现栈（简单）','## 思路分析

本题让我们借助使用实现的队列实现栈，可以借鉴上一题类似「负负得正」的做法，使用两个队列实现栈。其实 **放入辅助队列的那些元素可以直接放在当前的队列的尾部** ，仅使用一个队列也能实现栈。

具体的做法是：在 `push()` 的时候，依次将「队列长度 - 1」个元素依次从队首出队，放入队尾。为了方便叙述，我们将从队首放一个元素到队尾，称为一次「旋转」，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/1749856031-ywLsIJ-image.png)


**参考代码**：

```java
import java.util.ArrayDeque;
import java.util.LinkedList;
import java.util.Queue;

class MyStack {

    private Queue<Integer> queue;

    public MyStack() {
        queue = new ArrayDeque<>();
    }
    
    public void push(int x) {
        int n = queue.size();
        queue.offer(x);
        for (int i = 0; i < n; i++) {
            queue.offer(queue.poll());
        }
    }
    
    public int pop() {
        return queue.poll();
    }
    
    public int top() {
        return queue.peek();
    }
    
    public boolean empty() {
        return queue.isEmpty();
    }

}
```

**复杂度分析**：

+ 时间复杂度：
    - `push(x)`：将新元素 `x` 加入队列，将队列中除 `x` 外的所有元素依次出队并重新入队（这一步是将 `x` 调整到队首），时间复杂度 $ O(n) $，这里 $ n $ 是此时队列的长度；
    - `pop()`：出队队首元素，时间复杂度是 $ O(1) $；
    - `top()`：返回队首元素，时间复杂度是 $ O(1) $；
    - `empty()`：检查队列是否为空，时间复杂度是 $ O(1) $；
+ 空间复杂度：$ O(n) $。','11',NULL,'0225-implement-stack-using-queues','2025-06-11 09:20:48','2025-06-14 07:07:52',1,5,false,NULL,'https://leetcode.cn/problems/implement-stack-using-queues/solutions/',34,11,'',false,'https://leetcode.cn/problems/implement-stack-using-queues/solutions/54439/peek-he-pop-shi-yi-ci-jiang-dui-shou-yuan-su-chu-d/',true,'审完成。','挺没意思的问题，两次先进先出即后进先出，用一个队列也能实现栈，加到末尾就好。'),(187,'liweiwei1419','「力扣」第 1 题：两数之和（简单）','## 思路分析

- **暴力解法**：通过两层嵌套循环，遍历数组中的每一对元素，检查它们的和是否等于目标值 `target`。如果找到这样的一对元素，就返回它们的下标，参考代码省略；
- **优化思路**：采用空间换时间，把遍历到的数及其下标记录在哈希表里，由于还要存下标，使用 `HashMap`。在遍历到一个新的数 `nums[i]` 时，判断 `target - nums[i]` 是否已在哈希表中。如果是，则找到了两个数的和为 `target`，返回它们对应的下标。

**参考代码**：

```java
import java.util.HashMap;
import java.util.Map;

public class Solution {

    public int[] twoSum(int[] nums, int target) {
        int n = nums.length;
        Map<Integer, Integer> hashMap = new HashMap<>(n - 1);
        for (int i = 0; i < n; i++) {
            if (hashMap.containsKey(target - nums[i])) {
                return new int[]{i, hashMap.get(target - nums[i])};
            }
            hashMap.put(nums[i], i);
        }
        return new int[0];
    }
    
}
```

**说明**：Java 的 `HashMap` 内部使用数组来存储键值对，当我们向 `HashMap` 中添加元素时，如果当前存储元素的数量达到了一定阈值（负载因子与当前容量的乘积），`HashMap` 会进行扩容操作，扩容操作会重新计算哈希值并重新分配元素，这是一个相对耗时的操作。

因此，当我们提前知道大概需要存储的元素数量时，可以在初始化 `HashMap` 时传入数组的长度作为初始容量，这样可以减少扩容的可能性，从而在一定程度上提高性能。

**复杂度分析**：

* 时间复杂度：$O(n)$，这里 $n$ 是数组的长度。我们只需要遍历数组一次，对于每个元素，哈希表的查找和插入操作的时间复杂度都是 $O(1)$；
* 空间复杂度：$O(n)$，最坏情况下哈希表需要存储数组中的所有元素。','15',NULL,'0001-two-sum','2025-06-11 18:57:32','2025-06-12 12:37:13',1,6,false,NULL,'https://leetcode.cn/problems/two-sum/description/',37,3,'',false,NULL,true,NULL,'用哈希表记住遍历到的数，在遍历的同时找 target - nums[i]'),(81,'liweiwei1419','「力扣」第 122 题：买卖股票的最佳时机 II（中等）','## 思路分析

题目说可以无限次买卖股票，简单说就是 **低买高卖，把所有能赚的小钱都加起来**。所以我们可以每天看一眼股价，只要今天比昨天股价高，就把这个差价算进利润里。比如：股价序列 `[1, 2, 3, 4]`：

+ 第二天比第一天高 `(2 - 1) = 1`，赚 1 块；
+ 第三天比第二天高 `(3 - 2) = 1`，再赚 1 块；
+ 第四天比第三天高 `(4 - 3) = 1`，又赚 1 块。
+ 总利润 `1 + 1 + 1 = 3`，其实和直接 「第 4 天卖， 第 1 天买」（4 - 1 = 3）的结果一样。**能这样做是因为题目说股票能无限次买卖**，如果每天的买卖有限制，例如只能在奇数天买、偶数天卖，就不能按照上面的做法操作股票。

因此本题将所有的上涨的小段差价加起来，就等于最大总利润。从第 2 天开始，每天都只看估价是不是比昨天还高，涨了就把差价相加，只看「眼前」，所以是贪心算法。

**参考代码**：

```java
public class Solution {

    public int maxProfit(int[] prices) {
        int n = prices.length;
        if (n < 2) {
            return 0;
        }

        int res = 0;
        for (int i = 1; i < n; i++) {
            res += Math.max(prices[i] - prices[i - 1], 0);
        }
        return res;
    }

}
```

**复杂度分析：**  

+ 时间复杂度：$ O(n) $，只遍历一次股价；
+ 空间复杂度：$ O(1) $，只用常数个变量。

## 本题总结

贪心算法之所以有效，全靠题目允许无限交易。如果限制交易次数（比如只能买卖一次），就得换动态规划了。','18',NULL,'0122-best-time-to-buy-and-sell-stock-ii','2025-06-11 08:20:34','2025-06-16 14:37:06',1,4,false,NULL,'https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-ii/description/',40,3,'',false,NULL,true,'完成。',NULL),(123,'liweiwei1419','「力扣」第 142 题：环形链表 II（中等）','## 思路分析

本题的解法需要一些数学推导：在有环的链表上，有 3 个很重要的结点，它们是起始结点、环的入口结点、快慢指针相遇结点，它们把有环的链表分成了 3 个部分，**这 3 个结点分别是对应部分的起始结点**。**从一个部分的起始位置，走到另一个部分的起始位置，走的步数恰好等于这个部分结点的个数**。设从 `head` 到环入口的距离为 $ a $，环入口到相遇点的距离为 $ b $，相遇点到环入口的距离为 $ c $，如下图所示：

![image.png](https://suanfa8-1252206550.cos.ap-shanghai.myqcloud.com/suanfa8/temp-image2716484630375726971.png)


+ 当快慢指针相遇时：
    - 慢指针走了：$ a + b $步；
    - 快指针走了：$ a + b + n(b + c) $步，其中 $ n $ 是快指针在环中转的圈数。
+ 因为快指针速度是慢指针的 2 倍，所以：$ 2(a + b) = a + b + n(b + c) $；
+ 化简得：$ a = (n-1)(b + c) + c $，这意味着：从 `head` 到环入口的距离 $ a $，等于从相遇点走 $ c $ 步后再绕环 $ n-1 $ 圈。

因此，当两个指针 **分别从 `head` 和相遇点以相同速度出发时，必定会在环入口相遇**。这个方法虽然节约了空间，但是相应的时间复杂度也高了。

**参考代码**：

```java
public class Solution {

    public ListNode detectCycle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }

        ListNode slow = head;
        ListNode fast = head;
        // 第一阶段：判断是否有环
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) {
                // 第二阶段：寻找环入口
                ListNode ptr = head;
                while (ptr != slow) {
                    ptr = ptr.next;
                    slow = slow.next;
                }
                return ptr;
            }
        }
        return null;
    }

}
```

**复杂度分析**：

+ 时间复杂度：$ O(n) $，这里 $ n $ 是链表的长度；
+ 空间复杂度：$ O(1) $，只使用了常数个变量。

# 总结

快慢指针解决位置/环路问题，虚拟头结点解决边界处理问题。

','9',NULL,'0142-linked-list-cycle-ii','2025-06-11 09:15:01','2025-06-14 13:39:06',1,7,false,NULL,'https://leetcode.cn/problems/linked-list-cycle-ii/description/',32,6,'',false,NULL,true,'完成！','很有技巧的问题：快慢指针，记住解法。'),(63,'liweiwei1419','「力扣」第 283 题：移动零（简单）','## 思路分析

题目要求我们：保持非零元素的相对顺序，需要在原地进行，且在「进阶」中要求我们尽量减少完成的操作次数，所以其实不需要真的移动（交换），将遍历到的非零值依次覆盖到数组的起始位置，然后再把未覆盖的部分依次赋值成 0 就好。

**具体做法**：使用 `i` 进行遍历，使用 `j` 进行赋值，赋值完成以后，再将 `j` 后面的元素赋值为 0。

下面我们给出 2 版代码，第 1 版代码 `j` 指向了下一个要赋值的元素的位置，第 2 版代码 `j` 指向了最近赋值的元素的位置。循环不变量的定义我们作为注释写在代码中，在此就不赘述了。

**参考代码 1**：

```java
public class Solution {

    public void moveZeroes(int[] nums) {
        int n = nums.length;

        // 循环不变量：nums[0..j) != 0，nums[j..i) = 0
        int j = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] != 0) {
                nums[j] = nums[i];
                j++;
            }
        }

        for (int i = j; i < n; i++) {
            nums[i] = 0;
        }
    }
    
}
```

**复杂度分析：**

+ 时间复杂度：$ O(n) $，这里 $ n $ 是数组的长度，只需要遍历一次数组；
+ 空间复杂度：$ O(1) $，只使用了常数个变量。

**参考代码 2**：

```java
public class Solution {

    public void moveZeroes(int[] nums) {
        int n = nums.length;

        // 循环不变量：nums[0..j] != 0，nums(j..i) = 0
        int j = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] != 0) {
                j++;
                nums[j] = nums[i];
            }
        }

        for (int i = j + 1; i < n; i++) {
            nums[i] = 0;
        }
    }
    
}
```

**复杂度分析**：（同「参考代码 1」）。','3',NULL,'0283-move-zeroes','2025-06-10 14:34:12','2025-06-12 15:38:17',1,61,false,NULL,'https://leetcode.cn/problems/move-zeroes/description/',25,0,'',false,NULL,false,NULL,NULL);
-- public.comments DML
INSERT INTO "public"."comments" ("id","article_id","user_id","content","parent_comment_id","created_at","updated_at","is_deleted","is_guest","like_count","user_nickname","reply_count","reply_to_user_id","reply_to_comment_id") VALUES (78,19,1575406949798027265,'回复 2',76,'2025-06-24 23:17:47','2025-06-24 23:17:55',true,false,0,'李威威同学',0,1575406949798027265,76),(77,19,1575406949798027265,'回复 1。',76,'2025-06-24 23:17:28','2025-06-24 23:18:53',true,false,0,'李威威同学',0,1575406949798027265,76),(71,19,1575406949798027265,'111',70,'2025-06-24 16:30:25','2025-06-24 17:01:39',true,false,0,'李威威同学',0,1575406949798027265,70),(81,19,1575406949798027265,'回复 4',76,'2025-06-24 23:26:10','2025-06-24 23:26:18',true,false,0,'李威威同学',0,1575406949798027265,79),(72,19,1575406949798027265,'111',70,'2025-06-24 16:30:56','2025-06-24 17:01:48',true,false,0,'李威威同学',0,1575406949798027265,70),(79,19,1575406949798027265,'回复 2',76,'2025-06-24 23:18:47','2025-06-24 23:26:23',true,false,0,'李威威同学',0,1575406949798027265,76),(73,19,1575406949798027265,'12332',70,'2025-06-24 16:34:23','2025-06-24 17:02:32',true,false,0,'李威威同学',0,1575406949798027265,70),(80,19,1575406949798027265,'回复 3',76,'2025-06-24 23:26:01','2025-06-24 23:26:23',true,false,0,'李威威同学',0,1575406949798027265,76),(76,19,1575406949798027265,'评论 1 ',NULL,'2025-06-24 23:17:19','2025-06-24 23:26:23',true,false,0,'李威威同学',2,NULL,NULL),(69,19,1575406949798027265,'2222',63,'2025-06-24 16:30:10','2025-06-24 17:03:24',true,false,0,'李威威同学',0,1575406949798027265,63),(70,19,1575406949798027265,'1233333',NULL,'2025-06-24 16:30:20','2025-06-24 23:04:10',true,false,0,'李威威同学',0,NULL,NULL),(64,19,1575406949798027265,'经历的过程，一开始觉得很难，后来觉得就那么回事，有时间还是多学习一些别的东西，跟刷抖音一样，它本来就是很简单的东西。',63,'2025-06-23 22:51:45','2025-06-24 23:16:26',true,false,0,'李威威同学',0,1575406949798027265,63),(65,19,1575406949798027265,'二级回复。',63,'2025-06-24 16:25:25','2025-06-24 23:16:26',true,false,0,'李威威同学',0,1575406949798027265,64),(66,19,1575406949798027265,'一级回复。',63,'2025-06-24 16:25:41','2025-06-24 23:16:26',true,false,0,'李威威同学',0,1575406949798027265,63),(67,19,1575406949798027265,'一级回复。',63,'2025-06-24 16:29:08','2025-06-24 23:16:26',true,false,0,'李威威同学',0,1575406949798027265,63),(68,19,1575406949798027265,'1111',63,'2025-06-24 16:29:34','2025-06-24 23:16:26',true,false,0,'李威威同学',0,1575406949798027265,63),(63,19,1575406949798027265,'再加上学到什么地方为止。 123',NULL,'2025-06-23 22:50:53','2025-06-24 23:16:26',true,false,0,'李威威同学',0,NULL,NULL),(61,19,1575406949798027265,'加上在飞书里写的内容。',NULL,'2025-06-23 09:57:23','2025-06-24 23:16:39',true,false,0,'李威威同学',1,NULL,NULL),(82,19,1575406949798027265,'测试评论。',NULL,'2025-06-25 07:36:45','2025-06-25 08:22:56',true,false,0,'李威威同学',0,NULL,NULL),(75,19,1575406949798027265,'333333333',70,'2025-06-24 16:34:51','2025-06-25 08:22:58',true,false,0,'李威威同学',0,1575406949798027265,70),(74,19,1575406949798027265,'2222',70,'2025-06-24 16:34:45','2025-06-25 08:23:00',true,false,0,'李威威同学',0,1575406949798027265,70),(84,19,1575406949798027265,'第 2 条评论。修改评论。',NULL,'2025-06-25 10:31:14','2025-06-26 13:05:07',true,false,0,'李威威同学',0,NULL,NULL),(83,19,1575406949798027265,'第 1 条评论。',NULL,'2025-06-25 10:31:05','2025-06-26 13:05:10',true,false,0,'李威威同学',0,NULL,NULL),(85,19,1575406949798027265,'算法领域的细节很多，我们没法全部写出来，会尽量做到重点突出，太细枝末节的地方，留给读者。',NULL,'2025-07-01 16:26:16','2025-07-01 16:26:16',false,false,0,'李威威同学',0,NULL,NULL),(86,19,1575406949798027265,'记得添加对刷题的看法，刷题不等于工程，会刷题和会编程是两件事情。',NULL,'2025-07-16 01:27:51','2025-07-16 01:27:51',false,false,0,'李威威同学',0,NULL,NULL),(87,19,1575406949798027265,'测试留言 123。',NULL,'2025-07-27 03:09:19','2025-07-27 03:09:28',false,false,0,'李威威同学',0,NULL,NULL);
-- public.judge_detail DML
INSERT INTO "public"."judge_detail" ("id","submission_id","testcase_id","status","time_used","memory_used","is_deleted","created_at","updated_at") VALUES (1,1,1,'accepted',12,1024,false,'2025-07-18 16:50:45','2025-07-18 16:50:45'),(2,1,2,'accepted',13,1020,false,'2025-07-18 16:50:45','2025-07-18 16:50:45');
-- public.judge_results DML
INSERT INTO "public"."judge_results" ("id","submission_id","test_case_index","input","expected_output","actual_output","status","execution_time","memory_usage") VALUES (1,22,0,'2 7 11 15\n9','0 1','','FAILED',193,0),(2,22,1,'3 2 4\n6','1 2','','FAILED',195,0),(3,23,0,'2 7 11 15\n9','0 1','','FAILED',196,0),(4,23,1,'3 2 4\n6','1 2','','FAILED',378,0),(5,24,0,'2 7 11 15\n9','0 1','','FAILED',201,0),(6,24,1,'3 2 4\n6','1 2','','FAILED',408,0),(7,25,0,'2 7 11 15\n9','0 1','','FAILED',209,0),(8,25,1,'3 2 4\n6','1 2','','FAILED',199,0),(9,26,0,'2 7 11 15\n9','0 1','','FAILED',245,0),(10,26,1,'3 2 4\n6','1 2','','FAILED',483,0),(11,27,0,'2 7 11 15\n9','0 1','','FAILED',264,0),(12,27,1,'3 2 4\n6','1 2','','FAILED',253,0),(13,28,0,'2 7 11 15\n9','0 1','','FAILED',238,0),(14,28,1,'3 2 4\n6','1 2','','FAILED',192,0),(15,29,0,'2 7 11 15\n9','0 1','','FAILED',174,0),(16,29,1,'3 2 4\n6','1 2','','FAILED',214,0),(17,30,0,'2 7 11 15\n9','0 1','','FAILED',267,0),(18,30,1,'3 2 4\n6','1 2','','FAILED',187,0),(19,31,0,'2 7 11 15\n9','0 1','','FAILED',607,0),(20,31,1,'3 2 4\n6','1 2','','FAILED',220,0),(21,32,0,'2 7 11 15\n9','0 1','','FAILED',216,0),(22,32,1,'3 2 4\n6','1 2','','FAILED',185,0),(23,34,0,'2 7 11 15\n9','0 1','','FAILED',251,0),(24,34,1,'3 2 4\n6','1 2','','FAILED',222,0),(25,35,0,'2 7 11 15\n9','0 1','','FAILED',343,0),(26,35,1,'3 2 4\n6','1 2','','FAILED',255,0),(27,36,0,'2 7 11 15\n9','0 1','','FAILED',345,0),(28,36,1,'3 2 4\n6','1 2','','FAILED',164,0),(29,37,0,'2 7 11 15\n9','0 1','','FAILED',162,0),(30,37,1,'3 2 4\n6','1 2','','FAILED',157,0),(31,38,0,'2 7 11 15\n9','0 1','','FAILED',176,0),(32,38,1,'3 2 4\n6','1 2','','FAILED',149,0),(33,39,0,'2 7 11 15\n9','0 1','','FAILED',159,0),(34,39,1,'3 2 4\n6','1 2','','FAILED',174,0),(35,40,0,'2 7 11 15\n9','0 1','','FAILED',148,0),(36,40,1,'3 2 4\n6','1 2','','FAILED',167,0),(37,41,0,'2 7 11 15\n9','0 1','','FAILED',163,0),(38,41,1,'3 2 4\n6','1 2','','FAILED',174,0),(39,42,0,'2 7 11 15\n9','0 1','','FAILED',374,0),(40,42,1,'3 2 4\n6','1 2','','FAILED',147,0),(41,43,0,'2 7 11 15\n9','0 1','','FAILED',156,0),(42,43,1,'3 2 4\n6','1 2','','FAILED',162,0),(43,44,0,'2 7 11 15\n9','0 1','','FAILED',183,0),(44,44,1,'3 2 4\n6','1 2','','FAILED',154,0),(45,45,0,'2 7 11 15\n9','0 1','','FAILED',0,0),(46,45,1,'3 2 4\n6','1 2','','FAILED',0,0),(47,46,0,'2 7 11 15\n9','0 1','','FAILED',0,0),(48,46,1,'3 2 4\n6','1 2','','FAILED',0,0),(49,47,0,'2 7 11 15\n9','0 1','','FAILED',161,0),(50,47,1,'3 2 4\n6','1 2','','FAILED',155,0),(51,48,0,'2 7 11 15\n9','0 1','','FAILED',164,0),(52,48,1,'3 2 4\n6','1 2','','FAILED',166,0),(53,49,0,'2 7 11 15\n9','0 1','','FAILED',169,0),(54,49,1,'3 2 4\n6','1 2','','FAILED',182,0),(55,50,0,'2 7 11 15\n9','0 1','','FAILED',192,0),(56,50,1,'3 2 4\n6','1 2','','FAILED',157,0),(57,51,0,'2 7 11 15\n9','0 1','','FAILED',178,0),(58,51,1,'3 2 4\n6','1 2','','FAILED',156,0),(59,52,0,'2 7 11 15\n9','0 1','','FAILED',179,0),(60,52,1,'3 2 4\n6','1 2','','FAILED',160,0),(61,53,0,'2 7 11 15\n9','0 1','','FAILED',167,0),(62,53,1,'3 2 4\n6','1 2','','FAILED',166,0),(63,54,0,'2 7 11 15\n9','0 1','','FAILED',153,0),(64,54,1,'3 2 4\n6','1 2','','FAILED',156,0),(65,55,0,'2 7 11 15\n9','0 1','','FAILED',201,0),(66,55,1,'3 2 4\n6','1 2','','FAILED',156,0),(67,56,0,'2 7 11 15\n9','0 1','','FAILED',167,0),(68,56,1,'3 2 4\n6','1 2','','FAILED',215,0),(69,57,0,'2 7 11 15\n9','0 1','','FAILED',226,0),(70,57,1,'3 2 4\n6','1 2','','FAILED',158,0),(71,58,0,'2 7 11 15\n9','0 1','','FAILED',150,0),(72,58,1,'3 2 4\n6','1 2','','FAILED',147,0),(73,59,0,'2 7 11 15\n9','0 1','','FAILED',295,0),(74,59,1,'3 2 4\n6','1 2','','FAILED',185,0),(75,60,0,'2 7 11 15\n9','0 1','','FAILED',195,0),(76,60,1,'3 2 4\n6','1 2','','FAILED',183,0),(77,61,0,'2 7 11 15\n9','0 1','','FAILED',161,0),(78,61,1,'3 2 4\n6','1 2','','FAILED',176,0),(79,62,0,'2 7 11 15\\n9','0 1','','FAILED',277,0),(80,62,1,'3 2 4\\n6','1 2','','FAILED',175,0),(81,63,0,'1 2 1','2','','FAILED',254,0),(82,63,1,'1 8 6 2 5 4 8 3 7','49','','FAILED',168,0),(83,63,2,'1 1','1','','FAILED',170,0),(84,63,3,'4 3 2 1 4','16','','FAILED',137,0),(85,64,0,'3 2 4
6','1 2','','FAILED',143,0),(86,64,1,'2 7 11 15 
9','0 1','','FAILED',213,0),(87,65,0,'3 2 4
6','1 2','','FAILED',146,0),(88,65,1,'2 7 11 15 
9','0 1','','FAILED',151,0),(89,66,0,'3 2 4
6','1 2','','FAILED',143,0),(90,66,1,'2 7 11 15 
9','0 1','','FAILED',190,0),(91,67,0,'3 2 4
6','1 2','','FAILED',189,0),(92,67,1,'2 7 11 15 
9','0 1','','FAILED',143,0),(93,68,0,'3 2 4
6','1 2','2 3','FAILED',324,0),(94,68,1,'2 7 11 15 
9','0 1','1 2','FAILED',237,0),(95,69,0,'3 2 4
6','2 3','2 3','PASSED',310,0),(96,69,1,'2 7 11 15 
9','1 2','1 2','PASSED',170,0),(97,70,0,'3 2 4
6','2 3','2 3','PASSED',246,0),(98,70,1,'2 7 11 15 
9','1 2','1 2','PASSED',277,0),(99,71,0,'3 2 4
6','2 3','2 3','PASSED',309,0),(100,71,1,'2 7 11 15 
9','1 2','1 2','PASSED',283,0);
INSERT INTO "public"."judge_results" ("id","submission_id","test_case_index","input","expected_output","actual_output","status","execution_time","memory_usage") VALUES (101,72,0,'3 2 4
6','2 3','2 3','PASSED',251,0),(102,72,1,'2 7 11 15 
9','1 2','1 2','PASSED',188,0),(103,73,0,'3 2 4
6','2 3','1 2','FAILED',197,0),(104,73,1,'2 7 11 15 
9','1 2','0 1','FAILED',283,0),(105,74,0,'3 2 4
6','2 3','1 2','FAILED',207,0),(106,74,1,'2 7 11 15 
9','1 2','0 1','FAILED',218,0),(107,75,0,'3 2 4
6','2 3','2 3','PASSED',181,0),(108,75,1,'2 7 11 15 
9','1 2','1 2','PASSED',189,0),(109,76,0,'3 2 4
6','2 3','2 3','PASSED',258,0),(110,76,1,'2 7 11 15 
9','1 2','1 2','PASSED',185,0),(111,77,0,'3 2 4
6','2 3','1 2','FAILED',279,0),(112,77,1,'2 7 11 15 
9','1 2','0 1','FAILED',214,0),(113,78,0,'3 2 4
6','2 3','2 3','PASSED',243,0),(114,78,1,'2 7 11 15 
9','1 2','1 2','PASSED',234,0),(115,79,0,'3 2 4
6','2 3','2 3','PASSED',189,0),(116,79,1,'2 7 11 15 
9','1 2','1 2','PASSED',310,0),(117,80,0,'3 2 4
6','2 3','1 2','FAILED',264,0),(118,80,1,'2 7 11 15 
9','1 2','0 1','FAILED',259,0),(119,81,0,'3 2 4
6','2 3','1 3','FAILED',342,0),(120,81,1,'2 7 11 15 
9','1 2','0 2','FAILED',237,0),(121,82,0,'3 2 4
6','2 3','1 3','FAILED',210,0),(122,82,1,'2 7 11 15 
9','1 2','0 2','FAILED',197,0),(123,83,0,'3 2 4
6','2 3','2 3','PASSED',230,0),(124,83,1,'2 7 11 15 
9','1 2','1 2','PASSED',216,0),(125,84,0,'3 2 4
6','2 3','2 3','PASSED',213,0),(126,84,1,'2 7 11 15 
9','1 2','1 2','PASSED',279,0),(127,85,0,'3 2 4
6','2 3','1 3','FAILED',255,0),(128,85,1,'2 7 11 15 
9','1 2','0 2','FAILED',272,0),(129,86,0,'3 2 4
6','2 3','1 3','FAILED',237,0),(130,86,1,'2 7 11 15 
9','1 2','0 2','FAILED',250,0),(131,87,0,'3 2 4
6','2 3','','FAILED',183,0),(132,87,1,'2 7 11 15 
9','1 2','','FAILED',172,0),(133,88,0,'3 2 4
6','2 3','2 3','PASSED',221,0),(134,88,1,'2 7 11 15 
9','1 2','1 2','PASSED',224,0),(135,89,0,'3 2 4
6','2 3','1 3','FAILED',252,0),(136,89,1,'2 7 11 15 
9','1 2','0 2','FAILED',213,0),(137,90,0,'3 2 4
6','2 3','2 3','PASSED',268,0),(138,90,1,'2 7 11 15 
9','1 2','1 2','PASSED',258,0),(139,91,0,'3 2 4
6','2 3','2 3','PASSED',247,0),(140,91,1,'2 7 11 15 
9','1 2','1 2','PASSED',177,0),(141,92,0,'3 2 4
6','2 3','1 3','FAILED',208,0),(142,92,1,'2 7 11 15 
9','1 2','0 2','FAILED',223,0),(143,93,0,'3 2 4
6','2 3','2 3','PASSED',189,0),(144,93,1,'2 7 11 15 
9','1 2','1 2','PASSED',185,0),(145,94,0,'3 2 4
6','2 3','2 3','PASSED',227,0),(146,94,1,'2 7 11 15 
9','1 2','1 2','PASSED',262,0),(147,95,0,'3 2 4
6','2 3','2 3','PASSED',206,0),(148,95,1,'2 7 11 15 
9','1 2','1 2','PASSED',195,0),(149,97,0,'3 2 4
6','2 3','','FAILED',179,0),(150,97,1,'2 7 11 15 
9','1 2','','FAILED',190,0),(151,98,0,'3 2 4
6','2 3','2 3','PASSED',230,0),(152,98,1,'2 7 11 15 
9','1 2','1 2','PASSED',180,0),(153,99,0,'3 2 4
6','2 3','2 3','PASSED',265,0),(154,99,1,'2 7 11 15 
9','1 2','1 2','PASSED',265,0),(155,100,0,'3 2 4
6','2 3','2 3','PASSED',188,0),(156,100,1,'2 7 11 15 
9','1 2','1 2','PASSED',250,0),(157,101,0,'3 2 4
6','2 3','2 3','PASSED',202,0),(158,101,1,'2 7 11 15 
9','1 2','1 2','PASSED',184,0),(159,102,0,'3 2 4
6','2 3','1 3','FAILED',199,0),(160,102,1,'2 7 11 15 
9','1 2','0 2','FAILED',205,0),(161,103,0,'3 2 4
6','2 3','2 3','PASSED',271,0),(162,103,1,'2 7 11 15 
9','1 2','1 2','PASSED',255,0),(163,96,0,'3 2 4
6','2 3','','FAILED',167,0),(164,96,1,'2 7 11 15 
9','1 2','','FAILED',266,0),(165,104,0,'3 2 4
6','2 3','','FAILED',549,0),(166,104,1,'2 7 11 15 
9','1 2','','FAILED',580,0),(167,105,0,'3 2 4
6','2 3','','FAILED',515,0),(168,105,1,'2 7 11 15 
9','1 2','','FAILED',595,0),(169,107,0,'3 2 4
6','2 3','','FAILED',542,0),(170,107,1,'2 7 11 15 
9','1 2','','FAILED',651,0),(171,108,0,'3 2 4
6','2 3','','TIME_LIMIT_EXCEEDED',0,0),(172,108,1,'2 7 11 15 
9','1 2','','TIME_LIMIT_EXCEEDED',0,0),(173,106,0,'3 2 4
6','2 3','','FAILED',469,0),(174,106,1,'2 7 11 15 
9','1 2','','FAILED',473,0),(175,109,0,'3 2 4
6','2 3','2 3','PASSED',767,0),(176,109,1,'2 7 11 15 
9','1 2','1 2','PASSED',786,0),(177,110,0,'3 2 4
6','2 3','2 3','PASSED',736,0),(178,110,1,'2 7 11 15 
9','1 2','1 2','PASSED',650,0),(179,111,0,'3 2 4
6','2 3','2 3','PASSED',825,0),(180,111,1,'2 7 11 15 
9','1 2','1 2','PASSED',744,0),(181,112,0,'3 2 4
6','2 3','2 3','PASSED',680,0),(182,112,1,'2 7 11 15 
9','1 2','1 2','PASSED',744,0),(183,113,0,'3 2 4
6','2 3','2 3','PASSED',231,0),(184,113,1,'2 7 11 15 
9','1 2','1 2','PASSED',260,0),(185,114,0,'3 2 4
6','2 3','2 3','PASSED',277,0),(186,114,1,'2 7 11 15 
9','1 2','1 2','PASSED',386,0),(187,115,0,'3 2 4
6','2 3','2 3','PASSED',218,0),(188,115,1,'2 7 11 15 
9','1 2','1 2','PASSED',218,0),(189,116,0,'3 2 4
6','2 3','2 3','PASSED',237,0),(190,116,1,'2 7 11 15 
9','1 2','1 2','PASSED',273,0),(191,117,0,'3 2 4
6','2 3','2 3','PASSED',313,0),(192,117,1,'2 7 11 15 
9','1 2','1 2','PASSED',224,0),(193,118,0,'3 2 4
6','2 3','2 3','PASSED',390,0),(194,118,1,'2 7 11 15 
9','1 2','1 2','PASSED',290,0),(195,119,0,'3 2 4
6','2 3','2 3','PASSED',252,0),(196,119,1,'2 7 11 15 
9','1 2','1 2','PASSED',261,0),(197,120,0,'3 2 4
6','2 3','2 3','PASSED',321,0),(198,120,1,'2 7 11 15 
9','1 2','1 2','PASSED',210,0),(199,121,0,'3 2 4
6','2 3','2 3','PASSED',276,0),(200,121,1,'2 7 11 15 
9','1 2','1 2','PASSED',246,0);
INSERT INTO "public"."judge_results" ("id","submission_id","test_case_index","input","expected_output","actual_output","status","execution_time","memory_usage") VALUES (201,122,0,'3 2 4
6','2 3','2 3','PASSED',258,0),(202,123,0,'3 2 4
6','2 3','2 3','PASSED',245,0),(203,122,1,'2 7 11 15 
9','1 2','1 2','PASSED',262,0),(204,123,1,'2 7 11 15 
9','1 2','1 2','PASSED',283,0),(205,124,0,'3 2 4
6','2 3','2 3','PASSED',238,0),(206,124,1,'2 7 11 15 
9','1 2','1 2','PASSED',222,0),(207,125,0,'3 2 4
6','2 3','','FAILED',184,0),(208,125,1,'2 7 11 15 
9','1 2','','FAILED',194,0),(209,126,0,'3 2 4
6','2 3','','FAILED',190,0),(210,126,1,'2 7 11 15 
9','1 2','','FAILED',188,0),(211,127,0,'3 2 4
6','2 3','2 3','PASSED',253,0),(212,127,1,'2 7 11 15 
9','1 2','1 2','PASSED',250,0),(213,128,0,'3 2 4
6','2 3','2 3','PASSED',279,0),(214,128,1,'2 7 11 15 
9','1 2','1 2','PASSED',241,0),(215,129,0,'3 2 4
6','2 3','2 3','PASSED',270,0),(216,129,1,'2 7 11 15 
9','1 2','1 2','PASSED',274,0),(217,130,0,'3 2 4
6','2 3','2 3','PASSED',205,0),(218,130,1,'2 7 11 15 
9','1 2','1 2','PASSED',255,0),(219,131,0,'3 2 4
6','2 3','2 3','PASSED',243,0),(220,131,1,'2 7 11 15 
9','1 2','1 2','PASSED',262,0),(221,132,0,'3 2 4
6','2 3','2 3','PASSED',219,0),(222,132,1,'2 7 11 15 
9','1 2','1 2','PASSED',273,0),(223,133,0,'3 2 4
6','2 3','2 3','PASSED',264,0),(224,133,1,'2 7 11 15 
9','1 2','1 2','PASSED',267,0),(225,134,0,'3 2 4
6','2 3','1 3','FAILED',205,0),(226,134,1,'2 7 11 15 
9','1 2','0 2','FAILED',193,0),(227,135,0,'3 2 4
6','2 3','2 3','PASSED',259,0),(228,135,1,'2 7 11 15 
9','1 2','1 2','PASSED',201,0),(229,136,0,'3 2 4
6','2 3','2 3','PASSED',292,0),(230,136,1,'2 7 11 15 
9','1 2','1 2','PASSED',270,0),(231,138,0,'3 2 4
6','2 3','','FAILED',592,0),(232,138,1,'2 7 11 15 
9','1 2','','FAILED',530,0),(233,140,0,'3 2 4
6','2 3','2 3','PASSED',734,0),(234,140,1,'2 7 11 15 
9','1 2','1 2','PASSED',755,0),(235,143,0,'3 2 4
6','2 3','2 3','PASSED',741,0),(236,143,1,'2 7 11 15 
9','1 2','1 2','PASSED',791,0),(237,145,0,'[1]\n0','0','','FAILED',676,0),(238,145,1,'1 3 5 6
5','2','2','PASSED',642,0),(239,145,2,'1 3 5 6
2','1','1','PASSED',655,0),(240,145,3,'1 3 5 6
0','0','0','PASSED',660,0),(241,145,4,'1 3 5 6
7','4','4','PASSED',626,0),(242,146,0,'[1]\n0','0','','FAILED',571,0),(243,146,1,'1 3 5 6
5','2','','TIME_LIMIT_EXCEEDED',0,0),(244,146,2,'1 3 5 6
2','1','1','PASSED',641,0),(245,146,3,'1 3 5 6
0','0','0','PASSED',652,0),(246,146,4,'1 3 5 6
7','4','4','PASSED',613,0),(247,147,0,'[1]\n0','0','','FAILED',580,0),(248,147,1,'1 3 5 6
5','2','2','PASSED',587,0),(249,147,2,'1 3 5 6
2','1','1','PASSED',560,0),(250,147,3,'1 3 5 6
0','0','0','PASSED',649,0),(251,147,4,'1 3 5 6
7','4','4','PASSED',609,0),(252,148,0,'[1]\n0','0','','FAILED',637,0),(253,148,1,'1 3 5 6
5','2','2','PASSED',629,0),(254,148,2,'1 3 5 6
2','1','1','PASSED',563,0),(255,148,3,'1 3 5 6
0','0','0','PASSED',669,0),(256,148,4,'1 3 5 6
7','4','4','PASSED',714,0),(257,149,0,'1 3 5 6
5','2','2','PASSED',614,0),(258,149,1,'1 3 5 6
2','1','1','PASSED',549,0),(259,149,2,'1 3 5 6
0','0','0','PASSED',618,0),(260,149,3,'1 3 5 6
7','4','4','PASSED',584,0),(261,149,4,'1
0','0','0','PASSED',637,0),(262,150,0,'1 3 5 6
5','2','2','PASSED',628,0),(263,150,1,'1 3 5 6
2','1','1','PASSED',633,0),(264,150,2,'1 3 5 6
0','0','0','PASSED',632,0),(265,150,3,'1 3 5 6
7','4','4','PASSED',632,0),(266,150,4,'1
0','0','0','PASSED',643,0),(267,151,0,'1 3 5 6
5','2','2','PASSED',613,0),(268,151,1,'1 3 5 6
2','1','1','PASSED',705,0),(269,151,2,'1 3 5 6
0','0','0','PASSED',614,0),(270,151,3,'1 3 5 6
7','4','4','PASSED',637,0),(271,151,4,'1
0','0','0','PASSED',628,0),(272,152,0,'3 2 4
6','2 3','输入格式错误，请输入两个数字，用空格分隔','FAILED',651,0),(273,152,1,'2 7 11 15 
9','1 2','输入格式错误，请输入两个数字，用空格分隔','FAILED',596,0),(274,153,0,'3 2 4
6','2 3','输入格式错误，请输入两个数字，用空格分隔','FAILED',644,0),(275,153,1,'2 7 11 15 
9','1 2','输入格式错误，请输入两个数字，用空格分隔','FAILED',679,0),(276,154,0,'3 2 4
6','2 3','2 3','PASSED',843,0),(277,154,1,'2 7 11 15 
9','1 2','1 2','PASSED',756,0),(278,155,0,'5
5','0','0','PASSED',697,0),(279,155,1,'-1 0 3 5 9 12
9','4','4','PASSED',636,0),(280,155,2,'-1 0 3 5 9 12
2','-1','-1','PASSED',666,0);
-- public.problem DML
INSERT INTO "public"."problem" ("id","title","description","input_description","output_description","sample_input","sample_output","hint","time_limit","memory_limit","difficulty","is_deleted","created_at","updated_at") VALUES (35,'搜索插入位置','给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。','排序整数数组 nums，整数 target','目标值的索引或插入位置','[1,3,5,6]\n5','2',NULL,1000,128,'Easy',false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(1,'两数之和','给定一个整数数组 `nums` 和一个目标值 `target`，请你在该数组中找出和为目标值的那两个整数，并返回它们的数组下标。','输入包含两行，第一行为数组元素，第二行为目标值。','输出为两个下标，空格分隔。','2 7 11 15\n9','0 1','可以假设每种输入只会对应一个答案。',1000,65536,'easy',false,'2025-07-18 16:50:45','2025-07-18 16:50:45'),(11,'盛最多水的容器','给定一个长度为 `n` 的整数数组 `height`。有 `n` 条垂线，第 `i` 条线的两个端点是 `(i, 0)` 和 `(i, height[i])`。找出其中的两条线，使得它们与 `x` 轴共同构成的容器可以容纳最多的水。','整数数组 height','可以容纳的最大水量','[1,8,6,2,5,4,8,3,7]','49',NULL,1000,128,'Medium',false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(704,'二分查找','给定一个 `n` 个元素有序的（升序）整型数组 `nums` 和一个目标值 `target`，写一个函数搜索 `nums` 中的 `target`，如果目标值存在返回下标，否则返回 `-1`。','有序整数数组 nums，整数 target','目标值的下标或 -1','[-1,0,3,5,9,12]\n9','4',NULL,1000,128,'Easy',false,'2025-07-18 18:31:48','2025-07-18 18:31:48');
-- public.suanfa8_user DML
INSERT INTO "public"."suanfa8_user" ("id","username","password","nickname","avatar","email","role_id","homepage","is_deleted","created_at","updated_at") VALUES (1583024819105763329,'mockup','cf2ec1886c194b2c9dd02384bf833b15','mock',NULL,'mockup@bccto.cc',0,NULL,false,'2022-10-20 17:18:23','2022-10-20 17:18:23'),(1583257437445361665,'apprenticeDYC','c8786e2ec3f74ead2f7c2c9b7a58f56b','apppretice',NULL,'dyc21032009@gmail.com',0,NULL,false,'2022-10-21 08:42:43','2022-10-21 08:42:43'),(1583349103997030402,'zmxy','7044810bc040101988d6000545f2cd17','tydxm',NULL,'1786610837@qq.com',0,NULL,false,'2022-10-21 14:46:58','2022-10-21 14:46:58'),(1584175284933693441,'xijinian','8a684636ad2801a1521dcd08eb957c07','西纪年',NULL,'xijinian@duck.com',0,NULL,false,'2022-10-23 21:29:55','2022-10-23 21:29:55'),(1584199131200294914,'zzh','618346c5a52b81aeddef6ecc925b7101','Lion',NULL,'2486722561@qq.com',0,NULL,false,'2022-10-23 23:04:41','2022-10-23 23:04:41'),(1585582090855714817,'zhoumiao','b51816379b85f181a3e16534de21103b','汉寿周杰伦',NULL,'zhoumiao48@gmail.com',0,NULL,false,'2022-10-27 18:40:04','2022-10-27 18:40:04'),(1586348014663827458,'zeng','4060e9407425082b880a8f944ed6b488','zeng',NULL,'3553642457@qq.com',0,NULL,false,'2022-10-29 21:23:34','2022-10-29 21:23:34'),(1586634319020883970,'newcici7777','f4a45ee7154d59bdc85f19f05cad3fc5','cici',NULL,'newcici7777@gmail.com',0,NULL,false,'2022-10-30 16:21:15','2022-10-30 16:21:15'),(1586976132973920257,'1123391258','447f0fc2469ab8ea542ea7038d048ace','wdgz',NULL,'1123391258@qq.com',0,NULL,false,'2022-10-31 14:59:29','2022-10-31 14:59:29'),(1589894590417678338,'XuBino','487918a35915c4ea0b16bcfb33103424','XuBino',NULL,'1198265517@qq.com',0,NULL,false,'2022-11-08 16:16:24','2022-11-08 23:27:00'),(1590175431995764737,'accee','ec7b53ced5fcef7d43a62d3e09a24384','123eee',NULL,'2825787448@qq.com',0,NULL,false,'2022-11-09 10:52:22','2022-11-09 10:52:22'),(1590883513335885825,'gypsy','cab8943e341c55d3d7fd0d9d80651d5d','gypsy',NULL,'2411583192@qq.com',0,NULL,false,'2022-11-11 09:46:01','2022-11-11 09:46:01'),(1591220892332535810,'Tzz','d7a5cf26d0e9649e89b3dc54b36e6f8d','Tzz',NULL,'ziqima11@163.com',0,NULL,false,'2022-11-12 08:06:39','2022-11-12 08:06:39'),(1591644029926846466,'tengzhiyong','1754a05a114a5ad7745f9634cbc0459b','刷题农民工',NULL,'tengzhiyongdgqb@gmail.com',0,NULL,false,'2022-11-13 12:08:03','2022-11-13 12:08:03'),(1593542060217544705,'dantemg','ac9c4c2984b1ce681144eef9a772b016','dante',NULL,'2357711865@qq.com',0,NULL,false,'2022-11-18 17:50:08','2022-11-18 17:50:08'),(1593638981032554498,'naivecoder','4b598df090f8ed947d2f79e619dcb1b0','naivecoder',NULL,'540209474@qq.com',0,NULL,false,'2022-11-19 00:15:16','2022-11-19 00:15:16'),(1594686445202255873,'aszluozh','bc7a3df85eee5bd584c9dfc0433573d8','Esalindochica',NULL,'2390545586@qq.com',0,NULL,false,'2022-11-21 21:37:31','2022-11-21 21:37:31'),(1595210167369674754,'wozhenbang','8a569587cdab78a97a7aca018506e0cd','okkk',NULL,'wozhenbang@qq.com',0,NULL,false,'2022-11-23 08:18:36','2022-11-23 08:18:36'),(1596032321040494593,'huajunatuk','d75d00408641a988ebc9f3a529673f9c','huajunatuk',NULL,'huajunatuk@hotmail.com',0,NULL,false,'2022-11-25 14:45:33','2022-11-25 14:45:33'),(1596753323739394050,'prec','0bf97de920a6983c247e5f311fd9d26a','mcc',NULL,'L_hire@163.com',0,NULL,false,'2022-11-27 14:30:33','2022-12-06 09:58:38'),(1598063553349758977,'xiaorang','2487ea67ed8fd12f57161941f535048b','xiaorang',NULL,'15019474951@163.com',0,NULL,false,'2022-12-01 05:16:56','2022-12-01 05:16:56'),(1598648197057163266,'chasing1874','157fdcec606965ed323006545abbee89','柴柴快乐',NULL,'314888536@qq.com',0,NULL,false,'2022-12-02 20:00:06','2022-12-02 20:00:06'),(1598709890420387841,'sepiggy','2a336fe689e3e114b5b71036de9188a3','sepiggy',NULL,'jms1209@qq.com',0,NULL,false,'2022-12-03 00:05:15','2022-12-03 00:05:15'),(1599371148291289089,'Matthew','e4b5b7b0dc6f99c8bf916dae93634299','Matthew',NULL,'771901015@qq.com',0,NULL,false,'2022-12-04 19:52:51','2022-12-04 19:52:51'),(1600126526272647169,'lovecoding','168da0815028d61e3477ad6cd0c89db9','',NULL,'NerveSurrender666@163.com',0,NULL,false,'2022-12-06 21:54:27','2022-12-06 21:54:27'),(1600306891079626753,'lihu','a080d20dc2a99bef5f38874a357d332a','lihu',NULL,'1050417395@qq.com',0,NULL,false,'2022-12-07 09:51:10','2022-12-07 09:51:10'),(1601590110928445442,'xiaoao','8798c1095ec4315089fadbadff36a788','xiaoao',NULL,'3189137314@qq.com',0,NULL,false,'2022-12-10 22:50:13','2022-12-10 22:50:13'),(1608314546637447169,'小张爱编程','3bec9b82074bccaf625168df6797a2d2','小张爱编程',NULL,'1968664100@qq.com',0,NULL,false,'2022-12-29 12:10:44','2022-12-29 12:10:44'),(1609822611744432129,'demin','d32b531e5b966ec1133c67efc10752e6','转不过眼',NULL,'364522127@qq.com',0,NULL,false,'2023-01-02 16:03:14','2023-01-02 16:03:14'),(1610489690986323969,'kakaxym@126.com','5db1e7d77a8660c08f29dcd1311c3388','老白',NULL,'kakaxym@126.com',0,NULL,false,'2023-01-04 12:13:58','2023-01-04 12:13:58'),(1611233867307098113,'qcx','dbef2216f17f5e8ed76a9a48425a82e0','q',NULL,'2502715025@qq.com',0,NULL,false,'2023-01-06 13:31:04','2023-01-06 13:31:04'),(1612389535040872449,'卖老头儿的炸串','fc91845520fb15309779d12b8eabdb44','',NULL,'1824067305@qq.com',0,NULL,false,'2023-01-09 18:03:17','2023-01-09 18:03:17'),(1612455861973360641,'ryanus','e7e11a6da9c4c0b169a8605ae28e3c5a','Ryan',NULL,'ryan09@foxmail.com',0,NULL,false,'2023-01-09 22:26:50','2023-01-09 22:26:50'),(1616056320927670274,'Echo','bc710d17e99a0c3ae667fe2185c26e6b','Echo',NULL,'1361680482@qq.com',0,NULL,false,'2023-01-19 20:53:46','2023-01-19 20:53:46'),(1616323974368272385,'cos43','23eb9542529cc372e67bac9545939bbd','',NULL,'1140182402@qq.com',0,NULL,false,'2023-01-20 14:37:20','2023-01-20 14:37:20'),(1616842975569715202,'zihehuang','a18765fd0dcf1d4ce0b927eae790a0fe','',NULL,'676814617@qq.com',0,NULL,false,'2023-01-22 00:59:40','2023-01-22 00:59:40'),(1619629058908954625,'曲尽音静','bb70c91afff731c6ba0bd7d02ee29f44','',NULL,'qujinyinjing@126.com',0,NULL,false,'2023-01-29 17:30:34','2023-01-29 17:30:34'),(1619860774101655553,'why','631d3ec7728b156cf2a767ce51a20f60','why',NULL,'1585049082@qq.com',0,NULL,false,'2023-01-30 08:51:19','2023-01-30 08:51:19'),(1620394641539670017,'daphne','b485ff8b87fa8378511c2bd34905bad5','堅果',NULL,'daphne61221@gmail.com',0,NULL,false,'2023-01-31 20:12:43','2023-01-31 20:12:43'),(1623289905854226434,'lisnkin','0f5f8cb903646abda2d899d34943362c','',NULL,'lisnkin@foxmail.com',0,NULL,false,'2023-02-08 19:57:27','2023-02-08 19:57:27'),(1623944768862756865,'DCyan','6a8ebba7898cfa5ea84899203c4cfc18','CrescentLove',NULL,'markdowndir@foxmail.com',0,NULL,false,'2023-02-10 15:19:39','2023-02-10 15:19:39'),(1627081888494198786,'lelih','0aafe6f100d07c56ced4db6e585b09b6','',NULL,'hslscarlett@gmail.com',0,NULL,false,'2023-02-19 07:05:27','2023-02-19 07:05:27'),(1627291382201393153,'Lananyangyang','4e26c410400ce7d2b55f69801129db7c','',NULL,'1337540561@qq.com',0,NULL,false,'2023-02-19 20:57:54','2023-02-19 20:57:54'),(1627584789712936962,'guoshuyi','410e94556c0329487632f08cb8c06ae7','菜鸡',NULL,'864263681@qq.com',0,NULL,false,'2023-02-20 16:23:48','2023-02-20 16:23:48'),(1630524445702168577,'LilGeorge13','e6ed25f879b466a85c02d6bae093db93','敏敏特穆尔',NULL,'wangzhihai@bupt.edu.cn',0,NULL,false,'2023-02-28 19:04:56','2023-02-28 19:04:56'),(1631133298605105153,'tao_mi','c535bc72a9e652369762253e8b8f2f3c','',NULL,'minjiatao@gmail.com',0,NULL,false,'2023-03-02 11:24:18','2023-03-02 11:24:18'),(1632312142447849474,'小枫叶','7f37123e5d833976b9bb65e2e9710b8a','',NULL,'536744031@qq.com',0,NULL,false,'2023-03-05 17:28:36','2023-03-05 17:28:36'),(1634392280656326657,'wbpounds','c6b1149d8b24d798d4c9aa4d6aeca372','王保保',NULL,'wbpounds@163.com',0,NULL,false,'2023-03-11 11:14:20','2023-03-11 11:14:20'),(1635489329854361601,'475031724@qq.com','3a80997d9a578190ef10689238a6f49d','xp',NULL,'475031724@qq.com',0,NULL,false,'2023-03-14 11:53:37','2023-03-14 11:53:37'),(1635962989702623233,'326418118','b47b40ff579892022ee4b587d185b8b5','326418118',NULL,'326418118@qq.com',0,NULL,false,'2023-03-15 19:15:46','2023-03-15 19:15:46'),(1637057698307059714,'kasalocc','0a553c3861b284324a240050ad97b39e','kasalocc',NULL,'2352052121@qq.com',0,NULL,false,'2023-03-18 19:45:45','2023-03-18 19:45:45'),(1637448177838272514,'FFIT','003bc673fa1460d3f6f7f425ccbc971e','FFIT',NULL,'1980114332@qq.com',0,NULL,false,'2023-03-19 21:37:23','2023-03-19 21:37:23'),(1638041517923315713,'Caijet','07bdee52af8a92ff73dedef6775464cf','铁甲十三卫',NULL,'caijet@qq.com',0,NULL,false,'2023-03-21 12:55:06','2023-03-21 12:55:06'),(1640181441124446209,'1442804649@qq.com','491590c967a0f8818aa62e0188583a91','txj',NULL,'1442804649@qq.com',0,NULL,false,'2023-03-27 10:38:23','2023-03-27 10:38:23'),(1642710507010596866,'metachen','1c517a42117aab5d46148910299254e5','meta',NULL,'metachen.com@gmail.com',0,NULL,false,'2023-04-03 10:08:00','2023-04-03 10:08:00'),(1642710507052539905,'metachen','1c517a42117aab5d46148910299254e5','meta',NULL,'metachen.com@gmail.com',0,NULL,false,'2023-04-03 10:08:00','2023-04-03 10:08:00'),(1642710507325169665,'metachen','1c517a42117aab5d46148910299254e5','meta',NULL,'metachen.com@gmail.com',0,NULL,false,'2023-04-03 10:08:00','2023-04-03 10:08:00'),(1645616140760199170,'一只硬核少年','d978be2a918938ecd2fd073b99a9e5a2','',NULL,'2251985371@qq.com',0,NULL,false,'2023-04-11 10:33:57','2023-04-11 10:33:57'),(1646330241362767874,'iyue','4913ac75b2cb6280ce7a025555e7aea9','守护',NULL,'chunpeng.iyue@gmail.com',0,NULL,false,'2023-04-13 09:51:32','2023-04-13 09:51:32'),(1647269527771754497,'vannvan','5883e5211de32a87393f632dcc480217','',NULL,'862670198@qq.com',0,NULL,false,'2023-04-16 00:03:55','2023-04-16 00:03:55'),(1647934117480312833,'Zhiyang','cf4f833c01ef4b9e5939be4ad55a4988','LZY',NULL,'1424936399@qq.com',0,NULL,false,'2023-04-17 20:04:45','2023-04-17 20:04:45'),(1654839301066272770,'一江夜雨','c61f18bb7ea5964fbbfc2b3ad254d37b','',NULL,'zzbillcumt@126.com',0,NULL,false,'2023-05-06 21:23:29','2023-05-06 21:23:29'),(1656134393588690946,'zhangkui','1dc6a691539eda793c19ebec28360ef6','猛禽不是鸟',NULL,'lyzk163@gmail.com',0,NULL,false,'2023-05-10 11:09:44','2023-05-10 11:09:44'),(1656243656814309377,'非典型性学渣','5f2797062da4ab63503c52d537ec89f9','非典型性学渣',NULL,'18616380408@163.com',0,NULL,false,'2023-05-10 18:23:54','2023-05-10 18:23:54'),(1656282280574398465,'妮妮lll','4831a12947d6d73bb58bc6f80af760b1','',NULL,'2676052685@qq.com',0,NULL,false,'2023-05-10 20:57:23','2023-05-10 20:57:23'),(1656582569491771394,'da_yin','274ee67c078776dbef4334f03e1add5c','da_yin',NULL,'1101092707@qq.com',0,NULL,false,'2023-05-11 16:50:37','2023-05-11 16:50:37'),(1657732042863489026,'cet','fab836e81a534e9d22e46145fd0b49aa','烈火',NULL,'309521305@qq.com',0,NULL,false,'2023-05-14 20:58:13','2023-05-14 20:58:13'),(1660590072936345602,'guyuan','fce22a6140de9be99bdc0a9b70b4a628','故渊zhang','c9c77960-f6b6-40fd-abd2-f324aa77cca1.jpg','3116367903@qq.com',0,NULL,false,'2023-05-22 18:15:00','2023-05-22 18:15:38'),(1662321856812232705,'西门吹雪','4b3d7b5aa7c9ca056ebb437677a724f1','',NULL,'1297857842@qq.com',0,NULL,false,'2023-05-27 12:56:30','2023-05-27 12:56:30'),(1662420026493841409,'lanananyangyang','52036dd291ba3506d51081458d91c2b6','',NULL,'18310789149@163.com',0,NULL,false,'2023-05-27 19:26:35','2023-05-27 19:26:35'),(1663473938122485761,'2134104774@qq.com','84b48d57e452920fa731f7b7d3c5404f','',NULL,'2134104774@qq.com',0,NULL,false,'2023-05-30 17:14:27','2023-05-30 17:14:27'),(1664445767330902017,'limq0755@163.com','f8b91ee866e2f60828ecd58c30215d0e','',NULL,'limq0755@163.com',0,NULL,false,'2023-06-02 09:36:09','2023-06-02 09:36:09'),(1664483085085388801,'wang189074396','13087a91eb2e171a8708e084aeb459f0','随风',NULL,'1185349505@qq.com',0,NULL,false,'2023-06-02 12:04:27','2023-06-02 12:04:27'),(1664782852877266945,'liwei_sx','bb49ad781b0db509817f74ba42b134e7','',NULL,'liwei_sx@qq.com',0,NULL,false,'2023-06-03 07:55:37','2023-06-03 07:55:37'),(1665631323960193025,'黎书丿','6ba8d1a055059caa753ed130abef8c07','',NULL,'1952340974@qq.com',0,NULL,false,'2023-06-05 16:07:08','2023-06-05 16:07:08'),(1665977274600075266,'lhzou','511b3aa047e8671857aec4b09636ae72','',NULL,'happyzjhao@163.com',0,NULL,false,'2023-06-06 15:01:49','2023-06-06 15:01:49'),(1667834881019293698,'lihd','f1a6c300f85f99620ea98137737c9e35','',NULL,'2214304312@qq.com',0,NULL,false,'2023-06-11 18:03:17','2023-06-11 18:03:17'),(1671339085230845953,'wanwan','90b31bc538a8025b5aa822df3791e13f','wan_wan',NULL,'834254081@qq.com',0,NULL,false,'2023-06-21 10:07:45','2023-06-21 10:07:45'),(1675111994130771970,'jeffery','f5969d71d0aa716281cb984f1e2b7555','jeffery',NULL,'jeffery0211@163.com',0,NULL,false,'2023-07-01 19:59:56','2023-07-01 19:59:56'),(1676243256308477954,'lihang','25eebed5bf464b944c1aed526b77c915','lihang',NULL,'2634263077@qq.com',0,NULL,false,'2023-07-04 22:55:10','2023-07-04 22:55:10'),(1678657650954940417,'GuoWR','36faa48765f42bdc66e12e0cad3f8723','GuoWR',NULL,'17600023233@163.com',0,NULL,false,'2023-07-11 14:49:07','2023-07-11 14:49:07'),(1678702134908497921,'麦麦特雷西','dcf987ed942f558a743a1e6d5209e54a','',NULL,'309865411@qq.com',0,NULL,false,'2023-07-11 17:45:52','2023-07-11 17:45:52'),(1680040774322434050,'gogocx123','3636ca137fc5962e1c492e8b7c66eefd','gogocx123',NULL,'18298203141@163.com',0,NULL,false,'2023-07-15 10:25:09','2023-07-15 10:25:09'),(1681207552008335362,'平行世界Lolita','d241a6da23706a93dfb844f4b469ae67','',NULL,'liuliqi_1993@163.com',0,NULL,false,'2023-07-18 15:41:30','2023-07-18 15:41:30'),(1681291065856438274,'niudong','80255e3af57733f5a31e2a822fcc32d3','nd',NULL,'niudong_coder@126.com',0,NULL,false,'2023-07-18 21:13:22','2023-07-18 21:13:22'),(1685901361262702594,'kitchen','9753e0510bd3f37aba8ba9ec840111d5','123',NULL,'az0123333@qq.com',0,NULL,false,'2023-07-31 14:33:02','2023-07-31 14:33:02'),(1686658456413089794,'keke','98af8556e516fd2f30092977590f99a2','',NULL,'lhlkeke@qq.com',0,NULL,false,'2023-08-02 16:41:27','2023-08-02 16:41:27'),(1688724132455854081,'taotaozi','b8febb24c6dff0a3de3bbdeb6c8cc769','桃桃子',NULL,'17600307262@163.com',0,NULL,false,'2023-08-08 09:29:43','2023-08-08 09:29:43'),(1691996196704956418,'maluyi','91419e35d65f3bc2ac7a6c78b40b568e','maluyi',NULL,'295884760@qq.com',0,NULL,false,'2023-08-17 10:11:44','2023-08-17 10:11:44'),(1693852157300256769,'1660356615@qq.com','a5e4f77cb7daba579b4e9d37ba55257d','77冠冠',NULL,'1660356615@qq.com',0,NULL,false,'2023-08-22 13:06:39','2023-08-22 13:06:39'),(1696416901664157697,'wuyongxiang','067b8a487ebfdaa6fef4affe5be847f7','',NULL,'1805680076@qq.com',0,NULL,false,'2023-08-29 14:58:02','2023-08-29 14:58:02'),(1696458509017231361,'BHY','702982a01533b6e2ede5dd5344edc114','',NULL,'787276792@qq.com',0,NULL,false,'2023-08-29 17:43:22','2023-08-29 17:43:22'),(1698596250412724225,'acbdekk','aeeb0429716d5445a009cd12436ad8d9','',NULL,'15382415034@qq.com',0,NULL,false,'2023-09-04 15:17:59','2023-09-04 15:17:59'),(1698631685792935938,'温存的小窝','95549ba5afe685650beb878e4749daa1','温存',NULL,'2656985144@qq.com',0,NULL,false,'2023-09-04 17:38:48','2023-09-04 17:38:48'),(1699745697221914625,'LSB','b1abb4da444d6a45566f2f658a3fddd2','lsb',NULL,'2105277676@qq.com',0,NULL,false,'2023-09-07 19:25:29','2023-09-07 19:25:29'),(1701835117890711554,'yubbing','99c3b56775cbcbb286793285ad9d5520','yubbing',NULL,'binglv7@126.com',0,NULL,false,'2023-09-13 13:48:05','2023-09-13 13:48:05'),(1702491447366332418,'Sinan','31e6b5407c34a333605d8cf95865a489','',NULL,'zhouxug@qq.com',0,NULL,false,'2023-09-15 09:16:06','2023-09-15 09:16:06'),(1703906345929486337,'Rio813','dbb648777b6645ce24753d550f08fa07','',NULL,'wmy854811839@gmail.com',0,NULL,false,'2023-09-19 06:58:25','2023-09-19 06:58:25'),(1704054086584315905,'helloworld','dc328cae1225aaf501bccfc78be5081c','tomato',NULL,'a2660486638b@163.com',0,NULL,false,'2023-09-19 16:45:29','2023-09-19 16:45:29'),(1705564209471369217,'巴塞罗熊','7b33be6657b4e43957e4954e0717f701','',NULL,'719665334@qq.com',0,NULL,false,'2023-09-23 20:46:10','2023-09-23 20:46:10');
INSERT INTO "public"."suanfa8_user" ("id","username","password","nickname","avatar","email","role_id","homepage","is_deleted","created_at","updated_at") VALUES (1705943271717023745,'wangchuan','1ba414df8f83e418b04d2a966e4006b5','wangchuan',NULL,'2858168149@qq.com',0,NULL,false,'2023-09-24 21:52:26','2023-09-24 21:52:26'),(1707014657667575810,'2685165104@qq.com','89f67220f234c0ac8f390f65e5689f81','吉祥如意',NULL,'2685165104@qq.com',0,NULL,false,'2023-09-27 20:49:44','2023-09-27 20:49:44'),(1707207969624109058,'zhch97','7fbf40eb8ffe181a2b572d44c04a5699','',NULL,'506326498@qq.com',0,NULL,false,'2023-09-28 09:37:53','2023-09-28 09:37:53'),(1710175111806005249,'yuanjinming','a3577a976d842ba142f6609abd78ec0c','',NULL,'1779569744@qq.com',0,NULL,false,'2023-10-06 14:08:15','2023-10-06 14:08:15'),(1711196518635614209,'margo','c77ad6a684f1ed9228d7ac77ff992a65','',NULL,'18633053841@163.com',0,NULL,false,'2023-10-09 09:46:57','2023-10-09 09:46:57'),(1712078929883901954,'664208456','bc182a835dd10f6bf3387f99babca095','',NULL,'664208456@qq.com',0,NULL,false,'2023-10-11 20:13:20','2023-10-11 20:13:20'),(1716714878949470209,'qp3232552','7371d2b42137b7d98868b84bfdea6ec5','H',NULL,'406286069@qq.com',0,NULL,false,'2023-10-24 15:14:57','2023-10-24 15:14:57'),(1717509953291890690,'yuanhe','c446e5b1523dc6a1a16ce2a641504dcd','鸢禾',NULL,'2669641501@qq.com',0,NULL,false,'2023-10-26 19:54:17','2023-10-26 19:54:17'),(1720129953139863554,'sam','9e03a3dfa68928061593924499de16ea','sam',NULL,'1737349741@qq.com',0,NULL,false,'2023-11-03 01:25:14','2023-11-03 01:25:14'),(1724151729696092161,'tstang','abb8f9bf28cdfd43c6f8097db01de407','张三',NULL,'6668220@qq.com',0,NULL,false,'2023-11-14 03:46:20','2023-11-14 03:46:20'),(1727163942300102658,'madik','3a4696b8ab63d7daa508522fda94a8d3','dafafa',NULL,'1557654591@qq.com',0,NULL,false,'2023-11-22 11:15:48','2023-11-22 11:15:48'),(1729162607709466626,'rochestor','7a1c2b144fdb363d010fc153af671b61','',NULL,'2276329692@qq.com',0,NULL,false,'2023-11-27 23:37:47','2023-11-27 23:37:47'),(1729205161561763841,'algoLearn2511','548e9727a3d451d5956bce17068da1bc','PG家长指引',NULL,'1109235477@qq.com',0,NULL,false,'2023-11-28 02:26:52','2023-11-28 02:26:52'),(1729356519770238977,'Sure','6768d4dfe4dc7f33732c741455d8ff36','Sure',NULL,'1440512883@qq.com',0,NULL,false,'2023-11-28 12:28:19','2023-11-28 12:28:19'),(1732215730887798785,'bgl','7bbcaac796705e41007eda5d98f90d99','bgl',NULL,'13237443239@163.com',0,NULL,false,'2023-12-06 09:49:48','2023-12-06 09:49:48'),(1732633638621229057,'384247264@qq.com','79e28bb30a5d320f1a685e56cab6062c','尘埃落定',NULL,'384247264@qq.com',0,NULL,false,'2023-12-07 13:30:25','2023-12-07 13:30:25'),(1735997287809232898,'liuchenchen0210','bdc108a17a1a5751c10cae87aab762e1','liuchenchen0210',NULL,'1277805076@qq.com',0,NULL,false,'2023-12-16 20:16:21','2023-12-16 20:16:21'),(1737096529831342082,'leetcode111','b8e16223033d780762722b5cfd0ed0e5','',NULL,'1243135602@qq.com',0,NULL,false,'2023-12-19 21:04:21','2023-12-19 21:04:21'),(1737434950504361986,'leehomwanglj','296c1046c82c7889ac6120dc1b4185a0','s',NULL,'jingleng77@sina.com',0,NULL,false,'2023-12-20 19:29:07','2023-12-20 19:29:07'),(1737616682381815809,'yuren1978','cf906a02707e579613058e6026834049','',NULL,'jianwei.sun@gmail.com',0,NULL,false,'2023-12-21 07:31:15','2023-12-21 07:31:15'),(1738107402842615810,'3481554467@qq.com','3d80bb71d88e7d07e18fe8f75141e9ea','',NULL,'3481554467@qq.com',0,NULL,false,'2023-12-22 16:01:12','2023-12-22 16:01:12'),(1738944095015481346,'Test','d05b665d45762ff0e1e843a8ed175801','',NULL,'kylinwsh@163.com',0,NULL,false,'2023-12-24 23:25:55','2023-12-24 23:25:55'),(1741370209138716674,'yuan2021','d022872c9b5b67a1e04245c9c9ebbd2e','源领',NULL,'321878563@qq.com',0,NULL,false,'2023-12-31 16:06:26','2023-12-31 16:06:26'),(1742014928088805378,'qichang0921','2db761604388073c2844c879c2f3bae9','',NULL,'qichang0921@163.com',0,NULL,false,'2024-01-02 10:48:19','2024-01-02 10:48:19'),(1745710518916165633,'feic','f99eb79195c7764e76219a34962375cb','feic',NULL,'feicong2018@gmail.com',0,NULL,false,'2024-01-12 15:33:16','2024-01-12 15:33:16'),(1746702596571865089,'ccc','f42251d974be1122062760237a337820','进击的cc',NULL,'18890765861@163.com',0,NULL,false,'2024-01-15 09:15:26','2024-01-15 09:15:26'),(1748887984757481474,'Seabiscuit','4cb5a3e9de6c72c33353701b5f07722a','',NULL,'pujingyu0105@163.com',0,NULL,false,'2024-01-21 09:59:23','2024-01-21 09:59:23'),(1750333839779766274,'Lyu.KJ','539d4ef302c4109bb25933fb725d64a2','',NULL,'1157529316@qq.com',0,NULL,false,'2024-01-25 09:44:42','2024-01-25 09:44:42'),(1750495501350543362,'令狐昭诩','3181ddac30b7911a04286c2d88fee90c','令狐昭诩',NULL,'2367279431@qq.com',0,NULL,false,'2024-01-25 20:27:05','2024-01-25 20:27:05'),(1751891084413968386,'18076211279','1580be738c34f7038c62f2f7cc58f87c','',NULL,'3493209254@qq.com',0,NULL,false,'2024-01-29 16:52:38','2024-01-29 16:52:38'),(1754647055322259458,'kevinjiang','40ad22441afc69c097577edfc781e00c','',NULL,'jhw_9951@126.com',0,NULL,false,'2024-02-06 07:23:52','2024-02-06 07:23:52'),(1754897928619237377,'yay','c3e15d3af052dcc23498a5a52060eb3c','yay',NULL,'yangaoyu33@gmail.com',0,NULL,false,'2024-02-07 00:00:45','2024-02-07 00:00:45'),(1756895415672446977,'lin','4a7a458e68ac80b9f4f7f75d569e239c','',NULL,'jlysll@buaa.edu.cn',0,NULL,false,'2024-02-12 12:18:03','2024-02-12 12:18:03'),(1759233435490787330,'Ayaka','689899ca4710abf25f48191a7bcddd7f','',NULL,'1409625488@qq.com',0,NULL,false,'2024-02-18 23:08:31','2024-02-18 23:08:31'),(1760494174843117569,'why741886','dbaedcfb24f7079f4d49fcb5de745ba1','123456',NULL,'1915356072@qq.com',0,NULL,false,'2024-02-22 10:38:14','2024-02-22 10:38:14'),(1762030847242477569,'小小的手心','d5722fe99227096217a9604e30c1cd3b','小小的手心',NULL,'3417135727@qq.com',0,NULL,false,'2024-02-26 16:24:26','2024-02-26 16:24:26'),(1762616870628687873,'weilai','17c7e2c116cf9c7341b0c203dbef9d6c','',NULL,'1215193268@qq.com',0,NULL,false,'2024-02-28 07:13:04','2024-02-28 07:13:04'),(1764845173913616386,'罗小白不白','65d99ad6050e31d8066e793c19fe96b1','罗小白',NULL,'1102667522@qq.com',0,NULL,false,'2024-03-05 10:47:33','2024-03-05 10:47:33'),(1766028552050769921,'ajiang8271','049a0f03759fce320b9b356993fae5f6','中炮',NULL,'ajiang8271@163.com',0,NULL,false,'2024-03-08 17:09:53','2024-03-08 17:09:53'),(1766446422555557889,'belaa','0b11cc0872cdb9c581ba828b577ed403','belaa',NULL,'1541238711@qq.com',0,NULL,false,'2024-03-09 20:50:21','2024-03-09 20:50:21'),(1766762161632116738,'指北针学算法','5afeb110e3127014bd4bf1f46671009b','指北针学算法',NULL,'lebin_2022@qq.com',0,NULL,false,'2024-03-10 17:44:59','2024-03-10 17:44:59'),(1767026301579755522,'月雾.','421396a92b79e421bfd54d68a17e2384','',NULL,'2218735695@qq.com',0,NULL,false,'2024-03-11 11:14:35','2024-03-11 11:14:35'),(1767369920769622018,'wddwh','dfc7375d95087543ad5d8208b54a4293','',NULL,'2063065783@qq.com',0,NULL,false,'2024-03-12 10:00:00','2024-03-12 10:00:00'),(1768257588378402818,'klshi','1c846a581b0bd2085dd52282ed50e4bb','',NULL,'klose.shi@live.com',0,NULL,false,'2024-03-14 20:47:16','2024-03-14 20:47:16'),(1768296211677118466,'yanpeidong','008b53bcd9112dcb5b5a180f6648a97b','小海浪',NULL,'lyzxii@163.com',0,NULL,false,'2024-03-14 23:20:45','2024-03-14 23:20:45'),(1771357640084881410,'judy6666666','d8a78a74c9e65c8a14c73b795e2f76d8','',NULL,'2412726772@qq.com',0,NULL,false,'2024-03-23 10:05:46','2024-03-23 10:05:46'),(1773702341031034882,'jksb','36c5cd337883fb723aebfa74b33d5b72','',NULL,'2517919848@qq.com',0,NULL,false,'2024-03-29 21:22:47','2024-03-29 21:22:47'),(1773992992783806465,'humertank','1e3677b149046c11333e0f72fb0161b3','humertank',NULL,'1156661395@qq.com',0,NULL,false,'2024-03-30 16:37:43','2024-03-30 16:37:43'),(1774319570428440577,'jwy0405','b2edf0998fc20cd4840ed82bb7dda51f','',NULL,'1379929535@qq.com',0,NULL,false,'2024-03-31 14:15:26','2024-03-31 14:15:26'),(1776097486485139457,'春晓1900','0a00b43f0d03d30b9f6e5a7f85b5b61c','春晓1900',NULL,'954204097@qq.com',0,NULL,false,'2024-04-05 12:00:14','2024-04-05 12:00:14'),(1779569063231041538,'domorningstr','cbb3176f285c8bcee370b023f7813956','',NULL,'18770709@qq.com',0,NULL,false,'2024-04-15 01:55:02','2024-04-15 01:55:02'),(1780519488134393857,'cpipi1024','c76e905708b7b5fce69d971c4b6729ba','',NULL,'1461481767@qq.com',0,NULL,false,'2024-04-17 16:51:41','2024-04-17 16:51:41'),(1781263713931177985,'1393645270','17fd2e45d5d37582b96967286f402c3d','以诚',NULL,'1393645270@qq.com',0,NULL,false,'2024-04-19 18:08:58','2024-04-19 18:08:58'),(1783625703903277058,'daluge','5258ef76d0d94d2e654c62831e4b202f','daluge',NULL,'daluge@sohu.com',0,NULL,false,'2024-04-26 06:34:41','2024-04-26 06:34:41'),(1788767205046431746,'算法好难','a8aa4b0045bbb405e2ea88ce16f0b8f4','',NULL,'15102815859@163.com',0,NULL,false,'2024-05-10 11:05:10','2024-05-10 11:05:10'),(1789217835540099074,'zzw','8f82192e90b5448c037c5798f3e2cd11','zzw',NULL,'a15149070507@163.com',0,NULL,false,'2024-05-11 16:55:49','2024-05-11 16:55:49'),(1795268996080676866,'link_xiaow','8ad6b40af92d83bd26de1db5ec81b012','link_xiaow',NULL,'link_xiaow@163.com',0,NULL,false,'2024-05-28 09:40:58','2024-05-28 09:40:58'),(1795376442858090498,'Doggy','3d2970da7142cd4d560a64f4bb4614e0','DOGGY',NULL,'3250465545@qq.com',0,NULL,false,'2024-05-28 16:47:55','2024-05-28 16:47:55'),(1796522409762304001,'liangcben','4332a2bb494ce92d9c7903b0c2b825fe','小号而已了',NULL,'lslcben10@qq.com',0,NULL,false,'2024-05-31 20:41:35','2024-05-31 20:41:35'),(1798387642869035010,'追风要快','a6f5c5ae2c529c7e18415bf09016da2c','',NULL,'3230354750@qq.com',0,NULL,false,'2024-06-06 00:13:21','2024-06-06 00:13:21'),(1800921373731270657,'chief','6184da62c9cabd989d44b193c703e0c7','',NULL,'961353968@qq.com',0,NULL,false,'2024-06-13 00:01:30','2024-06-13 00:01:30'),(1806239491374526465,'tomcat','e7aabb2c7c6f293bd0611b434eb57b1c','tomcat',NULL,'18765616271@163.com',0,NULL,false,'2024-06-27 16:13:48','2024-06-27 16:13:48'),(1806877059917099009,'Peter','462970acb7221af635c17d22121b39ee','',NULL,'te.shi1997@gmail.com',0,NULL,false,'2024-06-29 10:27:16','2024-06-29 10:27:16'),(1808522878437109761,'huwenchang','5a6c3ebc459ca88e3d08e9e926dd4e59','',NULL,'huwenchang0624@gmail.com',0,NULL,false,'2024-07-03 23:27:10','2024-07-03 23:27:10'),(1809801086616809473,'Ling','58109457b6ddb0d514b7abcc1a73b50a','Lingzk',NULL,'914516716@qq.com',0,NULL,false,'2024-07-07 12:06:18','2024-07-07 12:06:18'),(1813557668735430657,'kangjeren','340d6591c5c2adaa639e49dda9cf4dd5','kangjeren',NULL,'2597581752@qq.com',0,NULL,false,'2024-07-17 20:53:37','2024-07-17 20:53:37'),(1816766722148478977,'富贵是只猫','66bf8a77cfb84ac6457bea84542c1fcd','',NULL,'17600148757@163.com',0,NULL,false,'2024-07-26 17:25:15','2024-07-26 17:25:15'),(1817160420761874434,'relife','e30e1a740e23f6a1e418249dbb7e986d','',NULL,'hmmyw15@163.com',0,NULL,false,'2024-07-27 19:29:40','2024-07-27 19:29:40'),(1823014602186240001,'李66','22b9e1ae1fc05bd85e9c688577667bbd','',NULL,'3152079190@qq.com',0,NULL,false,'2024-08-12 23:12:06','2024-08-12 23:12:06'),(1824657103930339329,'1425621071','f0b0b9d8c909dae4b712cf19c8b62012','努力学习的XT',NULL,'1425621071@qq.com',0,NULL,false,'2024-08-17 11:58:49','2024-08-17 11:58:49'),(1830802465535635457,'jlbill22','478d458f94b1d83b7f6b2d1f3c413ab8','',NULL,'282034095@qq.com',0,NULL,false,'2024-09-03 10:58:17','2024-09-03 10:58:17'),(1830802465552412674,'jlbill22','478d458f94b1d83b7f6b2d1f3c413ab8','',NULL,'282034095@qq.com',0,NULL,false,'2024-09-03 10:58:17','2024-09-03 10:58:17'),(1837432235564281857,'benaixuexi','871df7e40b0207499dadb51f7ee7e71e','Bencode',NULL,'benaixuexi@163.com',0,NULL,false,'2024-09-21 18:02:37','2024-09-21 18:02:37'),(1838179853957410817,'ywen','4de4f131d0079958a1da8ae77f5084e2','',NULL,'3621980487@qq.com',0,NULL,false,'2024-09-23 19:33:24','2024-09-23 19:33:24'),(1838583388440178690,'明里灰','121bf457bb329e91a42d8aa2d12e34b3','',NULL,'2171204141@qq.com',0,NULL,false,'2024-09-24 22:16:54','2024-09-24 22:16:54'),(1839237025399123969,'如果可以','ec6247161a82fdb8b8d39fdf2d905e44','',NULL,'1443029652@qq.com',0,NULL,false,'2024-09-26 17:34:13','2024-09-26 17:34:13'),(1840220703021412354,'wkl','910be3258b373ee82ab10461e5587d9a','',NULL,'1691590687@qq.com',0,NULL,false,'2024-09-29 10:43:00','2024-09-29 10:43:00'),(1840390076541513730,'006900','8f07978b6fdd55dab1988ac462f868ae','',NULL,'3111274807@qq.com',0,NULL,false,'2024-09-29 21:56:02','2024-09-29 21:56:02'),(1840488135317336065,'kevin','7fcde522c7da979c0d8011fb40388df6','',NULL,'drzhong2015@gmail.com',0,NULL,false,'2024-09-30 04:25:41','2024-09-30 04:25:41'),(1841319351734054913,'yxxL','b490b9e960c1bd26c5a70ff290c613b8','',NULL,'yxxl_luziyan@163.com',0,NULL,false,'2024-10-02 11:28:38','2024-10-02 11:28:38'),(1844328148714991617,'cangfeng','2f350e5ffa76271c92c61bf5914d7421','梦飞',NULL,'767700484@qq.com',0,NULL,false,'2024-10-10 18:44:31','2024-10-10 18:44:31'),(1944925637355843586,'zhouguang','e4bfdc84d495ee4ca846f9824e2ad985','周光',NULL,'liwei1419@163.com',0,NULL,false,'2025-07-15 09:03:01','2025-07-15 10:27:53'),(1575406949798027265,'liweiwei1419','f14d60097ddcdd6b433fee5452f57b30','李威威同学','https://minio.dance8.fun/algo-crazy/avatars/liwei.jpeg','121088825@qq.com',1,'https://suanfa8.com',false,'2022-09-29 16:47:41','2024-03-30 03:33:45');
-- public.submission DML
INSERT INTO "public"."submission" ("id","user_id","problem_id","code","language","status","score","time_used","memory_used","submit_time","is_deleted","created_at","updated_at","message","execution_time") VALUES (1,1,1,'public int[] twoSum(int[] nums, int target) { ... }','java','accepted',100,12,1024,'2025-07-18 16:50:45',false,'2025-07-18 16:50:45','2025-07-18 16:50:45',NULL,NULL),(3,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','PENDING',0,NULL,NULL,'2025-07-19 03:52:05',false,'2025-07-19 11:52:05','2025-07-19 11:52:05',NULL,NULL),(9,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','PENDING',0,NULL,NULL,'2025-07-19 06:05:07',false,'2025-07-19 14:05:07','2025-07-19 14:05:07','代码已提交，正在判题中...',NULL),(10,1,1,'#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    // 在这里写代码
    return 0;
}','cpp','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 14:28:14',false,'2025-07-19 14:28:14','2025-07-19 14:28:14','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(11,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 14:43:30',false,'2025-07-19 14:43:30','2025-07-19 14:43:30','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(81,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:29:58',false,'2025-07-20 01:29:56','2025-07-20 01:29:56','部分测试用例未通过',579),(12,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 14:44:14',false,'2025-07-19 14:44:14','2025-07-19 14:44:14','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(13,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 14:57:27',false,'2025-07-19 14:57:27','2025-07-19 14:57:27','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(14,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:03:24',false,'2025-07-19 15:03:24','2025-07-19 15:03:24','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(15,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:09:51',false,'2025-07-19 15:09:51','2025-07-19 15:09:51','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(16,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:12:02',false,'2025-07-19 15:12:02','2025-07-19 15:12:02','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(82,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:30:50',false,'2025-07-20 01:30:48','2025-07-20 01:30:48','部分测试用例未通过',407),(83,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:30:57',false,'2025-07-20 01:30:55','2025-07-20 01:30:55','所有测试用例通过',446),(17,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:13:12',false,'2025-07-19 15:13:12','2025-07-19 15:13:12','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(18,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:14:24',false,'2025-07-19 15:14:24','2025-07-19 15:14:24','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(84,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:33:27',false,'2025-07-20 01:33:25','2025-07-20 01:33:25','所有测试用例通过',492),(85,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:33:33',false,'2025-07-20 01:33:31','2025-07-20 01:33:31','部分测试用例未通过',527),(19,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:15:10',false,'2025-07-19 15:15:10','2025-07-19 15:15:10','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(20,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:17:51',false,'2025-07-19 15:15:58','2025-07-19 15:15:58','运行时错误: Invalid bound statement (not found): com.suanfa8.oj.mapper.TestcaseMapper.selectByProblemId',NULL),(86,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:33:52',false,'2025-07-20 01:33:50','2025-07-20 01:33:50','部分测试用例未通过',487),(148,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 17:17:28',false,'2025-07-20 17:17:18','2025-07-20 17:17:18','部分测试用例未通过',3212),(87,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:35:40',false,'2025-07-20 01:35:38','2025-07-20 01:35:38','部分测试用例未通过',355),(21,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:19:16',false,'2025-07-19 15:18:30','2025-07-19 15:18:30','运行时错误: 
### Error updating database.  Cause: org.postgresql.util.PSQLException: ERROR: relation "judge_results" does not exist
  位置：13
### The error may exist in com/suanfa8/oj/mapper/JudgeResultMapper.java (best guess)
### The error may involve com.suanfa8.oj.mapper.JudgeResultMapper.insert-Inline
### The error occurred while setting parameters
### SQL: INSERT INTO judge_results  ( submission_id, test_case_index, input, expected_output, actual_output, status, execution_time, memory_usage )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?  )
### Cause: org.postgresql.util.PSQLException: ERROR: relation "judge_results" does not exist
  位置：13
; bad SQL grammar []',NULL),(27,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:37:41',false,'2025-07-19 15:37:40','2025-07-19 15:37:40','部分测试用例未通过',517),(28,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:39:37',false,'2025-07-19 15:39:36','2025-07-19 15:39:36','部分测试用例未通过',430),(29,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:40:35',false,'2025-07-19 15:40:34','2025-07-19 15:40:34','部分测试用例未通过',388),(30,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:50:43',false,'2025-07-19 15:50:41','2025-07-19 15:50:41','部分测试用例未通过',454),(22,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','RUNTIME_ERROR',0,NULL,NULL,'2025-07-19 15:24:23',false,'2025-07-19 15:24:18','2025-07-19 15:24:18','运行时错误: 
### Error updating database.  Cause: org.postgresql.util.PSQLException: ERROR: column "execution_time" of relation "submission" does not exist
  位置：111
### The error may exist in com/suanfa8/oj/mapper/SubmissionMapper.java (best guess)
### The error may involve com.suanfa8.oj.mapper.SubmissionMapper.updateById-Inline
### The error occurred while setting parameters
### SQL: UPDATE submission  SET user_id=?, problem_id=?, code=?, language=?, status=?, score=?,  memory_used=?, execution_time=?, submit_time=?, is_deleted=?, created_at=?, updated_at=?, message=?  WHERE id=?
### Cause: org.postgresql.util.PSQLException: ERROR: column "execution_time" of relation "submission" does not exist
  位置：111
; bad SQL grammar []',NULL),(24,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:30:45',false,'2025-07-19 15:30:44','2025-07-19 15:30:44','部分测试用例未通过',609),(23,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:26:04',false,'2025-07-19 15:26:02','2025-07-19 15:26:02','部分测试用例未通过',574),(25,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:33:16',false,'2025-07-19 15:33:14','2025-07-19 15:33:14','部分测试用例未通过',408),(26,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:35:14',false,'2025-07-19 15:35:12','2025-07-19 15:35:12','部分测试用例未通过',728),(31,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:54:34',false,'2025-07-19 15:54:31','2025-07-19 15:54:31','部分测试用例未通过',827),(88,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:35:52',false,'2025-07-20 01:35:50','2025-07-20 01:35:50','所有测试用例通过',445),(32,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 15:55:41',false,'2025-07-19 15:55:39','2025-07-19 15:55:39','部分测试用例未通过',401),(33,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-19 15:57:05',false,'2025-07-19 15:57:05','2025-07-19 15:57:05','编译错误: 编译过程出错：Format specifier ''%s''',NULL),(89,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:36:01',false,'2025-07-20 01:36:00','2025-07-20 01:36:00','部分测试用例未通过',465),(37,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:13:48',false,'2025-07-19 16:13:46','2025-07-19 16:13:46','部分测试用例未通过',319),(34,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:00:27',false,'2025-07-19 16:00:24','2025-07-19 16:00:24','部分测试用例未通过',473),(36,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:10:46',false,'2025-07-19 16:10:43','2025-07-19 16:10:43','部分测试用例未通过',509),(35,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:05:22',false,'2025-07-19 16:05:19','2025-07-19 16:05:19','部分测试用例未通过',598),(38,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:18:46',false,'2025-07-19 16:18:44','2025-07-19 16:18:44','部分测试用例未通过',325),(39,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:35:55',false,'2025-07-19 16:35:53','2025-07-19 16:35:53','部分测试用例未通过',333),(43,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:52:24',false,'2025-07-19 16:52:22','2025-07-19 16:52:22','部分测试用例未通过',318),(40,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:40:22',false,'2025-07-19 16:40:20','2025-07-19 16:40:20','部分测试用例未通过',315),(42,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:48:17',false,'2025-07-19 16:48:15','2025-07-19 16:48:15','部分测试用例未通过',521),(41,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:43:31',false,'2025-07-19 16:43:29','2025-07-19 16:43:29','部分测试用例未通过',337),(44,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取输入
        int n = scanner.nextInt(); // 数组长度
        int target = scanner.nextInt(); // 目标和
        
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = scanner.nextInt();
        }
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 16:58:52',false,'2025-07-19 16:58:49','2025-07-19 16:58:49','部分测试用例未通过',337),(149,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 17:18:44',false,'2025-07-20 17:18:33','2025-07-20 17:18:33','所有测试用例通过',3002),(45,1,1,'package com.suanfa8;

import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:14:19',false,'2025-07-19 17:14:17','2025-07-19 17:14:17','部分测试用例未通过',0),(46,1,1,'package com.suanfa8;

import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:17:38',false,'2025-07-19 17:17:36','2025-07-19 17:17:36','部分测试用例未通过',0),(90,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:36:08',false,'2025-07-20 01:36:06','2025-07-20 01:36:06','所有测试用例通过',526),(91,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:38:36',false,'2025-07-20 01:38:34','2025-07-20 01:38:34','所有测试用例通过',424),(92,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:38:45',false,'2025-07-20 01:38:43','2025-07-20 01:38:43','部分测试用例未通过',431),(47,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:18:43',false,'2025-07-19 17:18:41','2025-07-19 17:18:41','部分测试用例未通过',316),(48,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:19:08',false,'2025-07-19 17:19:05','2025-07-19 17:19:05','部分测试用例未通过',330),(93,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:38:56',false,'2025-07-20 01:38:55','2025-07-20 01:38:55','所有测试用例通过',374),(94,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:40:40',false,'2025-07-20 01:40:38','2025-07-20 01:40:38','所有测试用例通过',489),(49,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:23:15',false,'2025-07-19 17:23:13','2025-07-19 17:23:13','部分测试用例未通过',351),(50,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:26:28',false,'2025-07-19 17:26:25','2025-07-19 17:26:25','部分测试用例未通过',349),(96,1,1,'#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    // 在这里写代码
    return 0;
}','cpp','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:59:28',false,'2025-07-20 01:41:48','2025-07-20 01:41:48','部分测试用例未通过',433),(95,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:40:51',false,'2025-07-20 01:40:50','2025-07-20 01:40:50','所有测试用例通过',401),(97,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:42:25',false,'2025-07-20 01:42:22','2025-07-20 01:42:22','部分测试用例未通过',369),(51,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:37:09',false,'2025-07-19 17:37:07','2025-07-19 17:37:07','部分测试用例未通过',334),(52,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:39:55',false,'2025-07-19 17:39:53','2025-07-19 17:39:53','部分测试用例未通过',339),(98,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:42:36',false,'2025-07-20 01:42:34','2025-07-20 01:42:34','所有测试用例通过',410),(99,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:43:43',false,'2025-07-20 01:43:41','2025-07-20 01:43:41','所有测试用例通过',530),(53,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:43:55',false,'2025-07-19 17:43:53','2025-07-19 17:43:53','部分测试用例未通过',333),(54,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:45:50',false,'2025-07-19 17:45:48','2025-07-19 17:45:48','部分测试用例未通过',309),(100,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:43:58',false,'2025-07-20 01:43:56','2025-07-20 01:43:56','所有测试用例通过',438),(101,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:44:01',false,'2025-07-20 01:44:00','2025-07-20 01:44:00','所有测试用例通过',386),(55,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:46:53',false,'2025-07-19 17:46:51','2025-07-19 17:46:51','部分测试用例未通过',357),(56,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:48:09',false,'2025-07-19 17:48:06','2025-07-19 17:48:06','部分测试用例未通过',382),(102,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:44:07',false,'2025-07-20 01:44:06','2025-07-20 01:44:06','部分测试用例未通过',404),(103,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:44:13',false,'2025-07-20 01:44:12','2025-07-20 01:44:12','所有测试用例通过',526),(122,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:56:15',false,'2025-07-20 15:56:13','2025-07-20 15:56:13','所有测试用例通过',520),(57,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:55:12',false,'2025-07-19 17:55:10','2025-07-19 17:55:10','部分测试用例未通过',384),(58,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:56:54',false,'2025-07-19 17:56:52','2025-07-19 17:56:52','部分测试用例未通过',297),(104,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 09:57:52',false,'2025-07-20 09:57:46','2025-07-20 09:57:46','部分测试用例未通过',1129),(123,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:56:15',false,'2025-07-20 15:56:13','2025-07-20 15:56:13','所有测试用例通过',528),(150,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 17:21:08',false,'2025-07-20 17:20:56','2025-07-20 17:20:56','所有测试用例通过',3168),(59,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 17:58:38',false,'2025-07-19 17:58:36','2025-07-19 17:58:36','部分测试用例未通过',480),(60,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 18:04:09',false,'2025-07-19 18:04:06','2025-07-19 18:04:06','部分测试用例未通过',378),(106,1,1,'#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    // 在这里写代码
    return 0;
}','cpp','WRONG_ANSWER',0,NULL,0,'2025-07-20 10:06:19',false,'2025-07-20 10:04:27','2025-07-20 10:04:27','部分测试用例未通过',942),(105,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 10:01:47',false,'2025-07-20 10:01:42','2025-07-20 10:01:42','部分测试用例未通过',1110),(107,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 10:04:52',false,'2025-07-20 10:04:46','2025-07-20 10:04:46','部分测试用例未通过',1193),(151,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 18:29:57',false,'2025-07-20 18:29:45','2025-07-20 18:29:45','所有测试用例通过',3197),(61,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 18:09:31',false,'2025-07-19 18:09:28','2025-07-19 18:09:28','部分测试用例未通过',337),(108,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 10:06:12',false,'2025-07-20 10:06:03','2025-07-20 10:06:03','部分测试用例未通过',0),(62,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 1. 读取第一行数字，转换成数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        int target = scanner.nextInt();

        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 18:11:14',false,'2025-07-19 18:11:12','2025-07-19 18:11:12','部分测试用例未通过',452),(109,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:12:00',false,'2025-07-20 10:11:54','2025-07-20 10:11:54','所有测试用例通过',1553),(63,1,11,'import java.util.Scanner;

public class Main {
    public static int maxArea(int[] height) {
        int left = 0;
        int right = height.length - 1;
        int maxArea = 0;
        
        while (left < right) {
            int currentArea = Math.min(height[left], height[right]) * (right - left);
            maxArea = Math.max(maxArea, currentArea);
            
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        
        return maxArea;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取一行输入并按空格分割
        String[] input = scanner.nextLine().split(" ");
        int[] height = new int[input.length];
        
        // 将字符串数组转换为整数数组
        for (int i = 0; i < input.length; i++) {
            height[i] = Integer.parseInt(input[i]);
        }
        
        // 计算并输出结果
        System.out.println(maxArea(height));
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-19 18:16:31',false,'2025-07-19 18:16:27','2025-07-19 18:16:27','部分测试用例未通过',729),(64,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 00:06:45',false,'2025-07-20 00:06:44','2025-07-20 00:06:44','部分测试用例未通过',356),(65,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 00:19:13',false,'2025-07-20 00:19:11','2025-07-20 00:19:11','部分测试用例未通过',297),(66,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 00:22:19',false,'2025-07-20 00:22:17','2025-07-20 00:22:17','部分测试用例未通过',333),(110,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:20:54',false,'2025-07-20 10:20:48','2025-07-20 10:20:48','所有测试用例通过',1386),(67,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 00:23:05',false,'2025-07-20 00:23:03','2025-07-20 00:23:03','部分测试用例未通过',332),(68,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 00:38:30',false,'2025-07-20 00:38:28','2025-07-20 00:38:28','部分测试用例未通过',561),(111,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:21:21',false,'2025-07-20 10:21:16','2025-07-20 10:21:16','所有测试用例通过',1569),(112,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:21:32',false,'2025-07-20 10:21:27','2025-07-20 10:21:27','所有测试用例通过',1424);
INSERT INTO "public"."submission" ("id","user_id","problem_id","code","language","status","score","time_used","memory_used","submit_time","is_deleted","created_at","updated_at","message","execution_time") VALUES (69,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 00:40:25',false,'2025-07-20 00:40:23','2025-07-20 00:40:23','所有测试用例通过',480),(70,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:09:35',false,'2025-07-20 01:09:33','2025-07-20 01:09:33','所有测试用例通过',523),(113,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:28:38',false,'2025-07-20 10:28:35','2025-07-20 10:28:35','所有测试用例通过',491),(114,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:29:58',false,'2025-07-20 10:29:56','2025-07-20 10:29:56','所有测试用例通过',663),(71,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:11:40',false,'2025-07-20 01:11:38','2025-07-20 01:11:38','所有测试用例通过',592),(72,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:18:51',false,'2025-07-20 01:18:49','2025-07-20 01:18:49','所有测试用例通过',439),(115,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:31:25',false,'2025-07-20 10:31:23','2025-07-20 10:31:23','所有测试用例通过',436),(124,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:57:17',false,'2025-07-20 15:57:15','2025-07-20 15:57:15','所有测试用例通过',460),(125,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 15:57:43',false,'2025-07-20 15:57:41','2025-07-20 15:57:41','部分测试用例未通过',378),(126,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 16:01:10',false,'2025-07-20 16:01:08','2025-07-20 16:01:08','部分测试用例未通过',378),(73,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + i);
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:19:18',false,'2025-07-20 01:19:16','2025-07-20 01:19:16','部分测试用例未通过',480),(127,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:01:29',false,'2025-07-20 16:01:27','2025-07-20 16:01:27','所有测试用例通过',503),(74,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + i);
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:21:10',false,'2025-07-20 01:21:09','2025-07-20 01:21:09','部分测试用例未通过',425),(116,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 10:44:18',false,'2025-07-20 10:44:16','2025-07-20 10:44:16','所有测试用例通过',510),(129,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:40:15',false,'2025-07-20 16:40:13','2025-07-20 16:40:13','所有测试用例通过',544),(75,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:21:27',false,'2025-07-20 01:21:25','2025-07-20 01:21:25','所有测试用例通过',370),(76,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:21:55',false,'2025-07-20 01:21:54','2025-07-20 01:21:54','所有测试用例通过',443),(117,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:33:57',false,'2025-07-20 15:33:54','2025-07-20 15:33:54','所有测试用例通过',537),(128,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:38:06',false,'2025-07-20 16:38:03','2025-07-20 16:38:03','所有测试用例通过',520),(138,1,1,'import java.util.*;

public class Main {
    public static void main(String[] args) {
        // 在这里写代码
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 17:02:22',false,'2025-07-20 17:02:17','2025-07-20 17:02:17','部分测试用例未通过',1122),(77,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) ) + " " + (i));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:22:16',false,'2025-07-20 01:22:14','2025-07-20 01:22:14','部分测试用例未通过',493),(78,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:22:30',false,'2025-07-20 01:22:29','2025-07-20 01:22:29','所有测试用例通过',477),(118,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:45:22',false,'2025-07-20 15:45:19','2025-07-20 15:45:19','所有测试用例通过',680),(119,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:48:01',false,'2025-07-20 15:47:59','2025-07-20 15:47:59','所有测试用例通过',513),(79,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 01:28:34',false,'2025-07-20 01:28:32','2025-07-20 01:28:32','所有测试用例通过',499),(80,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 01:28:43',false,'2025-07-20 01:28:41','2025-07-20 01:28:41','部分测试用例未通过',523),(120,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:48:34',false,'2025-07-20 15:48:32','2025-07-20 15:48:32','所有测试用例通过',531),(121,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 15:51:12',false,'2025-07-20 15:51:10','2025-07-20 15:51:10','所有测试用例通过',522),(130,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:40:48',false,'2025-07-20 16:40:46','2025-07-20 16:40:46','所有测试用例通过',460),(131,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:41:14',false,'2025-07-20 16:41:12','2025-07-20 16:41:12','所有测试用例通过',505),(132,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:53:24',false,'2025-07-20 16:53:22','2025-07-20 16:53:22','所有测试用例通过',492),(133,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:53:30',false,'2025-07-20 16:53:28','2025-07-20 16:53:28','所有测试用例通过',531),(134,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement)) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 16:53:42',false,'2025-07-20 16:53:40','2025-07-20 16:53:40','部分测试用例未通过',398),(135,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:53:49',false,'2025-07-20 16:53:47','2025-07-20 16:53:47','所有测试用例通过',460),(136,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 16:54:00',false,'2025-07-20 16:53:58','2025-07-20 16:53:58','所有测试用例通过',562),(137,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(aString[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-20 17:01:50',false,'2025-07-20 17:01:48','2025-07-20 17:01:48','编译错误: 编译失败：Main.java:5: error: cannot find symbol
    public static void main(aString[] args) {
                            ^
  symbol:   class aString
  location: class Main
1 error
',NULL),(139,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(aString[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-20 17:02:52',false,'2025-07-20 17:02:51','2025-07-20 17:02:51','编译错误: 编译失败：Main.java:5: error: cannot find symbol
    public static void main(aString[] args) {
                            ^
  symbol:   class aString
  location: class Main
1 error
',NULL),(140,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 17:03:21',false,'2025-07-20 17:03:15','2025-07-20 17:03:15','所有测试用例通过',1489),(141,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(aString[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-20 17:03:28',false,'2025-07-20 17:03:26','2025-07-20 17:03:26','编译错误: 编译失败：Main.java:5: error: cannot find symbol
    public static void main(aString[] args) {
                            ^
  symbol:   class aString
  location: class Main
1 error
',NULL),(147,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 17:15:58',false,'2025-07-20 17:15:47','2025-07-20 17:15:47','部分测试用例未通过',2985),(142,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(aString[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-20 17:04:01',false,'2025-07-20 17:04:00','2025-07-20 17:04:00','编译错误: 编译失败：Main.java:5: error: cannot find symbol
    public static void main(aString[] args) {
                            ^
  symbol:   class aString
  location: class Main
1 error
',NULL),(144,1,35,'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int[] nums = new int[numsStr.length];
        for (int i = 0; i < numsStr.length; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        
        // 读取第二行target
        int target = scanner.nextInt();
        
        // 调用搜索方法
        int result = searchInsert(nums, target);
        System.out.println(result);
    }
    
    public static int searchInsert(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return left;
    }
}','java','COMPILE_ERROR',0,NULL,NULL,'2025-07-20 17:09:00',false,'2025-07-20 17:08:58','2025-07-20 17:08:58','编译错误: 编译失败：Main.java:3: error: class Solution is public, should be declared in a file named Solution.java
public class Solution {
       ^
1 error
',NULL),(143,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 17:04:11',false,'2025-07-20 17:04:05','2025-07-20 17:04:05','所有测试用例通过',1532),(145,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int[] nums = new int[numsStr.length];
        for (int i = 0; i < numsStr.length; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        
        // 读取第二行target
        int target = scanner.nextInt();
        
        // 调用搜索方法
        int result = searchInsert(nums, target);
        System.out.println(result);
    }
    
    public static int searchInsert(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return left;
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 17:10:42',false,'2025-07-20 17:10:30','2025-07-20 17:10:30','部分测试用例未通过',3259),(146,1,35,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n;

        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        System.out.println(left);
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 17:14:24',false,'2025-07-20 17:14:12','2025-07-20 17:14:12','部分测试用例未通过',2477),(152,1,1,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 检查是否有输入可用
        if (!scanner.hasNextLine()) {
            System.out.println("错误：没有检测到输入");
            System.exit(1);
        }
        
        // 读取一行输入
        String input = scanner.nextLine();
        
        // 分割输入字符串
        String[] numbers = input.trim().split("\\s+"); // 处理多个空格的情况
        
        // 确保输入是两个数字
        if (numbers.length != 2) {
            System.out.println("输入格式错误，请输入两个数字，用空格分隔");
            System.exit(1);
        }
        
        try {
            // 解析数字并计算和
            int num1 = Integer.parseInt(numbers[0]);
            int num2 = Integer.parseInt(numbers[1]);
            int sum = num1 + num2;
            
            // 输出结果
            System.out.println(sum); // 只输出结果，方便自动判题
        } catch (NumberFormatException e) {
            System.out.println("输入的不是有效数字");
            System.exit(1);
        }
        
        scanner.close();
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 18:50:41',false,'2025-07-20 18:50:35','2025-07-20 18:50:35','部分测试用例未通过',1247),(153,1,1,'import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 检查是否有输入可用
        if (!scanner.hasNextLine()) {
            System.out.println("错误：没有检测到输入");
            System.exit(1);
        }
        
        // 读取一行输入
        String input = scanner.nextLine();
        
        // 分割输入字符串
        String[] numbers = input.trim().split("\\s+"); // 处理多个空格的情况
        
        // 确保输入是两个数字
        if (numbers.length != 2) {
            System.out.println("输入格式错误，请输入两个数字，用空格分隔");
            System.exit(1);
        }
        
        try {
            // 解析数字并计算和
            int num1 = Integer.parseInt(numbers[0]);
            int num2 = Integer.parseInt(numbers[1]);
            int sum = num1 + num2;
            
            // 输出结果
            System.out.println(sum); // 只输出结果，方便自动判题
        } catch (NumberFormatException e) {
            System.out.println("输入的不是有效数字");
            System.exit(1);
        }
        
        scanner.close();
    }
}','java','WRONG_ANSWER',0,NULL,0,'2025-07-20 19:07:39',false,'2025-07-20 19:07:34','2025-07-20 19:07:34','部分测试用例未通过',1323),(154,1,1,'import java.util.HashMap;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // 读取第一行（数组）
        String arrayLine = scanner.nextLine();
        String[] numStrings = arrayLine.split(" ");
        int[] nums = new int[numStrings.length];
        for (int i = 0; i < numStrings.length; i++) {
            nums[i] = Integer.parseInt(numStrings[i]);
        }
        
        // 读取第二行（target）
        int target = scanner.nextInt();
        
        // 使用哈希表解决两数之和问题
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                // 输出结果，注意ACM模式通常从1开始计数
                System.out.println((map.get(complement) + 1) + " " + (i + 1));
                return;
            }
            map.put(nums[i], i);
        }
        
        // 如果没有找到解
        System.out.println("No solution");
    }
}','java','ACCEPTED',0,NULL,0,'2025-07-20 19:26:08',false,'2025-07-20 19:26:02','2025-07-20 19:26:02','所有测试用例通过',1599),(155,1,704,'import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        // 读取第一行数组
        String[] numsStr = scanner.nextLine().split(" ");
        int n = numsStr.length;
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = Integer.parseInt(numsStr[i]);
        }
        // 读取第二行 target
        int target = scanner.nextInt();
        // 调用搜索方法
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                System.out.println(mid);
                return;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        System.out.println(-1);
    }

}','java','ACCEPTED',0,NULL,0,'2025-07-20 19:29:42',false,'2025-07-20 19:29:35','2025-07-20 19:29:35','所有测试用例通过',1999);
-- public.testcase DML
INSERT INTO "public"."testcase" ("id","problem_id","input","output","is_sample","is_deleted","created_at","updated_at") VALUES (14,11,'1 2 1','2',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(11,11,'1 8 6 2 5 4 8 3 7','49',true,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(12,11,'1 1','1',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(13,11,'4 3 2 1 4','16',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(2,1,'3 2 4
6','2 3',false,false,'2025-07-18 16:50:45','2025-07-18 16:50:45'),(1,1,'2 7 11 15 
9','1 2',true,false,'2025-07-18 16:50:45','2025-07-18 16:50:45'),(3,35,'1 3 5 6
5','2',true,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(4,35,'1 3 5 6
2','1',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(6,35,'1 3 5 6
0','0',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(5,35,'1 3 5 6
7','4',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(7,35,'1
0','0',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(10,704,'5
5','0',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(8,704,'-1 0 3 5 9 12
9','4',true,false,'2025-07-18 18:31:48','2025-07-18 18:31:48'),(9,704,'-1 0 3 5 9 12
2','-1',false,false,'2025-07-18 18:31:48','2025-07-18 18:31:48');
SET session_replication_role = 'origin';

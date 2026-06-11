-- SELECT
--     t1.ID,
--     t1.review_tag,
--     t1.why_typical,
--     t1.site_review,
--     t2.title,
--     t2.leetcode_number
-- FROM
--     problem_review_topics t1
--         JOIN exercise_solutions t2 ON t1.exercise_id = t2.ID
START TRANSACTION;

UPDATE problem_review_topics
SET why_typical = '非常经典的动态规划问题，也是理解「以某个位置结尾」状态定义的好例题。',
    site_review = '不要急着写转移方程，先想清楚 dp[i] 表示以 nums[i] 结尾的最大子数组和；「结尾」这个词很重要。'
WHERE id = 55;

UPDATE problem_review_topics
SET why_typical = '「合并两个有序数组」的扩展，常被称为「多路合并」问题。',
    site_review = '思路很简单，在纸上编码没有那么容易。重点是理解优先队列里到底放什么，以及每次弹出以后补哪个结点。'
WHERE id = 37;

UPDATE problem_review_topics
SET why_typical = '两个序列上的动态规划经典问题，很多字符串 DP 都可以从这道题开始理解。',
    site_review = '重点是定义清楚 dp[i][j] 表示什么，再讨论两个字符相等和不相等两种情况。不要背公式，先看状态代表的含义。'
WHERE id = 66;

UPDATE problem_review_topics
SET why_typical = '本题是「优先队列」的典型应用。',
    site_review = '优先队列应用于动态求最值，中位数是前半部分的最大值、后半部分的最小值。数据是动态的，因此用两个优先队列可以「动态地」维护中位数。'
WHERE id = 1;

UPDATE problem_review_topics
SET why_typical = '题目描述简单，面试、笔试都有内容可聊。',
    site_review = '对前序、中序遍历定义的考查，还需要结合哈希表避免重复查找。关键不是记递归，而是看清楚根结点如何把左右子树切出来。'
WHERE id = 40;

UPDATE problem_review_topics
SET why_typical = '树的基础、常规问题，适合用来练习递归定义。',
    site_review = '使用深度优先遍历，记成「递归」也可以。重点是函数返回什么：当前结点所在子树的最大深度。'
WHERE id = 38;

UPDATE problem_review_topics
SET why_typical = '树形动态规划的经典问题，比普通树遍历多了一层「路径贡献」的理解。',
    site_review = '关键是区分两个量：向父结点返回的最大贡献，以及全局最大路径和。前者只能选一边，后者可以经过当前结点连接左右两边。'
WHERE id = 68;

UPDATE problem_review_topics
SET why_typical = '题号靠前，快速排序和优先队列的典型例题之一。',
    site_review = '非常经典的问题，partition 和优先队列的解法思路都很直接。重点是说清楚你为什么能只关心第 K 大，而不是完整排序。'
WHERE id = 10;

UPDATE problem_review_topics
SET why_typical = '非常经典的动态规划问题，也是线性 DP 的基础题。',
    site_review = '写法不唯一，定义清楚状态即可写出。重点是理解「偷当前房子」和「不偷当前房子」两个选择。'
WHERE id = 56;

UPDATE problem_review_topics
SET why_typical = '括号类问题里的经典题，可以用动态规划，也可以用栈来理解。',
    site_review = '不要急着背状态转移。重点是看当前位置如果是右括号，它能和谁配对，以及配对以后前面那一段能不能接上。'
WHERE id = 65;

UPDATE problem_review_topics
SET why_typical = '题号靠前，快速排序的典型例题之一。',
    site_review = '定义清楚变量和区间，编写代码的逻辑就很清晰。本题适合练习三路划分：小于、等于、大于三个区域都要说清楚。'
WHERE id = 9;

UPDATE problem_review_topics
SET why_typical = '题号靠前，不难，但没学过算法很难做对，或者说很难答到考点。',
    site_review = '本题的考点是 partition，特别是三路快排。写对代码的关键是：把变量定义和区间定义清楚。'
WHERE id = 2;

UPDATE problem_review_topics
SET why_typical = '常规、基础问题。和「合并两个有序数组」的思路一样：看链表首结点。',
    site_review = '可以自己设计指针修改，也可以使用递归。重点是别把链表当数组看，修改 next 指针之前要想清楚链接关系。'
WHERE id = 28;

UPDATE problem_review_topics
SET why_typical = '分治算法典型例题，本质上就是在归并排序的过程中统计答案。',
    site_review = '几乎就是写一次「归并排序」。「归并排序」是理解「分治算法」「递归」很好的学习材料，多写几遍一定会有收获。'
WHERE id = 6;

UPDATE problem_review_topics
SET why_typical = '贪心算法的基础问题，适合理解为什么「能赚就赚」是正确的。',
    site_review = '重点不是背代码，而是理解多次交易可以拆成每天相邻价格的上涨收益。只要今天比昨天贵，这一段上涨就可以被收入答案。'
WHERE id = 70;

UPDATE problem_review_topics
SET why_typical = '快慢指针典型问题，也是链表题里很常见的一类考法。',
    site_review = '常考问题，解法比较固定。除了记住做法，还要能说清楚为什么相遇以后一个指针回到头结点，再一起走会在入环点相遇。'
WHERE id = 31;

UPDATE problem_review_topics
SET why_typical = '题号靠前，分治算法典型例题。',
    site_review = '不要只记住递归，要记「拆分问题」「解决问题」的思路。本题是一半一半地拆，然后合并结果。代码写出来是递归，思想是分治。'
WHERE id = 5;

UPDATE problem_review_topics
SET why_typical = '题号靠前的经典广度优先遍历问题，也适合理解图上的最短路径。',
    site_review = '思想简单，但建图和编码都不算轻松。重点是知道为什么要用 BFS：因为题目问的是最短转换序列。'
WHERE id = 71;

UPDATE problem_review_topics
SET why_typical = '本题不需要学习复杂算法也能实现，主要考查编码基本功和循环不变量。',
    site_review = '循环不变量不是什么高深概念，就是让自己设计的变量定义保持不变。明确变量定义，代码逻辑就会清晰很多。'
WHERE id = 4;

UPDATE problem_review_topics
SET why_typical = '常考算法与数据结构综合问题，哈希表和双向链表都要用得上。',
    site_review = '考前需要准备。重点是为什么哈希表负责 O(1) 查找，双向链表负责 O(1) 调整最近使用顺序。'
WHERE id = 32;

UPDATE problem_review_topics
SET why_typical = '题目要求返回任意一个峰值，不能在循环体内一下子确定答案。',
    site_review = '本题的「峰顶」较难使用一个表达式表示出来，属于「必须退出循环以后才能确定答案」的问题。'
WHERE id = 15;

UPDATE problem_review_topics
SET why_typical = '题号靠前，常考基础问题，适合练习回溯算法的递归树。',
    site_review = '画出递归树，根据递归树编码。重点是每一步还能放左括号还是右括号，而不是死记代码结构。'
WHERE id = 49;

UPDATE problem_review_topics
SET why_typical = '动态规划基础问题，也可以从图的最短路径角度理解。',
    site_review = '重点是定义 dp[i] 表示组成整数 i 所需的最少完全平方数个数，再枚举最后选择的那个平方数。'
WHERE id = 61;

UPDATE problem_review_topics
SET why_typical = '常考问题，题目描述简单，但可以考查图遍历的基本功。',
    site_review = '深度优先遍历、广度优先遍历都可以实现。重点是把访问过的位置标记清楚，避免重复计算同一个岛屿。'
WHERE id = 50;

UPDATE problem_review_topics
SET why_typical = '常考基础问题，适合练习回溯算法里的搜索路径和剪枝。',
    site_review = '回溯算法的基础问题，代码较难一次写对。重点是访问标记要及时恢复，方向搜索不要写乱。'
WHERE id = 51;

UPDATE problem_review_topics
SET why_typical = '题号靠前，很经典的滑动窗口问题。',
    site_review = '重点是理解为什么可以使用「滑动窗口」：当窗口里出现重复字符时，左边界必须向右移动，窗口才重新合法。'
WHERE id = 20;

UPDATE problem_review_topics
SET why_typical = '题号靠前，常见基础考题。',
    site_review = '分析清楚「后进先出」，自然会想到使用栈。重点是遇到右括号时，只能和栈顶的左括号匹配。'
WHERE id = 33;

UPDATE problem_review_topics
SET why_typical = '双指针典型问题，也是理解「左右夹逼」的好例题。',
    site_review = '题号靠前。重点是理解为什么移动较短的那一边：宽度一定变小，只有短板变高，答案才有可能变大。'
WHERE id = 24;

UPDATE problem_review_topics
SET why_typical = '动态规划基础问题，其实就是斐波那契数列。',
    site_review = '动态规划问题如果之前没有学习过，面试的时候较难当场写出来。重点是看清楚最后一步来自前一阶还是前两阶。'
WHERE id = 53;

UPDATE problem_review_topics
SET why_typical = '双指针典型问题，适合理解有序数组里的「缩小搜索区间」。',
    site_review = '理解为什么可以使用「双指针」。「双指针」其实可以理解为排除法，缩小搜索区间。本题是「力扣」第 15 题的前置问题。'
WHERE id = 22;

UPDATE problem_review_topics
SET why_typical = '题目描述简单，如果没看过解答，还真不一定当场能想到解法。',
    site_review = '可以作为备考题目背一背思路。重点是从右上角或者左下角出发，每一步都能排除一行或者一列。'
WHERE id = 26;

UPDATE problem_review_topics
SET why_typical = '在「力扣」里 0-1 背包问题不多，本题题号靠前。',
    site_review = '需要理解问题如何转换成 0-1 背包问题：能不能选出一些数，使它们的和等于数组总和的一半。'
WHERE id = 69;

UPDATE problem_review_topics
SET why_typical = '典型哈希表应用，题号靠前，解法需要一点思考。',
    site_review = '面试笔试前值得做一下、复习一次。重点是只从连续序列的起点开始扩展，这样整体复杂度才是 O(n)。'
WHERE id = 47;

UPDATE problem_review_topics
SET why_typical = '原地哈希的典型应用，题目要求空间复杂度很苛刻。',
    site_review = '注意到数据的数值范围有限，数组本身就可以当做哈希表使用。重点是把数字放回它应该在的位置。'
WHERE id = 46;

UPDATE problem_review_topics
SET why_typical = '一道简单但很适合讲清楚二分查找边界的问题。',
    site_review = '题目要找的是平方以后小于等于 x 的最大整数，本质上属于「必须退出循环以后才能确定答案」的问题。'
WHERE id = 12;

UPDATE problem_review_topics
SET why_typical = '本题也不能在循环体内一下子找到答案，适合练习二分查找的判断方向。',
    site_review = '本题的「峰值」较难使用一个表达式表示出来，属于「必须退出循环以后才能确定答案」的问题。'
WHERE id = 14;

UPDATE problem_review_topics
SET why_typical = '本题也不能在循环体内一下子找到答案，是二分查找里比较有代表性的难题。',
    site_review = '本题有点难度，有很强的前提条件，可以当做例题学习。重点是用矩阵性质统计小于等于 mid 的元素个数。'
WHERE id = 16;

UPDATE problem_review_topics
SET why_typical = '链表学习第 1 题，也是修改指针的基础练习。',
    site_review = '需要设计清楚修改指针链接的先后顺序，也可以使用递归实现。重点是保存后继结点，避免链表断掉以后找不回来。'
WHERE id = 27;

UPDATE problem_review_topics
SET why_typical = '前缀和与哈希表的典型问题，重点在如何把「区间和」转换成「两个前缀和的差」。',
    site_review = '本题前缀和数组以哈希表的形式出现。重点是看到当前前缀和 prefix 时，去找之前出现过多少个 prefix - k。'
WHERE id = 72;

UPDATE problem_review_topics
SET why_typical = '本题是经典的「木棍分割」问题，适合理解二分查找也可以用来查找答案。',
    site_review = '可以当做例题学习。搞懂之后可以解决类似问题，例如「力扣」第 875 题：爱吃香蕉的珂珂。这类问题条件比较苛刻，重点要看清楚题目的关键条件。'
WHERE id = 17;

UPDATE problem_review_topics
SET why_typical = '完全背包的经典问题，也是动态规划里很常见的最值问题。',
    site_review = '重点是 dp[i] 表示凑出金额 i 所需的最少硬币数，再枚举最后一枚硬币。不要把它和排列组合类硬币问题混在一起。'
WHERE id = 62;

UPDATE problem_review_topics
SET why_typical = '动态规划经典问题，也可以用数学贪心做，但 DP 更适合作为学习材料。',
    site_review = '重点是理解「把整数 i 拆成两部分」以后，后半部分可以继续拆，也可以不继续拆。状态转移里这两种情况都要考虑。'
WHERE id = 63;

UPDATE problem_review_topics
SET why_typical = '旋转有序数组做这一题就可以了，其它旋转数组问题大多是在本题基础上增加判别条件。',
    site_review = '本质上本题属于「必须退出循环以后才能确定答案」的问题。重点是判断最小值在左半边还是右半边。'
WHERE id = 13;

UPDATE problem_review_topics
SET why_typical = '双指针典型问题，也是数组题里很经典的思维题。',
    site_review = '题号靠前。重点是理解为什么可以使用「双指针」：每次移动较低的一边，才能有机会获得更高的水位。'
WHERE id = 25;

UPDATE problem_review_topics
SET why_typical = '题目描述简单，而且有内容可聊，很多面试官爱考。',
    site_review = '实际上不会有人这么用，当成一道面试题准备即可。记住「负负得正」的思路：用两个队列翻转顺序。'
WHERE id = 34;

UPDATE problem_review_topics
SET why_typical = '题目描述简单，而且有内容可聊，很多面试官爱考。',
    site_review = '实际上不会有人这么用，当成一道面试题准备即可。记住「负负得正」的思路：用两个栈翻转顺序。'
WHERE id = 35;

UPDATE problem_review_topics
SET why_typical = '树的常规、基础问题，适合对比最大深度一起学习。',
    site_review = '广度优先遍历思路更直接，遇到第一个叶子结点即可返回。深度优先遍历也可以做，但空子树的处理要小心。'
WHERE id = 39;

UPDATE problem_review_topics
SET why_typical = '题号靠前，题目描述简单，是回溯算法入门题。',
    site_review = '考查是否学习过算法与数据结构。重点是理解路径、选择列表、撤销选择这三个动作。'
WHERE id = 48;

UPDATE problem_review_topics
SET why_typical = '快慢指针典型问题，也是链表题里很常见的考法。',
    site_review = '常考问题，解法比较固定，记住解法即可。重点是让快指针先走 N 步，再一起走到待删除结点的前一个位置。'
WHERE id = 29;

UPDATE problem_review_topics
SET why_typical = '滑动窗口典型问题，适合理解窗口为什么可以单调移动。',
    site_review = '重点是理解为什么可以使用「滑动窗口」：当窗口和已经满足条件后，右边界再右移只会更满足，因此可以尝试收缩左边界。'
WHERE id = 21;

UPDATE problem_review_topics
SET why_typical = '单调队列就这一题，是非常常见的考题了。',
    site_review = '本题结合了「栈」（后进先出）和「队列」（先进先出）的特点，因此合适的数据结构是双端队列。重点是队头维护窗口最大值。'
WHERE id = 36;

UPDATE problem_review_topics
SET why_typical = '题号靠前，比较经典的问题，有小概率会考到，也适合训练二分查找的另一种形式。',
    site_review = '思想简单：找到单调性。编码较复杂，是一个比较好的练习。可以在循环体内找到答案，也可以把答案留到最后处理。'
WHERE id = 19;

UPDATE problem_review_topics
SET why_typical = '快慢指针典型问题，也是链表题里最基础的判环问题。',
    site_review = '常考问题，解法单一，记住解法即可。重点是快指针每次走两步，慢指针每次走一步，如果有环一定会相遇。'
WHERE id = 30;

UPDATE problem_review_topics
SET why_typical = '本题如果套模板，很可能能做对，但不一定能说清楚为什么代码这么写。',
    site_review = '本题问题的本质是「必须退出循环以后才能确定答案」（区别于「可以在循环体内一下子找到答案」）。'
WHERE id = 3;

UPDATE problem_review_topics
SET why_typical = '如果乱套模板，会把代码写得很乱，是理解二分边界的好例题。',
    site_review = '本质上本题属于「必须退出循环以后才能确定答案」的问题。重点是分别找第一个大于等于 target 的位置和第一个大于 target 的位置。'
WHERE id = 11;

UPDATE problem_review_topics
SET why_typical = '双指针典型问题，也是「两数之和 II」的自然扩展。',
    site_review = '先理解「力扣」第 167 题，再做本题。重点是固定一个数以后，剩下两个数仍然可以用双指针缩小搜索区间。'
WHERE id = 23;

UPDATE problem_review_topics
SET why_typical = '本题描述简单，且考查知识点简单直接。',
    site_review = '写法挺多的，面试、笔试前需要练习。最直接的思路是中序遍历二叉搜索树，第 k 个访问到的结点就是答案。'
WHERE id = 44;

UPDATE problem_review_topics
SET why_typical = '题号靠前，动态规划经典问题，适合练习路径类 DP。',
    site_review = '需要定义清楚状态，边界条件的讨论也需要注意。重点是每个位置只能从上一层相邻两个位置转移过来。'
WHERE id = 54;

UPDATE problem_review_topics
SET why_typical = '树形动态规划的经典问题，是「打家劫舍」系列里很值得看的变形。',
    site_review = '重点是每个结点都有两个状态：偷当前结点、不偷当前结点。想清楚这两个状态，递归写法就比较自然。'
WHERE id = 67;

UPDATE problem_review_topics
SET why_typical = '动态规划经典问题，学习动态规划基本都会学习到这道题。',
    site_review = 'O(n log n) 解法需要描述清楚状态。重点是 tails 数组的含义：长度为 i 的上升子序列，结尾尽量小才有利于后续扩展。'
WHERE id = 57;

UPDATE problem_review_topics
SET why_typical = '二维动态规划经典问题，适合练习「以当前位置为右下角」的状态定义。',
    site_review = '重点是 dp[i][j] 表示以当前位置为右下角的最大正方形边长。只有左、上、左上三个方向都支持，正方形才能继续变大。'
WHERE id = 64;

UPDATE problem_review_topics
SET why_typical = '本题类似「力扣」第 410 题，先搞懂那道题再做本题，思路就很清楚。',
    site_review = '虽然经常被归为「最大值极小化」问题，但本质上还是查找一个整数、查找最值，所以可以使用「二分查找」。'
WHERE id = 18;

UPDATE problem_review_topics
SET why_typical = '树的基础问题，也有话题性。说是 homebrew 的作者面试时没有做出来，我觉得这很正常，也不能说明什么。',
    site_review = '用遍历即可，深度优先遍历或者广度优先遍历都可以。重点是交换每个结点的左右子树。'
WHERE id = 43;

UPDATE problem_review_topics
SET why_typical = '常考问题，题目描述简单，但真正编码并不轻松。',
    site_review = '树的问题基本上不是深度优先遍历，就是广度优先遍历。本题重点是序列化和反序列化要使用同一种规则，空结点也要记录。'
WHERE id = 42;

UPDATE problem_review_topics
SET why_typical = '题目描述简单，并且比较容易筛选出是否学习过算法与数据结构。',
    site_review = '结合公共祖先的定义，应该向上看；向上看就是「后序遍历」。如果硬从代码本身来记，会记成递归，反而比较难记。'
WHERE id = 41;

UPDATE problem_review_topics
SET why_typical = '「力扣」第一题，描述简单，是哈希表最典型的入门应用。',
    site_review = '如果没有学习过哈希表，不知道哈希表这种数据结构，本题很难以 O(n) 复杂度实现。重点是边遍历边查找 target - nums[i]。'
WHERE id = 45;

UPDATE problem_review_topics
SET why_typical = '经典动态规划问题，和「力扣」第 53 题最大子数组和很像。',
    site_review = '和最大子数组和类似，也要定义以当前位置结尾的状态。但乘积有正负号变化，所以最大值和最小值都要维护。'
WHERE id = 58;

UPDATE problem_review_topics
SET why_typical = '题号靠前，描述简单，但回溯状态的设计很有代表性。',
    site_review = '根据 3 个规则，已经放好的皇后位置需要记录下来。重点是列、主对角线、副对角线都不能冲突。'
WHERE id = 52;

UPDATE problem_review_topics
SET why_typical = '字符串动态规划经典问题，适合练习「最后一步」的分类讨论。',
    site_review = '重点是看当前位置能不能单独解码，以及能不能和前一个字符一起解码。边界和 0 的处理很容易写错。'
WHERE id = 59;

UPDATE problem_review_topics
SET why_typical = '动态规划经典问题，也可以从字符串切分的角度理解。',
    site_review = '重点是 dp[i] 表示前 i 个字符能否被拆分，再枚举最后一个单词的起点。哈希表用于快速判断某一段是不是单词。'
WHERE id = 60;

COMMIT;

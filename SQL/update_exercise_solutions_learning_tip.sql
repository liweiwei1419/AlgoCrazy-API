-- SELECT T
--            .ID,
--        T.leetcode_number,
--        T.title,
--        T.learning_tip
-- FROM
--     exercise_solutions T
START TRANSACTION;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练动态规划里「以当前位置结尾」的状态定义。不要急着背代码，重点看清楚 dp[i] 表示什么，以及为什么答案不是最后一个状态，而是所有状态里的最大值。'
WHERE id = 266;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查算法与数据结构的基础知识：循环不变量。编码者需要说清楚变量的含义，变量定义明确以后，「初始值、先赋值还是先移动、返回值」就比较容易写出。'
WHERE id = 11;

UPDATE exercise_solutions
SET learning_tip = '本题可以用贪心，也可以用动态规划理解。重点不是记住一段代码，而是看清楚什么时候趋势发生改变，为什么只记录上升和下降两个状态就够了。'
WHERE id = 257;

UPDATE exercise_solutions
SET learning_tip = '本题是「逆序对」和「力扣」第 315 题的进阶版本，定义了更强的逆序关系。建议先搞懂归并排序统计逆序对，再做本题；如果准备时间有限，本题可以往后放。'
WHERE id = 15;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二叉树遍历和指针重连。重点看清楚展开后的顺序其实是前序遍历，编码时不要只想着遍历，还要注意左右子树重新连接的先后顺序。'
WHERE id = 137;

UPDATE exercise_solutions
SET learning_tip = '本题是「合并两个有序链表」的扩展，也常被称为多路合并。重点是理解优先队列里放什么，以及每弹出一个结点以后，应该把哪个后继结点补进去。'
WHERE id = 118;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和的变形。不要被题面绕住，重点是把「奇数个数恰好为 k」转换成两个前缀计数的差。'
WHERE id = 212;

UPDATE exercise_solutions
SET learning_tip = '本题是两个序列上的动态规划经典问题。重点是定义清楚 dp[i][j] 的含义，再讨论两个字符相等和不相等两种情况；不要只背状态转移方程。'
WHERE id = 289;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查循环不变量。重点是想清楚 slow 指针代表什么：它通常表示下一个可以写入的位置，定义清楚以后代码就很顺。'
WHERE id = 10;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练优先队列在动态求最值中的应用。中位数可以看成前半部分的最大值和后半部分的最小值，因此用两个堆维护边界。'
WHERE id = 120;

UPDATE exercise_solutions
SET learning_tip = '本题是链表基础题。重点是利用有序这个条件，只需要比较当前结点和下一个结点；修改 next 指针前要想清楚是否会跳过结点。'
WHERE id = 70;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练滑动窗口。重点是窗口长度固定以后，如何维护字符计数；不要每次重新统计整个窗口。'
WHERE id = 50;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练状态压缩和前缀思想。重点是把五个元音的奇偶状态压成一个整数，再记录每个状态第一次出现的位置。'
WHERE id = 213;

UPDATE exercise_solutions
SET learning_tip = '本题是优先队列的直接应用。重点是维护一个大小为 k 的小顶堆，堆顶就是当前第 k 大元素。'
WHERE id = 115;

UPDATE exercise_solutions
SET learning_tip = '本题是股票问题里最基础的一题。重点是维护到当前位置为止的最低买入价格，而不是枚举所有买卖日期。'
WHERE id = 280;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练排列计数和定位。重点是用阶乘确定当前位应该选哪个数，而不是把所有排列都生成出来。'
WHERE id = 234;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查循环不变量。重点是定义清楚可以保留到什么位置，以及当前元素是否允许写入。'
WHERE id = 12;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法的综合题。重点是把行、列、宫格的约束维护清楚，搜索时选择一个空格尝试数字并及时撤销。'
WHERE id = 245;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表最基础的应用。重点不是题目难，而是知道哈希表可以用空间换时间，把重复判断从 O(n^2) 降到 O(n)。'
WHERE id = 166;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练带重复元素的回溯。重点是排序以后在同一层跳过重复选择，而不是在最后用集合去重。'
WHERE id = 227;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表拆分和拼接。重点是分别维护小于 x 和大于等于 x 的两条链表，最后再连接起来。'
WHERE id = 73;

UPDATE exercise_solutions
SET learning_tip = '本题是数据结构设计题。重点不是业务逻辑，而是如何组织用户、关注关系和推文流，尤其是取最近动态时可以借助优先队列。'
WHERE id = 119;

UPDATE exercise_solutions
SET learning_tip = '本题可以作为动态规划基础题，也可以从图的最短路径角度理解。重点是 dp[i] 表示组成 i 所需的最少完全平方数个数。'
WHERE id = 214;

UPDATE exercise_solutions
SET learning_tip = '本题是股票动态规划的进阶题。重点是把最多两次交易拆成几个状态，不要只凭感觉讨论买入和卖出。'
WHERE id = 281;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表或者计数数组。重点是看清字符范围，如果只有小写字母，数组计数比哈希表更直接。'
WHERE id = 168;

UPDATE exercise_solutions
SET learning_tip = '本题是字符串动态规划里的难题。重点是理解星号只影响它前面的字符，状态转移要围绕「匹配 0 次」和「匹配多次」讨论。'
WHERE id = 291;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查前序和中序遍历的定义。重点是用前序找到根结点，再用中序切分左右子树；哈希表可以避免反复查找。'
WHERE id = 147;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心的基础题。重点是维护当前能够到达的最远位置，只要当前位置在可达范围内，就可以继续向后扩展。'
WHERE id = 253;

UPDATE exercise_solutions
SET learning_tip = '本题是数据结构设计题。重点不是业务逻辑，而是如何组织用户、关注关系和推文流，尤其是取最近动态时可以借助优先队列。'
WHERE id = 87;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表降维。重点是把四个数组分成两组，先统计前两组的和，再在后两组里找相反数。'
WHERE id = 180;

UPDATE exercise_solutions
SET learning_tip = '本题是栈的典型应用。重点是遇到数字入栈，遇到运算符弹出两个数计算；注意两个操作数的顺序不要反。'
WHERE id = 94;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练数组模拟队列。重点是理解循环数组里 head、tail、size 的含义，避免空和满的判断混乱。'
WHERE id = 112;

UPDATE exercise_solutions
SET learning_tip = '本题是广度优先遍历的基础题。重点是按层处理队列，一层的数量要先记录下来，这样才能把结果分层。'
WHERE id = 128;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈的经典难题。重点是理解一个柱子被弹出时，左右边界已经确定，此时可以计算以它为高度的最大矩形。'
WHERE id = 101;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练单调栈和贪心。重点是既要保证字典序尽量小，又要保证每个字符至少还能在后面出现。'
WHERE id = 102;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈入门题。重点是从右往左或用栈维护还没找到更大元素的数，理解栈里为什么保持单调。'
WHERE id = 103;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表计数。重点是处理重复次数，而不是只判断元素是否出现过。'
WHERE id = 170;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划最基础的问题。重点是看到状态可以由前两个状态推出，同时注意只用两个变量即可优化空间。'
WHERE id = 260;

UPDATE exercise_solutions
SET learning_tip = '本题是树的基础题。重点是函数返回什么：当前结点所在子树的最大深度；想清楚返回值，递归就自然了。'
WHERE id = 124;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练递归比较。重点是同时看两个结点：值是否相同、左子树是否相同、右子树是否相同。'
WHERE id = 131;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练树上的回溯。重点是路径进入时加入当前结点，离开时撤销选择，只有叶子结点才判断是否满足要求。'
WHERE id = 136;

UPDATE exercise_solutions
SET learning_tip = '本题是树形动态规划经典题。重点是区分「向父结点返回的最大贡献」和「全局最大路径和」，前者只能选一边，后者可以连接两边。'
WHERE id = 295;

UPDATE exercise_solutions
SET learning_tip = '本题是快速排序 partition 和优先队列的经典练习。重点是理解 partition 返回的位置为什么可以帮助我们只找第 K 大，而不是完整排序。'
WHERE id = 17;

UPDATE exercise_solutions
SET learning_tip = '本题是线性动态规划基础题。重点是每间房只有偷和不偷两种选择，当前状态依赖前一间和前两间。'
WHERE id = 267;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是用 start 控制下一次从哪里选，避免重复组合。'
WHERE id = 230;

UPDATE exercise_solutions
SET learning_tip = '本题是广度优先遍历的典型应用。重点是把每一个状态看成图上的一个点，BFS 可以保证第一次到达目标就是最短步数。'
WHERE id = 220;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表和滑动窗口的结合。重点是只关心距离不超过 k 的元素，窗口外的数据要及时移除。'
WHERE id = 175;

UPDATE exercise_solutions
SET learning_tip = '本题是链表题里比较特殊的一题。重点是不能访问前驱结点时，可以把下一个结点的值复制过来，再删除下一个结点。'
WHERE id = 66;

UPDATE exercise_solutions
SET learning_tip = '本题是字符串动态规划的经典难题。重点是 dp[i][j] 表示两个前缀的最少操作次数，再分别讨论插入、删除、替换。'
WHERE id = 290;

UPDATE exercise_solutions
SET learning_tip = '本题适合作为算法与数据结构的练习题。重点不是背代码，而是看清楚题目真正训练的思想，并能说清楚为什么这种做法成立。'
WHERE id = 16;

UPDATE exercise_solutions
SET learning_tip = '本题是路径类动态规划基础题。重点是每个格子只能从上方或左方过来，状态定义清楚后转移很直接。'
WHERE id = 263;

UPDATE exercise_solutions
SET learning_tip = '本题是树遍历基础题。重点是理解前序遍历的顺序：根、左、右；递归和迭代都可以练习。'
WHERE id = 140;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和与哈希表。重点是两个前缀和模 k 的余数相同，它们中间这段子数组的和就能被 k 整除。'
WHERE id = 211;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表映射。重点是 pattern 到单词、单词到 pattern 都要一致，只做单向映射容易漏情况。'
WHERE id = 173;

UPDATE exercise_solutions
SET learning_tip = '本题是链表基础题。重点是比较两个链表当前头结点，使用虚拟头结点可以让指针处理更统一。'
WHERE id = 67;

UPDATE exercise_solutions
SET learning_tip = '本题是路径类动态规划基础题。重点是每个位置的最小路径和只依赖上方和左方，边界行列要单独处理。'
WHERE id = 265;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表基本操作。重点是下标、虚拟头结点、插入和删除时指针顺序，写之前最好先画图。'
WHERE id = 90;

UPDATE exercise_solutions
SET learning_tip = '本题是偏工程化的数据结构题。重点是理解跳表用多层链表加速查找，编码细节较多，不是所有人都必须掌握。'
WHERE id = 91;

UPDATE exercise_solutions
SET learning_tip = '本题是逆序对问题的进阶版本。重点是使用索引数组，在归并排序统计逆序关系时保留元素原来的位置。'
WHERE id = 14;

UPDATE exercise_solutions
SET learning_tip = '本题是学习归并排序和分治思想的经典练习。重点是在合并两个有序子数组时，顺便快速统计逆序对数量。'
WHERE id = 13;

UPDATE exercise_solutions
SET learning_tip = '本题可以用优先队列，也可以利用字符种类有限做计数排序。重点是先统计频率，再按照频率组织结果。'
WHERE id = 18;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心算法基础题。重点是理解多次交易可以拆成每天相邻价格的上涨收益，只要上涨就可以收入答案。'
WHERE id = 246;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表和优先队列。重点是先统计频率，再维护大小为 k 的堆。'
WHERE id = 116;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是窗口里最多只能有两种水果，超过两种时就要移动左边界。'
WHERE id = 53;

UPDATE exercise_solutions
SET learning_tip = '本题是快慢指针典型问题。重点是理解相遇以后为什么让一个指针回到头结点，再一起走会在入环点相遇。'
WHERE id = 82;

UPDATE exercise_solutions
SET learning_tip = '本题是树遍历基础题。重点是理解中序遍历的顺序：左、根、右；在二叉搜索树中，中序遍历还有有序性质。'
WHERE id = 141;

UPDATE exercise_solutions
SET learning_tip = '本题可以用栈，也可以用动态规划。重点是看当前位置如果是右括号，它能和谁配对，以及配对后前面那一段能不能接上。'
WHERE id = 286;

UPDATE exercise_solutions
SET learning_tip = '本题是三数之和的变形。重点是排序以后固定一个数，再用双指针缩小搜索区间，同时维护离目标最近的答案。'
WHERE id = 58;

UPDATE exercise_solutions
SET learning_tip = '本题可以用栈，也可以用动态规划。重点是看当前位置如果是右括号，它能和谁配对，以及配对后前面那一段能不能接上。'
WHERE id = 96;

UPDATE exercise_solutions
SET learning_tip = '本题是广度优先遍历的典型应用。重点是从所有 0 同时出发做多源 BFS，而不是每个 1 单独去找最近的 0。'
WHERE id = 216;

UPDATE exercise_solutions
SET learning_tip = '本题是树遍历基础题。重点是理解后序遍历的顺序：左、右、根；很多树形动态规划都带有后序遍历的味道。'
WHERE id = 142;

UPDATE exercise_solutions
SET learning_tip = '本题是股票动态规划的变形。重点是冷冻期会影响买入状态，因此需要把持有、卖出、冷冻等状态定义清楚。'
WHERE id = 283;

UPDATE exercise_solutions
SET learning_tip = '本题可以用贪心，也可以用动态规划理解。重点不是记住一段代码，而是看清楚什么时候趋势发生改变，为什么只记录上升和下降两个状态就够了。'
WHERE id = 278;

UPDATE exercise_solutions
SET learning_tip = '本题可以从动态规划或最短路角度理解。重点是中转次数是限制条件，不能直接套普通最短路。'
WHERE id = 190;

UPDATE exercise_solutions
SET learning_tip = '本题是图建模问题。重点是把等式看成带权边，查询就是在图里找一条路径并累乘边权。'
WHERE id = 191;

UPDATE exercise_solutions
SET learning_tip = '学习递归问题时，不要只看递归写法，要理解背后的思想是分而治之。本题把大问题拆成一半计算，是快速幂的典型例题。'
WHERE id = 304;

UPDATE exercise_solutions
SET learning_tip = '本题是 Trie 的应用题。重点是把 key 按字符插入前缀树，同时维护前缀对应的累计值。'
WHERE id = 201;

UPDATE exercise_solutions
SET learning_tip = '本题是二分答案的难题。重点是二分距离，再用双指针统计距离小于等于 mid 的数对个数。'
WHERE id = 41;

UPDATE exercise_solutions
SET learning_tip = '本题是路径类动态规划的变形。重点是障碍物会让当前位置不可达，状态转移前要先处理障碍。'
WHERE id = 264;

UPDATE exercise_solutions
SET learning_tip = '本题是 Trie 的设计题。重点是普通字符按路径查找，遇到点号时要尝试所有可能的子结点。'
WHERE id = 200;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二维前缀和。重点是预处理以后，每次查询都用四个角的前缀和快速得到矩形区域和。'
WHERE id = 205;

UPDATE exercise_solutions
SET learning_tip = '本题是单词接龙的进阶版本。重点是 BFS 建最短路径层次，再用回溯还原所有最短路径，编码量比较大。'
WHERE id = 219;

UPDATE exercise_solutions
SET learning_tip = '本题是链表双指针经典题。重点是两个指针分别走完自己的链表后切到另一条链表，长度差会被抵消。'
WHERE id = 83;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练双向映射。重点是两个字符串中的字符必须一一对应，只检查一个方向不够。'
WHERE id = 174;

UPDATE exercise_solutions
SET learning_tip = '这是二分查找最基础的问题：在有序数组中查找一个数。可以用本题验证你掌握的二分查找模板是否逻辑清楚。'
WHERE id = 19;

UPDATE exercise_solutions
SET learning_tip = '本题主要利用二叉搜索树中序遍历有序的性质。重点是找到中序序列中被破坏的两个位置，再交换它们的值。'
WHERE id = 163;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀积和后缀积。重点是在不能使用除法的条件下，分别记录当前位置左边和右边的乘积。'
WHERE id = 276;

UPDATE exercise_solutions
SET learning_tip = '本题是广度优先遍历的经典问题。重点是为什么使用 BFS：题目问最短转换序列，第一次到达目标就是最短。'
WHERE id = 218;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀积和后缀积。重点是在不能使用除法的条件下，分别记录当前位置左边和右边的乘积。'
WHERE id = 207;

UPDATE exercise_solutions
SET learning_tip = '本题是数据结构设计题。重点是在允许重复的情况下，哈希表里需要保存一个值对应的多个下标。'
WHERE id = 186;

UPDATE exercise_solutions
SET learning_tip = '本题是 BFS 状态搜索。重点是把棋盘编码成字符串状态，再在状态图上寻找最短交换次数。'
WHERE id = 221;

UPDATE exercise_solutions
SET learning_tip = '本题是完全背包的经典问题。重点是 dp[i] 表示凑出金额 i 所需的最少硬币数，再枚举最后一枚硬币。'
WHERE id = 301;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练多指针动态规划。重点是下一个丑数一定来自当前某个丑数乘以 2、3、5，并且要处理重复。'
WHERE id = 288;

UPDATE exercise_solutions
SET learning_tip = '本题是拓扑排序应用。重点是在判断是否能学完的基础上，还需要输出一个合法的学习顺序。'
WHERE id = 222;

UPDATE exercise_solutions
SET learning_tip = '本题是股票动态规划的变形。重点是手续费应该在买入或卖出时扣一次，不要重复扣。'
WHERE id = 284;

UPDATE exercise_solutions
SET learning_tip = '本题是并查集或者图遍历基础题。重点是把相连城市看成一个集合，最后统计连通分量数量。'
WHERE id = 241;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二分查找。重点是先判断答案是否能在循环体内确定，还是必须退出循环以后才能确定。'
WHERE id = 25;

UPDATE exercise_solutions
SET learning_tip = '本题适合作为算法与数据结构的练习题。重点不是背代码，而是看清楚题目真正训练的思想，并能说清楚为什么这种做法成立。'
WHERE id = 20;

UPDATE exercise_solutions
SET learning_tip = '本题是树遍历基础题。重点是 N 叉树的孩子不止两个，但遍历思想仍然是先访问根，再依次访问孩子。'
WHERE id = 143;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表上的插入操作。重点是使用虚拟头结点，在已排序部分找到插入位置后修改指针。'
WHERE id = 75;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查循环不变量。重点是 slow 指针表示下一个可写位置，当前元素与前一个保留元素不同才写入。'
WHERE id = 303;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练树的递归返回值设计。重点是每个结点同时返回深度和对应子树，左右深度相同时当前结点就是答案。'
WHERE id = 297;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练分治思想。重点是找到链表中点作为根结点，左右两段分别构造左右子树。'
WHERE id = 80;

UPDATE exercise_solutions
SET learning_tip = '本题是广度优先遍历基础题。重点是队列按层处理，遍历每个结点的所有孩子。'
WHERE id = 145;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表和双向链表的综合设计题。重点是哈希表负责 O(1) 查找，双向链表负责维护最近使用顺序。'
WHERE id = 88;

UPDATE exercise_solutions
SET learning_tip = '本题是拓扑排序基础题。重点是把课程依赖看成有向图，判断图里是否存在环。'
WHERE id = 223;

UPDATE exercise_solutions
SET learning_tip = '本题是栈的应用。重点是按斜杠切分路径，遇到普通目录入栈，遇到两个点弹栈，一个点忽略。'
WHERE id = 93;

UPDATE exercise_solutions
SET learning_tip = '本题是数据结构设计题。重点是数组支持随机访问，哈希表支持 O(1) 定位，删除时用最后一个元素补位。'
WHERE id = 185;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练分治。重点是每次选择中间元素作为根结点，这样才能构造高度平衡的二叉搜索树。'
WHERE id = 153;

UPDATE exercise_solutions
SET learning_tip = '本题是设计迭代器的问题。重点是不要一次性只看表面结构，要理解如何按需展开嵌套列表。'
WHERE id = 97;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表底层思想。重点是理解哈希函数、桶、冲突处理，而不是只会调用现成的 Map。'
WHERE id = 165;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练排序和双指针。重点是固定最长边后，利用单调性统计满足两边之和大于最长边的数量。'
WHERE id = 32;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二叉搜索树中序遍历的迭代写法。重点是用栈模拟递归，并做到按需返回下一个最小值。'
WHERE id = 158;

UPDATE exercise_solutions
SET learning_tip = '本题的特点是可以在循环体内找到目标。重点是每次判断哪一半有序，再决定目标可能在哪一半。'
WHERE id = 24;

UPDATE exercise_solutions
SET learning_tip = '本题是图遍历基础题。重点是遇到陆地就启动一次 DFS 或 BFS，并把同一个岛屿全部标记掉。'
WHERE id = 193;

UPDATE exercise_solutions
SET learning_tip = '本题是旋转数组最小值的进阶版本。重点是有重复元素时，某些判断会失效，需要谨慎收缩边界。'
WHERE id = 34;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找的典型应用。重点是通过比较 arr[mid] 和 arr[mid + 1] 判断峰顶在左边还是右边。'
WHERE id = 36;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是选择数字时控制起点、剩余个数和剩余和，及时剪枝。'
WHERE id = 233;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练后序遍历。重点是先知道左右子树高度，才能判断当前子树是否平衡。'
WHERE id = 161;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二分查找。重点是数组已经有序，可以查找第一个满足 citations[i] >= n - i 的位置。'
WHERE id = 39;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法经典题。重点是每一步还能放多少左括号、右括号，右括号数量不能超过已经放过的左括号。'
WHERE id = 235;

UPDATE exercise_solutions
SET learning_tip = '本题可以用 DFS 染色，也可以反向建图做拓扑排序。重点是理解安全状态表示最终不会进入环。'
WHERE id = 225;

UPDATE exercise_solutions
SET learning_tip = '本题有多种做法，经典解法是把数组看成链表来找环。重点是理解数值范围和下标之间形成的映射。'
WHERE id = 38;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是每一段长度最多 3，数值不能超过 255，并且前导零要小心处理。'
WHERE id = 237;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二分查找和排序。重点是把区间起点排序后，为每个右端点查找第一个大于等于它的起点。'
WHERE id = 31;

UPDATE exercise_solutions
SET learning_tip = '本题可以作为动态规划基础题，也可以从图的最短路径角度理解。重点是 dp[i] 表示组成 i 所需的最少完全平方数个数。'
WHERE id = 273;

UPDATE exercise_solutions
SET learning_tip = '本题是图遍历基础题。重点是遇到陆地就启动一次 DFS 或 BFS，并把同一个岛屿全部标记掉。'
WHERE id = 239;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是访问标记要及时恢复，四个方向搜索时不要把同一个格子重复使用。'
WHERE id = 240;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口经典题。重点是窗口内不能有重复字符，一旦重复就移动左边界直到窗口重新合法。'
WHERE id = 46;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和与哈希表。重点是把 0 看成 -1，这样问题就变成寻找前缀和相同的最远两点。'
WHERE id = 210;

UPDATE exercise_solutions
SET learning_tip = '本题是链表基础题。重点是使用虚拟头结点统一删除头结点和中间结点的情况。'
WHERE id = 68;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查中序和后序遍历的定义。重点是后序最后一个元素是根结点，再用中序切分左右子树。'
WHERE id = 148;

UPDATE exercise_solutions
SET learning_tip = '本题是栈的典型应用。重点是遇到右括号时，只能和栈顶的左括号匹配。'
WHERE id = 92;

UPDATE exercise_solutions
SET learning_tip = '本题是双指针典型题。重点是理解为什么移动较短的一边：宽度变小以后，只有短板变高，答案才可能变大。'
WHERE id = 305;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表指针操作。重点是画清楚指针变化顺序，尤其是修改 next 之前要保存后继结点。'
WHERE id = 86;

UPDATE exercise_solutions
SET learning_tip = '本题适合作为算法与数据结构的练习题。重点不是背代码，而是看清楚题目真正训练的思想，并能说清楚为什么这种做法成立。'
WHERE id = 204;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练贪心和规则编码。重点是把特殊值也放进映射表，从大到小尽量匹配。'
WHERE id = 252;

UPDATE exercise_solutions
SET learning_tip = '本题是二叉搜索树基础题。重点是利用左小右大的性质，每一步只需要走一边。'
WHERE id = 151;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表指针操作。重点是先计算长度，再把链表连成环，找到新的尾结点后断开。'
WHERE id = 69;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和思想。重点是当前位置左边和右边的和可以由总和和当前前缀快速得到。'
WHERE id = 206;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表局部反转。重点是使用虚拟头结点，画清楚每一组两个结点交换时指针如何变化。'
WHERE id = 71;

UPDATE exercise_solutions
SET learning_tip = '本题是区间贪心经典题。重点是按右端点排序，每次尽量用当前箭覆盖更多气球。'
WHERE id = 250;

UPDATE exercise_solutions
SET learning_tip = '本题是双指针基础题。当前最小值和最大值相加太小，说明最小值太小；相加太大，说明最大值太大。'
WHERE id = 56;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心问题。重点是从左到右满足右边比左边高，再从右到左满足左边比右边高，最后取两次约束的结果。'
WHERE id = 255;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口经典难题。重点是窗口满足条件后尽量收缩左边界，同时维护字符计数是否仍然覆盖目标。'
WHERE id = 49;

UPDATE exercise_solutions
SET learning_tip = '本题比较容易想到二分查找，但更标准的做法是从右上角或左下角开始。每一步都能排除一行或一列，这个思路需要记一下。'
WHERE id = 63;

UPDATE exercise_solutions
SET learning_tip = '本题是 0-1 背包的典型应用。重点是把问题转换成：能不能选出一些数，使它们的和等于总和的一半。'
WHERE id = 306;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练括号匹配。重点是用一个变量记录当前还需要匹配的左括号数量，遇到无法匹配的右括号就需要补一个左括号。'
WHERE id = 258;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表经典题。重点是只从连续序列的起点开始向后扩展，这样整体复杂度才是 O(n)。'
WHERE id = 183;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表统计斜率。重点是斜率要用约分后的整数对表示，避免浮点误差。'
WHERE id = 187;

UPDATE exercise_solutions
SET learning_tip = '本题是图建模问题。重点是把等式看成带权边，查询就是在图里找一条路径并累乘边权。'
WHERE id = 198;

UPDATE exercise_solutions
SET learning_tip = '本题适合作为算法与数据结构的练习题。重点不是背代码，而是看清楚题目真正训练的思想，并能说清楚为什么这种做法成立。'
WHERE id = 287;

UPDATE exercise_solutions
SET learning_tip = '本题是 Trie 和回溯的结合。重点是用前缀树剪枝，否则对每个单词单独搜索会很慢。'
WHERE id = 203;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练计数。重点是先统计每个字符出现次数，再按原顺序找到第一个次数为 1 的字符。'
WHERE id = 167;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表计数。重点是固定一个点，统计其它点到它的距离，相同距离的点可以形成排列。'
WHERE id = 182;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表经典题。重点是只从连续序列的起点开始向后扩展，这样整体复杂度才是 O(n)。'
WHERE id = 195;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表分组。重点是为每个字符串构造一个稳定的 key，可以排序，也可以使用字符计数。'
WHERE id = 179;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希集合的基础应用。重点是只关心元素是否出现过，不关心重复次数。'
WHERE id = 169;

UPDATE exercise_solutions
SET learning_tip = '本题是原地哈希经典题。重点是把数值 x 放到下标 x - 1 的位置，数组本身就可以当哈希表。'
WHERE id = 178;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是每个元素都有选和不选两种选择，也可以用 start 逐步枚举。'
WHERE id = 231;

UPDATE exercise_solutions
SET learning_tip = '本题是完全背包的经典问题。重点是 dp[i] 表示凑出金额 i 所需的最少硬币数，再枚举最后一枚硬币。'
WHERE id = 215;

UPDATE exercise_solutions
SET learning_tip = '本题是层序遍历的变形。重点是每一层遍历后根据层数决定是否反转，或者用双端队列控制插入方向。'
WHERE id = 130;

UPDATE exercise_solutions
SET learning_tip = '本题是多路合并和优先队列的应用。重点是不要枚举所有数对，而是从最小候选开始逐步扩展。'
WHERE id = 123;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练分治思想。重点是找到链表中点作为根结点，左右两段分别构造左右子树。'
WHERE id = 154;

UPDATE exercise_solutions
SET learning_tip = '本题主要考查二叉搜索树定义。重点是不能只比较当前结点和左右孩子，还要维护整个子树的上下界。'
WHERE id = 155;

UPDATE exercise_solutions
SET learning_tip = '本题可以用双指针。重点是两个平方数之和与目标比较后，决定移动左指针还是右指针。'
WHERE id = 60;

UPDATE exercise_solutions
SET learning_tip = '本题是快速排序 partition 和优先队列的经典练习。重点是理解 partition 返回的位置为什么可以帮助我们只找第 K 大，而不是完整排序。'
WHERE id = 117;

UPDATE exercise_solutions
SET learning_tip = '本题属于「查找一个有范围的整数」。重点是找平方后小于等于 x 的最大整数，答案通常要在循环结束后确定。'
WHERE id = 28;

UPDATE exercise_solutions
SET learning_tip = '本题是带重复元素的子集问题。重点是排序以后在同一层跳过重复选择，避免生成重复结果。'
WHERE id = 232;

UPDATE exercise_solutions
SET learning_tip = '本题适合作为算法与数据结构的练习题。重点不是背代码，而是看清楚题目真正训练的思想，并能说清楚为什么这种做法成立。'
WHERE id = 62;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找的典型应用。重点是通过相邻元素的上升或下降趋势判断峰值在哪一边。'
WHERE id = 35;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找的进阶题。重点是二分答案值，再统计矩阵中小于等于 mid 的元素个数。'
WHERE id = 40;

UPDATE exercise_solutions
SET learning_tip = '本题是链表学习的第一题。重点是修改 next 指针前保存后继结点，避免链表断掉以后找不回来。'
WHERE id = 64;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和与哈希表。重点是看到当前前缀和 prefix 时，去找之前出现过多少个 prefix - k。'
WHERE id = 208;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练循环数组。重点是双端都能插入和删除，因此 head、tail、size 的定义要非常清楚。'
WHERE id = 113;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈典型题。重点是栈里保存还没找到更高温度的下标，遇到更高温度时不断出栈结算答案。'
WHERE id = 100;

UPDATE exercise_solutions
SET learning_tip = '本题可以用单调栈。重点是先维护一个递减下标栈，再从右往左寻找能形成最大宽度的位置。'
WHERE id = 107;

UPDATE exercise_solutions
SET learning_tip = '本题是层序遍历或深度优先遍历的应用。重点是每一层最右边的结点才会被看到。'
WHERE id = 127;

UPDATE exercise_solutions
SET learning_tip = '本题是二分答案经典题。重点是二分最大子数组和，再判断能否在不超过 m 段的条件下完成分割。'
WHERE id = 42;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表上的归并排序。重点是用快慢指针切分链表，再合并两个有序链表。'
WHERE id = 85;

UPDATE exercise_solutions
SET learning_tip = '本题可以用哈希集合，也可以用快慢指针。重点是过程一定会进入循环，判断是否能到 1。'
WHERE id = 172;

UPDATE exercise_solutions
SET learning_tip = '本题是层序遍历的变形。重点是先按正常层序遍历收集结果，最后反转层的顺序即可。'
WHERE id = 129;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找的综合题。重点是先找峰顶，再分别在左右两段有序区间里二分查找。'
WHERE id = 37;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划经典问题，也可以用数学贪心。DP 的重点是讨论拆成两部分后，后半部分是否继续拆。'
WHERE id = 247;

UPDATE exercise_solutions
SET learning_tip = '本题是区间贪心问题。重点是按右端点排序，尽量保留结束早的区间，给后面的区间留下空间。'
WHERE id = 249;

UPDATE exercise_solutions
SET learning_tip = '本题是区间动态规划经典难题。重点是反过来想最后戳破哪个气球，而不是正向模拟戳气球。'
WHERE id = 293;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找基础题。重点是数组有序且答案可能循环到第一个字符。'
WHERE id = 30;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划基础题，本质上是斐波那契数列。重点是最后一步可能从前一阶来，也可能从前两阶来。'
WHERE id = 261;

UPDATE exercise_solutions
SET learning_tip = '本题可以用贪心或并查集。重点是把情侣关系和座位关系建模清楚，别只盯着交换过程。'
WHERE id = 197;

UPDATE exercise_solutions
SET learning_tip = '本题是完全背包的经典问题。重点是 dp[i] 表示凑出金额 i 所需的最少硬币数，再枚举最后一枚硬币。'
WHERE id = 274;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练树形递归。重点是直径可能经过当前结点，因此每个结点都要用左右子树深度更新答案。'
WHERE id = 296;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划经典问题，也可以用数学贪心。DP 的重点是讨论拆成两部分后，后半部分是否继续拆。'
WHERE id = 275;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表或布尔数组标记。重点是行、列、九宫格三个维度都不能重复。'
WHERE id = 184;

UPDATE exercise_solutions
SET learning_tip = '本题是链表局部反转。重点是找到反转区间的前一个结点，然后在区间内部逐步头插。'
WHERE id = 65;

UPDATE exercise_solutions
SET learning_tip = '本题是原地哈希思想。重点是利用数值范围 1 到 n，把出现过的数字映射回数组位置。'
WHERE id = 177;

UPDATE exercise_solutions
SET learning_tip = '本题把有序数组放在二维表格中。重点是理解二维坐标和一维下标之间的转换，本质仍然是二分查找。'
WHERE id = 22;

UPDATE exercise_solutions
SET learning_tip = '本题属于必须退出循环以后才能确定答案的问题。重点是通过中间值和右端点比较判断最小值在哪一边。'
WHERE id = 33;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是窗口长度固定为 s1 的长度，维护字符计数是否完全匹配。'
WHERE id = 51;

UPDATE exercise_solutions
SET learning_tip = '本题是经典双指针或单调栈问题。重点是理解每个位置能接多少水，取决于左右两边最高柱子的较小值。'
WHERE id = 59;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心问题。重点是按层扩展当前能到达的范围，每次走到当前层边界时步数加一。'
WHERE id = 254;

UPDATE exercise_solutions
SET learning_tip = '本题是经典双指针或单调栈问题。重点是理解每个位置能接多少水，取决于左右两边最高柱子的较小值。'
WHERE id = 98;

UPDATE exercise_solutions
SET learning_tip = '本题是区间动态规划基础题。重点是 dp[i][j] 表示区间内最长回文子序列长度，再看两端字符是否相同。'
WHERE id = 292;

UPDATE exercise_solutions
SET learning_tip = '本题是栈和队列的设计题。重点是理解栈后进先出、队列先进先出，用两个队列或者一个队列旋转顺序。'
WHERE id = 110;

UPDATE exercise_solutions
SET learning_tip = '本题是栈和队列的设计题。重点是两个栈配合，一个负责输入，一个负责输出，输出栈为空时再整体倒入。'
WHERE id = 111;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈应用。重点是栈里维护比当前价格更高的历史价格，低于当前价格的都可以合并跨度。'
WHERE id = 105;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈进阶题。重点是计算每个元素作为子数组最小值时，左右能扩展的范围。'
WHERE id = 106;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈的进阶应用。重点是从右往左维护可能的 2，并寻找左侧是否存在更小的 1。'
WHERE id = 109;

UPDATE exercise_solutions
SET learning_tip = '本题是栈和表达式解析问题。重点是括号会改变当前符号环境，编码时要维护结果和符号。'
WHERE id = 99;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心问题。重点是排序以后每一对取较小值，为了让总和最大，应该让相邻两个数配对。'
WHERE id = 256;

UPDATE exercise_solutions
SET learning_tip = '本题是二维 0-1 背包问题。重点是每个字符串都有 0 和 1 两种成本，状态要倒序更新。'
WHERE id = 298;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练栈模拟。重点是按 pushed 入栈，并在栈顶等于 popped 当前元素时不断出栈。'
WHERE id = 95;

UPDATE exercise_solutions
SET learning_tip = '本题是单调栈和贪心。重点是为了让数字最小，遇到更小的数字时可以删除前面较大的数字。'
WHERE id = 108;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练数组扫描。重点是找出哪些位置破坏了整体有序性，可以从左到右和从右到左各扫一遍。'
WHERE id = 104;

UPDATE exercise_solutions
SET learning_tip = '本题是树的基础题。BFS 遇到第一个叶子结点即可返回；DFS 写法要注意空子树不能当作深度 0 的候选。'
WHERE id = 125;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练递归比较。重点是左子树的左边要和右子树的右边比较，左子树的右边要和右子树的左边比较。'
WHERE id = 132;

UPDATE exercise_solutions
SET learning_tip = '本题是树的基础递归题。重点是一路向下减去当前结点值，只有到叶子结点时才判断是否刚好为 0。'
WHERE id = 135;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是路径、选择列表、撤销选择三个动作，写清楚以后很多回溯题都类似。'
WHERE id = 226;

UPDATE exercise_solutions
SET learning_tip = '本题是快慢指针典型题。重点是让快指针先走 N 步，再一起走到待删除结点的前一个位置。'
WHERE id = 78;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练树上的路径累积。重点是从根到叶子的过程中维护当前数字，只有到叶子结点才加入答案。'
WHERE id = 126;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口典型题。重点是窗口和达到目标后，尝试不断收缩左边界，寻找更短答案。'
WHERE id = 47;

UPDATE exercise_solutions
SET learning_tip = '本题是链表题里较难的指针操作题。重点是每组先确认长度够不够，再在局部区间里完成反转。'
WHERE id = 76;

UPDATE exercise_solutions
SET learning_tip = '本题是多源 BFS。重点是从所有腐烂橘子同时出发扩散，层数就是需要的分钟数。'
WHERE id = 217;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找难题。重点是利用两个数组有序，在较短数组上二分切分位置，让左右两边数量和大小都满足要求。'
WHERE id = 45;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找基础应用。重点是查找第一个满足条件的位置，属于退出循环以后确定答案的问题。'
WHERE id = 29;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练树上的路径记录。重点是进入结点时加入路径，遇到叶子结点输出，返回时恢复状态。'
WHERE id = 133;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是当乘积过大时移动左边界，窗口合法后以右端点结尾的子数组数量可以直接计算。'
WHERE id = 48;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是窗口长度减去窗口内最多字符次数，就是需要替换的字符数。'
WHERE id = 52;

UPDATE exercise_solutions
SET learning_tip = '本题是完全背包的组合计数问题。重点是先枚举硬币再枚举金额，避免把不同顺序当成不同方案。'
WHERE id = 302;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是窗口内 0 的个数不能超过 k，超过以后移动左边界。'
WHERE id = 54;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口问题。重点是窗口内最多允许一个 0，最后答案要减去被删除的那个元素。'
WHERE id = 55;

UPDATE exercise_solutions
SET learning_tip = '本题利用完全二叉树性质。重点是比较左右子树高度，如果某一边是满二叉树，就可以直接计算结点数。'
WHERE id = 138;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练前缀和取模。重点是两个前缀和模 k 相同，中间子数组和就能被 k 整除，同时长度至少为 2。'
WHERE id = 209;

UPDATE exercise_solutions
SET learning_tip = '本题是链表复制的经典题。重点是既要复制 next 指针，也要复制 random 指针，可以用哈希表或原地穿插结点。'
WHERE id = 77;

UPDATE exercise_solutions
SET learning_tip = '本题是快慢指针基础题。重点是快指针每次走两步，慢指针每次走一步，如果有环一定会相遇。'
WHERE id = 81;

UPDATE exercise_solutions
SET learning_tip = '本题是链表删除题。重点是删除所有重复值，而不是每个重复值保留一个，虚拟头结点很有用。'
WHERE id = 72;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练链表重排。重点是按位置奇偶拆成两条链表，最后把偶链表接到奇链表后面。'
WHERE id = 74;

UPDATE exercise_solutions
SET learning_tip = '本题是快慢指针基础题。重点是快指针走两步、慢指针走一步，快指针到尾时慢指针在中间。'
WHERE id = 79;

UPDATE exercise_solutions
SET learning_tip = '本题是最短路问题。重点是从源点出发计算到所有点的最短时间，最后取最大值。'
WHERE id = 188;

UPDATE exercise_solutions
SET learning_tip = '本题是数据结构设计难题。重点是同时维护访问频率和同频率下的最近使用顺序，开发成本和细节都比较高。'
WHERE id = 89;

UPDATE exercise_solutions
SET learning_tip = '本题属于「查找一个有范围的整数」，因此可以使用二分查找。重点是判断 mid * mid 和目标值的关系。'
WHERE id = 23;

UPDATE exercise_solutions
SET learning_tip = '本题是二分答案典型题。重点是二分运载能力，再判断在这个能力下能否不超过 D 天送完。'
WHERE id = 44;

UPDATE exercise_solutions
SET learning_tip = '本题是树的基础题。重点是判断一个结点是不是左叶子，不能只看它是不是叶子。'
WHERE id = 134;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练二分查找。重点是先判断答案是否能在循环体内确定，还是必须退出循环以后才能确定。'
WHERE id = 26;

UPDATE exercise_solutions
SET learning_tip = '本题是二分查找经典题。重点是分别查找第一个大于等于 target 的位置和第一个大于 target 的位置。'
WHERE id = 27;

UPDATE exercise_solutions
SET learning_tip = '本题可以用优先队列，也可以利用字符种类有限做计数排序。重点是先统计频率，再按照频率组织结果。'
WHERE id = 121;

UPDATE exercise_solutions
SET learning_tip = '本题是双指针经典题。重点是排序以后固定一个数，再用左右指针寻找另外两个数，同时处理重复。'
WHERE id = 57;

UPDATE exercise_solutions
SET learning_tip = '本题是双指针基础题。重点是平方以后最大值一定来自原数组两端，结果可以从后往前填。'
WHERE id = 61;

UPDATE exercise_solutions
SET learning_tip = '本题利用二叉搜索树中序遍历有序的性质。重点是中序遍历时第 k 个访问到的结点就是答案。'
WHERE id = 157;

UPDATE exercise_solutions
SET learning_tip = '本题是 0-1 背包变形。重点是把石头分成两堆，让两堆重量尽量接近。'
WHERE id = 300;

UPDATE exercise_solutions
SET learning_tip = '本题是链表综合题。重点是先找到中点，再反转后半部分，最后交替合并两条链表。'
WHERE id = 84;

UPDATE exercise_solutions
SET learning_tip = '本题是单调队列经典题。重点是队头维护当前窗口最大值，队尾负责保持队列单调。'
WHERE id = 114;

UPDATE exercise_solutions
SET learning_tip = '本题是路径类动态规划。重点是每个位置只能从上一层相邻两个位置转移过来，自底向上写可以节省空间。'
WHERE id = 262;

UPDATE exercise_solutions
SET learning_tip = '本题可以转换成 0-1 背包。重点是把加减号问题转换成选出一部分数，使它们的和达到某个目标。'
WHERE id = 299;

UPDATE exercise_solutions
SET learning_tip = '本题是树形动态规划。重点是每个结点有偷和不偷两个状态，偷当前结点就不能偷孩子。'
WHERE id = 294;

UPDATE exercise_solutions
SET learning_tip = '本题可以用二分答案加 BFS，也可以用最小堆。重点是路径代价由经过格子的最大高度决定。'
WHERE id = 189;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划基础题。重点是如果最后三个数能形成等差，那么以当前位置结尾的等差子数组数量可以由前一个状态推出。'
WHERE id = 277;

UPDATE exercise_solutions
SET learning_tip = '本题是图遍历问题。重点是从边界上的 O 出发，标记所有不会被包围的位置。'
WHERE id = 194;

UPDATE exercise_solutions
SET learning_tip = '本题是并查集经典题。重点是按边加入集合，如果一条边连接的两个点已经在同一集合里，这条边就是冗余边。'
WHERE id = 192;

UPDATE exercise_solutions
SET learning_tip = '本题可以用二分答案加 BFS，也可以用最小堆。重点是路径代价由经过格子的最大高度决定。'
WHERE id = 196;

UPDATE exercise_solutions
SET learning_tip = '本题是滑动窗口加有序集合的问题。重点是同时限制下标距离和数值差距，普通哈希表不够用。'
WHERE id = 162;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划经典题。O(n log n) 做法的重点是理解 tails 数组的含义：长度固定时结尾越小越好。'
WHERE id = 268;

UPDATE exercise_solutions
SET learning_tip = '本题是二维动态规划经典题。重点是 dp[i][j] 表示以当前位置为右下角的最大正方形边长。'
WHERE id = 285;

UPDATE exercise_solutions
SET learning_tip = '本题是树和编码规则设计题。重点是序列化和反序列化必须使用同一套规则，BST 性质可以帮助恢复结构。'
WHERE id = 159;

UPDATE exercise_solutions
SET learning_tip = '本题是前缀树基础题。重点是每个结点保存孩子指针和是否为单词结尾，适合处理前缀查询。'
WHERE id = 199;

UPDATE exercise_solutions
SET learning_tip = '本题是 Trie 的应用题。重点是把词根放入前缀树，再为句子中的每个单词寻找最短词根。'
WHERE id = 202;

UPDATE exercise_solutions
SET learning_tip = '本题是二分答案经典题。重点是二分吃香蕉速度，再判断能否在规定时间内吃完。'
WHERE id = 43;

UPDATE exercise_solutions
SET learning_tip = '本题是优先队列或快速选择问题。重点是距离只需要比较平方和，不需要真的开平方。'
WHERE id = 122;

UPDATE exercise_solutions
SET learning_tip = '本题利用二叉搜索树性质。重点是如果两个结点都小于当前结点就往左，都大于当前结点就往右，否则当前结点就是答案。'
WHERE id = 160;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练后序遍历。重点是先求左右子树结点和，才能计算当前结点的坡度。'
WHERE id = 139;

UPDATE exercise_solutions
SET learning_tip = '本题是树的基础题。重点是遍历每个结点，交换它的左右子树；DFS 和 BFS 都可以。'
WHERE id = 146;

UPDATE exercise_solutions
SET learning_tip = '本题是树的经典设计题。重点是空结点也要记录，序列化和反序列化要遵循同一种遍历规则。'
WHERE id = 150;

UPDATE exercise_solutions
SET learning_tip = '本题是 N 叉树遍历基础题。重点是先依次访问所有孩子，最后访问根结点。'
WHERE id = 144;

UPDATE exercise_solutions
SET learning_tip = '本题是二叉搜索树基础题。重点是根据大小关系一路向下找到空位置，再插入新结点。'
WHERE id = 152;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练后序遍历。重点是从左右子树向上返回信息：如果左右两边都找到了目标，当前结点就是最近公共祖先。'
WHERE id = 149;

UPDATE exercise_solutions
SET learning_tip = '本题是二叉搜索树操作题。重点是删除有两个孩子的结点时，通常用后继或前驱结点替换。'
WHERE id = 156;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表底层思想。重点是理解哈希函数、桶和冲突处理，而不是只会调用现成的 Set。'
WHERE id = 164;

UPDATE exercise_solutions
SET learning_tip = '本题主要训练哈希表计数。重点是 k 为 0 时要找出现次数超过 1 的数，k 大于 0 时找 num + k 是否存在。'
WHERE id = 181;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心算法基础题。重点是优先用小饼干满足胃口小的孩子，让资源尽量不浪费。'
WHERE id = 248;

UPDATE exercise_solutions
SET learning_tip = '本题是原地哈希思想。重点是利用数值范围 1 到 n，把数字映射到对应下标并标记出现。'
WHERE id = 176;

UPDATE exercise_solutions
SET learning_tip = '本题是哈希表最典型的入门应用。重点是边遍历边查找 target - nums[i] 是否出现过。'
WHERE id = 171;

UPDATE exercise_solutions
SET learning_tip = '本题是 N 皇后的计数版本。重点是列、主对角线、副对角线的冲突判断，找到方案后只计数即可。'
WHERE id = 243;

UPDATE exercise_solutions
SET learning_tip = '本题是图遍历基础题。重点是从起点出发，只扩展原颜色相同的相邻格子。'
WHERE id = 238;

UPDATE exercise_solutions
SET learning_tip = '本题是拓扑剥叶子的思想。重点是树的中心会在一层层删除叶子以后留下。'
WHERE id = 224;

UPDATE exercise_solutions
SET learning_tip = '本题是股票动态规划的通用版本。重点是把交易次数也放进状态里；当 k 很大时可以退化成无限次交易。'
WHERE id = 282;

UPDATE exercise_solutions
SET learning_tip = '本题和最大子数组和类似，但乘积有正负号变化。重点是同时维护以当前位置结尾的最大值和最小值。'
WHERE id = 269;

UPDATE exercise_solutions
SET learning_tip = '本题是带重复元素的回溯问题。重点是排序后在同一层跳过重复选择，每个数字只能使用一次。'
WHERE id = 229;

UPDATE exercise_solutions
SET learning_tip = '本题是动态规划计数题。重点是枚举哪个数字作为根结点，左右子树的方案数相乘。'
WHERE id = 272;

UPDATE exercise_solutions
SET learning_tip = '本题是图遍历模拟题。重点是根据周围地雷数量决定是停止展开，还是继续扩展空白区域。'
WHERE id = 244;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法基础题。重点是数字可以重复使用，因此递归时下一层仍然可以从当前下标开始。'
WHERE id = 228;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法经典题。重点是记录列、主对角线、副对角线占用情况，而不是每次扫描整个棋盘。'
WHERE id = 242;

UPDATE exercise_solutions
SET learning_tip = '本题是回溯算法入门题。重点是每一位数字对应一组字母，递归深度对应输入数字的位置。'
WHERE id = 236;

UPDATE exercise_solutions
SET learning_tip = '本题是贪心问题。重点是先保证每一行最高位为 1，再让每一列的 1 尽量多。'
WHERE id = 259;

UPDATE exercise_solutions
SET learning_tip = '本题是区间问题基础题。重点是先按左端点排序，再判断当前区间是否与上一个区间重叠。'
WHERE id = 251;

UPDATE exercise_solutions
SET learning_tip = '本题是字符串动态规划经典题。重点是当前位置能否单独解码，以及能否和前一个字符一起解码，0 的处理很容易写错。'
WHERE id = 270;

UPDATE exercise_solutions
SET learning_tip = '本题是完全背包的排列计数问题。重点是顺序不同算不同方案，因此通常先枚举目标值，再枚举数字。'
WHERE id = 279;

UPDATE exercise_solutions
SET learning_tip = '本题是字符串动态规划经典题。重点是 dp[i] 表示前 i 个字符能否被拆分，再枚举最后一个单词的起点。'
WHERE id = 271;

COMMIT;

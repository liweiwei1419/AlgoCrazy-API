ALTER TABLE exercise_solutions
    ADD COLUMN IF NOT EXISTS learning_tip TEXT;

COMMENT ON COLUMN exercise_solutions.learning_tip IS '学习提示：说明这道题主要训练什么，以及阅读题解时应该关注什么';

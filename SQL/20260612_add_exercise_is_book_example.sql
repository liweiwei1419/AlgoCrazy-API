ALTER TABLE exercise_solutions
    ADD COLUMN IF NOT EXISTS is_book_example BOOLEAN NOT NULL DEFAULT false;

UPDATE exercise_solutions
SET is_book_example = true
WHERE solution LIKE '%本书例题%';

COMMENT ON COLUMN exercise_solutions.is_book_example IS '是否本书例题';

CREATE INDEX IF NOT EXISTS idx_exercise_solutions_is_book_example ON exercise_solutions(is_book_example);

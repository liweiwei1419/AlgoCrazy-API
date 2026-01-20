package com.suanfa8.algocrazyapi;

import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import com.opencsv.exceptions.CsvValidationException;
import com.suanfa8.algocrazyapi.entity.DifficultyEnum;
import com.suanfa8.algocrazyapi.entity.LeetCodeProblems;
import com.suanfa8.algocrazyapi.mapper.LeetCodeProblemsMapper;
import com.suanfa8.algocrazyapi.service.ILeetCodeProblemsService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
public class LeetCodeTitleChineseTranslateTest {

    // 存储LeetCode id和中文标题的映射
    private static final Map<Integer, String> LEETCODE_ID_TITLE_MAP = new HashMap<>();

    // 静态初始化块，读取LeetCode-id-title.csv文件
    static {
        String csvFilePath = "LeetCode-id-title.csv";
        readLeetCodeIdTitleFromCsv(csvFilePath);
    }

    @Autowired
    private ILeetCodeProblemsService leetCodeProblemsService;

    /**
     * 从CSV文件中读取LeetCode id和中文标题的映射
     */
    private static void readLeetCodeIdTitleFromCsv(String filePath) {
        try (CSVReader reader = new CSVReaderBuilder(new FileReader(filePath)).withSkipLines(1) // 跳过标题行
                .build()) {

            String[] nextLine;
            while ((nextLine = reader.readNext()) != null) {
                if (nextLine.length >= 2) {
                    try {
                        Integer id = Integer.parseInt(nextLine[0].trim());
                        String title = nextLine[1].trim();
                        LEETCODE_ID_TITLE_MAP.put(id, title);
                    } catch (NumberFormatException e) {
                        // 忽略无效的id
                        System.out.println("Invalid id format: " + nextLine[0]);
                    }
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (CsvValidationException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 获取LeetCode id和中文标题的映射
     */
    public static Map<Integer, String> getLeetCodeMap() {
        return LEETCODE_ID_TITLE_MAP;
    }

    /**
     * 测试将英文标题替换为中文标题
     */
    @Test
    public void testTranslateTitle() {
        String csvFilePath = "leetcode_problems_focus.csv";
        List<LeetCodeProblems> problems = Problems.readProblemsFromCsv(csvFilePath);

        // 存储要保存到数据库的问题列表
        List<LeetCodeProblems> problemsToSave = new ArrayList<>();

        for (LeetCodeProblems problem : problems) {
            Integer id = problem.getId();
            String originalTitle = problem.getTitle();

            // 根据id从map中获取中文标题
            String chineseTitle = LEETCODE_ID_TITLE_MAP.get(id);

            if (chineseTitle != null) {
                // 替换为中文标题
                problem.setTitle(chineseTitle);
                System.out.println("Problem ID: " + id + " | Original Title: " + originalTitle + " | Chinese Title: " + chineseTitle);
            } else {
                System.out.println("Problem ID: " + id + " | Title: " + originalTitle + " | No Chinese translation found");
            }

            // 设置创建时间和更新时间
            LocalDateTime now = LocalDateTime.now();
            problem.setCreatedTime(now);
            problem.setUpdatedTime(now);

            problemsToSave.add(problem);
        }

        // 批量保存到数据库
        if (!problemsToSave.isEmpty()) {
            leetCodeProblemsService.saveBatch(problemsToSave);
            System.out.println("Successfully saved " + problemsToSave.size() + " problems to database");
        }
    }
}

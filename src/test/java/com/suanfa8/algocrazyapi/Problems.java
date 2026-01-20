package com.suanfa8.algocrazyapi;

import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import com.opencsv.exceptions.CsvValidationException;
import com.suanfa8.algocrazyapi.entity.DifficultyEnum;
import com.suanfa8.algocrazyapi.entity.LeetCodeProblems;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Problems {

    /**
     * 从CSV文件中读取LeetCode问题数据
     *
     * @param filePath CSV文件路径
     * @return LeetCode问题列表
     */
    public static List<LeetCodeProblems> readProblemsFromCsv(String filePath) {
        List<LeetCodeProblems> problems = new ArrayList<>();
        Pattern pattern = Pattern.compile("\\d+");

        try (CSVReader reader = new CSVReaderBuilder(new FileReader(filePath)).withSkipLines(1) // 跳过标题行
                .build()) {

            String[] nextLine;
            while ((nextLine = reader.readNext()) != null) {
                if (nextLine.length >= 6) {
                    LeetCodeProblems problem = new LeetCodeProblems();

                    // 处理id字段，提取数字部分
                    String idStr = nextLine[0].trim();
                    Matcher matcher = pattern.matcher(idStr);
                    Integer id = null;
                    if (matcher.find()) {
                        id = Integer.parseInt(matcher.group());
                    }
                    problem.setId(id);

                    problem.setTitle(nextLine[1].trim());
                    problem.setTitleSlug(nextLine[2].trim());

                    // 处理难度字段，转换为枚举类型
                    String difficultyStr = nextLine[3].trim();
                    problem.setDifficulty(DifficultyEnum.getByName(difficultyStr));

                    // 处理是否会员题字段，转换为boolean类型
                    String paidOnlyStr = nextLine[4].trim();
                    problem.setPaidOnly("是".equals(paidOnlyStr));


                    problem.setUrl(nextLine[5].trim());

                    problems.add(problem);
                }
            }

            // 按id升序排序
            problems.sort(Comparator.comparing(LeetCodeProblems::getId, Comparator.nullsLast(Comparator.naturalOrder())));

        } catch (IOException e) {
            e.printStackTrace();
        } catch (CsvValidationException e) {
            throw new RuntimeException(e);
        }

        return problems;
    }
}

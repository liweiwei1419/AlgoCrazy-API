package com.suanfa8.algocrazyapi;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.mapper.ExerciseSolutionMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class ExerciseSolutionMapperTest {

    @Resource
    private ExerciseSolutionMapper exerciseSolutionMapper;


    @Test
    public void testMapper() {
        List<ExerciseSolution> list = exerciseSolutionMapper.selectList(null); // 添加 LIMIT 子句

        // 为每条数据生成URL并打印
        for (ExerciseSolution solution : list) {
            String chapter = solution.getChapterNumber();
            String leetcodeNumber = solution.getLeetcodeNumber();
            String source = solution.getSource();

            String webReference = solution.getWebReference();

            // 生成URL
            String url = generateExerciseUrl(chapter, leetcodeNumber, source, webReference);


            LambdaUpdateWrapper<ExerciseSolution> updateWrapper = new LambdaUpdateWrapper<>();
            updateWrapper.eq(ExerciseSolution::getId, solution.getId())
                    .set(ExerciseSolution::getUrl, url);

            exerciseSolutionMapper.update(null, updateWrapper);

            // 打印结果
            System.out.println("生成的URL: " + url);
            System.out.println("------------------------");
        }
    }


    /**
     * 生成练习 URL 路径
     *
     * @param chapter        章节（如"第1章"）
     * @param leetcodeNumber 力扣题号（如"1"）
     * @param source         题目来源（如"leetcode"）
     * @return 生成的 URL 路径
     */
    private String generateExerciseUrl(String chapter, String leetcodeNumber, String source, String webReference) {
        // 处理章节编号：移除"第"和"章"，补前导零，添加"chapter"前缀
        String chapterPart = chapter.replaceAll("[第章]", "").replaceAll("\\D", ""); // 只保留数字
        chapterPart = "chapter" + String.format("%02d", Integer.parseInt(chapterPart));

        // 处理力扣题号：保留 4 位，高位补零
        String leetcodePart = String.format("%04d", Integer.parseInt(leetcodeNumber));

        // 处理webReference：把 problems/ 到下一个 / 之间的字符串提取出来
        String webReferencePart = webReference.split("/problems/")[1].split("/")[0];

        // 组合成完整 URL 路径
        return String.format("%s/%s/%s-%s", chapterPart, source, leetcodePart, webReferencePart);

    }
}
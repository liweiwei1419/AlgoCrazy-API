package com.suanfa8.algocrazyapi;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FormatText {

    public static void main(String[] args) {
        String inputFile = "/Users/liwei/Downloads/ws/suanfa8/algo-crazy/AlgoCrazy-API/text.txt";
        String outputFile = "/Users/liwei/Downloads/ws/suanfa8/algo-crazy/AlgoCrazy-API/output.md";
        
        try {
            // 读取文件内容
            List<String> lines = readFile(inputFile);
            
            // 处理每一行
            List<String> processedLines = new ArrayList<>();
            boolean isExampleSection = false; // 标记是否在示例部分
            
            for (String line : lines) {
                String processedLine = line;
                
                // 检查是否是输入、输出、解释开头的行
                if (isTargetLine(line)) {
                    // 功能1：替换逗号为逗号加空格
                    processedLine = addSpaceAfterComma(processedLine);
                    
                    // 功能2：添加末尾的句号
                    processedLine = addEndingPeriod(processedLine);
                }
                
                // 功能3：去掉「**示例」或「**提示」开头行的冒号
                if (isSectionLine(line)) {
                    processedLine = removeColonFromSectionLine(processedLine);
                    // 标记是否进入示例部分
                    isExampleSection = line.contains("提示");
                }
                
                // 功能4：为「示例」后面以「+」或「-」开头的行添加末尾句号
                if (isExampleSection && (line.trim().startsWith("+") || line.trim().startsWith("-"))) {
                    processedLine = addEndingPeriod(processedLine);
                }
                
                processedLines.add(processedLine);
            }
            
            // 写入输出文件
            writeFile(outputFile, processedLines);
            
            System.out.println("处理完成，输出到：" + outputFile);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 读取文件内容
     */
    private static List<String> readFile(String filePath) throws IOException {
        List<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        }
        return lines;
    }
    
    /**
     * 检查是否是目标行（输入、输出、解释开头）
     */
    private static boolean isTargetLine(String line) {
        return line.startsWith("输入：") || line.startsWith("输出：") || line.startsWith("解释：");
    }
    
    /**
     * 检查是否是章节行（**示例** 或 **提示** 开头）
     */
    private static boolean isSectionLine(String line) {
        return line.startsWith("**示例") || line.startsWith("**提示");
    }
    
    /**
     * 功能3：去掉章节行中的冒号
     */
    private static String removeColonFromSectionLine(String line) {
        // 去掉冒号，无论它在行尾还是在 "**" 之前
        return line.replaceAll("：(?=\\*\\*$|$)", "");
    }
    
    /**
     * 功能1：在逗号后添加空格
     */
    private static String addSpaceAfterComma(String line) {
        // 替换所有的","为", "，但要避免已经有空格的情况
        return line.replaceAll(",(?!\\s)", ", ");
    }
    
    /**
     * 功能2：在末尾添加句号
     */
    private static String addEndingPeriod(String line) {
        // 检查行尾是否已经有句号
        if (!line.trim().endsWith("。")) {
            return line.trim() + "。";
        }
        return line;
    }
    
    /**
     * 写入文件
     */
    private static void writeFile(String filePath, List<String> lines) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }
}
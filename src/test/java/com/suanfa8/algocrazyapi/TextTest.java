package com.suanfa8.algocrazyapi;


import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.LineIterator;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TextTest {

    @Test
    public void test02() {
        String inputFile = "b.txt";
        String outputPrefix = "";
        String splitPattern = "例题 \\d+："; // 匹配"例题 1："、"例题 2："等

        try {
            splitFileByExample(inputFile, outputPrefix, splitPattern);
            System.out.println("文件分割完成！");
        } catch (IOException e) {
            System.err.println("处理文件时出错: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void splitFileByExample(String inputFile, String outputPrefix, String splitPattern) throws IOException {
        File file = new File(inputFile);
        LineIterator it = FileUtils.lineIterator(file, "UTF-8");

        List<String> currentLines = new ArrayList<>();
        int fileCounter = 1;
        boolean isFirstExample = true;

        try {
            while (it.hasNext()) {
                String line = it.nextLine();

                if (line.matches(".*" + splitPattern + ".*")) {
                    // 遇到新的例题标记
                    if (!isFirstExample) {
                        // 不是第一个例题，先保存前一个例题内容
                        writeToFile(outputPrefix + fileCounter + ".txt", currentLines);
                        fileCounter++;
                        currentLines.clear();
                    } else {
                        // 是第一个例题，不需要分割，只需标记不是第一个了
                        isFirstExample = false;
                    }
                }

                currentLines.add(line);
            }

            // 写入最后一个例题内容
            if (!currentLines.isEmpty()) {
                writeToFile(outputPrefix + fileCounter + ".txt", currentLines);
            }
        } finally {
            LineIterator.closeQuietly(it);
        }
    }

    private void writeToFile(String filename, List<String> lines)  {
        File outputFile = new File(filename);
        FileWriter writer = null;

        try {
            writer = new FileWriter(outputFile);
            for (String line : lines) {
                writer.write(line);
                writer.write(IOUtils.LINE_SEPARATOR);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }



    @Test
    public void test01() {
        // 读取文件
        // 提取包含 「例题」的行和「题目地址」的行，打印出来即可

        // 指定文件路径
        File file = new File("a.txt"); // 替换为实际文件路径

        // 使用FileUtils按行读取文件
        List<String> lines = null;
        try {
            lines = FileUtils.readLines(file, "UTF-8");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 遍历每一行，查找包含特定关键词的行
        for (String line : lines) {
            if (line.contains("例题") || line.contains("题目地址")) {
                // 找到第一个 "：" 的位置，并截取其后内容
                int colonIndex = line.indexOf("：");
                if (colonIndex != -1) { // 确保 "：" 存在
                    System.out.println(line.substring(colonIndex + 1).trim());
                } else {
                    System.out.println(line); // 如果没有 "："，则打印整行
                }
            }
        }
    }


}

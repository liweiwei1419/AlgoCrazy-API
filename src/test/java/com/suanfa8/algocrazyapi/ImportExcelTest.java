package com.suanfa8.algocrazyapi;

import com.suanfa8.algocrazyapi.entity.Article;
import com.suanfa8.algocrazyapi.service.IArticleService;
import jakarta.annotation.Resource;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@SpringBootTest
public class ImportExcelTest {

    @Resource
    private IArticleService articleService;

    @Test
    public void importFromExcel() throws IOException {
        String filePath = "problems.xlsx";

        List<Article> articleList = new ArrayList<>();
        try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0); // 获取第一个工作表
            Iterator<Row> rowIterator = sheet.iterator();
            // 跳过标题行（如果 Excel 第一行是列名）
            if (rowIterator.hasNext()) {
                rowIterator.next();
            }
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Article article = new Article();
                // 假设列顺序是：标题、source_url、p_id
                Cell titleCell = row.getCell(0);
                Cell sourceUrlCell = row.getCell(1);
                Cell pIdCell = row.getCell(2);
                Cell displayOrderCell = row.getCell(3);
                // 处理每个单元格的值
                article.setTitle(getCellValue(titleCell));
                article.setSourceUrl(getCellValue(sourceUrlCell));
                article.setParentId(Long.parseLong(getCellValue(pIdCell)));
                article.setAuthor("liweiwei1419");
                article.setContent("");
                article.setDisplayOrder(Integer.parseInt(getCellValue(displayOrderCell)));
                articleList.add(article);
            }
        }
        for (Article article : articleList) {
            articleService.articleCreate(article);
        }
    }

    private static String getCellValue(Cell cell) {
        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    // 防止科学计数法
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            case BLANK:
                return "";
            default:
                return "";
        }
    }

}

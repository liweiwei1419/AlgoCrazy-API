package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.dto.exercise.ExerciseSolutionListDTO;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.mapper.ExerciseSolutionMapper;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import com.suanfa8.algocrazyapi.utils.MinioUtils;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class ExerciseSolutionServiceImpl extends ServiceImpl<ExerciseSolutionMapper, ExerciseSolution> implements IExerciseSolutionService {

    @Resource
    private ExerciseSolutionMapper exerciseSolutionMapper;

    @Resource
    private MinioUtils minioUtils;

    @Override
    public List<ExerciseSolution> getChildrenByParentId(Integer parentId) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getParentId, parentId)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByDifficulty(String difficulty) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getDifficultyLevel, difficulty)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByCategory(String category) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getCategory, category)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public List<ExerciseSolution> getByChapterNumber(String chapterNumber) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getChapterNumber, chapterNumber)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public ExerciseSolution getByLeetcodeNumber(String leetcodeNumber) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getLeetcodeNumber, leetcodeNumber)
                   .eq(ExerciseSolution::getIsDeleted, false);
        return exerciseSolutionMapper.selectOne(queryWrapper);
    }

    @Override
    public ExerciseSolution getByUrl(String url) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getUrl, url)
                   .eq(ExerciseSolution::getIsDeleted, false);
        return exerciseSolutionMapper.selectOne(queryWrapper);
    }

    @Override
    public IPage<ExerciseSolution> getPageList(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished) {
        Page<ExerciseSolution> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = buildQueryWrapper(keyword, difficulty, category, chapterNumber, leetcodeNumber, isPublished);
        return exerciseSolutionMapper.selectPage(pageParam, queryWrapper);
    }

    @Override
    public IPage<ExerciseSolutionListDTO> getPageListWithPartialFields(Integer page, Integer size, String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished) {
        Page<ExerciseSolution> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = buildQueryWrapper(keyword, difficulty, category, chapterNumber, leetcodeNumber, isPublished);
        
        // 指定只查询需要的字段
        queryWrapper.select(
            ExerciseSolution::getId,
            ExerciseSolution::getParentId,
            ExerciseSolution::getTitle,
            ExerciseSolution::getSortOrder,
            ExerciseSolution::getDifficultyLevel,
            ExerciseSolution::getCategory,
            ExerciseSolution::getChapterNumber,
            ExerciseSolution::getLeetcodeNumber,
            ExerciseSolution::getIsPublished,
            ExerciseSolution::getCreatedAt,
            ExerciseSolution::getUpdatedAt,
            ExerciseSolution::getUrl
        );
        
        // 执行查询
        IPage<ExerciseSolution> resultPage = exerciseSolutionMapper.selectPage(pageParam, queryWrapper);
        
        // 手动转换为 DTO 分页对象
        IPage<ExerciseSolutionListDTO> dtoPage = new Page<>(resultPage.getCurrent(), resultPage.getSize(), resultPage.getTotal());
        dtoPage.setRecords(resultPage.getRecords().stream()
            .map(this::convertToDTO)
            .collect(Collectors.toList()));
        
        return dtoPage;
    }

    /**
     * 构建查询条件
     */
    private LambdaQueryWrapper<ExerciseSolution> buildQueryWrapper(String keyword, String difficulty, String category, String chapterNumber, String leetcodeNumber, Boolean isPublished) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        
        // 构建 OR 关系的查询条件
        boolean hasCondition = false;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            queryWrapper.like(ExerciseSolution::getTitle, keyword)
                       .or()
                       .like(ExerciseSolution::getDescription, keyword);
            hasCondition = true;
        }
        
        if (difficulty != null && !difficulty.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getDifficultyLevel, difficulty);
            hasCondition = true;
        }
        
        if (category != null && !category.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getCategory, category);
            hasCondition = true;
        }
        
        if (chapterNumber != null && !chapterNumber.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getChapterNumber, chapterNumber);
            hasCondition = true;
        }
        
        if (leetcodeNumber != null && !leetcodeNumber.trim().isEmpty()) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getLeetcodeNumber, leetcodeNumber);
            hasCondition = true;
        }
        
        if (isPublished != null) {
            if (hasCondition) {
                queryWrapper.or();
            }
            queryWrapper.eq(ExerciseSolution::getIsPublished, isPublished);
            hasCondition = true;
        }
        
        queryWrapper.eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder)
                   .orderByDesc(ExerciseSolution::getUpdatedAt);
        
        return queryWrapper;
    }

    /**
     * 将实体转换为 DTO
     */
    private ExerciseSolutionListDTO convertToDTO(ExerciseSolution entity) {
        ExerciseSolutionListDTO dto = new ExerciseSolutionListDTO();
        dto.setId(entity.getId());
        dto.setTitle(entity.getTitle());
        dto.setSortOrder(entity.getSortOrder());
        dto.setDifficultyLevel(entity.getDifficultyLevel());
        dto.setCategory(entity.getCategory());
        dto.setChapterNumber(entity.getChapterNumber());
        dto.setLeetcodeNumber(entity.getLeetcodeNumber());
        dto.setIsPublished(entity.getIsPublished());
        dto.setCreatedAt(entity.getCreatedAt());
        dto.setUpdatedAt(entity.getUpdatedAt());
        dto.setUrl(entity.getUrl());
        return dto;
    }

    @Override
    public List<ExerciseSolution> getByPublishStatus(Boolean isPublished) {
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ExerciseSolution::getIsPublished, isPublished)
                   .eq(ExerciseSolution::getIsDeleted, false)
                   .orderByAsc(ExerciseSolution::getSortOrder)
                   .orderByDesc(ExerciseSolution::getUpdatedAt);
        return exerciseSolutionMapper.selectList(queryWrapper);
    }

    @Override
    public boolean batchUpdatePublishStatus(List<Integer> ids, Boolean isPublished) {
        ExerciseSolution updateEntity = new ExerciseSolution();
        updateEntity.setIsPublished(isPublished);
        
        LambdaQueryWrapper<ExerciseSolution> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(ExerciseSolution::getId, ids);
        
        return exerciseSolutionMapper.update(updateEntity, queryWrapper) > 0;
    }

    @Override
    public List<ExerciseSolution> getTreeList() {
        // 获取所有根节点（parent_id为null或0）
        LambdaQueryWrapper<ExerciseSolution> rootQuery = new LambdaQueryWrapper<>();
        rootQuery.and(wrapper -> wrapper.isNull(ExerciseSolution::getParentId)
                                .or().eq(ExerciseSolution::getParentId, 0))
                .eq(ExerciseSolution::getIsDeleted, false)
                .orderByAsc(ExerciseSolution::getSortOrder);
        
        List<ExerciseSolution> roots = exerciseSolutionMapper.selectList(rootQuery);
        
        // 为每个根节点递归获取子节点
        List<ExerciseSolution> treeList = new ArrayList<>();
        for (ExerciseSolution root : roots) {
            ExerciseSolution treeNode = buildTree(root);
            treeList.add(treeNode);
        }
        
        return treeList;
    }

    @Override
    public List<ExerciseSolution> getAllChildren(Integer parentId) {
        List<ExerciseSolution> allChildren = new ArrayList<>();
        getChildrenRecursive(parentId, allChildren);
        return allChildren;
    }

    /**
     * 递归构建树形结构
     */
    private ExerciseSolution buildTree(ExerciseSolution node) {
        List<ExerciseSolution> children = getChildrenByParentId(node.getId());
        if (!children.isEmpty()) {
            List<ExerciseSolution> childNodes = new ArrayList<>();
            for (ExerciseSolution child : children) {
                childNodes.add(buildTree(child));
            }
            // 这里可以添加children字段，但需要修改实体类
            // 或者使用DTO来返回树形结构
        }
        return node;
    }

    /**
     * 递归获取所有子节点
     */
    private void getChildrenRecursive(Integer parentId, List<ExerciseSolution> result) {
        List<ExerciseSolution> children = getChildrenByParentId(parentId);
        result.addAll(children);
        
        for (ExerciseSolution child : children) {
            getChildrenRecursive(child.getId(), result);
        }
    }

    @Override
    public boolean replaceImages(Integer id) {
        // 1. 获取练习信息
        ExerciseSolution exercise = getById(id);
        if (exercise == null || exercise.getIsDeleted()) {
            return false;
        }
        
        // 2. 提取章节序号、力扣题号和问题路径
        String chapterNumber = getFormattedChapterNumber(exercise.getChapterNumber());
        String leetcodeNumber = getFormattedLeetcodeNumber(exercise.getLeetcodeNumber());
        String problemPath = extractProblemPath(exercise.getWebReference());
        
        // 3. 提取 Markdown 中的图片
        String solution = exercise.getSolution();
        if (solution == null || solution.isEmpty()) {
            // 没有内容，无需处理
            return true;
        }
        
        // 4. 处理图片
        AtomicInteger imageIndex = new AtomicInteger(1);
        String updatedSolution;
        try {
            updatedSolution = replaceMarkdownImages(solution, chapterNumber, leetcodeNumber, problemPath, imageIndex);
        } catch (Exception e) {
            log.error("处理图片失败", e);
            return false;
        }
        
        // 5. 更新练习内容
        exercise.setSolution(updatedSolution);
        return updateById(exercise);
    }

    /**
     * 格式化章节序号（不足两位补前导 0）
     */
    private String getFormattedChapterNumber(String chapterNumber) {
        if (chapterNumber == null || chapterNumber.isEmpty()) {
            return "00";
        }
        try {
            int num = Integer.parseInt(chapterNumber);
            return String.format("%02d", num);
        } catch (NumberFormatException e) {
            return "00";
        }
    }

    /**
     * 格式化力扣题号（不足 4 位补前导0）
     */
    private String getFormattedLeetcodeNumber(String leetcodeNumber) {
        if (leetcodeNumber == null || leetcodeNumber.isEmpty()) {
            return "0000";
        }
        try {
            int num = Integer.parseInt(leetcodeNumber);
            return String.format("%04d", num);
        } catch (NumberFormatException e) {
            return "0000";
        }
    }

    /**
     * 从 web_reference 中提取问题路径
     * 格式：在 problems/ 和 /description 之间的部分
     */
    private String extractProblemPath(String webReference) {
        if (webReference == null || webReference.isEmpty()) {
            return "unknown";
        }
        Pattern pattern = Pattern.compile("problems/([^/]+)/description");
        Matcher matcher = pattern.matcher(webReference);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return "unknown";
    }

    /**
     * 替换 Markdown 中的图片
     */
    private String replaceMarkdownImages(String content, String chapterNumber, String leetcodeNumber, String problemPath, AtomicInteger imageIndex) throws Exception {
        // 匹配 Markdown 图片格式：![]() 单独占一行
        Pattern pattern = Pattern.compile("^\\s*!\\[.*?\\]\\((.*?)\\)\\s*$", Pattern.MULTILINE);
        Matcher matcher = pattern.matcher(content);
        
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            String imageUrl = matcher.group(1);
            String newImageUrl = processImage(imageUrl, chapterNumber, leetcodeNumber, problemPath, imageIndex.getAndIncrement());
            // 在图片前后各添加一个空行，符合 Markdown 规范
            String replacement = "\n![]()\n".replace("()", "(" + newImageUrl + ")");
            matcher.appendReplacement(sb, replacement);
        }
        matcher.appendTail(sb);
        
        return sb.toString();
    }

    /**
     * 处理单个图片：下载、上传到 MinIO、返回新的 URL
     */
    private String processImage(String imageUrl, String chapterNumber, String leetcodeNumber, String problemPath, int imageIndex) throws Exception {
        // 1. 下载图片到永久临时文件夹
        File tempFile = downloadImage(imageUrl);
        
        try {
            // 2. 构建 MinIO 路径（去掉 crazy 前缀，因为存储桶名称已经是 crazy）
            String extension = getFileExtension(imageUrl);
            String objectName = String.format("exercises/chapter%s/%s-%s/%02d.%s", 
                chapterNumber, leetcodeNumber, problemPath, imageIndex, extension);
            
            // 3. 上传到 MinIO
            String minioUrl = uploadToMinio(tempFile, objectName);
            
            // 4. 构建本站链接，确保包含 crazy 前缀
            return "https://static.suanfa8.com/crazy/" + objectName;
        } finally {
            // 5. 不删除临时文件，保留在永久临时文件夹中
        }
    }

    /**
     * 下载图片到永久临时文件夹
     */
    private File downloadImage(String imageUrl) throws Exception {
        // 创建永久临时文件夹
        String tempDirPath = System.getProperty("java.io.tmpdir") + File.separator + "suanfa8_image_cache";
        File tempDir = new File(tempDirPath);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        
        // 生成唯一的文件名
        String fileName = System.currentTimeMillis() + "_" + Math.abs(imageUrl.hashCode()) + ".tmp";
        File tempFile = new File(tempDir, fileName);
        
        URL url = new URL(imageUrl);
        
        try (InputStream in = url.openStream();
             FileOutputStream out = new FileOutputStream(tempFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
        
        return tempFile;
    }

    /**
     * 获取文件扩展名
     */
    private String getFileExtension(String url) {
        int lastDotIndex = url.lastIndexOf('.');
        if (lastDotIndex != -1) {
            String extension = url.substring(lastDotIndex + 1);
            // 处理 URL 中的查询参数
            int queryIndex = extension.indexOf('?');
            if (queryIndex != -1) {
                extension = extension.substring(0, queryIndex);
            }
            return extension.toLowerCase();
        }
        return "png"; // 默认扩展名
    }

    /**
     * 上传文件到 MinIO 的 crazy 存储桶
     */
    private String uploadToMinio(File file, String objectName) throws Exception {
        return minioUtils.upload(file, objectName, "crazy");
    }
}
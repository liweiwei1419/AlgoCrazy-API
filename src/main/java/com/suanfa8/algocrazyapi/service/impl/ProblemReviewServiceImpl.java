package com.suanfa8.algocrazyapi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewStatsDTO;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewSubmitDTO;
import com.suanfa8.algocrazyapi.dto.problemreview.ProblemReviewTopicDTO;
import com.suanfa8.algocrazyapi.dto.problemreview.StuckPointStatDTO;
import com.suanfa8.algocrazyapi.entity.ExerciseSolution;
import com.suanfa8.algocrazyapi.entity.ProblemReview;
import com.suanfa8.algocrazyapi.entity.ProblemReviewTopic;
import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.mapper.ProblemReviewMapper;
import com.suanfa8.algocrazyapi.mapper.ProblemReviewTopicMapper;
import com.suanfa8.algocrazyapi.service.IExerciseSolutionService;
import com.suanfa8.algocrazyapi.service.IProblemReviewService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProblemReviewServiceImpl extends ServiceImpl<ProblemReviewMapper, ProblemReview> implements IProblemReviewService {

    private static final String AUTHOR_TYPE_USER = "USER";
    private static final String AUTHOR_TYPE_GUEST = "GUEST";
    private static final String STATUS_VISIBLE = "VISIBLE";
    private static final String DEFAULT_GUEST_NAME = "匿名用户";
    private static final Set<String> ALLOWED_STUCK_POINTS = Set.of(
            "IDEA", "BORDER", "IMPLEMENTATION", "COMPLEXITY", "MISREAD", "OTHER"
    );

    @Resource
    private ProblemReviewTopicMapper problemReviewTopicMapper;

    @Resource
    private IExerciseSolutionService exerciseSolutionService;

    @Override
    public List<ProblemReviewTopicDTO> listEnabledTopics() {
        List<ProblemReviewTopic> topics = listEnabledTopicEntities();
        if (topics.isEmpty()) {
            return List.of();
        }

        Map<Long, List<ProblemReview>> reviewsByTopic = listVisibleReviewsByTopicIds(
                topics.stream().map(ProblemReviewTopic::getId).toList()
        );
        Map<Integer, ExerciseSolution> exerciseMap = exerciseSolutionService.getExerciseMapByIds(
                topics.stream().map(ProblemReviewTopic::getExerciseId).filter(Objects::nonNull).distinct().toList()
        );

        return topics.stream()
                .map(topic -> buildTopicDTO(topic, exerciseMap.get(topic.getExerciseId()), reviewsByTopic.get(topic.getId()), false))
                .toList();
    }

    @Override
    public ProblemReviewTopicDTO getTopicDetail(Long topicId) {
        ProblemReviewTopic topic = getEnabledTopic(topicId);
        List<ProblemReview> reviews = listVisibleReviews(topicId);
        ExerciseSolution exercise = topic.getExerciseId() == null ? null : exerciseSolutionService.getById(topic.getExerciseId());
        return buildTopicDTO(topic, exercise, reviews, true);
    }

    @Override
    public ProblemReview submitReview(Long topicId, ProblemReviewSubmitDTO submitDTO, User currentUser) {
        ProblemReviewTopic topic = getEnabledTopic(topicId);
        validateSubmitDTO(submitDTO);

        ProblemReview review = new ProblemReview();
        review.setTopicId(topic.getId());
        review.setExerciseId(topic.getExerciseId());
        review.setRecommendScore(submitDTO.getRecommendScore());
        review.setThinkingScore(submitDTO.getThinkingScore());
        review.setStuckPoint(normalizeStuckPoint(submitDTO.getStuckPoint()));
        review.setShortComment(submitDTO.getShortComment().trim());
        review.setStatus(STATUS_VISIBLE);

        if (currentUser != null) {
            review.setAuthorType(AUTHOR_TYPE_USER);
            review.setUserId(currentUser.getId());
            boolean anonymous = submitDTO.getAnonymous() == null || Boolean.TRUE.equals(submitDTO.getAnonymous());
            review.setAnonymous(anonymous);
            review.setDisplayNickname(anonymous ? DEFAULT_GUEST_NAME : fallback(currentUser.getNickname(), currentUser.getUsername()));
        } else {
            review.setAuthorType(AUTHOR_TYPE_GUEST);
            review.setAnonymous(true);
            review.setGuestNickname(fallback(submitDTO.getGuestNickname(), DEFAULT_GUEST_NAME));
            review.setDisplayNickname(review.getGuestNickname());
        }

        save(review);
        return review;
    }

    @Override
    public List<ProblemReviewTopicDTO> listAdminTopics(String keyword) {
        LambdaQueryWrapper<ProblemReviewTopic> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProblemReviewTopic::getIsDeleted, false);
        if (StringUtils.hasText(keyword)) {
            String trimmedKeyword = keyword.trim();
            queryWrapper.and(wrapper -> wrapper
                    .like(ProblemReviewTopic::getReviewTag, trimmedKeyword)
                    .or()
                    .like(ProblemReviewTopic::getWhyTypical, trimmedKeyword)
                    .or()
                    .like(ProblemReviewTopic::getSiteReview, trimmedKeyword));
        }
        queryWrapper.orderByAsc(ProblemReviewTopic::getSortOrder)
                .orderByDesc(ProblemReviewTopic::getUpdatedAt);

        List<ProblemReviewTopic> topics = problemReviewTopicMapper.selectList(queryWrapper);
        if (topics.isEmpty()) {
            return List.of();
        }

        Map<Long, List<ProblemReview>> reviewsByTopic = listVisibleReviewsByTopicIds(
                topics.stream().map(ProblemReviewTopic::getId).toList()
        );
        Map<Integer, ExerciseSolution> exerciseMap = exerciseSolutionService.getExerciseMapByIds(
                topics.stream().map(ProblemReviewTopic::getExerciseId).filter(Objects::nonNull).distinct().toList()
        );

        return topics.stream()
                .map(topic -> buildTopicDTO(topic, exerciseMap.get(topic.getExerciseId()), reviewsByTopic.get(topic.getId()), false))
                .toList();
    }

    @Override
    public ProblemReviewTopic getAdminTopic(Long topicId) {
        if (topicId == null || topicId < 1) {
            throw new IllegalArgumentException("点评题目不存在");
        }
        LambdaQueryWrapper<ProblemReviewTopic> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProblemReviewTopic::getId, topicId)
                .eq(ProblemReviewTopic::getIsDeleted, false);
        ProblemReviewTopic topic = problemReviewTopicMapper.selectOne(queryWrapper);
        if (topic == null) {
            throw new IllegalArgumentException("点评题目不存在");
        }
        return topic;
    }

    @Override
    public ProblemReviewTopic createTopic(ProblemReviewTopic topic) {
        normalizeTopic(topic);
        problemReviewTopicMapper.insert(topic);
        return topic;
    }

    @Override
    public ProblemReviewTopic updateTopic(Long topicId, ProblemReviewTopic topic) {
        ProblemReviewTopic existingTopic = getAdminTopic(topicId);
        topic.setId(existingTopic.getId());
        normalizeTopic(topic);
        problemReviewTopicMapper.updateById(topic);
        return getAdminTopic(topicId);
    }

    @Override
    public boolean deleteTopic(Long topicId) {
        getAdminTopic(topicId);
        LambdaUpdateWrapper<ProblemReviewTopic> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(ProblemReviewTopic::getId, topicId)
                .set(ProblemReviewTopic::getIsDeleted, true);
        return problemReviewTopicMapper.update(new ProblemReviewTopic(), updateWrapper) > 0;
    }

    private List<ProblemReviewTopic> listEnabledTopicEntities() {
        LambdaQueryWrapper<ProblemReviewTopic> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProblemReviewTopic::getIsDeleted, false)
                .eq(ProblemReviewTopic::getReviewEnabled, true)
                .orderByAsc(ProblemReviewTopic::getSortOrder)
                .orderByDesc(ProblemReviewTopic::getUpdatedAt);
        return problemReviewTopicMapper.selectList(queryWrapper);
    }

    private ProblemReviewTopic getEnabledTopic(Long topicId) {
        if (topicId == null || topicId < 1) {
            throw new IllegalArgumentException("点评题目不存在");
        }
        LambdaQueryWrapper<ProblemReviewTopic> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProblemReviewTopic::getId, topicId)
                .eq(ProblemReviewTopic::getIsDeleted, false)
                .eq(ProblemReviewTopic::getReviewEnabled, true);
        ProblemReviewTopic topic = problemReviewTopicMapper.selectOne(queryWrapper);
        if (topic == null) {
            throw new IllegalArgumentException("点评题目不存在");
        }
        return topic;
    }

    private List<ProblemReview> listVisibleReviews(Long topicId) {
        LambdaQueryWrapper<ProblemReview> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProblemReview::getTopicId, topicId)
                .eq(ProblemReview::getStatus, STATUS_VISIBLE)
                .orderByDesc(ProblemReview::getCreatedAt);
        return list(queryWrapper);
    }

    private Map<Long, List<ProblemReview>> listVisibleReviewsByTopicIds(List<Long> topicIds) {
        if (topicIds == null || topicIds.isEmpty()) {
            return Map.of();
        }
        LambdaQueryWrapper<ProblemReview> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(ProblemReview::getTopicId, topicIds)
                .eq(ProblemReview::getStatus, STATUS_VISIBLE)
                .orderByDesc(ProblemReview::getCreatedAt);
        return list(queryWrapper).stream().collect(Collectors.groupingBy(ProblemReview::getTopicId));
    }

    private ProblemReviewTopicDTO buildTopicDTO(ProblemReviewTopic topic, ExerciseSolution exercise, List<ProblemReview> reviews, boolean includeRecentReviews) {
        List<ProblemReview> safeReviews = reviews == null ? List.of() : reviews;
        ProblemReviewTopicDTO dto = new ProblemReviewTopicDTO();
        dto.setId(topic.getId());
        dto.setExerciseId(topic.getExerciseId());
        dto.setReviewTag(topic.getReviewTag());
        dto.setWhyTypical(topic.getWhyTypical());
        dto.setSiteReview(topic.getSiteReview());
        dto.setSortOrder(topic.getSortOrder());
        dto.setReviewEnabled(topic.getReviewEnabled());
        dto.setStats(buildStats(safeReviews));
        if (includeRecentReviews) {
            dto.setRecentReviews(safeReviews.stream().limit(8).toList());
        }

        if (exercise != null) {
            dto.setTitle(exercise.getTitle());
            dto.setCategory(exercise.getCategory());
            dto.setDifficultyLevel(exercise.getDifficultyLevel());
            dto.setChapterNumber(exercise.getChapterNumber());
            dto.setLeetcodeNumber(exercise.getLeetcodeNumber());
            dto.setUrl(exercise.getUrl());
        }
        return dto;
    }

    private ProblemReviewStatsDTO buildStats(List<ProblemReview> reviews) {
        ProblemReviewStatsDTO stats = new ProblemReviewStatsDTO();
        List<ProblemReview> validReviews = reviews == null ? List.of() : reviews;
        long count = validReviews.size();
        stats.setReviewCount(count);
        if (count == 0) {
            return stats;
        }

        stats.setAverageRecommendScore(roundOneDecimal(validReviews.stream()
                .map(ProblemReview::getRecommendScore)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0D)));
        stats.setAverageThinkingScore(roundOneDecimal(validReviews.stream()
                .map(ProblemReview::getThinkingScore)
                .filter(Objects::nonNull)
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0D)));

        Map<String, Long> stuckCounts = validReviews.stream()
                .map(ProblemReview::getStuckPoint)
                .filter(StringUtils::hasText)
                .collect(Collectors.groupingBy(value -> value, Collectors.counting()));

        List<StuckPointStatDTO> stuckStats = new ArrayList<>();
        for (Map.Entry<String, Long> entry : stuckCounts.entrySet()) {
            StuckPointStatDTO stuckPointStat = new StuckPointStatDTO();
            stuckPointStat.setStuckPoint(entry.getKey());
            stuckPointStat.setCount(entry.getValue());
            stuckPointStat.setPercent(roundOneDecimal(entry.getValue() * 100D / count));
            stuckStats.add(stuckPointStat);
        }
        stuckStats.sort(Comparator.comparing(StuckPointStatDTO::getCount).reversed());
        stats.setStuckPointStats(stuckStats);
        stats.setTopStuckPoint(stuckStats.isEmpty() ? null : stuckStats.get(0).getStuckPoint());
        return stats;
    }

    private void validateSubmitDTO(ProblemReviewSubmitDTO submitDTO) {
        if (submitDTO == null) {
            throw new IllegalArgumentException("点评内容不能为空");
        }
        validateScore(submitDTO.getRecommendScore(), "推荐指数");
        validateScore(submitDTO.getThinkingScore(), "思维含量");
        String stuckPoint = normalizeStuckPoint(submitDTO.getStuckPoint());
        if (!ALLOWED_STUCK_POINTS.contains(stuckPoint)) {
            throw new IllegalArgumentException("卡点类型不合法");
        }
        String shortComment = submitDTO.getShortComment() == null ? "" : submitDTO.getShortComment().trim();
        if (shortComment.isEmpty()) {
            throw new IllegalArgumentException("短评不能为空");
        }
        if (shortComment.length() > 300) {
            throw new IllegalArgumentException("短评不能超过 300 个字符");
        }
    }

    private void normalizeTopic(ProblemReviewTopic topic) {
        if (topic == null) {
            throw new IllegalArgumentException("点评题目不能为空");
        }
        if (topic.getExerciseId() == null || topic.getExerciseId() < 1) {
            throw new IllegalArgumentException("请选择关联练习");
        }
        ExerciseSolution exercise = exerciseSolutionService.getById(topic.getExerciseId());
        if (exercise == null || Boolean.TRUE.equals(exercise.getIsDeleted())) {
            throw new IllegalArgumentException("关联练习不存在");
        }
        topic.setReviewTag(blankToNull(topic.getReviewTag()));
        topic.setWhyTypical(blankToNull(topic.getWhyTypical()));
        topic.setSiteReview(blankToNull(topic.getSiteReview()));
        topic.setReviewEnabled(topic.getReviewEnabled() == null || Boolean.TRUE.equals(topic.getReviewEnabled()));
        topic.setSortOrder(topic.getSortOrder() == null ? 0 : topic.getSortOrder());
        topic.setIsDeleted(false);
    }

    private void validateScore(Integer score, String label) {
        if (score == null || score < 1 || score > 5) {
            throw new IllegalArgumentException(label + "必须在 1 到 5 分之间");
        }
    }

    private String normalizeStuckPoint(String stuckPoint) {
        return StringUtils.hasText(stuckPoint) ? stuckPoint.trim().toUpperCase() : "OTHER";
    }

    private Double roundOneDecimal(Double value) {
        return Math.round(value * 10D) / 10D;
    }

    private String fallback(String value, String fallback) {
        return StringUtils.hasText(value) ? value.trim() : fallback;
    }

    private String blankToNull(String value) {
        return StringUtils.hasText(value) ? value.trim() : null;
    }
}

import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/progress_ring.dart';
import '../../data/models/achievement_models.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  AchievementCategory? _selectedCategory; // null = All
  int _filterTab = 0; // 0: All, 1: Unlocked, 2: Locked

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final store = scope.store;
    final achStore = scope.achievementStore;
    final isFa = l10n.isFa;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: Listenable.merge([store, achStore]),
      builder: (context, _) {
        final allItems = achStore.getAllProgress(store);
        final filteredItems = allItems.where((item) {
          if (_selectedCategory != null &&
              item.definition.category != _selectedCategory) {
            return false;
          }
          if (_filterTab == 1 && !item.isUnlocked) return false;
          if (_filterTab == 2 && item.isUnlocked) return false;
          return true;
        }).toList();

        final unlockedCount = allItems.where((a) => a.isUnlocked).length;
        final totalCount = allItems.length;
        final totalPoints = achStore.totalAchievementPoints;

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // Top App Bar
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.translate('achievements'),
                                  style: AppTypography.headlineLgMobile(
                                      color: AppColors.primary),
                                ),
                                Text(
                                  l10n.translate('achievementsSubtitle'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Overall Level & Progress Card
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 60),
                      child: _buildHeroProgressCard(
                        context,
                        l10n,
                        unlockedCount,
                        totalCount,
                        totalPoints,
                        isFa,
                        isDark,
                      ),
                    ),
                  ),
                ),

                // Category Filter Chips
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 100),
                      child: _buildCategoryChips(l10n),
                    ),
                  ),
                ),

                // Status Filter Segment (All / Unlocked / Locked)
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 140),
                      child: Row(
                        children: [
                          _buildFilterTab(0, l10n.translate('allCategories'),
                              allItems.length, isFa),
                          const SizedBox(width: 8),
                          _buildFilterTab(1, l10n.translate('completed'),
                              unlockedCount, isFa),
                          const SizedBox(width: 8),
                          _buildFilterTab(2, l10n.translate('pending'),
                              totalCount - unlockedCount, isFa),
                        ],
                      ),
                    ),
                  ),
                ),

                // Achievement List Items
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  sliver: filteredItems.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: EmptyStateView(
                              icon: Icons.emoji_events_outlined,
                              title: l10n.translate('emptyAnalyticsTitle'),
                              message: l10n.translate('lockedDescription'),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = filteredItems[index];
                              return FadeSlideIn(
                                delay: Duration(
                                    milliseconds: 180 + (index * 30)),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildAchievementCard(
                                    context,
                                    l10n,
                                    item,
                                    isFa,
                                    isDark,
                                  ),
                                ),
                              );
                            },
                            childCount: filteredItems.length,
                          ),
                        ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 60)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroProgressCard(
    BuildContext context,
    AppLocalizations l10n,
    int unlocked,
    int total,
    int points,
    bool isFa,
    bool isDark,
  ) {
    final percent = total > 0 ? (unlocked / total) * 100 : 0.0;

    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Progress Ring
          ProgressRing(
            percentage: percent,
            size: 90,
            strokeWidth: 8,
            primaryColor: AppColors.primary,
            trackColor: AppColors.primary.withValues(alpha: 0.15),
            centerChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events_rounded,
                    color: Color(0xFFFFB800), size: 22),
                const SizedBox(height: 2),
                Text(
                  '${ZedDateUtils.toFaDigits(unlocked, fa: isFa)}/${ZedDateUtils.toFaDigits(total, fa: isFa)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Details & Score
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.translate('levelTitle'),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${ZedDateUtils.toFaDigits(points, fa: isFa)} ${l10n.translate('totalPoints')}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFB800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${ZedDateUtils.toFaDigits(percent.round(), fa: isFa)}٪ ${l10n.translate('completed')}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.translate(percent >= 80
                      ? 'insightDisciplineHigh'
                      : (percent >= 40
                          ? 'insightDisciplineMed'
                          : 'insightDisciplineLow')),
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onSurfaceVariant,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(AppLocalizations l10n) {
    final categories = [
      (null, l10n.translate('allCategories'), Icons.dashboard_outlined),
      (
        AchievementCategory.discipline,
        l10n.translate('catDiscipline'),
        Icons.flash_on_rounded
      ),
      (
        AchievementCategory.focus,
        l10n.translate('catFocus'),
        Icons.timer_outlined
      ),
      (
        AchievementCategory.habits,
        l10n.translate('catHabits'),
        Icons.autorenew_rounded
      ),
      (
        AchievementCategory.planning,
        l10n.translate('catPlanning'),
        Icons.calendar_month_rounded
      ),
      (
        AchievementCategory.mastery,
        l10n.translate('catMastery'),
        Icons.military_tech_rounded
      ),
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategory == cat.$1;

          return FilterChip(
            selected: isSelected,
            showCheckmark: false,
            avatar: Icon(
              cat.$3,
              size: 16,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
            label: Text(
              cat.$2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : AppColors.onSurface,
              ),
            ),
            backgroundColor: AppColors.surfaceContainerLow,
            selectedColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.outlineVariant,
                width: 0.5,
              ),
            ),
            onSelected: (_) {
              setState(() => _selectedCategory = cat.$1);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterTab(
      int index, String label, int count, bool isFa) {
    final isSelected = _filterTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _filterTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryContainer.withValues(alpha: 0.2)
                : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
              width: isSelected ? 1.5 : 0.5,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ZedDateUtils.toFaDigits(count, fa: isFa),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context,
    AppLocalizations l10n,
    AchievementProgress item,
    bool isFa,
    bool isDark,
  ) {
    final def = item.definition;
    final isUnlocked = item.isUnlocked;
    final tier = item.unlockedTier;
    final nextThreshold = item.nextThreshold;

    final badgeColor =
        isUnlocked ? (tier?.color ?? AppColors.primary) : AppColors.onSurfaceVariant;
    final nextTarget = nextThreshold?.value ?? def.maxTarget;
    final currentVal = item.currentProgress;

    return GestureDetector(
      onTap: () => _showAchievementDetailSheet(context, l10n, item, isFa),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceContainerLow
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isUnlocked
                ? badgeColor.withValues(alpha: 0.4)
                : AppColors.outlineVariant,
            width: isUnlocked ? 1.5 : 0.5,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: tier?.glowColor ?? Colors.transparent,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge Icon Circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? badgeColor.withValues(alpha: 0.18)
                      : AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isUnlocked ? badgeColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  isUnlocked ? def.iconData : Icons.lock_outline_rounded,
                  color: badgeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),

              // Title, Description & Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.translate(def.titleKey),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        if (isUnlocked && tier != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: tier.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: tier.color.withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              tier.label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: tier.color,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.translate(def.descKey),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Progress bar & counters
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.isMaxedOut
                              ? l10n.translate('maxTierReached')
                              : '${ZedDateUtils.toFaDigits(currentVal.toInt(), fa: isFa)} / ${ZedDateUtils.toFaDigits(nextTarget.toInt(), fa: isFa)} ${l10n.translate(def.unitKey)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked
                                ? badgeColor
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        if (!item.isMaxedOut && nextThreshold != null)
                          Text(
                            l10n.translate('nextTier').replaceFirst('%s', nextThreshold.tier.label),
                            style: TextStyle(
                              fontSize: 10,
                              color: nextThreshold.tier.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: item.percentToNext,
                        minHeight: 6,
                        backgroundColor: AppColors.surfaceContainerHigh,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isUnlocked ? badgeColor : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAchievementDetailSheet(
    BuildContext context,
    AppLocalizations l10n,
    AchievementProgress item,
    bool isFa,
  ) {
    final def = item.definition;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: Container(
            color: isDark ? AppColors.darkSurface : Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),

                // Icon & Title
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: (item.unlockedTier?.color ?? AppColors.primary)
                        .withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.unlockedTier?.color ?? AppColors.primary,
                      width: 2.5,
                    ),
                  ),
                  child: Icon(
                    def.iconData,
                    size: 36,
                    color: item.unlockedTier?.color ?? AppColors.primary,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.translate(def.titleKey),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.translate(def.descKey),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // Tier Stepper Breakdown
                Text(
                  l10n.translate('levelTitle'),
                  style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: def.thresholds.map((threshold) {
                    final isReached = item.currentProgress >= threshold.value;
                    final isCurrent = item.unlockedTier == threshold.tier;

                    return Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isReached
                                ? threshold.tier.color.withValues(alpha: 0.2)
                                : AppColors.surfaceContainerHigh,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isCurrent
                                  ? threshold.tier.color
                                  : (isReached
                                      ? threshold.tier.color.withValues(alpha: 0.5)
                                      : Colors.transparent),
                              width: isCurrent ? 2.5 : 1.0,
                            ),
                          ),
                          child: Icon(
                            isReached
                                ? Icons.check_circle_rounded
                                : Icons.lock_outline_rounded,
                            size: 20,
                            color: isReached
                                ? threshold.tier.color
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          threshold.tier.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isCurrent
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isReached
                                ? threshold.tier.color
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          '${ZedDateUtils.toFaDigits(threshold.value.toInt(), fa: isFa)} ${l10n.translate(def.unitKey)}',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // Action Close Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.translate('close')),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}

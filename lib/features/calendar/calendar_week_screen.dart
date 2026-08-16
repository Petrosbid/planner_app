import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/skeleton.dart';
import '../../data/models/planner_models.dart';
import '../common/block_form_sheet.dart';
import '../common/distraction_reason_sheet.dart';

class CalendarWeekScreen extends StatefulWidget {
  const CalendarWeekScreen({super.key});

  @override
  State<CalendarWeekScreen> createState() => _CalendarWeekScreenState();
}

class _CalendarWeekScreenState extends State<CalendarWeekScreen> with SimulatedFetchMixin {
  static const double _rowHeight = 64;
  static const int _firstHour = 0;
  static const int _lastHour = 23;
  static const double _usefulCapacityHours = 6.5;

  String _selectedView = '3-Day'; // Day, 3-Day, Week, Month
  late DateTime _selectedDay;
  bool _bannerDismissed = false;
  late final ScrollController _scrollController;
  Timer? _nowTicker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _scrollController = ScrollController();
    startSimulatedFetch();
    _nowTicker = Timer.periodic(const Duration(seconds: 60), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _nowTicker?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToNow() {
    if (!mounted || !_scrollController.hasClients) return;
    if (_now.hour < _firstHour || _now.hour > _lastHour) return;
    _scrollController.jumpTo(
      ((_now.hour - _firstHour) * _rowHeight).clamp(0.0, _scrollController.position.maxScrollExtent),
    );
  }

  @override
  void onLoadComplete() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToNow());
  }

  double get _plannedHours => AppScope.of(context).store.plannedHoursForDay(_selectedDay);

  bool get _isOverloaded => _plannedHours > _usefulCapacityHours;

  String _categoryLabel(String category, AppLocalizations l10n) =>
      BlockFormSheet.categoryLabel(category, l10n);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;

    if (isLoading) {
      return Scaffold(body: SafeArea(child: Shimmer(child: _buildSkeleton())));
    }

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          // Also rebuilds when the user switches calendar system or language.
          listenable: Listenable.merge([store, AppScope.of(context).settings]),
          builder: (context, _) {
            final isFa = l10n.isFa;
            final useJalali = AppScope.of(context).settings.useJalali;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(l10n),
                if (_selectedView != 'Month') ...[
                  _buildDateStrip(isFa, useJalali),
                  const SizedBox(height: 12),
                  if (_isOverloaded && !_bannerDismissed) ...[
                    _buildCapacityBanner(l10n, isFa, useJalali),
                    const SizedBox(height: 12),
                  ],
                ],
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _buildBody(l10n, store, isFa, useJalali),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------- header ----------

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.calendar,
              style: AppTypography.headlineLgMobile(color: AppColors.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_rounded, color: AppColors.primary),
            tooltip: l10n.translate('addTimeBlock'),
            onPressed: () => _showAddBlockSheet(l10n),
          ),
          const SizedBox(width: 4),
          Row(
            children: [
              _viewChip('Day', l10n.translate('viewDay')),
              const SizedBox(width: 4),
              _viewChip('3-Day', l10n.translate('view3Day')),
              const SizedBox(width: 4),
              _viewChip('Week', l10n.translate('viewWeek')),
              const SizedBox(width: 4),
              _viewChip('Month', l10n.translate('viewMonth')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _viewChip(String type, String label) {
    final isSelected = _selectedView == type;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppColors.onSurfaceVariant),
      ),
      selected: isSelected,
      selectedColor: AppColors.primary,
      showCheckmark: false,
      onSelected: (val) {
        if (val) setState(() => _selectedView = type);
      },
    );
  }

  // ---------- date strip ----------

  Widget _buildDateStrip(bool isFa, bool useJalali) {
    final week = ZedDateUtils.weekOf(_selectedDay);
    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: week.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, idx) {
          final day = week[idx];
          final isSelected = ZedDateUtils.isSameDay(day, _selectedDay);
          final isToday = ZedDateUtils.isToday(day);
          return GestureDetector(
            onTap: () => setState(() {
              _selectedDay = day;
              _bannerDismissed = false;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: (!isSelected && isToday)
                    ? Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1.5)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ZedDateUtils.weekday(day, fa: isFa, short: true),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ZedDateUtils.dayNumber(day, fa: isFa, jalali: useJalali),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- capacity banner ----------

  Widget _buildCapacityBanner(AppLocalizations l10n, bool isFa, bool useJalali) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: AppColors.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showCapacitySheet(l10n, isFa),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${l10n.translate('capacityWarning')}: ${ZedDateUtils.toFaDigits(_plannedHours.toStringAsFixed(1), fa: isFa)} ${l10n.translate('hoursUnit')} (${l10n.translate('usefulCapacity')}: ${ZedDateUtils.toFaDigits(_usefulCapacityHours, fa: isFa)})',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.error),
                  onPressed: () => setState(() => _bannerDismissed = true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- body per view ----------

  Widget _buildBody(AppLocalizations l10n, PlannerStore store, bool isFa, bool useJalali) {
    switch (_selectedView) {
      case 'Month':
        return _buildMonthView(l10n, store, isFa, useJalali);
      case '3-Day':
        return _buildThreeDayView(l10n, store, isFa, useJalali);
      default:
        return _buildTimeline(l10n, store, isFa, useJalali);
    }
  }

  Widget _buildTimeline(AppLocalizations l10n, PlannerStore store, bool isFa, bool useJalali) {
    final blocks = store.blocksForDay(_selectedDay);
    if (blocks.isEmpty) return _emptyBlocks(l10n, isFa, useJalali);

    final rows = _lastHour - _firstHour + 1;
    return SingleChildScrollView(
      controller: _scrollController,
      key: const ValueKey('timeline'),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: rows * _rowHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            for (var i = 0; i < rows; i++)
              Positioned(
                top: i * _rowHeight,
                left: 0,
                right: 0,
                height: _rowHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          ZedDateUtils.hourLabel((_firstHour + i).toDouble(), fa: isFa),
                          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(height: 1, thickness: 0.5, color: AppColors.outlineVariant),
                    ),
                  ],
                ),
              ),
            for (final tb in blocks)
              Positioned(
                top: (tb.startHour - _firstHour) * _rowHeight + 2,
                height: tb.durationHours * _rowHeight - 4,
                left: 56,
                right: 0,
                child: FadeSlideIn(
                  key: ValueKey(tb.id),
                  duration: const Duration(milliseconds: 300),
                  child: _buildTimeBlock(tb, l10n, isFa, useJalali),
                ),
              ),
            if (ZedDateUtils.isToday(_selectedDay))
              Positioned(
                top: (_now.hour + _now.minute / 60 - _firstHour) * _rowHeight,
                left: 44,
                right: 0,
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    ),
                    const Expanded(child: Divider(height: 2, thickness: 2, color: AppColors.error)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBlock(TimeBlockItem tb, AppLocalizations l10n, bool isFa, bool useJalali) {
    final color = Color(tb.colorValue);
    return GestureDetector(
      onTap: () => _showBlockDetailsSheet(tb, l10n, isFa, useJalali),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border(right: BorderSide(color: color, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    tb.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      decoration: tb.isDone ? TextDecoration.lineThrough : null,
                      color: tb.isDone ? AppColors.onSurfaceVariant : AppColors.onSurface,
                    ),
                  ),
                ),
                if (tb.hasOutcome) ...[
                  const SizedBox(width: 4),
                  Icon(
                    tb.isDone ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    size: 14,
                    color: tb.isDone ? AppColors.success : AppColors.error,
                  ),
                ],
              ],
            ),
            if (tb.durationHours >= 0.75)
              Text(
                ZedDateUtils.rangeLabel(tb.startHour, tb.durationHours, fa: isFa),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
              ),
          ],
        ),
      ),
    );
  }

  Widget _emptyBlocks(AppLocalizations l10n, bool isFa, bool useJalali) {
    return FadeSlideIn(
      key: const ValueKey('empty-blocks'),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available_rounded, size: 56, color: AppColors.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(l10n.translate('emptyBlocksCalendar'), style: AppTypography.headlineMd()),
            const SizedBox(height: 8),
            Text(ZedDateUtils.fullDate(_selectedDay, fa: isFa, jalali: useJalali), style: AppTypography.bodySm()),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => _showAddBlockSheet(l10n),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(l10n.translate('addTimeBlock')),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- 3-day & month ----------

  Widget _buildThreeDayView(AppLocalizations l10n, PlannerStore store, bool isFa, bool useJalali) {
    final days = [0, 1, 2]
        .map((i) => DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day + i))
        .toList();
    return ListView(
      key: const ValueKey('three-day'),
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < days.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(child: _buildThreeDayColumn(days[i], l10n, store, isFa, useJalali)),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildThreeDayColumn(DateTime day, AppLocalizations l10n, PlannerStore store, bool isFa, bool useJalali) {
    final blocks = store.blocksForDay(day);
    final isSelected = ZedDateUtils.isSameDay(day, _selectedDay);
    return GestureDetector(
      onTap: () => setState(() => _selectedDay = day),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceContainerLow : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${ZedDateUtils.weekday(day, fa: isFa, short: true)} ${ZedDateUtils.dayNumber(day, fa: isFa, jalali: useJalali)}',
              style: AppTypography.labelCaps(color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            if (blocks.isEmpty)
              Text(l10n.translate('noCategoryData'), style: AppTypography.bodySm())
            else
              for (final tb in blocks)
                GestureDetector(
                  onTap: () => _showBlockDetailsSheet(tb, l10n, isFa, useJalali),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(tb.colorValue).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border(right: BorderSide(color: Color(tb.colorValue), width: 3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tb.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                        Text(
                          ZedDateUtils.rangeLabel(tb.startHour, tb.durationHours, fa: isFa),
                          style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthView(AppLocalizations l10n, PlannerStore store, bool isFa, bool useJalali) {
    final now = DateTime.now();
    // The current month in the user's calendar system (Jalali or Gregorian).
    final firstOfMonth = ZedDateUtils.monthStart(now, jalali: useJalali);
    final daysInMonth = ZedDateUtils.daysInMonth(now, jalali: useJalali);
    final leading = (firstOfMonth.weekday + 1) % 7; // Sat-start offset
    final allBlocks = store.blocks;

    return Padding(
      key: const ValueKey('month'),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ZedDateUtils.monthYearHeader(now, fa: isFa, jalali: useJalali),
            style: AppTypography.headlineMd(),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: leading + daysInMonth,
            itemBuilder: (ctx, index) {
              if (index < leading) return const SizedBox.shrink();
              final date = firstOfMonth.add(Duration(days: index - leading));
              final count = allBlocks.where((b) => ZedDateUtils.isSameDay(b.date, date)).length;
              final isSelected = ZedDateUtils.isSameDay(date, _selectedDay);
              final isToday = ZedDateUtils.isToday(date);
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedDay = date;
                  _selectedView = 'Day';
                }),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                    border: isToday && !isSelected
                        ? Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1.5)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ZedDateUtils.dayNumber(date, fa: isFa, jalali: useJalali),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        height: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < min(count, 3); i++)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // ---------- sheets ----------

  void _showAddBlockSheet(AppLocalizations l10n) {
    // Shared form: 24h range, custom categories, overlap validation.
    BlockFormSheet.show(context, initialDate: _selectedDay);
  }

  void _showBlockDetailsSheet(TimeBlockItem tb, AppLocalizations l10n, bool isFa, bool useJalali) {
    final store = AppScope.of(context).store;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(tb.colorValue).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_categoryLabel(tb.category, l10n), style: AppTypography.labelCaps()),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(tb.title, style: AppTypography.headlineMd()),
              const SizedBox(height: 8),
              Text(ZedDateUtils.fullDate(tb.date, fa: isFa, jalali: useJalali), style: AppTypography.bodySm()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.schedule_rounded, size: 18, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${ZedDateUtils.rangeLabel(tb.startHour, tb.durationHours, fa: isFa)} · ${l10n.translate('durationLabel')}: ${ZedDateUtils.toFaDigits(tb.durationHours, fa: isFa)} ${l10n.translate('hoursUnit')}',
                      style: AppTypography.bodySm(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Outcome: done / not done (not done records a reason).
              Text(l10n.translate('outcomeSection'), style: AppTypography.labelCaps()),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _outcomeButton(
                      ctx: ctx,
                      selected: tb.isDone,
                      icon: Icons.check_circle_rounded,
                      label: l10n.translate('markDone'),
                      color: AppColors.success,
                      onTap: () {
                        tb.isDone = true;
                        tb.hasOutcome = true;
                        store.updateBlock(tb);
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _outcomeButton(
                      ctx: ctx,
                      selected: tb.hasOutcome && !tb.isDone,
                      icon: Icons.cancel_rounded,
                      label: l10n.translate('markNotDone'),
                      color: AppColors.error,
                      onTap: () {
                        tb.isDone = false;
                        tb.hasOutcome = true;
                        store.updateBlock(tb);
                        Navigator.of(ctx).pop();
                        DistractionReasonSheet.show(context, relatedTitle: tb.title);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _showEditBlockDialog(tb, l10n);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: Text(l10n.translate('edit')),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.outlined(
                    tooltip: l10n.translate('delete'),
                    onPressed: () async {
                      await store.deleteBlock(tb);
                      if (!ctx.mounted) return;
                      Navigator.of(ctx).pop();
                    },
                    icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _outcomeButton({
    required BuildContext ctx,
    required bool selected,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: selected ? Colors.white : color,
          backgroundColor: selected ? color : color.withValues(alpha: 0.08),
          side: BorderSide(color: selected ? color : color.withValues(alpha: 0.4)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        icon: Icon(icon, size: 18),
        label: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showEditBlockDialog(TimeBlockItem tb, AppLocalizations l10n) {
    final controller = TextEditingController(text: tb.title);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('edit')),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.translate('cancel'))),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                tb.title = text;
                AppScope.of(context).store.updateBlock(tb);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(l10n.translate('save')),
          ),
        ],
      ),
    );
  }

  void _showCapacitySheet(AppLocalizations l10n, bool isFa) {
    final store = AppScope.of(context).store;
    final blocks = store.blocksForDay(_selectedDay);
    final capFraction = (_plannedHours / _usefulCapacityHours).clamp(0.0, 1.0);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.translate('capacityBreakdown'), style: AppTypography.headlineMd()),
              const SizedBox(height: 20),
              _capacityRow(
                l10n.translate('plannedTime'),
                '${ZedDateUtils.toFaDigits(_plannedHours.toStringAsFixed(1), fa: isFa)} ${l10n.translate('hoursUnit')}',
                AppColors.error,
                capFraction,
              ),
              const SizedBox(height: 12),
              _capacityRow(
                l10n.translate('usefulCapacity'),
                '${ZedDateUtils.toFaDigits(_usefulCapacityHours, fa: isFa)} ${l10n.translate('hoursUnit')}',
                AppColors.success,
                1.0,
              ),
              const SizedBox(height: 20),
              Text(l10n.translate('categorySplit'), style: AppTypography.labelCaps()),
              const SizedBox(height: 8),
              for (final tb in blocks)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: Color(tb.colorValue), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(tb.title, style: AppTypography.bodySm(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        '${ZedDateUtils.toFaDigits(tb.durationHours, fa: isFa)} ${l10n.translate('hoursUnit')}',
                        style: AppTypography.bodySm(),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(l10n.translate('close')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _capacityRow(String label, String value, Color color, double fraction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.bodySm()),
            Text(value, style: AppTypography.numericMd(color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 8,
            backgroundColor: AppColors.surfaceContainerLow,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // ---------- skeleton ----------

  Widget _buildSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const SkeletonLine(width: 120, height: 22),
              const Spacer(),
              for (var i = 0; i < 3; i++) ...[
                SkeletonLine(width: 44, height: 28, borderRadius: 14),
                const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        SizedBox(
          height: 76,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (var i = 0; i < 7; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SkeletonCard(
                    radius: 16,
                    padding: EdgeInsets.zero,
                    child: const SizedBox(
                      width: 52,
                      child: Center(child: SkeletonLine(width: 24, height: 26)),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SkeletonCard(
            radius: 16,
            padding: const EdgeInsets.all(12),
            child: const SkeletonLine(height: 12),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (var i = 0; i < 9; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonLine(width: 42, height: 10),
                      const SizedBox(width: 14),
                      Expanded(
                        child: SkeletonCard(
                          radius: 12,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonLine(width: 150 + (i % 3) * 40.0, height: 12),
                              const SizedBox(height: 8),
                              const SkeletonLine(width: 90, height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

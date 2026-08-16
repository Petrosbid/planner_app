import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';

/// Shared "new time block" form used by the quick-create button and the
/// calendar. Covers the full 24-hour day, supports custom categories, and
/// rejects ranges that overlap an existing block on the chosen day.
class BlockFormSheet extends StatefulWidget {
  final DateTime initialDate;

  const BlockFormSheet({super.key, required this.initialDate});

  static void show(BuildContext context, {DateTime? initialDate}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlockFormSheet(initialDate: initialDate ?? DateTime.now()),
    );
  }

  /// Display label for a category key: built-ins localize, customs show as-is.
  static String categoryLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'deep':
        return l10n.translate('deepWork');
      case 'meeting':
        return l10n.translate('meeting');
      case 'review':
        return l10n.translate('review');
      default:
        return key;
    }
  }

  @override
  State<BlockFormSheet> createState() => _BlockFormSheetState();
}

class _BlockFormSheetState extends State<BlockFormSheet> {
  final _titleController = TextEditingController();
  late DateTime _date = DateTime(
    widget.initialDate.year,
    widget.initialDate.month,
    widget.initialDate.day,
  );
  double _startHour = 9;
  double _duration = 1;
  late String _category = 'deep';
  String? _conflictTitle;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _save(PlannerStore store, AppLocalizations l10n) {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final conflict = store.conflictingBlock(_date, _startHour, _duration);
    if (conflict != null) {
      setState(() => _conflictTitle = conflict.title);
      return;
    }

    store.addBlock(
      title: title,
      date: _date,
      startHour: _startHour,
      durationHours: _duration,
      colorValue: PlannerStore.categoryColor(_category),
      category: _category,
    );
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.translate('blockAdded'))),
    );
  }

  Future<void> _showNewCategoryDialog(PlannerStore store, AppLocalizations l10n) async {
    final controller = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);
    final added = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('addCategory')),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.translate('categoryNameHint')),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(l10n.translate('cancel'))),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.translate('add')),
          ),
        ],
      ),
    );
    if (added != true) return;
    final ok = await store.addCustomCategory(controller.text);
    if (!mounted) return;
    if (ok) {
      setState(() => _category = controller.text.trim());
      messenger.showSnackBar(SnackBar(content: Text(l10n.translate('newCategoryAdded'))));
    } else {
      messenger.showSnackBar(SnackBar(content: Text(l10n.translate('categoryExists'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final settings = AppScope.of(context).settings;
    final isFa = l10n.isFa;
    final useJalali = settings.useJalali;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.translate('addBlockTitle'), style: AppTypography.headlineMd()),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.translate('blockTitleHint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 16),

              // Day picker (calendar-aware labels)
              Text(l10n.translate('dateLabel'), style: AppTypography.labelCaps()),
              const SizedBox(height: 8),
              SizedBox(
                height: 64,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final day = DateTime.now().add(Duration(days: i));
                    final selected = ZedDateUtils.isSameDay(day, _date);
                    return GestureDetector(
                      onTap: () => setState(() {
                        _date = day;
                        _conflictTitle = null;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.primary : AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              i == 0
                                  ? l10n.translate('today')
                                  : ZedDateUtils.weekday(day, fa: isFa, short: true),
                              style: TextStyle(
                                fontSize: 11,
                                color: selected ? Colors.white : AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ZedDateUtils.dayNumber(day, fa: isFa, jalali: useJalali),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Start hour: full 24-hour range, 30-minute steps
              Text(
                '${l10n.translate('startTimeLabel')}: ${ZedDateUtils.hourLabel(_startHour, fa: isFa)}',
                style: AppTypography.bodySm(),
              ),
              Slider(
                value: _startHour,
                min: 0,
                max: 23.5,
                divisions: 47,
                onChanged: (v) => setState(() {
                  _startHour = v;
                  _conflictTitle = null;
                }),
              ),
              Text(
                '${l10n.translate('durationLabel')}: ${ZedDateUtils.toFaDigits(_duration, fa: isFa)} ${l10n.translate('hoursUnit')}',
                style: AppTypography.bodySm(),
              ),
              Slider(
                value: _duration,
                min: 0.5,
                max: 8,
                divisions: 15,
                onChanged: (v) => setState(() {
                  _duration = v;
                  _conflictTitle = null;
                }),
              ),

              // Categories: built-ins + user's own + add-new
              Text(l10n.translate('category'), style: AppTypography.labelCaps()),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in store.allCategories)
                    ChoiceChip(
                      label: Text(BlockFormSheet.categoryLabel(c, l10n)),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: _category == c ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                      avatar: CircleAvatar(
                        backgroundColor: Color(PlannerStore.categoryColor(c)),
                        radius: 5,
                      ),
                      selected: _category == c,
                      selectedColor: AppColors.primary,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _category = c),
                    ),
                  ActionChip(
                    avatar: Icon(Icons.add_rounded, size: 18, color: AppColors.primary),
                    label: Text(l10n.translate('addCategory')),
                    onPressed: () => _showNewCategoryDialog(store, l10n),
                  ),
                ],
              ),

              if (_conflictTitle != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 18, color: AppColors.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.translate('timeConflictError').replaceAll('%s', _conflictTitle!),
                          style: const TextStyle(fontSize: 12, color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () => _save(store, l10n),
                  child: Text(l10n.translate('save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

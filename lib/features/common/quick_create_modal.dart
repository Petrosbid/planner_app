import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';

/// Global quick-create sheet. Writes straight to the [PlannerStore].
class QuickCreateModal extends StatefulWidget {
  const QuickCreateModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickCreateModal(),
    );
  }

  @override
  State<QuickCreateModal> createState() => _QuickCreateModalState();
}

class _QuickCreateModalState extends State<QuickCreateModal> {
  String _selectedType = 'task'; // task, habit, goal, project, note, block
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _estimatedMinutes = 30;
  bool _isCommitment = false;
  int _priority = 1; // 0 low, 1 medium, 2 high

  // Time block options
  DateTime _blockDate = DateTime.now();
  double _blockStart = 9;
  double _blockDuration = 1;
  String _blockCategory = 'deep'; // deep | meeting | review

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final store = AppScope.of(context).store;
    final l10n = AppLocalizations.of(context);

    switch (_selectedType) {
      case 'habit':
        await store.addHabit(title: title);
        break;
      case 'goal':
        await store.addGoal(title: title, description: _descController.text.trim());
        break;
      case 'project':
        await store.addProject(title: title);
        break;
      case 'note':
        await store.addNote(title: title, body: _descController.text.trim());
        break;
      case 'block':
        await store.addBlock(
          title: title,
          date: _blockDate,
          startHour: _blockStart,
          durationHours: _blockDuration,
          colorValue: _blockColor().toARGB32(),
          category: _blockCategory,
        );
        break;
      default:
        await store.addTask(
          title: title,
          description: _descController.text.trim(),
          priority: _priority,
          estimatedMinutes: _estimatedMinutes,
          isCommitment: _isCommitment,
        );
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _selectedType == 'block' ? l10n.translate('blockAdded') : '${l10n.translate('add')}: $title',
        ),
      ),
    );
  }

  Color _blockColor() {
    switch (_blockCategory) {
      case 'meeting':
        return AppColors.success;
      case 'review':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isFa = l10n.isFa;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: bottomInset + 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: FadeSlideIn(
          duration: const Duration(milliseconds: 250),
          offset: const Offset(0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.quickCreate, style: AppTypography.headlineMd(color: AppColors.primary)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Type selector pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _typeChip('task', l10n.translate('newTask'), Icons.check_circle_outline),
                    _typeChip('habit', l10n.translate('newHabit'), Icons.autorenew),
                    _typeChip('goal', l10n.translate('newGoal'), Icons.flag_outlined),
                    _typeChip('project', l10n.translate('newProject'), Icons.folder_open),
                    _typeChip('note', l10n.translate('newNote'), Icons.note_outlined),
                    _typeChip('block', l10n.translate('timeBlock'), Icons.schedule_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: _hintFor(l10n),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 12),

              // Time block options: day, start hour, duration, category
              if (_selectedType == 'block') ...[
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
                      final selected = ZedDateUtils.isSameDay(day, _blockDate);
                      final useJalali = AppScope.of(context).settings.useJalali;
                      return GestureDetector(
                        onTap: () => setState(() => _blockDate = day),
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
                                    : ZedDateUtils.weekday(day, fa: l10n.isFa, short: true),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: selected ? Colors.white : AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                ZedDateUtils.dayNumber(day, fa: l10n.isFa, jalali: useJalali),
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
                Text(
                  '${l10n.translate('startTimeLabel')}: ${ZedDateUtils.hourLabel(_blockStart, fa: l10n.isFa)}',
                  style: AppTypography.bodySm(),
                ),
                Slider(
                  value: _blockStart,
                  min: 8,
                  max: 20,
                  divisions: 24,
                  onChanged: (v) => setState(() => _blockStart = v),
                ),
                Text(
                  '${l10n.translate('durationLabel')}: ${ZedDateUtils.toFaDigits(_blockDuration, fa: l10n.isFa)} ${l10n.translate('hoursUnit')}',
                  style: AppTypography.bodySm(),
                ),
                Slider(
                  value: _blockDuration,
                  min: 0.5,
                  max: 4,
                  divisions: 7,
                  onChanged: (v) => setState(() => _blockDuration = v),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final c in ['deep', 'meeting', 'review'])
                      ChoiceChip(
                        label: Text(_categoryLabel(c, l10n)),
                        selected: _blockCategory == c,
                        selectedColor: AppColors.primary,
                        showCheckmark: false,
                        onSelected: (_) => setState(() => _blockCategory = c),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Description (task/goal/note)
              if (_selectedType == 'task' || _selectedType == 'goal' || _selectedType == 'note') ...[
                TextField(
                  controller: _descController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: l10n.translate('noteBodyHint'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // Task options
              if (_selectedType == 'task') ...[
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _estimatedMinutes,
                        decoration: InputDecoration(labelText: l10n.translate('estimatedLabel')),
                        items: [
                          DropdownMenuItem(value: 15, child: Text('۱۵ ${l10n.minutes}')),
                          DropdownMenuItem(value: 30, child: Text('۳۰ ${l10n.minutes}')),
                          DropdownMenuItem(value: 60, child: Text('۱ ${l10n.hours}')),
                          DropdownMenuItem(value: 90, child: Text('۹۰ ${l10n.minutes}')),
                          DropdownMenuItem(value: 120, child: Text('۲ ${l10n.hours}')),
                        ],
                        onChanged: (val) => setState(() => _estimatedMinutes = val ?? 30),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _priority,
                        decoration: InputDecoration(labelText: l10n.translate('priorityLabel')),
                        items: [
                          DropdownMenuItem(value: 0, child: Text(l10n.translate('priorityLow'))),
                          DropdownMenuItem(value: 1, child: Text(l10n.translate('priorityMedium'))),
                          DropdownMenuItem(value: 2, child: Text(l10n.translate('priorityHigh'))),
                        ],
                        onChanged: (val) => setState(() => _priority = val ?? 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilterChip(
                  label: Text(_isCommitment
                      ? l10n.translate('topCommitments')
                      : l10n.translate('filterPending')),
                  selected: _isCommitment,
                  onSelected: (val) => setState(() => _isCommitment = val),
                  selectedColor: AppColors.primaryContainer.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 12),
              ],

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _submit,
                  child: Text('${l10n.translate('add')} ${_submitLabelFor(l10n, isFa)}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _submitLabelFor(AppLocalizations l10n, bool isFa) {
    switch (_selectedType) {
      case 'habit':
        return l10n.habits;
      case 'goal':
        return l10n.goals;
      case 'project':
        return l10n.projects;
      case 'note':
        return l10n.notes;
      case 'block':
        return l10n.translate('timeBlock');
      default:
        return l10n.tasks;
    }
  }

  String _hintFor(AppLocalizations l10n) {
    switch (_selectedType) {
      case 'habit':
        return l10n.translate('habitTitleHint');
      case 'goal':
        return l10n.translate('goalTitleHint');
      case 'project':
        return l10n.translate('projectTitleHint');
      case 'note':
        return l10n.translate('noteTitleHint');
      case 'block':
        return l10n.translate('blockTitleHint');
      default:
        return l10n.translate('taskTitleHint');
    }
  }

  String _categoryLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'deep':
        return l10n.translate('deepWork');
      case 'meeting':
        return l10n.translate('meeting');
      default:
        return l10n.translate('review');
    }
  }

  Widget _typeChip(String type, String label, IconData icon) {
    final isSelected = _selectedType == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : AppColors.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        selected: isSelected,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (sel) {
          if (sel) setState(() => _selectedType = type);
        },
      ),
    );
  }
}

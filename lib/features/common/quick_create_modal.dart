import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import 'block_form_sheet.dart';

/// Global quick-create sheet. Writes straight to the [PlannerStore].
/// The time-block type hands off to [BlockFormSheet] (24h + categories +
/// conflict validation), so this sheet stays for instant items.
class QuickCreateModal extends StatefulWidget {
  final BuildContext openerContext;

  const QuickCreateModal({super.key, required this.openerContext});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QuickCreateModal(openerContext: context),
    );
  }

  @override
  State<QuickCreateModal> createState() => _QuickCreateModalState();
}

class _QuickCreateModalState extends State<QuickCreateModal> {
  String _selectedType = 'task'; // task, habit, goal, project, note
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _estimateController = TextEditingController(text: '30');
  bool _isCommitment = false;
  int _priority = 1; // 0 low, 1 medium, 2 high

  static const _estimatePresets = [15, 30, 45, 60, 90, 120];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _estimateController.dispose();
    super.dispose();
  }

  /// Accepts Persian and Arabic-Indic digits.
  int? _parseMinutes(String input) {
    const fa = '۰۱۲۳۴۵۶۷۸۹';
    const ar = '٠١٢٣٤٥٦٧٨٩';
    var normalized = input.trim();
    for (var i = 0; i < 10; i++) {
      normalized = normalized.replaceAll(fa[i], '$i').replaceAll(ar[i], '$i');
    }
    return int.tryParse(normalized);
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final store = AppScope.of(context).store;
    final l10n = AppLocalizations.of(context);

    int estimated = 30;
    if (_selectedType == 'task') {
      final parsed = _parseMinutes(_estimateController.text);
      if (parsed == null || parsed <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.translate('invalidEstimate'))),
        );
        return;
      }
      estimated = parsed;
    }

    switch (_selectedType) {
      case 'habit':
        await store.addHabit(title: title);
        break;
      case 'goal':
        await store.addGoal(title: title, description: _descController.text.trim());
        break;
      case 'project':
        await store.addProject(title: title, description: _descController.text.trim());
        break;
      case 'note':
        await store.addNote(title: title, body: _descController.text.trim());
        break;
      default:
        await store.addTask(
          title: title,
          description: _descController.text.trim(),
          priority: _priority,
          estimatedMinutes: estimated,
          isCommitment: _isCommitment,
        );
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.translate('add')}: $title')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

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

              // Description (task/goal/project/note)
              if (_selectedType != 'habit') ...[
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

              // Task options: custom estimate + priority + commitment
              if (_selectedType == 'task') ...[
                Text(l10n.translate('estimatedLabel'), style: AppTypography.labelCaps()),
                const SizedBox(height: 8),
                TextField(
                  controller: _estimateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: l10n.translate('estimateHint'),
                    suffixText: l10n.minutes,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final preset in _estimatePresets)
                      ActionChip(
                        label: Text('$preset'),
                        labelStyle: const TextStyle(fontSize: 12),
                        onPressed: () => setState(() => _estimateController.text = '$preset'),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilterChip(
                        label: Text(_isCommitment
                            ? l10n.translate('topCommitments')
                            : l10n.translate('filterPending')),
                        selected: _isCommitment,
                        onSelected: (val) => setState(() => _isCommitment = val),
                        selectedColor: AppColors.primaryContainer.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _submit,
                  child: Text('${l10n.translate('add')} ${_submitLabelFor(l10n)}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _submitLabelFor(AppLocalizations l10n) {
    switch (_selectedType) {
      case 'habit':
        return l10n.habits;
      case 'goal':
        return l10n.goals;
      case 'project':
        return l10n.projects;
      case 'note':
        return l10n.notes;
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
      default:
        return l10n.translate('taskTitleHint');
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
          if (!sel) return;
          if (type == 'block') {
            // Hand off to the dedicated block form via the screen that opened us.
            Navigator.of(context).pop();
            BlockFormSheet.show(widget.openerContext);
            return;
          }
          setState(() => _selectedType = type);
        },
      ),
    );
  }
}

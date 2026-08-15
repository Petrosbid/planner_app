import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class QuickCreateModal extends StatefulWidget {
  final Function(String type, Map<String, dynamic> data) onCreateItem;

  const QuickCreateModal({super.key, required this.onCreateItem});

  static void show(BuildContext context, Function(String type, Map<String, dynamic> data) onCreateItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => QuickCreateModal(onCreateItem: onCreateItem),
    );
  }

  @override
  State<QuickCreateModal> createState() => _QuickCreateModalState();
}

class _QuickCreateModalState extends State<QuickCreateModal> {
  String _selectedType = 'task'; // task, habit, goal, project, note, focus
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _estimatedMinutes = 30;
  bool _isCommitment = false;
  final int _priorityIndex = 1; // 0: low, 1: medium, 2: high

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: bottomInset + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.quickCreate,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type Selector Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _typeChip('task', l10n.newTask, Icons.check_circle_outline),
                  _typeChip('habit', l10n.newHabit, Icons.autorenew),
                  _typeChip('goal', l10n.newGoal, Icons.flag_outlined),
                  _typeChip('project', l10n.newProject, Icons.folder_open),
                  _typeChip('note', l10n.newNote, Icons.note_outlined),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title Field
            TextField(
              controller: _titleController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: _getHintText(l10n),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 12),

            // Options for Task
            if (_selectedType == 'task') ...[
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: _estimatedMinutes,
                      decoration: const InputDecoration(labelText: 'زمان تخمینی'),
                      items: const [
                        DropdownMenuItem(value: 15, child: Text('۱۵ دقیقه')),
                        DropdownMenuItem(value: 30, child: Text('۳۰ دقیقه')),
                        DropdownMenuItem(value: 60, child: Text('۱ ساعت')),
                        DropdownMenuItem(value: 90, child: Text('۹۰ دقیقه')),
                        DropdownMenuItem(value: 120, child: Text('۲ ساعت')),
                      ],
                      onChanged: (val) => setState(() => _estimatedMinutes = val ?? 30),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilterChip(
                    label: Text(_isCommitment ? 'تعهد اصلی' : 'وظیفه عادی'),
                    selected: _isCommitment,
                    onSelected: (val) => setState(() => _isCommitment = val),
                    selectedColor: AppColors.primaryContainer.withValues(alpha: 0.3),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text('ایجاد ${_getSubmitLabel(l10n)}'),
              ),
            ),
          ],
        ),
      ),
    );
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

  String _getHintText(AppLocalizations l10n) {
    switch (_selectedType) {
      case 'habit':
        return 'عنوان عادت (مثال: مطالعه روزانه ۲۰ دقیقه)';
      case 'goal':
        return 'عنوان هدف (مثال: تسلط بر برنامه نویسی فلاتر)';
      case 'project':
        return 'عنوان پروژه (مثال: طراحی اپلیکیشن ZedPlan)';
      case 'note':
        return 'عنوان یادداشت...';
      default:
        return 'عنوان وظیفه (مثال: طراحی رابط کاربردی)';
    }
  }

  String _getSubmitLabel(AppLocalizations l10n) {
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

  void _submit() {
    if (_titleController.text.trim().isEmpty) return;

    widget.onCreateItem(_selectedType, {
      'title': _titleController.text.trim(),
      'description': _descController.text.trim(),
      'estimatedMinutes': _estimatedMinutes,
      'isCommitment': _isCommitment,
      'priority': _priorityIndex == 2 ? 'high' : (_priorityIndex == 0 ? 'low' : 'medium'),
    });

    Navigator.of(context).pop();
  }
}

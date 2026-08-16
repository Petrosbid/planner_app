import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/models/planner_models.dart';

/// Detail view for a single real task, resolved from the store by [taskId].
class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;

    return ListenableBuilder(
      listenable: store,
      builder: (_, __) {
        final task = store.taskById(widget.taskId);
        if (task == null) {
          // Deleted while open — pop back gracefully.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.translate('taskDetailTitle')),
            actions: [
              IconButton(
                icon: Icon(
                  task.isCommitment ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: task.isCommitment ? AppColors.primary : AppColors.onSurfaceVariant,
                ),
                tooltip: l10n.translate('topCommitments'),
                onPressed: () {
                  task.isCommitment = !task.isCommitment;
                  store.updateTask(task);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                tooltip: l10n.translate('delete'),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);
                  await store.deleteTask(task);
                  if (!mounted) return;
                  navigator.pop();
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.translate('taskDeleted'))),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                FadeSlideIn(child: _heroCard(l10n, store, task)),
                const SizedBox(height: 16),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 80),
                  child: _infoCard(l10n, task, isFa),
                ),
                const SizedBox(height: 16),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 160),
                  child: _descriptionCard(l10n, task),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _heroCard(AppLocalizations l10n, PlannerStore store, TaskItem task) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => store.toggleTaskDone(task),
                child: AnimatedScale(
                  scale: task.isCompleted ? 1.0 : 0.92,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: task.isCompleted ? AppColors.success : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: task.isCompleted ? AppColors.success : AppColors.outlineVariant,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
                  ),
                  child: Text(task.title),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.primary),
                tooltip: l10n.translate('editTaskTitle'),
                onPressed: () => _showEditTitleDialog(l10n, store, task),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _badge(
                task.priority == 2
                    ? l10n.translate('priorityHigh')
                    : task.priority == 0
                        ? l10n.translate('priorityLow')
                        : l10n.translate('priorityMedium'),
                AppColors.errorContainer,
                AppColors.error,
              ),
              _badge(
                '${l10n.translate('estimatedLabel')}: ${task.estimatedMinutes}',
                AppColors.primaryFixed,
                AppColors.primary,
              ),
              if (task.isCommitment)
                _badge(l10n.translate('topCommitments'), AppColors.surfaceContainerHigh, AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoCard(AppLocalizations l10n, TaskItem task, bool isFa) {
    final useJalali = AppScope.of(context).settings.useJalali;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.translate('startTimeLabel'), style: AppTypography.labelCaps()),
          const SizedBox(height: 8),
          Text(ZedDateUtils.fullDate(task.createdAt, fa: isFa, jalali: useJalali), style: AppTypography.bodyLg()),
        ],
      ),
    );
  }

  Widget _descriptionCard(AppLocalizations l10n, TaskItem task) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.translate('noDescription'), style: AppTypography.labelCaps()),
          const SizedBox(height: 8),
          Text(
            task.description.isEmpty ? l10n.translate('noDescription') : task.description,
            style: AppTypography.bodyLg(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditTitleDialog(AppLocalizations l10n, PlannerStore store, TaskItem task) async {
    final controller = TextEditingController(text: task.title);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('editTaskTitle')),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.translate('cancel'))),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                task.title = text;
                store.updateTask(task);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(l10n.translate('save')),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: fg)),
    );
  }
}

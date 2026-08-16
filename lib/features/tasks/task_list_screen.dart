import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../data/models/planner_models.dart';
import '../common/quick_create_modal.dart';

/// The Tasks tab: a real list of the user's tasks with filters and actions.
class TaskListScreen extends StatefulWidget {
  final void Function(String taskId) onOpenTaskDetail;

  const TaskListScreen({super.key, required this.onOpenTaskDetail});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _filter = 0; // 0 all, 1 pending, 2 done

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(l10n.translate('tasksTitle'), style: AppTypography.headlineLgMobile(color: AppColors.primary)),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_rounded, color: AppColors.primary),
                    tooltip: l10n.translate('addTask'),
                    onPressed: () => QuickCreateModal.show(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _filterChip(0, l10n.translate('filterAll')),
                  const SizedBox(width: 8),
                  _filterChip(1, l10n.translate('filterPending')),
                  const SizedBox(width: 8),
                  _filterChip(2, l10n.translate('filterDone')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildBody(l10n, store.tasks, isFa),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n, List<TaskItem> tasks, bool isFa) {
    final filtered = tasks.where((t) {
      if (_filter == 1) return !t.isCompleted;
      if (_filter == 2) return t.isCompleted;
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return _filter != 0
          ? Center(child: Text(l10n.translate('noDescription'), style: AppTypography.bodySm()))
          : EmptyStateShim(
              l10n: l10n,
            );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      itemCount: filtered.length,
      itemBuilder: (ctx, i) {
        final task = filtered[i];
        return FadeSlideIn(
          key: ValueKey(task.id),
          delay: Duration(milliseconds: 40 * (i < 8 ? i : 8)),
          child: _taskTile(l10n, task, isFa),
        );
      },
    );
  }

  Widget _taskTile(AppLocalizations l10n, TaskItem task, bool isFa) {
    final priorityColor = task.priority == 2
        ? AppColors.error
        : task.priority == 0
            ? AppColors.onSurfaceVariant
            : AppColors.warning;

    return Dismissible(
      key: ValueKey('dismiss-${task.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        final store = AppScope.of(context).store;
        await store.deleteTask(task);
        if (!mounted) return true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.translate('taskDeleted')),
            action: SnackBarAction(
              label: l10n.translate('undo'),
              onPressed: () => store.addTask(
                title: task.title,
                description: task.description,
                priority: task.priority,
                estimatedMinutes: task.estimatedMinutes,
                isCommitment: task.isCommitment,
              ),
            ),
          ),
        );
        return true;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            right: BorderSide(color: priorityColor, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: () => widget.onOpenTaskDetail(task.id),
            leading: _animatedCheckbox(task),
            title: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
              ),
              child: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            subtitle: Text(
              '${l10n.translate('estimatedLabel')}: ${ZedDateUtils.toFaDigits(task.estimatedMinutes, fa: isFa)} ${l10n.minutes}',
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
            ),
            trailing: task.isCommitment
                ? Icon(Icons.star_rounded, color: AppColors.primary, size: 20)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _animatedCheckbox(TaskItem task) {
    return GestureDetector(
      onTap: () => AppScope.of(context).store.toggleTaskDone(task),
      child: AnimatedScale(
        scale: task.isCompleted ? 1.0 : 0.92,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: task.isCompleted ? AppColors.success : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: task.isCompleted ? AppColors.success : AppColors.outlineVariant,
              width: 2,
            ),
          ),
          child: task.isCompleted
              ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
              : null,
        ),
      ),
    );
  }

  Widget _filterChip(int value, String label) {
    final selected = _filter == value;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, color: selected ? Colors.white : AppColors.onSurfaceVariant)),
      selected: selected,
      selectedColor: AppColors.primary,
      showCheckmark: false,
      onSelected: (_) => setState(() => _filter = value),
    );
  }
}

/// Small indirection so the empty state animates via AnimatedSwitcher.
class EmptyStateShim extends StatelessWidget {
  final AppLocalizations l10n;

  const EmptyStateShim({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      key: const ValueKey('empty-tasks'),
      icon: Icons.task_alt_rounded,
      title: l10n.translate('emptyTasksTitle'),
      message: l10n.translate('emptyTasksMessage'),
      actionLabel: l10n.translate('addTask'),
      onAction: () => QuickCreateModal.show(context),
    );
  }
}

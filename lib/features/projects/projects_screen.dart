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

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.translate('projectsTitle')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: l10n.translate('addProject'),
            onPressed: () => _showAddProjectSheet(l10n),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final projects = store.projects;
            if (projects.isEmpty) {
              return EmptyStateView(
                icon: Icons.folder_open,
                title: l10n.translate('emptyProjectsTitle'),
                message: l10n.translate('emptyProjectsMessage'),
                actionLabel: l10n.translate('addProject'),
                onAction: () => _showAddProjectSheet(l10n),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              itemCount: projects.length,
              itemBuilder: (ctx, i) {
                final project = projects[i];
                return FadeSlideIn(
                  key: ValueKey(project.id),
                  delay: Duration(milliseconds: 50 * (i < 8 ? i : 8)),
                  child: _projectCard(l10n, store, project, isFa),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _projectCard(AppLocalizations l10n, PlannerStore store, ProjectItem project, bool isFa) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: () => _showEditProjectSheet(l10n, store, project),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryFixed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.folder_open, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project.title,
                    style: AppTypography.headlineMd(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: 20, color: AppColors.primary),
                  tooltip: l10n.translate('editProject'),
                  onPressed: () => _showEditProjectSheet(l10n, store, project),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                  tooltip: l10n.translate('delete'),
                  onPressed: () => store.deleteProject(project),
                ),
              ],
            ),
            if (project.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                project.description,
                style: AppTypography.bodySm(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Text(
              '${l10n.translate('progress')}: ${ZedDateUtils.toFaDigits((project.progress * 100).round(), fa: isFa)}٪',
              style: AppTypography.bodySm(),
            ),
            const SizedBox(height: 4),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: project.progress),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.surfaceContainerHigh,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditProjectSheet(AppLocalizations l10n, PlannerStore store, ProjectItem project) async {
    final titleController = TextEditingController(text: project.title);
    final descController = TextEditingController(text: project.description);
    var progress = project.progress;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.translate('editProject'), style: AppTypography.headlineMd()),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: l10n.translate('projectTitleHint'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.translate('descriptionLabel'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${l10n.translate('progress')}: ${(progress * 100).round()}٪',
                  style: AppTypography.bodySm(),
                ),
                Slider(
                  value: progress,
                  onChanged: (v) => setSheetState(() => progress = v),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          final title = titleController.text.trim();
                          if (title.isEmpty) return;
                          project.title = title;
                          project.description = descController.text.trim();
                          project.progress = progress;
                          store.updateProject(project);
                          Navigator.of(ctx).pop();
                        },
                        child: Text(l10n.translate('save')),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.outlined(
                      tooltip: l10n.translate('delete'),
                      onPressed: () {
                        store.deleteProject(project);
                        Navigator.of(ctx).pop();
                      },
                      icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddProjectSheet(AppLocalizations l10n) async {
    final controller = TextEditingController();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.translate('addProject'), style: AppTypography.headlineMd()),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.translate('projectTitleHint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    final title = controller.text.trim();
                    if (title.isEmpty) return;
                    AppScope.of(context).store.addProject(title: title);
                    Navigator.of(ctx).pop();
                  },
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

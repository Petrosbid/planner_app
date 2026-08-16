import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/models/planner_models.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.translate('notesTitle'))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        tooltip: l10n.translate('addNote'),
        onPressed: () => _showNoteEditor(l10n),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final notes = store.notes
                .where((n) =>
                    _query.isEmpty ||
                    n.title.contains(_query) ||
                    n.body.contains(_query))
                .toList();

            if (store.notes.isEmpty) {
              return EmptyStateView(
                icon: Icons.note_alt_outlined,
                title: l10n.translate('emptyNotesTitle'),
                message: l10n.translate('emptyNotesMessage'),
                actionLabel: l10n.translate('addNote'),
                onAction: () => _showNoteEditor(l10n),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    decoration: InputDecoration(
                      hintText: l10n.translate('searchNotes'),
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                Expanded(
                  child: notes.isEmpty
                      ? Center(child: Text(l10n.translate('noDescription'), style: AppTypography.bodySm()))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 90),
                          itemCount: notes.length,
                          itemBuilder: (ctx, i) {
                            final note = notes[i];
                            return FadeSlideIn(
                              key: ValueKey(note.id),
                              delay: Duration(milliseconds: 40 * (i < 8 ? i : 8)),
                              child: _noteCard(l10n, note, isFa),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _noteCard(AppLocalizations l10n, NoteItem note, bool isFa) {
    final useJalali = AppScope.of(context).settings.useJalali;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: () => _showNoteEditor(l10n, existing: note),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: AppTypography.headlineMd(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                  tooltip: l10n.translate('delete'),
                  onPressed: () async {
                    await AppScope.of(context).store.deleteNote(note);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.translate('noteDeleted'))),
                    );
                  },
                ),
              ],
            ),
            if (note.body.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                note.body,
                style: AppTypography.bodySm(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            Text(
              ZedDateUtils.fullDate(note.updatedAt, fa: isFa, jalali: useJalali),
              style: AppTypography.labelCaps(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNoteEditor(AppLocalizations l10n, {NoteItem? existing}) async {
    final titleController = TextEditingController(text: existing?.title ?? '');
    final bodyController = TextEditingController(text: existing?.body ?? '');
    final store = AppScope.of(context).store;

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
              Text(
                existing == null ? l10n.translate('addNote') : l10n.translate('edit'),
                style: AppTypography.headlineMd(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.translate('noteTitleHint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: l10n.translate('noteBodyHint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () async {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;
                    if (existing == null) {
                      await store.addNote(title: title, body: bodyController.text.trim());
                    } else {
                      await store.updateNote(existing, title: title, body: bodyController.text.trim());
                    }
                    if (!ctx.mounted) return;
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

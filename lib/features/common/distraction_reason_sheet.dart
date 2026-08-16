import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';

/// Records one distraction / not-done reason: built-in options plus the
/// user's custom ones, with an "add new reason" flow. Persists via the store.
class DistractionReasonSheet extends StatefulWidget {
  final String? relatedTitle;

  const DistractionReasonSheet({super.key, this.relatedTitle});

  static void show(BuildContext context, {String? relatedTitle}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DistractionReasonSheet(relatedTitle: relatedTitle),
    );
  }

  /// Display label for a reason key: built-ins localize, customs show as-is.
  static String reasonLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'phone':
        return l10n.translate('reasonPhone');
      case 'lowEnergy':
        return l10n.translate('reasonLowEnergy');
      case 'environment':
        return l10n.translate('reasonEnvironment');
      case 'unexpected':
        return l10n.translate('reasonUnexpected');
      case 'clarity':
        return l10n.translate('reasonClarity');
      case 'motivation':
        return l10n.translate('reasonMotivation');
      default:
        return key == 'other' ? l10n.translate('reasonOther') : key;
    }
  }

  @override
  State<DistractionReasonSheet> createState() => _DistractionReasonSheetState();
}

class _DistractionReasonSheetState extends State<DistractionReasonSheet> {
  Future<void> _showNewReasonDialog() async {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final messenger = ScaffoldMessenger.of(context);
    final controller = TextEditingController();

    final added = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('addReason')),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.translate('reasonNameHint')),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(l10n.translate('cancel'))),
          FilledButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(l10n.translate('add'))),
        ],
      ),
    );
    if (added != true) return;
    final ok = await store.addCustomReason(controller.text);
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.translate(ok ? 'reasonAdded' : 'reasonExists'))),
    );
  }

  void _pick(String reason) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    store.addDistraction(reason: reason, relatedTitle: widget.relatedTitle);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${l10n.translate('distractionRecorded')}: ${DistractionReasonSheet.reasonLabel(reason, l10n)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_paused_outlined, color: AppColors.warning, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.translate('distractionsTitle'), style: AppTypography.headlineMd()),
                    if (widget.relatedTitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.relatedTitle!,
                        style: AppTypography.bodySm(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ] else ...[
                      Text(l10n.translate('distractionSubtitle'), style: AppTypography.bodySm()),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: FadeSlideIn(
                duration: const Duration(milliseconds: 250),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    for (final reason in store.allReasons)
                      ActionChip(
                        avatar: Icon(_reasonIcon(reason), size: 16, color: AppColors.onSurfaceVariant),
                        label: Text(DistractionReasonSheet.reasonLabel(reason, l10n)),
                        labelStyle: const TextStyle(fontSize: 13),
                        onPressed: () => _pick(reason),
                      ),
                    ActionChip(
                      avatar: Icon(Icons.add_rounded, size: 16, color: AppColors.primary),
                      label: Text(l10n.translate('addReason')),
                      labelStyle: TextStyle(fontSize: 13, color: AppColors.primary),
                      onPressed: _showNewReasonDialog,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _reasonIcon(String key) {
    switch (key) {
      case 'phone':
        return Icons.smartphone_rounded;
      case 'lowEnergy':
        return Icons.battery_2_bar_rounded;
      case 'environment':
        return Icons.volume_up_rounded;
      case 'unexpected':
        return Icons.bolt_rounded;
      case 'clarity':
        return Icons.help_outline_rounded;
      case 'motivation':
        return Icons.sentiment_dissatisfied_rounded;
      default:
        return Icons.category_outlined;
    }
  }
}

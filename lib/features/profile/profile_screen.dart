import 'package:flutter/material.dart';

import '../../core/controllers/app_settings.dart';
import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/notifications/notification_service.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';

/// Profile + settings: identity, real stats, working theme & language toggles.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppSettings get _settings => AppScope.of(context).settings;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final l10n = AppLocalizations.of(context);
    final isFa = l10n.isFa;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.translate('profileTitle'))),
      // Rebuild when theme/calendar/locale settings change so checkmarks move live.
      body: ListenableBuilder(
        listenable: scope.settings,
        builder: (_, __) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            FadeSlideIn(
              child: _identityCard(l10n, scope, isFa, scope.settings.useJalali),
            ),
            const SizedBox(height: 16),
            FadeSlideIn(
              delay: const Duration(milliseconds: 80),
              child: _statsRow(l10n, scope.store, isFa),
            ),
            const SizedBox(height: 24),
            FadeSlideIn(
              delay: const Duration(milliseconds: 160),
              child: _settingsCard(l10n),
            ),
            const SizedBox(height: 16),
            FadeSlideIn(
              delay: const Duration(milliseconds: 240),
              child: _aboutCard(l10n),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- identity ----------

  Widget _identityCard(
      AppLocalizations l10n, AppScope scope, bool isFa, bool useJalali) {
    final name = scope.settings.userName;
    final initials = name.isEmpty
        ? '?'
        : name
            .trim()
            .split(' ')
            .where((w) => w.isNotEmpty)
            .map((w) => w[0])
            .take(2)
            .join();
    final isFa = l10n.isFa;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: AppColors.primaryContainer, shape: BoxShape.circle),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? 'ZedPlan ${l10n.translate('appTitle')}' : name,
                  style: AppTypography.headlineMd(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  ZedDateUtils.fullDate(DateTime.now(),
                      fa: isFa, jalali: useJalali),
                  style: AppTypography.bodySm(),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: AppColors.primary),
            tooltip: l10n.translate('editName'),
            onPressed: () => _showNameDialog(l10n, scope.settings),
          ),
        ],
      ),
    );
  }

  Future<void> _showNameDialog(
      AppLocalizations l10n, AppSettings settings) async {
    final controller = TextEditingController(text: settings.userName);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('editName')),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.translate('nameHint')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.translate('cancel')),
          ),
          FilledButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await settings.setUserName(controller.text);
              if (!ctx.mounted) return;
              Navigator.of(ctx).pop();
              if (!mounted) return;
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.translate('nameSaved'))),
              );
            },
            child: Text(l10n.translate('save')),
          ),
        ],
      ),
    );
  }

  // ---------- stats ----------

  Widget _statsRow(AppLocalizations l10n, PlannerStore store, bool isFa) {
    final tasksDone = store.tasks.where((t) => t.isCompleted).length;
    final focusMinutes =
        store.focusRecords.fold(0, (sum, r) => sum + r.minutes);
    final bestStreak = store.habits.fold<int>(0, (best, h) {
      final s = store.habitStreak(h);
      return s > best ? s : best;
    });

    return Row(
      children: [
        _statCard(
          ZedDateUtils.toFaDigits(tasksDone, fa: isFa),
          l10n.translate('statTasksDone'),
          Icons.task_alt_rounded,
          AppColors.primary,
        ),
        const SizedBox(width: 12),
        _statCard(
          ZedDateUtils.toFaDigits(focusMinutes, fa: isFa),
          l10n.translate('statFocusMinutes'),
          Icons.timer_outlined,
          AppColors.success,
        ),
        const SizedBox(width: 12),
        _statCard(
          ZedDateUtils.toFaDigits(bestStreak, fa: isFa),
          l10n.translate('statBestStreak'),
          Icons.local_fire_department_outlined,
          AppColors.warning,
        ),
      ],
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.bodySm().copyWith(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ---------- color palette ----------

  static const List<int> _palette = [
    0xFF3C51C2, // ZedPlan blue (default)
    0xFF6366F1, // indigo
    0xFF8B5CF6, // violet
    0xFFEC4899, // pink
    0xFFEF4444, // red
    0xFFF97316, // orange
    0xFF10B981, // emerald
    0xFF14B8A6, // teal
    0xFF0EA5E9, // sky
    0xFF64748B, // slate
  ];

  Widget _colorPalette() {
    final selected = _settings.seedColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _palette.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (ctx, i) {
            final color = Color(_palette[i]);
            final isSelected = _palette[i] == selected;
            return GestureDetector(
              onTap: () => _settings.setSeedColor(_palette[i]),
              child: AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.onSurface : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: isSelected ? 0.5 : 0.15),
                        blurRadius: isSelected ? 8 : 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check_rounded,
                          size: 18, color: Colors.white)
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------- settings ----------

  Widget _settingsCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(l10n.translate('appearanceSection'),
                style: AppTypography.labelCaps()),
          ),
          SwitchListTile(
            secondary: Icon(
              _settings.themeMode == ThemeMode.dark
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: AppColors.primary,
            ),
            title: Text(l10n.translate('darkMode')),
            value: _settings.themeMode == ThemeMode.dark,
            onChanged: (v) =>
                _settings.setThemeMode(v ? ThemeMode.dark : ThemeMode.light),
          ),
          SwitchListTile(
            secondary: Icon(Icons.notifications_active_outlined,
                color: AppColors.primary),
            title: Text(l10n.translate('notificationsLabel')),
            subtitle: Text(l10n.translate('notificationsDesc'),
                style: AppTypography.bodySm().copyWith(fontSize: 11)),
            isThreeLine: true,
            value: _settings.notificationsEnabled,
            onChanged: (v) async {
              final store = AppScope.of(context).store;
              await _settings.setNotificationsEnabled(v);
              await NotificationService.instance.setEnabled(
                v,
                store,
                alarmEnabled: _settings.blockAlarmEnabled,
              );
            },
          ),
          SwitchListTile(
            secondary: Icon(Icons.alarm_rounded, color: AppColors.primary),
            title: Text(l10n.translate('blockEndAlarmLabel')),
            subtitle: Text(l10n.translate('blockEndAlarmDesc'),
                style: AppTypography.bodySm().copyWith(fontSize: 11)),
            value: _settings.blockAlarmEnabled,
            onChanged: (v) async {
              // Capture context-dependent values before any async gap.
              final store = AppScope.of(context).store;
              final fa = AppLocalizations.of(context).isFa;
              await _settings.setBlockAlarmEnabled(v);
              // Replace already-scheduled notifications so they pick up the
              // new alarm sound immediately (Android notifs are immutable).
              if (_settings.notificationsEnabled) {
                await NotificationService.instance.reschedule(store, fa: fa);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(l10n.translate('themeColor'),
                style: AppTypography.labelCaps()),
          ),
          _colorPalette(),
          const SizedBox(height: 8),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(l10n.translate('calendarSection'),
                style: AppTypography.labelCaps()),
          ),
          ListTile(
            leading: Icon(Icons.today_rounded, color: AppColors.primary),
            title: Text(l10n.translate('jalaliLabel')),
            trailing: _settings.useJalali
                ? Icon(Icons.check_rounded, color: AppColors.primary)
                : null,
            onTap: () => _settings.setUseJalali(true),
          ),
          ListTile(
            leading:
                Icon(Icons.calendar_view_day_rounded, color: AppColors.primary),
            title: Text(l10n.translate('gregorianLabel')),
            trailing: !_settings.useJalali
                ? Icon(Icons.check_rounded, color: AppColors.primary)
                : null,
            onTap: () => _settings.setUseJalali(false),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(l10n.translate('languageSection'),
                style: AppTypography.labelCaps()),
          ),
          ListTile(
            leading: Icon(Icons.translate_rounded, color: AppColors.primary),
            title: Text(l10n.isFa ? 'فارسی' : 'Persian'),
            trailing: l10n.isFa
                ? Icon(Icons.check_rounded, color: AppColors.primary)
                : null,
            onTap: () => _settings.setLocale(const Locale('fa')),
          ),
          ListTile(
            leading: Icon(Icons.translate_rounded, color: AppColors.primary),
            title: const Text('English'),
            trailing: !l10n.isFa
                ? Icon(Icons.check_rounded, color: AppColors.primary)
                : null,
            onTap: () => _settings.setLocale(const Locale('en')),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Text(l10n.translate('securitySection'),
                style: AppTypography.labelCaps()),
          ),
          SwitchListTile(
            secondary:
                Icon(Icons.lock_outline_rounded, color: AppColors.primary),
            title: Text(l10n.translate('lockAppLabel')),
            value: _settings.appLockEnabled,
            onChanged: (v) => _settings.setAppLockEnabled(v),
          ),
          if (_settings.appLockEnabled)
            SwitchListTile(
              secondary:
                  Icon(Icons.fingerprint_rounded, color: AppColors.primary),
              title: Text(l10n.translate('biometricLabel')),
              value: _settings.biometricLockEnabled,
              onChanged: (v) => _settings.setBiometricLockEnabled(v),
            ),
          if (_settings.appLockEnabled)
            ListTile(
              leading: Icon(Icons.pin_outlined, color: AppColors.primary),
              title: Text(l10n.translate('changePinLabel')),
              onTap: () => _showPinDialog(l10n),
            ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.delete_forever_outlined,
                color: AppColors.error),
            title: Text(l10n.translate('resetData'),
                style: const TextStyle(color: AppColors.error)),
            onTap: () => _confirmReset(l10n),
          ),
        ],
      ),
    );
  }

  Future<void> _showPinDialog(AppLocalizations l10n) async {
    final pinController = TextEditingController();
    final confirmController = TextEditingController();

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('changePinLabel')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: l10n.translate('newPinLabel')),
            ),
            TextField(
              controller: confirmController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: l10n.translate('confirmPinLabel')),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.translate('cancel'))),
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.translate('save'))),
        ],
      ),
    );

    if (saved != true || !mounted) return;
    final pin = pinController.text.trim();
    final confirmPin = confirmController.text.trim();
    final valid = RegExp(r'^\d{4}$').hasMatch(pin) && pin == confirmPin;

    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.translate('pinValidationError'))),
      );
      return;
    }

    await _settings.setLockPin(pin);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.translate('pinSaved'))),
    );
  }

  Future<void> _confirmReset(AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.translate('resetConfirmTitle')),
        content: Text(l10n.translate('resetConfirmBody')),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.translate('cancel'))),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.translate('confirm')),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await AppScope.of(context).store.clearAll();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.translate('dataCleared'))),
    );
  }

  // ---------- about ----------

  Widget _aboutCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.translate('aboutSection'),
                    style: AppTypography.labelCaps()),
                const SizedBox(height: 6),
                Text(l10n.translate('aboutBody'),
                    style: AppTypography.bodySm()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

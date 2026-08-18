import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scope.dart';
import 'widgets/focus_timer_ring.dart';
import 'widgets/focus_mode_selector.dart';
import 'widgets/focus_task_card.dart';
import 'widgets/ambient_sound_sheet.dart';
import 'widgets/ambient_sound_type.dart';
import 'widgets/audio_player_service.dart';
import 'widgets/focus_completion_dialog.dart';
import '../common/distraction_reason_sheet.dart';

class FocusSessionScreen extends StatefulWidget {
  final String taskTitle;
  final int totalMinutes;

  const FocusSessionScreen({
    super.key,
    this.taskTitle = '',
    this.totalMinutes = 25,
  });

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  // Session parameters
  String _activeTaskTitle = '';
  int _sessionTotalMinutes = 25;
  int _remainingSeconds = 25 * 60;
  FocusPresetMode _currentMode = FocusPresetMode.pomodoro;
  int _customMinutes = 30;

  // Timer state
  Timer? _timer;
  bool _isRunning = false;
  int _interruptions = 0;
  bool _isTaskCompleted = false;

  // Zen mode & Ambient Sound state
  bool _isZenMode = false;
  bool _ambientAudioEnabled = false;
  AmbientSoundType _selectedSound = AmbientSoundType.rain;
  double _ambientVolume = 70.0;

  @override
  void initState() {
    super.initState();
    _activeTaskTitle = widget.taskTitle;
    _sessionTotalMinutes = widget.totalMinutes;
    _remainingSeconds = _sessionTotalMinutes * 60;
    // Default to the newest pending task, if any.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _activeTaskTitle.isNotEmpty) return;
      final tasks = AppScope.of(context)
          .store
          .tasks
          .where((t) => !t.isCompleted)
          .toList();
      if (tasks.isNotEmpty) {
        setState(() => _activeTaskTitle = tasks.first.title);
      }
    });
  }

  @override
  void didUpdateWidget(covariant FocusSessionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.totalMinutes != oldWidget.totalMinutes && !_isRunning) {
      _sessionTotalMinutes = widget.totalMinutes;
      _remainingSeconds = _sessionTotalMinutes * 60;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    AudioPlayerService.instance.stop();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        setState(() => _isRunning = false);
        _recordCompletedSession();
        _handleSessionCompleted();
      }
    });
  }

  /// Persist the finished session so stats and analytics reflect it.
  void _recordCompletedSession() {
    final store = AppScope.of(context).store;
    store.recordFocus(
      minutes: _sessionTotalMinutes,
      interruptions: _interruptions,
      taskTitle: _activeTaskTitle.isEmpty ? null : _activeTaskTitle,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(AppLocalizations.of(context).translate('focusRecorded'))),
    );
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingSeconds = _sessionTotalMinutes * 60;
    });
  }

  void _skipSession() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('رد کردن این جلسه؟'),
        content: const Text(
            'آیا می‌خواهید از ادامه این جلسه صرف‌نظر کنید و تایمر را بازنشانی نمایید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _resetTimer();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('تایید و بازنشانی',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _addMinute() {
    setState(() {
      _remainingSeconds += 60;
    });
  }

  void _subtractMinute() {
    if (_remainingSeconds > 60) {
      setState(() {
        _remainingSeconds -= 60;
      });
    }
  }

  void _selectMode(FocusPresetMode mode) {
    final newMinutes =
        mode == FocusPresetMode.custom ? _customMinutes : mode.minutes;
    setState(() {
      _currentMode = mode;
      _sessionTotalMinutes = newMinutes;
      _remainingSeconds = newMinutes * 60;
    });
  }

  void _updateCustomMinutes(int minutes) {
    setState(() {
      _customMinutes = minutes;
      _sessionTotalMinutes = minutes;
      _remainingSeconds = minutes * 60;
    });
  }

  void _logInterruption() {
    setState(() => _interruptions++);
    // The shared sheet persists the distraction (reason + related task).
    DistractionReasonSheet.show(
      context,
      relatedTitle: _activeTaskTitle.isEmpty ? null : _activeTaskTitle,
    );
  }

  void _openAmbientAudioSheet() {
    AmbientSoundSheet.show(
      context,
      isEnabled: _ambientAudioEnabled,
      selectedSound: _selectedSound,
      volume: _ambientVolume,
      onToggle: (enabled) => setState(() => _ambientAudioEnabled = enabled),
      onSoundSelected: (sound) => setState(() => _selectedSound = sound),
      onVolumeChanged: (vol) => setState(() => _ambientVolume = vol),
    );
  }

  void _handleSessionCompleted() {
    FocusCompletionDialog.show(
      context,
      totalMinutes: _sessionTotalMinutes,
      interruptions: _interruptions,
      taskTitle: _activeTaskTitle,
      onStartBreak: () {
        _selectMode(FocusPresetMode.shortBreak);
        _startTimer();
      },
      onStartNextSession: () {
        _selectMode(FocusPresetMode.pomodoro);
        setState(() => _interruptions = 0);
        _startTimer();
      },
      onFinish: () {
        _resetTimer();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  /// Preset color with pomodoro following the app's theme color.
  Color get _modeColor => _currentMode.color ?? AppColors.primary;

  String _formatPersianDigits(String input) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsiDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(englishDigits[i], farsiDigits[i]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalSeconds = _sessionTotalMinutes * 60;
    final progressPercentage = totalSeconds > 0
        ? ((totalSeconds - _remainingSeconds) / totalSeconds) * 100.0
        : 0.0;

    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTightHeight = constraints.maxHeight < 680;
            final double ringSize = isTightHeight ? 200.0 : 230.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: (constraints.maxHeight - 16)
                          .clamp(0.0, double.infinity),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 1. Top Header Bar
                        _buildHeaderBar(context,
                            isDark: isDark, canPop: canPop),

                        const SizedBox(height: 10),

                        // 2. Active Task Anchor Card (Hidden in Zen Mode)
                        if (!_isZenMode) ...[
                          FocusTaskCard(
                            taskTitle: _activeTaskTitle,
                            isTaskCompleted: _isTaskCompleted,
                            onTaskChanged: (title) =>
                                setState(() => _activeTaskTitle = title),
                            onTaskCompletedToggle: (val) =>
                                setState(() => _isTaskCompleted = val),
                            isZenMode: _isZenMode,
                          ),
                          const SizedBox(height: 10),
                        ],

                        // 3. Preset Mode Selector Pills (Hidden in Zen Mode)
                        if (!_isZenMode) ...[
                          FocusModeSelector(
                            selectedMode: _currentMode,
                            customMinutes: _customMinutes,
                            isTimerRunning: _isRunning,
                            onModeSelected: _selectMode,
                            onCustomMinutesChanged: _updateCustomMinutes,
                          ),
                          const SizedBox(height: 12),
                        ],

                        // 4. Centered Hero Circular Countdown Timer
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FocusTimerRing(
                            percentage: progressPercentage,
                            remainingSeconds: _remainingSeconds,
                            totalSeconds: totalSeconds,
                            isRunning: _isRunning,
                            modeName: _currentMode.title,
                            primaryColor: _modeColor,
                            onAddMinute: _addMinute,
                            onSubtractMinute: _subtractMinute,
                            isZenMode: _isZenMode,
                            ringSize: ringSize,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 5. Interruption Logger & Ambient Audio Action Pills (Hidden in Zen Mode)
                        if (!_isZenMode) ...[
                          _buildQuickToolsRow(isDark: isDark),
                          const SizedBox(height: 12),
                        ],

                        // 6. Centered Primary Control Buttons (Play/Pause, Reset, Skip)
                        _buildControlButtons(isDark: isDark),

                        const SizedBox(height: 12),

                        // 7. Mini Daily Focus Stats Footer (Hidden in Zen Mode)
                        if (!_isZenMode)
                          _buildDailyFocusStatsBar(isDark: isDark),

                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context,
      {required bool isDark, required bool canPop}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (canPop)
          IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            tooltip: 'بازگشت',
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _modeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.self_improvement_rounded,
                    size: 15, color: _modeColor),
                const SizedBox(width: 4),
                Text(
                  'کار عمیق',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _modeColor,
                  ),
                ),
              ],
            ),
          ),

        // Title
        Flexible(
          child: Text(
            'حالت تمرکز عمیق',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
            ),
          ),
        ),

        // Zen Mode Toggle Icon
        IconButton(
          onPressed: () => setState(() => _isZenMode = !_isZenMode),
          icon: Icon(
            _isZenMode
                ? Icons.fullscreen_exit_rounded
                : Icons.fullscreen_rounded,
            size: 24,
            color: _isZenMode
                ? AppColors.primary
                : (isDark
                    ? AppColors.darkOnSurfaceVariant
                    : AppColors.onSurfaceVariant),
          ),
          tooltip:
              _isZenMode ? 'خروج از حالت تمام‌صفحه' : 'حالت غوطه‌وری (Zen)',
        ),
      ],
    );
  }

  Widget _buildQuickToolsRow({required bool isDark}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Interruption Counter Pill
        Flexible(
          child: InkWell(
            onTap: _logInterruption,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: _interruptions > 0
                    ? AppColors.error.withValues(alpha: isDark ? 0.2 : 0.1)
                    : (isDark
                        ? AppColors.darkSurfaceContainerLow
                        : AppColors.surfaceContainerLowest),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _interruptions > 0
                      ? AppColors.error.withValues(alpha: 0.5)
                      : (isDark
                          ? AppColors.darkOutlineVariant.withValues(alpha: 0.3)
                          : AppColors.outlineVariant.withValues(alpha: 0.4)),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_paused_outlined,
                    size: 15,
                    color: _interruptions > 0
                        ? AppColors.error
                        : (isDark
                            ? AppColors.darkOnSurfaceVariant
                            : AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      'حواس‌پرتی: ${_formatPersianDigits(_interruptions.toString())}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _interruptions > 0
                            ? AppColors.error
                            : (isDark
                                ? AppColors.darkOnSurfaceVariant
                                : AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.add_rounded,
                      size: 14, color: AppColors.error),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Ambient Audio Pill
        Flexible(
          child: InkWell(
            onTap: _openAmbientAudioSheet,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: _ambientAudioEnabled
                    ? _selectedSound.color.withValues(alpha: isDark ? 0.2 : 0.1)
                    : (isDark
                        ? AppColors.darkSurfaceContainerLow
                        : AppColors.surfaceContainerLowest),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _ambientAudioEnabled
                      ? _selectedSound.color.withValues(alpha: 0.5)
                      : (isDark
                          ? AppColors.darkOutlineVariant.withValues(alpha: 0.3)
                          : AppColors.outlineVariant.withValues(alpha: 0.4)),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _ambientAudioEnabled
                        ? _selectedSound.icon
                        : Icons.volume_off_rounded,
                    size: 15,
                    color: _ambientAudioEnabled
                        ? _selectedSound.color
                        : (isDark
                            ? AppColors.darkOnSurfaceVariant
                            : AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      _ambientAudioEnabled
                          ? _selectedSound.title
                          : 'صداهای محیطی',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _ambientAudioEnabled
                            ? _selectedSound.color
                            : (isDark
                                ? AppColors.darkOnSurfaceVariant
                                : AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButtons({required bool isDark}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Reset / Stop Button
        IconButton.filledTonal(
          onPressed: _resetTimer,
          tooltip: 'بازنشانی تایمر',
          style: IconButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.darkSurfaceContainerHigh
                : AppColors.surfaceContainerHigh,
            padding: const EdgeInsets.all(10),
          ),
          icon: Icon(
            Icons.refresh_rounded,
            color: isDark
                ? AppColors.darkOnSurfaceVariant
                : AppColors.onSurfaceVariant,
            size: 20,
          ),
        ),
        const SizedBox(width: 18),

        // Big Primary Play / Pause Action Button
        GestureDetector(
          onTap: _toggleTimer,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _modeColor,
              boxShadow: [
                BoxShadow(
                  color: _modeColor.withValues(alpha: 0.4),
                  blurRadius: _isRunning ? 18 : 10,
                  spreadRadius: _isRunning ? 2 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  key: ValueKey<bool>(_isRunning),
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),

        // Skip / Forward Button
        IconButton.filledTonal(
          onPressed: _skipSession,
          tooltip: 'پرش به بعد',
          style: IconButton.styleFrom(
            backgroundColor: isDark
                ? AppColors.darkSurfaceContainerHigh
                : AppColors.surfaceContainerHigh,
            padding: const EdgeInsets.all(10),
          ),
          icon: Icon(
            Icons.skip_next_rounded,
            color: isDark
                ? AppColors.darkOnSurfaceVariant
                : AppColors.onSurfaceVariant,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyFocusStatsBar({required bool isDark}) {
    final store = AppScope.of(context).store;
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceContainerLow
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? AppColors.darkOutlineVariant.withValues(alpha: 0.3)
                : AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _miniStat(
              icon: Icons.timer_outlined,
              title: l10n.translate('focusTodayStat'),
              value:
                  '${_formatPersianDigits(store.todayFocusMinutes.toString())} ${l10n.translate('minutesStat')}',
              color: AppColors.primary,
            ),
            Container(
              width: 1,
              height: 22,
              color: isDark
                  ? AppColors.darkOutlineVariant
                  : AppColors.outlineVariant,
            ),
            _miniStat(
              icon: Icons.check_circle_outline_rounded,
              title: l10n.translate('sessionsStat'),
              value: _formatPersianDigits(
                  store.todayFocusRecords.length.toString()),
              color: AppColors.success,
            ),
            Container(
              width: 1,
              height: 22,
              color: isDark
                  ? AppColors.darkOutlineVariant
                  : AppColors.outlineVariant,
            ),
            _miniStat(
              icon: Icons.notifications_paused_outlined,
              title: l10n.translate('mainObstacles'),
              value: _formatPersianDigits(_interruptions.toString()),
              color: AppColors.warning,
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style:
                  TextStyle(fontSize: 8.5, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

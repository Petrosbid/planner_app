import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum FocusPresetMode {
  pomodoro(title: 'پومودورو', minutes: 25, icon: Icons.timer_outlined),
  deepWork(title: 'کار عمیق', minutes: 50, icon: Icons.bolt_rounded, color: Color(0xFF4F46E5)),
  shortBreak(title: 'استراحت کوتاه', minutes: 5, icon: Icons.coffee_rounded, color: AppColors.success),
  longBreak(title: 'استراحت بلند', minutes: 15, icon: Icons.nature_people_rounded, color: Color(0xFF0D9488)),
  custom(title: 'سفارشی', minutes: 30, icon: Icons.tune_rounded, color: AppColors.warning);

  final String title;
  final int minutes;
  final IconData icon;

  /// Preset color; null means "follow the app's theme color" (pomodoro).
  final Color? color;

  const FocusPresetMode({
    required this.title,
    required this.minutes,
    required this.icon,
    this.color,
  });
}

class FocusModeSelector extends StatelessWidget {
  final FocusPresetMode selectedMode;
  final int customMinutes;
  final ValueChanged<FocusPresetMode> onModeSelected;
  final ValueChanged<int> onCustomMinutesChanged;
  final bool isTimerRunning;

  const FocusModeSelector({
    super.key,
    required this.selectedMode,
    required this.customMinutes,
    required this.onModeSelected,
    required this.onCustomMinutesChanged,
    this.isTimerRunning = false,
  });

  String _formatPersianDigits(String input) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsiDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(englishDigits[i], farsiDigits[i]);
    }
    return result;
  }

  void _showCustomDurationDialog(BuildContext context) {
    int tempMinutes = customMinutes;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
              width: 0.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'تنظیم مدت زمان دلخواه تمرکز',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${_formatPersianDigits(tempMinutes.toString())} دقیقه',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.primary.withValues(alpha: 0.15),
                  thumbColor: AppColors.primary,
                ),
                child: Slider(
                  value: tempMinutes.toDouble(),
                  min: 5,
                  max: 120,
                  divisions: 23,
                  onChanged: (val) {
                    setModalState(() => tempMinutes = val.toInt());
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('۵ دقیقه', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                  Text('۱۲۰ دقیقه', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    onCustomMinutesChanged(tempMinutes);
                    onModeSelected(FocusPresetMode.custom);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'اعمال زمان سفارشی',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: FocusPresetMode.values.map((mode) {
          final isSelected = selectedMode == mode;
          final duration = mode == FocusPresetMode.custom ? customMinutes : mode.minutes;
          final durationStr = _formatPersianDigits('$durationد');
          // Null color means "follow the app theme" (pomodoro).
          final modeColor = mode.color ?? AppColors.primary;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isTimerRunning
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ابتدا تایمر را متوقف کنید یا پایان دهید.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      : () {
                          if (mode == FocusPresetMode.custom) {
                            _showCustomDurationDialog(context);
                          } else {
                            onModeSelected(mode);
                          }
                        },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? modeColor.withValues(alpha: isDark ? 0.25 : 0.12)
                          : (isDark
                              ? AppColors.darkSurfaceContainerLow
                              : AppColors.surfaceContainerLowest),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? modeColor.withValues(alpha: 0.6)
                            : (isDark
                                ? AppColors.darkOutlineVariant.withValues(alpha: 0.4)
                                : AppColors.outlineVariant.withValues(alpha: 0.4)),
                        width: isSelected ? 1.5 : 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          mode.icon,
                          size: 16,
                          color: isSelected
                              ? modeColor
                              : (isDark
                                  ? AppColors.darkOnSurfaceVariant
                                  : AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          mode.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? (isDark ? Colors.white : modeColor)
                                : (isDark
                                    ? AppColors.darkOnSurfaceVariant
                                    : AppColors.onSurfaceVariant),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? modeColor.withValues(alpha: 0.2)
                                : (isDark
                                    ? AppColors.darkSurfaceContainerHigh
                                    : AppColors.surfaceContainerHigh),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            durationStr,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? modeColor
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
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class FocusCompletionDialog extends StatelessWidget {
  final int totalMinutes;
  final int interruptions;
  final String taskTitle;
  final VoidCallback onStartBreak;
  final VoidCallback onStartNextSession;
  final VoidCallback onFinish;

  const FocusCompletionDialog({
    super.key,
    required this.totalMinutes,
    required this.interruptions,
    required this.taskTitle,
    required this.onStartBreak,
    required this.onStartNextSession,
    required this.onFinish,
  });

  static void show(
    BuildContext context, {
    required int totalMinutes,
    required int interruptions,
    required String taskTitle,
    required VoidCallback onStartBreak,
    required VoidCallback onStartNextSession,
    required VoidCallback onFinish,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => FocusCompletionDialog(
        totalMinutes: totalMinutes,
        interruptions: interruptions,
        taskTitle: taskTitle,
        onStartBreak: onStartBreak,
        onStartNextSession: onStartNextSession,
        onFinish: onFinish,
      ),
    );
  }

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
    final efficiency = (100 - (interruptions * 8)).clamp(40, 100);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebration Badge
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF3C51C2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 38),
            ),
            const SizedBox(height: 18),

            const Text(
              'تمرکز با موفقیت تکمیل شد! 🎉',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              taskTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            // Statistics Grid Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceContainerLow
                    : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem(
                    label: 'زمان تمرکز',
                    value: '${_formatPersianDigits(totalMinutes.toString())} دقیقه',
                    color: AppColors.primary,
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
                  ),
                  _statItem(
                    label: 'حواس‌پرتی‌ها',
                    value: '${_formatPersianDigits(interruptions.toString())} مورد',
                    color: interruptions == 0 ? AppColors.success : AppColors.warning,
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
                  ),
                  _statItem(
                    label: 'بازدهی تمرکز',
                    value: '${_formatPersianDigits(efficiency.toString())}٪',
                    color: AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onStartBreak();
                },
                icon: const Icon(Icons.coffee_rounded, size: 18, color: Colors.white),
                label: const Text(
                  'شروع استراحت کوتاه (۵ دقیقه)',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onStartNextSession();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('جلسه بعدی', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onFinish();
                    },
                    child: const Text('پایان و ذخیره', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

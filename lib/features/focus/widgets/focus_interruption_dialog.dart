import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class FocusInterruptionDialog extends StatelessWidget {
  final int currentCount;
  final ValueChanged<String> onLogged;

  const FocusInterruptionDialog({
    super.key,
    required this.currentCount,
    required this.onLogged,
  });

  static void show(
    BuildContext context, {
    required int currentCount,
    required ValueChanged<String> onLogged,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FocusInterruptionDialog(
        currentCount: currentCount,
        onLogged: onLogged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final reasons = [
      {'title': 'تماس یا پیام اضطراری', 'icon': Icons.phone_callback_rounded, 'color': Color(0xFFEF4444)},
      {'title': 'همکار یا اعضای خانواده', 'icon': Icons.people_outline_rounded, 'color': Color(0xFFF59E0B)},
      {'title': 'نوتیفیکیشن و شبکه‌های اجتماعی', 'icon': Icons.notifications_active_outlined, 'color': Color(0xFF8B5CF6)},
      {'title': 'خستگی / نیاز به آب یا استراحت', 'icon': Icons.battery_charging_full_rounded, 'color': Color(0xFF06B6D4)},
      {'title': 'حواس‌پرتی متفرقه یا پرش ذهنی', 'icon': Icons.psychology_outlined, 'color': Color(0xFF6B7280)},
    ];

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_paused_outlined, color: AppColors.error, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ثبت علت حواس‌پرتی',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ثبت شفاف به بهبود دیسیپلین و تمرکز شما کمک می‌کند.',
                      style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...reasons.map((item) {
            final title = item['title'] as String;
            final icon = item['icon'] as IconData;
            final color = item['color'] as Color;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onLogged(title);
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurfaceContainerLow
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? AppColors.darkOutlineVariant.withValues(alpha: 0.3) : AppColors.outlineVariant.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: color, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_left_rounded, size: 20, color: AppColors.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      {'label': 'داشبورد', 'icon': Icons.grid_view_rounded},
      {'label': 'وظایف', 'icon': Icons.checklist_rtl_rounded},
      {'label': 'مالی', 'icon': Icons.account_balance_wallet_rounded},
      {'label': 'تحلیل', 'icon': Icons.show_chart_rounded},
      {'label': 'پروفایل', 'icon': Icons.person_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GlassCard(
        borderRadius: 24,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        backgroundColor: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = index == currentIndex;
            final color = isSelected
                ? AppColors.primaryContainer
                : (isDark ? Colors.white54 : AppColors.lightOnSurfaceVariant);

            return InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: color,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

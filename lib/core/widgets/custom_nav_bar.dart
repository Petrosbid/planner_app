import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../localization/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onQuickCreateTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onQuickCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 24),
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurface.withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
                width: 0.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _navItem(context, index: 0, icon: Icons.grid_view_rounded, label: l10n.home)),
                Expanded(child: _navItem(context, index: 1, icon: Icons.calendar_today_rounded, label: l10n.calendar)),
                Expanded(child: _navItem(context, index: 2, icon: Icons.check_box_outlined, label: l10n.tasks)),
                
                // Quick Create FAB in Center
                GestureDetector(
                  onTap: onQuickCreateTap,
                  child: Container(
                    width: 42,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ),

                Expanded(child: _navItem(context, index: 3, icon: Icons.timer_outlined, label: l10n.focus)),
                Expanded(child: _navItem(context, index: 4, icon: Icons.analytics_outlined, label: l10n.analytics)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, {required int index, required IconData icon, required String label}) {
    final isSelected = currentIndex == index;
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.onSurfaceVariant;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: isSelected
              ? BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? activeColor : inactiveColor, size: 20),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

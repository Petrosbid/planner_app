import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ZenHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onFocusModeTap;
  final VoidCallback? onNotificationTap;

  const ZenHeader({
    super.key,
    this.title,
    this.subtitle,
    this.onFocusModeTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Title
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.spa_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ZenPlan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: isDark ? Colors.white : AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),

              // Actions (Focus Mode Button & Notification Bell)
              Row(
                children: [
                  InkWell(
                    onTap: onFocusModeTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryContainer.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.bolt_rounded,
                            color: AppColors.primaryContainer,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'حالت تمرکز',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (onNotificationTap != null) ...[
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded),
                      onPressed: onNotificationTap,
                    ),
                  ],
                ],
              ),
            ],
          ),
          if (title != null) ...[
            const SizedBox(height: 16),
            Text(
              title!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.lightOnSurface,
              ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

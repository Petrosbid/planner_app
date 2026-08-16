import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';

class FocusTaskCard extends StatelessWidget {
  final String taskTitle;
  final String? projectOrCategory;
  final bool isTaskCompleted;
  final ValueChanged<String> onTaskChanged;
  final ValueChanged<bool> onTaskCompletedToggle;
  final bool isZenMode;

  const FocusTaskCard({
    super.key,
    required this.taskTitle,
    this.projectOrCategory = 'ZedPlan App',
    required this.isTaskCompleted,
    required this.onTaskChanged,
    required this.onTaskCompletedToggle,
    this.isZenMode = false,
  });

  void _showChangeTaskSheet(BuildContext context) {
    final controller = TextEditingController(text: taskTitle);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final presetSuggestions = [
      'کار عمیق: طراحی رابط کاربری ZedPlan',
      'برنامه‌نویسی و اتصال به دیتابیس Drift',
      'مطالعه و پژوهش تخصصی',
      'بازبینی و پاسخ به ایمیل‌ها و پیام‌ها',
      'نگارش گزارش هفتگی و تحلیل شاخص‌ها',
      'برنامه‌ریزی استراتژیک روزانه',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
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
              const Text(
                'موضوع یا وظیفه جلسه تمرکز',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'عنوان وظیفه را بنویسید...',
                  prefixIcon: Icon(Icons.bolt_rounded, color: AppColors.primary),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.darkSurfaceContainerLow
                      : AppColors.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'پیشنهادهای سریع:',
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: presetSuggestions.map((suggestion) {
                  return ActionChip(
                    label: Text(suggestion, style: const TextStyle(fontSize: 11)),
                    backgroundColor: isDark
                        ? AppColors.darkSurfaceContainerLow
                        : AppColors.surfaceContainerLow,
                    onPressed: () {
                      controller.text = suggestion;
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      onTaskChanged(controller.text.trim());
                    }
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'ثبت و شروع کار بر روی این وظیفه',
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

    return GlassCard(
      child: InkWell(
        onTap: () => _showChangeTaskSheet(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            children: [
              // Interactive checkbox / complete indicator
              InkWell(
                onTap: () => onTaskCompletedToggle(!isTaskCompleted),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isTaskCompleted
                        ? AppColors.success.withValues(alpha: 0.15)
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isTaskCompleted
                        ? Icons.check_circle_rounded
                        : Icons.bolt_rounded,
                    color: isTaskCompleted ? AppColors.success : AppColors.primary,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title and Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'وظیفه فعال',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkOnSurfaceVariant
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                        if (projectOrCategory != null) ...[
                          Text(
                            ' • $projectOrCategory',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.primary.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      taskTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: isTaskCompleted ? TextDecoration.lineThrough : null,
                        color: isTaskCompleted
                            ? AppColors.onSurfaceVariant
                            : (isDark ? AppColors.darkOnSurface : AppColors.onSurface),
                      ),
                    ),
                  ],
                ),
              ),

              // Edit icon
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant
                      : AppColors.onSurfaceVariant,
                ),
                onPressed: () => _showChangeTaskSheet(context),
                tooltip: 'تغییر وظیفه',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

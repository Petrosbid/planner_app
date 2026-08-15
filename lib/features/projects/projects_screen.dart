import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'پیاده‌سازی نسخه اول اپلیکیشن ZedPlan',
        'progress': 0.85,
        'tasksCount': 18,
        'completedTasks': 15,
        'deadline': '۲۰ مرداد ۱۴۰۵',
      },
      {
        'title': 'بازطراحی معماری سیستم و پایگاه داده',
        'progress': 0.60,
        'tasksCount': 10,
        'completedTasks': 6,
        'deadline': '۳۰ مرداد ۱۴۰۵',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت پروژه‌ها'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'پروژه‌های فعال',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('پروژه جدید'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...projects.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['title'] as String,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('پیشرفت: ${((p['progress'] as double) * 100).round()}٪', style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                            Text('مهلت: ${p['deadline']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: p['progress'] as double,
                          backgroundColor: AppColors.surfaceContainerHigh,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

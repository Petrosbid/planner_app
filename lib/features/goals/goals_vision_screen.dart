import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/progress_ring.dart';

class GoalsVisionScreen extends StatefulWidget {
  const GoalsVisionScreen({super.key});

  @override
  State<GoalsVisionScreen> createState() => _GoalsVisionScreenState();
}

class _GoalsVisionScreenState extends State<GoalsVisionScreen> {
  final List<Map<String, dynamic>> _lifeAreas = [
    {'name': 'سلامتی & تناسب اندام', 'icon': Icons.favorite_rounded, 'color': Color(0xFF10B981)},
    {'name': 'شغلی & حرفه‌ای', 'icon': Icons.work_rounded, 'color': AppColors.primary},
    {'name': 'یادگیری & رشد', 'icon': Icons.school_rounded, 'color': Color(0xFFF59E0B)},
    {'name': 'مالی & سرمایه‌گذاری', 'icon': Icons.account_balance_wallet_rounded, 'color': Color(0xFF8B5CF6)},
  ];

  final List<Map<String, dynamic>> _goals = [
    {
      'title': 'ارتقاء به سمت Senior Mobile Architect',
      'lifeArea': 'شغلی & حرفه‌ای',
      'progress': 65.0,
      'targetDate': '۱۵ اسفند ۱۴۰۵',
      'milestonesCount': 5,
      'completedMilestones': 3,
      'projectsCount': 2,
    },
    {
      'title': 'ورزش منظم ۴ روز در هفته و تغذیه سالم',
      'lifeArea': 'سلامتی & تناسب اندام',
      'progress': 80.0,
      'targetDate': 'مداوم',
      'milestonesCount': 4,
      'completedMilestones': 3,
      'projectsCount': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'چشم‌انداز & اهداف راهبردی',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            const Text(
              'چشم‌انداز خود را به اهداف ملموس و اقدام‌های روزانه تبدیل کنید.',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            // Vision Statement Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.visibility_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'بیانیه چشم‌انداز من',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '«ایجاد زندگی متعادل، عمیق و متمرکز با تسلط کامل بر انضباط فردی و خلق سیستم‌های نرم‌افزاری ارزش‌آفرین.»',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Life Areas Carousel
            const Text(
              'حوزه‌های زندگی',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _lifeAreas.length,
                itemBuilder: (ctx, idx) {
                  final area = _lifeAreas[idx];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.outlineVariant, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: (area['color'] as Color).withValues(alpha: 0.2),
                          child: Icon(area['icon'] as IconData, size: 20, color: area['color'] as Color),
                        ),
                        const Spacer(),
                        Text(
                          area['name'] as String,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Goals List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'اهداف فعال',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('هدف جدید'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._goals.map((g) => _buildGoalCard(g)),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    final progress = goal['progress'] as double;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProgressRing(
                  percentage: progress,
                  size: 56,
                  strokeWidth: 6,
                  primaryColor: AppColors.primary,
                  centerChild: Text(
                    '${progress.round()}٪',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal['title'] as String,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        goal['lifeArea'] as String,
                        style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مایلستون‌ها: ${goal['completedMilestones']} از ${goal['milestonesCount']}',
                  style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                ),
                Text(
                  'تاريخ هدف: ${goal['targetDate']}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

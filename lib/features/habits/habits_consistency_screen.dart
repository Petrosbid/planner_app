import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/aura_charts.dart';

class HabitsConsistencyScreen extends StatefulWidget {
  const HabitsConsistencyScreen({super.key});

  @override
  State<HabitsConsistencyScreen> createState() => _HabitsConsistencyScreenState();
}

class _HabitsConsistencyScreenState extends State<HabitsConsistencyScreen> {
  final List<Map<String, dynamic>> _habits = [
    {
      'id': '1',
      'title': 'مدیتیشن و تنفس عمیق صبحگاهی',
      'streak': 12,
      'frequency': 'هر روز',
      'opacities': [1.0, 0.8, 1.0, 1.0, 0.6, 1.0, 1.0],
      'completedToday': true,
    },
    {
      'id': '2',
      'title': 'مطالعه کتب تخصصی و توسعه فردی (۳۰ دقیقه‌)',
      'streak': 5,
      'frequency': 'روزهای کاری',
      'opacities': [0.8, 1.0, 0.0, 1.0, 1.0, 0.4, 0.0],
      'completedToday': false,
    },
    {
      'id': '3',
      'title': 'ورزش و حرکات کششی عصرگاهی',
      'streak': 8,
      'frequency': '۳ روز در هفته',
      'opacities': [1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0],
      'completedToday': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عادت‌ها & استمرار',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ساخت انضباط پایدار با ردیابی سیستماتیک',
                      style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Metrics Summary Header Card
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem('نرخ استمرار کل', '۸۴٪', AppColors.primary),
                  Container(width: 1, height: 36, color: AppColors.outlineVariant),
                  _statItem('طولانی‌ترین استریک', '۱۲ روز', AppColors.success),
                  Container(width: 1, height: 36, color: AppColors.outlineVariant),
                  _statItem('عادت‌های فعال', '۳', AppColors.onSurface),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Habit Cards List
            const Text(
              'عادت‌های من (۷ روز اخیر)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            ..._habits.map((h) => _buildHabitCard(h)),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildHabitCard(Map<String, dynamic> habit) {
    final completed = habit['completedToday'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit['title'] as String,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'فرکانس: ${habit['frequency']} | استریک: ${habit['streak']} روز 🔥',
                        style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    completed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    color: completed ? AppColors.success : AppColors.outline,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      habit['completedToday'] = !completed;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            HabitHeatmapGrid(dayOpacities: (habit['opacities'] as List).cast<double>()),
          ],
        ),
      ),
    );
  }
}

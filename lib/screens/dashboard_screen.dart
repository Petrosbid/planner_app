import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';
import '../widgets/custom_charts.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const DashboardScreen({super.key, this.onOpenFocusMode});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> _morningRituals = [
    {'title': 'تأمل', 'completed': true},
    {'title': 'مدیتیشن', 'completed': false},
    {'title': 'نوشیدن آب', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    final completedRituals = _morningRituals.where((r) => r['completed'] as bool).length;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            ZenHeader(
              title: 'داشبورد رفتاری',
              subtitle: 'نمای کلی روزانه شما برای بهره‌وری متعادل.',
              onFocusModeTap: widget.onOpenFocusMode,
            ),
            const SizedBox(height: 12),

            // Card 1: Discipline Score
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  children: [
                    const Text(
                      'امتیاز دیسیپلین',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightOnSurface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DonutChartWidget(
                      percentages: const [85, 15],
                      colors: const [AppColors.primaryContainer, Color(0xFFE2E8F0)],
                      centerText: '۸۵\n/ ۱۰۰',
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'ادامه بده! تو در یک مسیر ۵ روزه هستی.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Next Scheduled Task
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                borderColor: AppColors.primaryContainer.withValues(alpha: 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.bolt, color: AppColors.primaryContainer, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'برنامه بعدی',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryContainer,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '۱۰:۰۰ صبح',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightOnSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'نهایی کردن ارائه استراتژی سه‌ماهه سوم',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'بلوک کار عمیق توصیه می‌شود. زمان تخمینی: ۹۰ دقیقه.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.lightOnSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Morning Rituals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.wb_sunny_outlined, color: AppColors.secondary, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'ریچوال صبحگاهی',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(_morningRituals.length, (index) {
                      final item = _morningRituals[index];
                      return CheckboxListTile(
                        value: item['completed'] as bool,
                        title: Text(
                          item['title'] as String,
                          style: TextStyle(
                            decoration: (item['completed'] as bool)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        activeColor: AppColors.primaryContainer,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) {
                          setState(() {
                            item['completed'] = val ?? false;
                          });
                        },
                      );
                    }),
                    const SizedBox(height: 8),
                    Text(
                      '$completedRituals/${_morningRituals.length} تکمیل شده',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.lightOnSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: Energy Forecast Chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.battery_charging_full_rounded, color: AppColors.warning, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'پیش‌بینی انرژی',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'اوج انتظار می‌رود در ساعت ۱۱:۰۰ صبح',
                      style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
                    ),
                    const SizedBox(height: 16),
                    const LineChartWidget(
                      dataPoints: [10, 18, 28, 22, 14, 8],
                      xLabels: ['۸ صبح', '۱۰ صبح', '۱۲ ظهر', '۲ بعدظهر', '۴ عصر', '۶ عصر'],
                      primaryColor: AppColors.primaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

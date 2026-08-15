import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';
import '../widgets/custom_charts.dart';

class PerformanceReportScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const PerformanceReportScreen({super.key, this.onOpenFocusMode});

  @override
  State<PerformanceReportScreen> createState() => _PerformanceReportScreenState();
}

class _PerformanceReportScreenState extends State<PerformanceReportScreen> {
  int _selectedFilter = 1; // 0: روزانه, 1: هفتگی, 2: ماهانه

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: 'گزارش جامع عملکرد',
              subtitle: 'تحلیل وضعیت بهره‌وری و مالی شما در یک نگاه.',
              onFocusModeTap: widget.onOpenFocusMode,
            ),

            // Time Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.lightSurfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _buildFilterTab('روزانه', 0),
                    _buildFilterTab('هفتگی', 1),
                    _buildFilterTab('ماهانه', 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // KPI Metric Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.check_circle_outline, color: AppColors.secondary, size: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('+۱۲٪', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('وظایف انجام شده', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                          const SizedBox(height: 2),
                          const Text('۴۸ وظیفه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.self_improvement, color: AppColors.primaryContainer, size: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('پایدار', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('درصد دیسیپلین', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                          const SizedBox(height: 2),
                          const Text('۸۵٪', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.warning, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('بودجه باقی‌مانده', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                          Text('۲,۴۵۰,۰۰۰ تومان', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('-۵٪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card: Weekly Performance Comparison Bar Chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('مقایسه عملکرد هفتگی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('ساعات تمرکز: این هفته در مقابل هفته گذشته', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                    const SizedBox(height: 16),
                    const WeeklyBarChartWidget(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card: AI Smart Analysis
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('تحلیل هوشمند', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'نقطه قوت: ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                          TextSpan(text: 'دیسیپلین شما در روزهای دوشنبه و چهارشنبه در بالاترین حد خود قرار دارد. تمرکز روی وظایف کلیدی در این روزها نتیجه‌بخش بوده است.'),
                        ],
                      ),
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 10),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'قابل بهبود: ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.error)),
                          TextSpan(text: 'مخارج شما در دسته "سرگرمی" نسبت به هفته گذشته ۲۰٪ افزایش یافته است. پیشنهاد می‌شود برای آخر هفته بودجه‌بندی دقیق‌تری داشته باشید.'),
                        ],
                      ),
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card: Expense Categorization Donut Chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('دسته‌بندی مخارج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Center(
                      child: DonutChartWidget(
                        percentages: [45, 30, 25],
                        colors: [AppColors.primaryContainer, AppColors.secondary, AppColors.warning],
                        centerText: '۱۰۰%\nکل بودجه',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLegendItem('ضروریات', '۴۵٪', AppColors.primaryContainer),
                    _buildLegendItem('پس‌انداز', '۳۰٪', AppColors.secondary),
                    _buildLegendItem('سرگرمی', '۲۵٪', AppColors.warning),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, int index) {
    final selected = _selectedFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected ? Colors.white : AppColors.lightOnSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, String pct, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(pct, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

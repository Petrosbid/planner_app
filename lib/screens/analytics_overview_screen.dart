import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';
import '../widgets/custom_charts.dart';

class AnalyticsOverviewScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const AnalyticsOverviewScreen({super.key, this.onOpenFocusMode});

  @override
  State<AnalyticsOverviewScreen> createState() => _AnalyticsOverviewScreenState();
}

class _AnalyticsOverviewScreenState extends State<AnalyticsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: 'تحلیل بهره‌وری',
              subtitle: 'بار شناختی و روندهای بهره‌وری خود را پیگیری کنید.',
              onFocusModeTap: widget.onOpenFocusMode,
            ),

            // Card 1: 30-Day Growth Trends Chart
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.show_chart, color: AppColors.primaryContainer, size: 24),
                            SizedBox(width: 8),
                            Text('روندهای رشد (۳۰ روز)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('+۱۲٪ نسبت به ماه قبل', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const LineChartWidget(
                      dataPoints: [12, 19, 15, 25, 22, 30, 28],
                      secondaryDataPoints: [4, 6, 5, 8, 7, 9, 8],
                      xLabels: ['۱', '۵', '۱۰', '۱۵', '۲۰', '۲۵', '۳۰'],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: AI Smart Insights
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: AppColors.warning, size: 22),
                        SizedBox(width: 8),
                        Text('بینش‌های هوشمند', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildInsightCard('اوج صبحگاهی', 'شما ۲۰٪ کارهای بیشتری را زمانی که قبل از ۸ صبح شروع می‌کنید انجام می‌دهید. برنامه‌ریزی برای کارهای عمیق در اوایل روز را در نظر بگیرید.', Icons.wb_incandescent_outlined, AppColors.primaryContainer),
                    const SizedBox(height: 10),
                    _buildInsightCard('تشخیص افت انرژی', 'بهره‌وری شما در حدود ساعت ۲ بعد از ظهر کاهش می‌یابد. یک پیاده‌روی ۱۵ دقیقه‌ای یا استراحت برای تمرکز توصیه می‌شود.', Icons.battery_saver, AppColors.secondary),
                    const SizedBox(height: 10),
                    _buildInsightCard('هدف ثبات', 'شما ۳ روز تا طولانی‌ترین روند برنامه‌ریزی روزانه خود فاصله دارید.', Icons.track_changes_outlined, AppColors.warning),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Energy vs Output Scatter Plot
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bubble_chart_outlined, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('انرژی در مقابل خروجی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16),
                    ScatterPlotWidget(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: Focus Consistency Heatmap
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ثبات در تمرکز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('دوشنبه', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                      ],
                    ),
                    SizedBox(height: 16),
                    HeatmapWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

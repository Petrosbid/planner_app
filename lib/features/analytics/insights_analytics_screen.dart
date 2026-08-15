import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/aura_charts.dart';

class InsightsAnalyticsScreen extends StatelessWidget {
  final VoidCallback? onOpenWeeklyReview;

  const InsightsAnalyticsScreen({super.key, this.onOpenWeeklyReview});

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
                      'تحلیل رفتاری & آمار',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'شناخت ریتم شخصی و ارتقاء انضباط خود',
                      style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.rate_review_outlined, color: AppColors.primary),
                  onPressed: onOpenWeeklyReview,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Top Behavioral Metrics Cards
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    child: Column(
                      children: [
                        const Text('دقت برنامه‌ریزی', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                        const SizedBox(height: 8),
                        const Text('۷۲٪', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        const SizedBox(height: 4),
                        Text('کارها ۳۰٪ طولانی‌تر از تخمین بوده‌اند', style: TextStyle(fontSize: 10, color: AppColors.warning)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GlassCard(
                    child: Column(
                      children: [
                        const Text('پایبندی به تعهدات', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                        const SizedBox(height: 8),
                        const Text('۸۴٪', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.success)),
                        const SizedBox(height: 4),
                        const Text('۲۱ از ۲۵ تعهد اصلی انجام شد', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Donut Chart: Time Allocation across Life Areas
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'توزیع زمان بر اساس حوزه‌های زندگی',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const DonutChartWidget(
                        percentages: [45, 25, 15, 15],
                        colors: [AppColors.primary, Color(0xFF10B981), Color(0xFFF59E0B), Color(0xFF8B5CF6)],
                        centerText: '۴۲.۵\nساعت',
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _legendItem('شغلی (۴۵٪)', AppColors.primary),
                          SizedBox(height: 6),
                          _legendItem('سلامتی (۲۵٪)', Color(0xFF10B981)),
                          SizedBox(height: 6),
                          _legendItem('یادگیری (۱۵٪)', Color(0xFFF59E0B)),
                          SizedBox(height: 6),
                          _legendItem('مالی (۱۵٪)', Color(0xFF8B5CF6)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rule-Based Behavioral Insights Recommendations
            const Text(
              'توصیه‌های هوشمند رفتاری',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
            const SizedBox(height: 12),
            _insightCard(
              title: 'الگوی تخمین زمان',
              message: 'شما کارهای مربوط به برنامه‌نویسی فلاتر را معمولاً ۳۰٪ کمتر از حد واقعی تخمین می‌زنید. پیشنهاد می‌شود ۱۵ دقیقه زمان پشتیبان اضافه کنید.',
              icon: Icons.timer_outlined,
              color: AppColors.warning,
            ),
            const SizedBox(height: 12),
            _insightCard(
              title: 'اوج ساعات تمرکز',
              message: 'احتمال تکمیل کارهای عمیق شما بین ساعت ۰۹:۰۰ تا ۱۱:۳۰ صبح تا ۸۸٪ بالاتر از سایر ساعات روز است.',
              icon: Icons.auto_awesome_rounded,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _insightCard({required String title, required String message, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border(right: BorderSide(color: color, width: 4)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

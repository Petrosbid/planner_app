import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/aura_charts.dart';

class WeeklyReviewScreen extends StatelessWidget {
  const WeeklyReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ارزیابی استراتژیک هفتگی'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'مرور عملکرد هفته گذشته',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            const Text(
              'مقایسه برنامه‌ریزی با واقعیت برای تنظیم استراتژی هفته آینده.',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            // Performance Cards Row
            Row(
              children: [
                Expanded(child: _metricCard('تکمیل وظایف', '۸۲٪', AppColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: _metricCard('پایبندی تعهدات', '۸۸٪', AppColors.success)),
                const SizedBox(width: 12),
                Expanded(child: _metricCard('دقت تخمین', '۷۵٪', AppColors.warning)),
              ],
            ),
            const SizedBox(height: 20),

            // Overloaded Days Chart
            GlassCard(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'توزیع فشار کاری روزهای هفته (ساعت)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                  SizedBox(height: 16),
                  SimpleBarChart(
                    values: [6.0, 8.5, 7.0, 9.2, 5.5, 4.0, 2.0],
                    labels: ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Strategic Adjustments Journal Input
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تعدیل‌های استراتژیک برای هفته آینده',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'چه تغییراتی در زمان‌بندی، اهداف یا عادت‌ها ایجاد خواهید کرد؟',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تعدیل‌های استراتژیک برای هفته بعد ذخیره شد.')),
                        );
                      },
                      child: const Text('ثبت و تأیید برنامه هفته بعد'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant, width: 0.5),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 6),
          Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

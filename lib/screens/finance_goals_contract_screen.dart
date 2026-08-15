import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';
import '../widgets/custom_charts.dart';

class FinanceGoalsContractScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const FinanceGoalsContractScreen({super.key, this.onOpenFocusMode});

  @override
  State<FinanceGoalsContractScreen> createState() => _FinanceGoalsContractScreenState();
}

class _FinanceGoalsContractScreenState extends State<FinanceGoalsContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: 'برنامه‌ریزی مالی و اهداف',
              subtitle: 'وضعیت بودجه این ماه خود را مدیریت کنید و به سمت اهداف خود پیش بروید.',
              onFocusModeTap: widget.onOpenFocusMode,
            ),

            // Card 1: Savings Goal Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.track_changes_outlined, color: AppColors.secondary, size: 24),
                            SizedBox(width: 8),
                            Text('هدف پس‌انداز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Icon(Icons.edit_outlined, size: 20, color: AppColors.primaryContainer),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('سفر تابستانی به ژاپن', style: TextStyle(fontSize: 14, color: AppColors.lightOnSurfaceVariant)),
                    ),
                    const SizedBox(height: 16),

                    DonutChartWidget(
                      percentages: const [65, 35],
                      colors: const [AppColors.primaryContainer, Color(0xFFE2E8F0)],
                      centerText: '۶۵%\nتکمیل شده',
                    ),
                    const SizedBox(height: 20),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('پس‌انداز فعلی', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                            SizedBox(height: 2),
                            Text('۶۵,۰۰۰,۰۰۰ تومان', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('هدف نهایی', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                            SizedBox(height: 2),
                            Text('۱۰۰,۰۰۰,۰۰۰ تومان', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Upcoming Bills Card
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
                            Icon(Icons.calendar_month_outlined, color: AppColors.warning, size: 22),
                            SizedBox(width: 8),
                            Text('قبوض پیش‌رو', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('۲ مورد', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildBillItem('قبض برق', '۱۲ آبان', '۱۲۰,۰۰۰ ت', Icons.bolt, AppColors.warning),
                    const SizedBox(height: 8),
                    _buildBillItem('اشتراک اینترنت', '۱۵ آبان', '۳۵۰,۰۰۰ ت', Icons.wifi, AppColors.primaryContainer),
                    const SizedBox(height: 12),

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('افزودن قبض جدید'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Monthly Category Budgets
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('بودجه ماهانه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('آبان ماه', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildBudgetItem('خرید منزل', 0.8, '۸۰%', '8M / 10M', Icons.shopping_cart_outlined, AppColors.secondary),
                    const SizedBox(height: 16),
                    _buildBudgetItem('سرگرمی', 0.4, '۴۰%', '2M / 5M', Icons.movie_creation_outlined, AppColors.primaryContainer),
                    const SizedBox(height: 16),
                    _buildBudgetItem('اجاره', 1.0, '۱۰۰%', '15M / 15M', Icons.home_outlined, AppColors.tertiary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: Financial Commitment Contract Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.assignment_outlined, color: AppColors.primaryContainer, size: 24),
                        SizedBox(width: 8),
                        Text('قرارداد تعهد مالی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      '"من متعهد می‌شوم که در این ماه به سقف بودجه تعیین شده خود پایبند باشم. در صورتی که از بودجه تخطی کنم، جریمه مشخص شده را پرداخت خواهم کرد."',
                      style: TextStyle(fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 16),

                    // Penalty Box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.gavel, color: AppColors.error, size: 20),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('جریمه تخطی', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                              Text('۵۰۰,۰۰۰ تومان به خیریه', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.error)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Partner Box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.group_outlined, color: AppColors.secondary, size: 20),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('شریک پاسخگویی', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                              Text('علی محمدی', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('تایید و امضا'),
                      ),
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

  Widget _buildBillItem(String title, String date, String price, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(date, style: const TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBudgetItem(String title, double val, String pct, String ratio, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            Text(pct, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: val,
            minHeight: 8,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(ratio, style: const TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
        ),
      ],
    );
  }
}

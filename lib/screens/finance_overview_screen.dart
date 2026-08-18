import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';
import '../widgets/custom_charts.dart';

class FinanceOverviewScreen extends StatefulWidget {
  final VoidCallback? onOpenGoalsContract;

  const FinanceOverviewScreen({super.key, this.onOpenGoalsContract});

  @override
  State<FinanceOverviewScreen> createState() => _FinanceOverviewScreenState();
}

class _FinanceOverviewScreenState extends State<FinanceOverviewScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: 'مدیریت منابع مالی',
              subtitle: 'وضوح در منابع شما.',
              onNotificationTap: () {},
            ),

            // Card 1: Radar Chart Card
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('رادار سلامت مالی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    RadarChartWidget(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Monthly Budget Card
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
                        Text('تومان باقی‌مانده ۱,۲۴۰', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.65,
                        minHeight: 12,
                        backgroundColor: Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryContainer),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('خرج شده: ۲,۳۶۰ تومان', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                        Text('هدف: ۳,۶۰۰ تومان', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Recent Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تراکنش‌های اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: widget.onOpenGoalsContract,
                          child: const Text('مشاهده همه'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTransactionItem('فروشگاه مواد غذایی', 'خواربار • امروز، ۱۰:۴۲ صبح', '-۸۴.۲۰ تومان', Icons.shopping_bag_outlined, AppColors.secondary),
                    const Divider(height: 16),
                    _buildTransactionItem('برق شهری', 'قبوض • دیروز', '-۱۲۰.۰۰ تومان', Icons.bolt, AppColors.warning),
                    const Divider(height: 16),
                    _buildTransactionItem('واریز حقوق', 'درآمد • ۲۳ مهر', '+۳,۲۰۰.۰۰ تومان', Icons.south_west, AppColors.primaryContainer),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: AI Assistant Transaction Categorization Notification Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                borderColor: AppColors.warning,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: AppColors.warning, size: 20),
                        SizedBox(width: 8),
                        Text('تراکنش جدید شناسایی شد', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'ما یک هزینه ۴۵.۰۰ تومان از "کافه ایندیگو" در پیامک‌های شما مشاهده کردیم. چگونه می‌خواهید این را دسته‌بندی کنید؟',
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _buildCategoryChip('رستوران'),
                        const SizedBox(width: 8),
                        _buildCategoryChip('شخصی'),
                        const SizedBox(width: 8),
                        _buildCategoryChip('تجاری'),
                      ],
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

  Widget _buildTransactionItem(String title, String subtitle, String amount, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: amount.startsWith('+') ? AppColors.secondary : AppColors.lightOnSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    final selected = _selectedCategory == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.lightOnSurface),
      onSelected: (val) => setState(() => _selectedCategory = val ? label : null),
    );
  }
}

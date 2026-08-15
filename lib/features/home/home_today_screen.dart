import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/progress_ring.dart';
import '../../core/localization/app_localizations.dart';

class HomeTodayScreen extends StatefulWidget {
  final VoidCallback onStartFocus;
  final Function(String screen) onNavigate;

  const HomeTodayScreen({
    super.key,
    required this.onStartFocus,
    required this.onNavigate,
  });

  @override
  State<HomeTodayScreen> createState() => _HomeTodayScreenState();
}

class _HomeTodayScreenState extends State<HomeTodayScreen> {
  final List<Map<String, dynamic>> _commitments = [
    {
      'id': '1',
      'title': 'نهایی‌سازی ارائه استراتژی سه‌ماهه سوم',
      'estimated': 90,
      'actual': 45,
      'isCompleted': false,
      'priority': 'high',
    },
    {
      'id': '2',
      'title': 'بازبینی معماری پایگاه داده ZedPlan',
      'estimated': 60,
      'actual': 60,
      'isCompleted': true,
      'priority': 'medium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.translate('goodMorning')}، جولیان',
                          style: AppTypography.headlineLgMobile(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'دوشنبه، ۱۰ مرداد',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Today's Workload Ring
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: GlassCard(
                  child: Row(
                    children: [
                      ProgressRing(
                        percentage: 78.0,
                        size: 88,
                        strokeWidth: 8,
                        primaryColor: AppColors.primary,
                        centerChild: const Text(
                          '۷۸٪',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.todayWorkload,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'برنامه شما امروز بلندپروازانه به نظر می‌رسد. مطمئن شوید که با سرعت مناسب پیش می‌روید.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Top Commitments Hero Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.topCommitments,
                          style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                        ),
                        InkWell(
                          onTap: () => widget.onNavigate('tasks'),
                          child: const Text(
                            'مشاهده همه',
                            style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._commitments.map((item) => _buildCommitmentHeroCard(item)),
                  ],
                ),
              ),
            ),

            // Today's Timeline Stream
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.timeline,
                      style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 12),
                    _buildTimelineEvent(
                      time: '۰۸:۰۰ صبح - ۰۹:۰۰ صبح',
                      title: 'بررسی صبحگاهی و ایمیل',
                      isCompleted: true,
                    ),
                    _buildActiveFocusTimelineEvent(
                      time: '۰۹:۳۰ صبح - ۱۱:۰۰ صبح',
                      title: 'کار عمیق: طراحی رابط کاربری',
                      onStartFocus: widget.onStartFocus,
                    ),
                    _buildTimelineEvent(
                      time: '۱۱:۳۰ صبح - ۱۲:۰۰ ظهر',
                      title: 'هماهنگی تیم و بررسی پیشرفت',
                      isCompleted: false,
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitmentHeroCard(Map<String, dynamic> item) {
    final isDone = item['isCompleted'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          right: BorderSide(color: AppColors.primary, width: 4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Checkbox(
            value: isDone,
            activeColor: AppColors.primary,
            onChanged: (val) {
              setState(() {
                item['isCompleted'] = val ?? false;
              });
            },
          ),
          title: Text(
            item['title'] as String,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? AppColors.onSurfaceVariant : AppColors.onSurface,
            ),
          ),
          subtitle: Text(
            'تخمین: ${item['estimated']} دقیقه',
            style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
          ),
          trailing: const Icon(Icons.star_rounded, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }

  Widget _buildTimelineEvent({required String time, required String title, required bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4, left: 12, right: 4),
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.outlineVariant : AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.outlineVariant, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                      color: isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFocusTimelineEvent({required String time, required String title, required VoidCallback onStartFocus}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 14,
            height: 14,
            margin: const EdgeInsets.only(top: 4, left: 10, right: 3),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onPrimaryFixed),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onStartFocus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('شروع تمرکز', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

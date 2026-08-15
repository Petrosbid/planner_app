import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';

class FocusAccountabilityScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const FocusAccountabilityScreen({super.key, this.onOpenFocusMode});

  @override
  State<FocusAccountabilityScreen> createState() => _FocusAccountabilityScreenState();
}

class _FocusAccountabilityScreenState extends State<FocusAccountabilityScreen> {
  double _focusDuration = 45;
  int _selectedFrequency = 1; // 0: هر ساعت, 1: هر ۳ ساعت, 2: صبح و عصر

  final TextEditingController _friendEmailController = TextEditingController();

  @override
  void dispose() {
    _friendEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: 'تعهد و نظم',
              subtitle: 'تنظیمات مربوط به تمرکز، انرژی و پاسخگویی اجتماعی خود را مدیریت کنید.',
              onFocusModeTap: widget.onOpenFocusMode,
            ),

            // Card 1: Focus Mode Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.timer_outlined, color: AppColors.primaryContainer, size: 24),
                        SizedBox(width: 8),
                        Text('تنظیمات حالت تمرکز (Focus Mode)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('مدت زمان پیش‌فرض تمرکز', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                        Text('${_focusDuration.toInt()} دقیقه', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
                      ],
                    ),
                    Slider(
                      value: _focusDuration,
                      min: 15,
                      max: 120,
                      divisions: 7,
                      activeColor: AppColors.primaryContainer,
                      onChanged: (val) => setState(() => _focusDuration = val),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('۱۵ دقیقه', style: TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
                        Text('۱۲۰ دقیقه', style: TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('استراحت کوتاه', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text('مدت زمان استراحت بین جلسات تمرکز', style: TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
                          ],
                        ),
                        Text('۱۰ دقیقه', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Energy Tracking
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bolt, color: AppColors.secondary, size: 24),
                        SizedBox(width: 8),
                        Text('ردیابی انرژی', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'یادآوری‌های دوره‌ای برای ثبت سطح انرژی شما جهت بهینه‌سازی زمان‌بندی وظایف.',
                      style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
                    ),
                    const SizedBox(height: 14),
                    const Text('فرکانس یادآوری', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildFrequencyChip('هر ساعت', 0),
                        const SizedBox(width: 8),
                        _buildFrequencyChip('هر ۳ ساعت', 1),
                        const SizedBox(width: 8),
                        _buildFrequencyChip('صبح و عصر', 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Social Accountability
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.groups_outlined, color: AppColors.tertiary, size: 24),
                        SizedBox(width: 8),
                        Text('پاسخگویی اجتماعی', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'پیشرفت خود را با یک دوست به اشتراک بگذارید تا انگیزه و نظم خود را حفظ کنید.',
                      style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _friendEmailController,
                      decoration: const InputDecoration(
                        hintText: 'ایمیل دوست خود را وارد کنید...',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('ارسال دعوت‌نامه'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Connected Partner Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user_outlined, color: AppColors.secondary, size: 22),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('متصل به علی رضایی', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                Text('علی می‌تواند گزارشات روزانه تمرکز شما را مشاهده کند.', style: TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('لغو اتصال', style: TextStyle(color: AppColors.error, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: Streak & Calendar Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_month_outlined, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('تاریخچه نظم', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('روزهایی که به اهداف تمرکز خود رسیده‌اید.', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                    const SizedBox(height: 16),

                    const Center(child: Text('مهر ۱۴۰۲', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 12),

                    // Calendar Grid Sample
                    _buildMonthGrid(),
                    const SizedBox(height: 16),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bolt, color: AppColors.warning, size: 18),
                            SizedBox(width: 4),
                            Text('زنجیره فعلی:', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                            SizedBox(width: 4),
                            Text('۴ روز', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('بهترین زنجیره:', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                            SizedBox(width: 4),
                            Text('۱۴ روز', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
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

  Widget _buildFrequencyChip(String label, int index) {
    final selected = _selectedFrequency == index;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.lightOnSurface),
      onSelected: (val) => setState(() => _selectedFrequency = index),
    );
  }

  Widget _buildMonthGrid() {
    final activeDays = [2, 3, 6, 8, 9, 12];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 14,
      itemBuilder: (context, index) {
        final dayNum = index + 1;
        final isActive = activeDays.contains(dayNum);
        return Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondary : AppColors.lightSurfaceContainerLow,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$dayNum',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : AppColors.lightOnSurfaceVariant,
              ),
            ),
          ),
        );
      },
    );
  }
}

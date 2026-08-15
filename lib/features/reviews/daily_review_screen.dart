import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';

class DailyReviewScreen extends StatefulWidget {
  const DailyReviewScreen({super.key});

  @override
  State<DailyReviewScreen> createState() => _DailyReviewScreenState();
}

class _DailyReviewScreenState extends State<DailyReviewScreen> {
  int _currentStep = 0;
  double _energyRating = 4.0;
  double _focusRating = 3.5;
  final _obstaclesController = TextEditingController();
  final _reflectionController = TextEditingController();
  final List<TextEditingController> _priorityControllers = [
    TextEditingController(text: 'نهایی‌سازی فاز ۱ نرم‌افزار'),
    TextEditingController(text: 'جلسه بازبینی کد'),
    TextEditingController(text: 'ورزش عصرگاهی ۳۰ دقیقه'),
  ];

  @override
  void dispose() {
    _obstaclesController.dispose();
    _reflectionController.dispose();
    for (var c in _priorityControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ارزیابی و انعکاس روزانه'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (_currentStep + 1) / 4,
              backgroundColor: AppColors.surfaceContainerHigh,
              color: AppColors.primary,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildStepContent(),
              ),
            ),
            // Bottom Action Bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (_currentStep > 0) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentStep--),
                        child: const Text('قبلی'),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentStep < 3) {
                          setState(() => _currentStep++);
                        } else {
                          _saveReview();
                        }
                      },
                      child: Text(_currentStep == 3 ? 'ثبت و تکمیل ارزیابی' : 'بعدی'),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'گام ۱: سنجش انرژی & تمرکز امروز',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'امروز احساس انرژی و سطح تمرکز شما چگونه بود؟',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 32),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('سطح انرژی', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${_energyRating.toStringAsFixed(1)} / ۵.۰', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  Slider(
                    value: _energyRating,
                    min: 1.0,
                    max: 5.0,
                    divisions: 8,
                    activeColor: AppColors.primary,
                    onChanged: (val) => setState(() => _energyRating = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('کیفیت تمرکز', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${_focusRating.toStringAsFixed(1)} / ۵.۰', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  Slider(
                    value: _focusRating,
                    min: 1.0,
                    max: 5.0,
                    divisions: 8,
                    activeColor: AppColors.primary,
                    onChanged: (val) => setState(() => _focusRating = val),
                  ),
                ],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'گام ۲: مرور کارکردهای امروز',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'وظایف انجام شده و به تعویق افتاده روز را بررسی کنید.',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.check_circle, color: AppColors.success),
                    title: Text('طراحی معماری فلاتر ZedPlan'),
                    subtitle: Text('تکمیل شده | ٪۱۰۰'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.history_toggle_off, color: AppColors.warning),
                    title: Text('نوشتن تست‌های واحد Drift DB'),
                    subtitle: Text('به تعویق افتاده برای فردا'),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'گام ۳: تحلیل موانع & یادگیری',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'چه مانع یا حواس‌پرتی در طول روز رخ داد و چه آموزه‌ای داشتید؟',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _obstaclesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'موانع اصلی امروز',
                hintText: 'مثال: پیام‌های غیرمنتظره و جلسه طولانی...',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reflectionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'یادداشت انعکاسی / تصمیم برای بهبود',
                hintText: 'مثال: زمان‌های کار عمیق را در تقویم مسدود خواهم کرد...',
              ),
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'گام ۴: ۳ اولویت کلیدی فردا',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'مهم‌ترین اقداماتی که فردا باید بدون فوت وقت انجام شوند را مشخص کنید.',
              style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              3,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextField(
                  controller: _priorityControllers[i],
                  decoration: InputDecoration(
                    prefixIcon: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primaryContainer,
                      child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    labelText: 'اولویت ${i + 1}',
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }

  void _saveReview() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ارزیابی با موفقیت ثبت شد! ✨'),
        content: const Text('تحلیل‌های رفتار روزانه شما به‌روزرسانی شد. فردا را با انرژی آغاز کنید.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('بازگشت به خانه'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  bool _isCommitment = true;
  bool _isCompleted = false;
  final int _estimatedMinutes = 60;
  final int _actualMinutes = 92;
  final int _postponedCount = 3;

  final List<Map<String, dynamic>> _subtasks = [
    {'title': 'طراحی وایرفریم اولیه', 'isCompleted': true},
    {'title': 'پیاده‌سازی کامپوننت‌های UI فلاتر', 'isCompleted': true},
    {'title': 'اتصال به دیتابیس Drift و تست کامل', 'isCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    final subtasksDone = _subtasks.where((s) => s['isCompleted'] as bool).length;
    final subtasksProgress = _subtasks.isNotEmpty ? subtasksDone / _subtasks.length : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات وظیفه و تعهد'),
        actions: [
          IconButton(
            icon: Icon(
              _isCommitment ? Icons.star_rounded : Icons.star_outline_rounded,
              color: _isCommitment ? AppColors.primary : AppColors.onSurfaceVariant,
            ),
            onPressed: () => setState(() => _isCommitment = !_isCommitment),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Hero Title & Status Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isCompleted,
                        activeColor: AppColors.primary,
                        onChanged: (val) => setState(() => _isCompleted = val ?? false),
                      ),
                      Expanded(
                        child: Text(
                          'طراحی و پیاده‌سازی سیستم مدیریت خود ZedPlan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: _isCompleted ? TextDecoration.lineThrough : null,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _badge('اولیت بالا', AppColors.errorContainer, AppColors.error),
                      const SizedBox(width: 8),
                      _badge('انرژی بالا (۳/۳)', AppColors.primaryFixed, AppColors.primary),
                      const SizedBox(width: 8),
                      if (_isCommitment)
                        _badge('تعهد اصلی', AppColors.surfaceContainerHigh, AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Time Tracking (Estimated vs Actual) Card
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'رهگیری زمان (تخمینی vs واقعی)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('تخمین زده شده', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Text('$_estimatedMinutes دقیقه', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                      Container(width: 1, height: 30, color: AppColors.outlineVariant),
                      Column(
                        children: [
                          const Text('زمان واقعی صرف‌شده', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Text('$_actualMinutes دقیقه', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.error)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '⚠️ این وظیفه ۳۲ دقیقه بیشتر از زمان تخمینی شما طول کشیده است.',
                    style: TextStyle(fontSize: 12, color: AppColors.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Postponement Analysis Warning Card
            if (_postponedCount > 0) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.history_rounded, color: AppColors.warning),
                        const SizedBox(width: 8),
                        Text(
                          'این وظیفه $_postponedCount بار به تعویق افتاده است!',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'پیشنهاد سیستم: آیا می‌خواهید این وظیفه را به گام‌های کوچک‌تر تقسیم کنید یا زمان آن را کاهش دهید؟',
                      style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Subtasks Section
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'زیر‌وظیفه‌ها',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      Text(
                        '$subtasksDone / ${_subtasks.length}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: subtasksProgress,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  ..._subtasks.map((st) => CheckboxListTile(
                        value: st['isCompleted'] as bool,
                        title: Text(st['title'] as String, style: const TextStyle(fontSize: 14)),
                        onChanged: (val) {
                          setState(() {
                            st['isCompleted'] = val ?? false;
                          });
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }
}

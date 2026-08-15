import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';

class TasksPlannerScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;
  final VoidCallback? onTaskDetailTap;

  const TasksPlannerScreen({
    super.key,
    this.onOpenFocusMode,
    this.onTaskDetailTap,
  });

  @override
  State<TasksPlannerScreen> createState() => _TasksPlannerScreenState();
}

class _TasksPlannerScreenState extends State<TasksPlannerScreen> {
  int _selectedDayIndex = 1; // سه 21

  final List<Map<String, dynamic>> _days = [
    {'day': 'دو', 'num': '۲۰'},
    {'day': 'سه', 'num': '۲۱'},
    {'day': 'چهار', 'num': '۲۲'},
    {'day': 'پنج', 'num': '۲۳'},
    {'day': 'جمعه', 'num': '۲۴'},
  ];

  final List<Map<String, dynamic>> _otherTasks = [
    {'title': 'بررسی طراحی‌ها', 'done': false},
    {'title': 'تماس با مشتری', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onTaskDetailTap,
        backgroundColor: AppColors.primaryContainer,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            ZenHeader(onFocusModeTap: widget.onOpenFocusMode),

            // Date Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'شهریور ۱۴۰۲',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.chevron_right, size: 20),
                            SizedBox(width: 8),
                            Icon(Icons.chevron_left, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(_days.length, (index) {
                        final isSelected = index == _selectedDayIndex;
                        return InkWell(
                          onTap: () => setState(() => _selectedDayIndex = index),
                          borderRadius: BorderRadius.circular(14),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryContainer
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _days[index]['day'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white70 : AppColors.lightOnSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _days[index]['num'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : AppColors.lightOnSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Daily Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'پیشرفت روزانه',
                          style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
                        ),
                        Text(
                          '۳/۵ وظیفه',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '۶۰٪ تکمیل شده',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.6,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Frog Task / High Priority Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.bolt, color: AppColors.warning, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'قورباغه را قورت بده',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GlassCard(
                    onTap: widget.onTaskDetailTap,
                    borderColor: AppColors.warning.withValues(alpha: 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'اولویت بالا',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.tertiary),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'نهایی کردن استراتژی سه‌ماهه سوم',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'تجمیع معیارهای بازاریابی و نهایی کردن اسلایدها برای جلسه فردا.',
                          style: TextStyle(fontSize: 14, color: AppColors.lightOnSurfaceVariant),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: widget.onOpenFocusMode,
                              child: const Text('شروع وظیفه'),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 16, color: AppColors.lightOnSurfaceVariant),
                                SizedBox(width: 4),
                                Text(
                                  '۲ ساعت',
                                  style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Secondary Tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.format_list_bulleted_rounded, size: 20),
                      SizedBox(width: 6),
                      Text('سایر وظایف', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(_otherTasks.length, (index) {
                    final item = _otherTasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Checkbox(
                              value: item['done'] as bool,
                              activeColor: AppColors.primaryContainer,
                              onChanged: (val) {
                                setState(() {
                                  item['done'] = val ?? false;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['title'] as String,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Timeline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تایم‌لاین', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton.icon(
                          onPressed: widget.onTaskDetailTap,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('افزودن زمان'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTimelineSlot('۰۹:۰۰', 'جلسه تیم', '۰۹:۰۰ - ۰۹:۳۰', Colors.indigo.shade50),
                    const SizedBox(height: 12),
                    _buildTimelineSlot('۱۰:۰۰', 'نهایی کردن استراتژی سه‌ماهه سوم (قورباغه)', '۱۰:۰۰ - ۱۲:۰۰', Colors.amber.shade50),
                    const SizedBox(height: 12),
                    _buildTimelineDropZone('۱۲:۰۰'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineSlot(String time, String title, String duration, Color bg) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            time,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.lightOnSurfaceVariant),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.lightOnSurface)),
                const SizedBox(height: 4),
                Text(duration, style: const TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineDropZone(String time) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            time,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.lightOnSurfaceVariant),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(color: AppColors.outlineVariant, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'وظیفه را اینجا رها کنید',
                style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

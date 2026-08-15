import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CalendarWeekScreen extends StatefulWidget {
  final VoidCallback? onOpenTaskDetail;

  const CalendarWeekScreen({super.key, this.onOpenTaskDetail});

  @override
  State<CalendarWeekScreen> createState() => _CalendarWeekScreenState();
}

class _CalendarWeekScreenState extends State<CalendarWeekScreen> {
  String _selectedView = '3-Day'; // Day, 3-Day, Week, Month
  int _selectedDayIndex = 2; // Wednesday

  final List<Map<String, dynamic>> _timeBlocks = [
    {
      'title': 'کار عمیق: طراحی ZedPlan',
      'time': '۰۸:۰۰ - ۱۰:۰۰',
      'startHour': 8,
      'durationHours': 2,
      'category': 'Deep Work',
      'color': AppColors.primary,
    },
    {
      'title': 'جلسه هماهنگی تیم پلتفرم',
      'time': '۱۰:۳۰ - ۱۱:۳۰',
      'startHour': 10.5,
      'durationHours': 1,
      'category': 'Meeting',
      'color': AppColors.tertiary,
    },
    {
      'title': 'بازبینی کدهای پایگاه داده',
      'time': '۱۳:۰۰ - ۱۵:۰۰',
      'startHour': 13,
      'durationHours': 2,
      'category': 'Deep Work',
      'color': AppColors.primaryContainer,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const hours = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
    const days = [
      {'day': 'ش', 'date': '۸'},
      {'day': 'ی', 'date': '۹'},
      {'day': 'د', 'date': '۱۰'},
      {'day': 'س', 'date': '۱۱'},
      {'day': 'چ', 'date': '۱۲'},
      {'day': 'پ', 'date': '۱۳'},
      {'day': 'ج', 'date': '۱۴'},
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar & View Switcher
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تقویم و زمان‌بندی',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  Row(
                    children: [
                      _viewChip('Day', 'روز'),
                      const SizedBox(width: 4),
                      _viewChip('3-Day', '۳ روز'),
                      const SizedBox(width: 4),
                      _viewChip('Week', 'هفته'),
                    ],
                  ),
                ],
              ),
            ),

            // Date Selector Strip
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: days.length,
                itemBuilder: (ctx, idx) {
                  final item = days[idx];
                  final isSelected = idx == _selectedDayIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDayIndex = idx),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 52,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['day']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Workload Capacity Overload Warning Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'هشدار ظرفیت: ۸.۳ ساعت برنامه‌ریزی شده (ظرفیت مفید: ۶.۵ ساعت)',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Hourly Time Grid
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: hours.length,
                itemBuilder: (ctx, idx) {
                  final hour = hours[idx];
                  return Container(
                    height: 64,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.outlineVariant, width: 0.5)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            '${hour.toString().padLeft(2, '۰')}:۰۰',
                            style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: _timeBlocks
                                .where((tb) => (tb['startHour'] as num).floor() == hour)
                                .map((tb) => GestureDetector(
                                      onTap: widget.onOpenTaskDetail,
                                      child: Container(
                                        width: double.infinity,
                                        height: 54,
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: (tb['color'] as Color).withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border(
                                            right: BorderSide(color: tb['color'] as Color, width: 4),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tb['title'] as String,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.onSurface,
                                              ),
                                            ),
                                            Text(
                                              tb['time'] as String,
                                              style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewChip(String type, String label) {
    final isSelected = _selectedView == type;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppColors.onSurfaceVariant)),
      selected: isSelected,
      selectedColor: AppColors.primary,
      onSelected: (val) {
        if (val) setState(() => _selectedView = type);
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> _notes = [
    {
      'id': '1',
      'title': 'ایده‌های توسعه محصول ZedPlan',
      'folder': 'ایده‌ها',
      'date': '۱۴ مرداد',
      'preview': 'پیاده‌سازی حالت آفلاین، سیستم دیسیپلین رفتاری و الگوریتم سنجش دقت تخمین زمان...',
    },
    {
      'id': '2',
      'title': 'خلاصه کتاب Atomic Habits',
      'folder': 'مطالعه',
      'date': '۱۲ مرداد',
      'preview': 'سیستم‌ها مهم‌تر از اهداف هستند. قانون ۱ درصد بهبود روزانه و طراحی محیط...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('یادداشت‌ها & بلوک‌ها'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'دفترچه یادداشت دیجیتال',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('یادداشت جدید'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ..._notes.map((note) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GlassCard(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              note['title'] as String,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                note['folder'] as String,
                                style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          note['preview'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.4),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          note['date'] as String,
                          style: const TextStyle(fontSize: 11, color: AppColors.outline),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

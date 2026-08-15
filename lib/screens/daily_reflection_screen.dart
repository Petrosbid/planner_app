import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';

class DailyReflectionScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const DailyReflectionScreen({super.key, this.onOpenFocusMode});

  @override
  State<DailyReflectionScreen> createState() => _DailyReflectionScreenState();
}

class _DailyReflectionScreenState extends State<DailyReflectionScreen> {
  final TextEditingController _reflectionController = TextEditingController();
  final TextEditingController _mindDumpController = TextEditingController();

  bool _isMorningRituals = true;

  final List<Map<String, dynamic>> _morningRituals = [
    {'title': 'نوشیدن آب گرم با لیمو', 'done': true},
    {'title': '۱۵ دقیقه مدیتیشن', 'done': true},
    {'title': 'مرور اهداف روزانه', 'done': false},
  ];

  final List<String> _mindDumpItems = [
    'ایمیل به تیم طراحی برای بررسی فایل‌ها',
    'خرید قهوه در مسیر برگشت',
  ];

  @override
  void dispose() {
    _reflectionController.dispose();
    _mindDumpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(onFocusModeTap: widget.onOpenFocusMode),

            // Card 1: Daily Reflections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.edit_note_rounded, color: AppColors.primaryContainer, size: 24),
                            SizedBox(width: 8),
                            Text('تأملات روزانه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('۲۴ مهر ۱۴۰۲', style: TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Formatting Toolbar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightSurfaceContainerLow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.format_bold, size: 20), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.format_italic, size: 20), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.format_list_bulleted, size: 20), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.format_list_numbered, size: 20), onPressed: () {}),
                          const Spacer(),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.mic, size: 16),
                            label: const Text('صدا', style: TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(width: 6),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.image_outlined, size: 16),
                            label: const Text('تصویر', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Text Editor Field
                    TextField(
                      controller: _reflectionController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'امروز چه احساسی دارید؟ افکار خود را اینجا بنویسید...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: const Text('ذخیره'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: Rituals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.wb_sunny_outlined, color: AppColors.secondary, size: 22),
                        SizedBox(width: 8),
                        Text('آیین‌ها', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Morning / Night Selector Toggle
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightSurfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isMorningRituals = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _isMorningRituals ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: _isMorningRituals
                                      ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                      : [],
                                ),
                                child: const Center(
                                  child: Text('صبح', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isMorningRituals = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: !_isMorningRituals ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: !_isMorningRituals
                                      ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                                      : [],
                                ),
                                child: const Center(
                                  child: Text('شب', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    ...List.generate(_morningRituals.length, (idx) {
                      final item = _morningRituals[idx];
                      return CheckboxListTile(
                        value: item['done'] as bool,
                        title: Text(
                          item['title'] as String,
                          style: TextStyle(
                            decoration: (item['done'] as bool) ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        activeColor: AppColors.primaryContainer,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (val) => setState(() => item['done'] = val ?? false),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Mind Dump
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bolt, color: AppColors.warning, size: 22),
                        SizedBox(width: 8),
                        Text('تخليه ذهن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              if (_mindDumpController.text.isNotEmpty) {
                                setState(() {
                                  _mindDumpItems.add(_mindDumpController.text);
                                  _mindDumpController.clear();
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _mindDumpController,
                            decoration: const InputDecoration(
                              hintText: 'یک فکر سریع ثبت کنید...',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ...List.generate(_mindDumpItems.length, (idx) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.lightSurfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_mindDumpItems[idx], style: const TextStyle(fontSize: 14)),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () {
                                  setState(() => _mindDumpItems.removeAt(idx));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

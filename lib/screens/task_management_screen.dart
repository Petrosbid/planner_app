import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/zen_header.dart';

class TaskManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const TaskManagementScreen({super.key, this.onBack});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  int _selectedCategory = 0; // 0: کار, 1: شخصی, 2: سلامتی
  int _selectedPriority = 1; // 0: پایین, 1: متوسط, 2: بالا

  final TextEditingController _titleController =
      TextEditingController(text: 'جلسه بررسی طراحی محصول');

  final List<Map<String, dynamic>> _subtasks = [
    {'title': 'آماده‌سازی فایل‌های فیگما', 'done': true},
    {'title': 'دعوت از تیم فنی', 'done': false},
    {'title': 'تنظیم دستور جلسه', 'done': false},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            const ZenHeader(
              title: 'مدیریت وظایف',
              subtitle: 'روز خود را با تمرکز و وضوح برنامه‌ریزی کنید.',
            ),

            // Quick Add Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'افزودن سریع وظیفه...',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: _buildCategoryCard('کار', '۱۲ وظیفه', Icons.work_outline, AppColors.primaryContainer)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildCategoryCard('شخصی', '۵ وظیفه', Icons.person_outline, AppColors.secondary)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildCategoryCard('سلامتی', '۲ وظیفه', Icons.favorite_outline, AppColors.warning)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Today's Tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('وظایف امروز', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildTaskRow('تکمیل گزارش مالی سه‌ماهه', '۱۰:۰۰ صبح', 'بالا', AppColors.warning, false),
                    const Divider(height: 20),
                    _buildTaskRow('جلسه بررسی طراحی محصول', '۲:۳۰ عصر', 'متوسط', AppColors.primaryContainer, true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Task Details Form Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                borderColor: AppColors.primaryContainer.withValues(alpha: 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('جزئیات وظیفه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Title Edit
                    const Text('عنوان وظیفه', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'عنوان وظیفه را وارد کنید',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category Chips
                    const Text('دسته‌بندی', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildChoiceChip('کار', Icons.work_outline, 0, _selectedCategory, (v) => setState(() => _selectedCategory = 0)),
                        const SizedBox(width: 8),
                        _buildChoiceChip('شخصی', Icons.person_outline, 1, _selectedCategory, (v) => setState(() => _selectedCategory = 1)),
                        const SizedBox(width: 8),
                        _buildChoiceChip('سلامتی', Icons.favorite_outline, 2, _selectedCategory, (v) => setState(() => _selectedCategory = 2)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Priority Chips
                    const Text('اولویت', style: TextStyle(fontSize: 13, color: AppColors.lightOnSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildPriorityChip('پایین', 0, _selectedPriority, (v) => setState(() => _selectedPriority = 0)),
                        const SizedBox(width: 8),
                        _buildPriorityChip('متوسط', 1, _selectedPriority, (v) => setState(() => _selectedPriority = 1)),
                        const SizedBox(width: 8),
                        _buildPriorityChip('بالا', 2, _selectedPriority, (v) => setState(() => _selectedPriority = 2)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Implementation Intention Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.spa_rounded, color: AppColors.primaryContainer, size: 18),
                              SizedBox(width: 6),
                              Text(
                                'قصد اجرا (Implementation Intention)',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryContainer),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              const Text('من'),
                              _buildIntentionBadge('بررسی طرح‌ها'),
                              const Text('را در'),
                              _buildIntentionBadge('ساعت ۱۴:۳۰'),
                              const Text('در'),
                              _buildIntentionBadge('اتاق کنفرانس'),
                              const Text('انجام خواهم داد.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Subtasks Checklist
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.account_tree_outlined, size: 18),
                            SizedBox(width: 6),
                            Text('زیر وظایف', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          '${_subtasks.where((s) => s['done'] as bool).length}/${_subtasks.length} انجام شده',
                          style: const TextStyle(fontSize: 12, color: AppColors.lightOnSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(_subtasks.length, (idx) {
                      final item = _subtasks[idx];
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
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('افزودن زیر وظیفه'),
                    ),
                    const SizedBox(height: 16),

                    // Reminders Section
                    const Row(
                      children: [
                        Icon(Icons.notifications_active_outlined, size: 18),
                        SizedBox(width: 6),
                        Text('یادآوری‌ها', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildReminderChip('۱۵ دقیقه قبل', Icons.access_time),
                    const SizedBox(height: 6),
                    _buildReminderChip('ارسال ایمیل', Icons.mail_outline),
                    const SizedBox(height: 6),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('افزودن یادآوری'),
                    ),
                    const SizedBox(height: 24),

                    // Actions Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: widget.onBack,
                          icon: const Icon(Icons.save, size: 18),
                          label: const Text('ذخیره تغییرات'),
                        ),
                        TextButton(
                          onPressed: widget.onBack,
                          child: const Text('لغو', style: TextStyle(color: AppColors.lightOnSurfaceVariant)),
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

  Widget _buildCategoryCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(count, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }

  Widget _buildTaskRow(String title, String time, String priority, Color color, bool selected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryContainer.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: selected,
            activeColor: AppColors.primaryContainer,
            onChanged: (v) {},
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              priority,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label, IconData icon, int index, int current, ValueChanged<bool> onSelect) {
    final selected = index == current;
    return ChoiceChip(
      avatar: Icon(icon, size: 16, color: selected ? Colors.white : AppColors.primaryContainer),
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.lightOnSurface),
      onSelected: onSelect,
    );
  }

  Widget _buildPriorityChip(String label, int index, int current, ValueChanged<bool> onSelect) {
    final selected = index == current;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.lightOnSurface),
      onSelected: onSelect,
    );
  }

  Widget _buildIntentionBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryContainer),
      ),
    );
  }

  Widget _buildReminderChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.lightOnSurfaceVariant),
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(fontSize: 13)),
            ],
          ),
          const Icon(Icons.close, size: 16, color: AppColors.lightOnSurfaceVariant),
        ],
      ),
    );
  }
}

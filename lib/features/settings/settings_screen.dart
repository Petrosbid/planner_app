import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const SettingsScreen({super.key, this.onLogout});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _isRtl = true;
  bool _notificationsEnabled = true;
  bool _biometricsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تنظیمات & پشتیبان‌گیری'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // User Profile Summary Card
            GlassCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryContainer,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('جولیان (Julian)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        SizedBox(height: 2),
                        Text('کاربر آفلاین ZedPlan', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Group 1: Appearance & Locale
            const Text('ظاهر & زبان', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('حالت تاریک (Dark Mode)'),
                    value: _darkMode,
                    activeTrackColor: AppColors.primary,
                    onChanged: (val) => setState(() => _darkMode = val),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('زبان فارسی & راست‌چین (RTL)'),
                    value: _isRtl,
                    activeTrackColor: AppColors.primary,
                    onChanged: (val) => setState(() => _isRtl = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Group 2: Data Backup & Restore
            const Text('مدیریت داده‌ها & پشتیبان‌گیری (آفلاین)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.upload_file_rounded, color: AppColors.primary),
                    title: const Text('خروجی پشتیبان (JSON Export)'),
                    subtitle: const Text('ذخیره تمام وظایف، اهداف و یادداشت‌ها در فایل مقادیر'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('فایل zedplan_backup.json آماده خروجی‌گرفتن است.')),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.download_rounded, color: AppColors.primary),
                    title: const Text('بازیابی داده‌ها (JSON Import)'),
                    subtitle: const Text('بارگذاری فایل پشتیبان قبلی'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Group 3: Security & Notifications
            const Text('امنیتی & اعلان‌ها', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('اعلان‌ها و یادآوری‌های محلی'),
                    value: _notificationsEnabled,
                    activeTrackColor: AppColors.primary,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('قفل اثرانگشت / بیومتریک'),
                    value: _biometricsEnabled,
                    activeTrackColor: AppColors.primary,
                    onChanged: (val) => setState(() => _biometricsEnabled = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Version Info
            const Center(
              child: Text(
                'ZedPlan v1.0.0 — Offline-First Productivity Engine',
                style: TextStyle(fontSize: 11, color: AppColors.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

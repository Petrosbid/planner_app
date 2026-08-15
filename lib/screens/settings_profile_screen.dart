import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class SettingsProfileScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const SettingsProfileScreen({super.key, this.onLogout});

  @override
  State<SettingsProfileScreen> createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  bool _isDarkMode = true;
  double _fontSize = 1.0; // 0: کوچک, 1: متوسط, 2: بزرگ
  bool _notifyNewTasks = true;
  bool _notifyWeeklyReport = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemeDarkOverride.theme,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'تنظیمات',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            children: [
              // Profile Header Card
              GlassCard(
                backgroundColor: AppColors.darkSurface.withValues(alpha: 0.8),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 46,
                          backgroundColor: AppColors.primaryContainer,
                          child: CircleAvatar(
                            radius: 44,
                            child: Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'امیرحسین رضایی',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'amir.rezaei@example.com',
                      style: TextStyle(fontSize: 13, color: AppColors.darkOnSurfaceVariant),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        'حساب ویژه',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onPrimaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Appearance Settings
              GlassCard(
                backgroundColor: AppColors.darkSurface.withValues(alpha: 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.palette_outlined, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('تنظیمات ظاهری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _isDarkMode,
                      title: const Text('تم تاریک', style: TextStyle(color: Colors.white)),
                      activeTrackColor: AppColors.primaryContainer,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) => setState(() => _isDarkMode = val),
                    ),
                    const SizedBox(height: 8),
                    const Text('اندازه فونت', style: TextStyle(fontSize: 13, color: AppColors.darkOnSurfaceVariant)),
                    Slider(
                      value: _fontSize,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      activeColor: AppColors.primaryContainer,
                      onChanged: (val) => setState(() => _fontSize = val),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('کوچک', style: TextStyle(fontSize: 11, color: AppColors.darkOnSurfaceVariant)),
                        Text('متوسط', style: TextStyle(fontSize: 11, color: AppColors.darkOnSurfaceVariant)),
                        Text('بزرگ', style: TextStyle(fontSize: 11, color: AppColors.darkOnSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notifications
              GlassCard(
                backgroundColor: AppColors.darkSurface.withValues(alpha: 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.notifications_none_rounded, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('اعلان‌ها', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _notifyNewTasks,
                      title: const Text('وظایف جدید', style: TextStyle(color: Colors.white)),
                      subtitle: const Text('اطلاع‌رسانی هنگام دریافت وظیفه جدید', style: TextStyle(fontSize: 11, color: AppColors.darkOnSurfaceVariant)),
                      activeTrackColor: AppColors.primaryContainer,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) => setState(() => _notifyNewTasks = val),
                    ),
                    SwitchListTile(
                      value: _notifyWeeklyReport,
                      title: const Text('گزارش هفتگی', style: TextStyle(color: Colors.white)),
                      subtitle: const Text('ارسال خلاصه عملکرد به ایمیل', style: TextStyle(fontSize: 11, color: AppColors.darkOnSurfaceVariant)),
                      activeTrackColor: AppColors.primaryContainer,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) => setState(() => _notifyWeeklyReport = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Privacy & Security
              GlassCard(
                backgroundColor: AppColors.darkSurface.withValues(alpha: 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.shield_outlined, color: AppColors.primaryContainer, size: 22),
                        SizedBox(width: 8),
                        Text('حریم خصوصی و امنیت', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.password, color: AppColors.darkOnSurfaceVariant),
                      title: const Text('تغییر رمز عبور', style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.chevron_left, color: AppColors.darkOnSurfaceVariant),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.devices, color: AppColors.darkOnSurfaceVariant),
                      title: const Text('دستگاه‌های متصل', style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.chevron_left, color: AppColors.darkOnSurfaceVariant),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout Button
              OutlinedButton.icon(
                onPressed: widget.onLogout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: const Text('خروج از حساب کاربری', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppThemeDarkOverride {
  static ThemeData get theme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryContainer,
          surface: AppColors.darkSurface,
        ),
      );
}

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum AmbientSoundType {
  rain(title: 'باران ملایم', subtitle: 'صدای بارش قطرات آرام‌بخش', icon: Icons.water_drop_rounded, color: Color(0xFF0284C7)),
  forest(title: 'طبیعت و جنگل', subtitle: 'آواز پرندگان و نسیم درختان', icon: Icons.forest_rounded, color: Color(0xFF16A34A)),
  cafe(title: 'کافه شلوغ', subtitle: 'همهمه ملایم و انرژی محیطی', icon: Icons.coffee_rounded, color: Color(0xFFD97706)),
  waves(title: 'امواج دریا', subtitle: 'ریتم آرامش‌بخش ساحل', icon: Icons.waves_rounded, color: Color(0xFF0D9488)),
  whiteNoise(title: 'نویز سفید', subtitle: 'حذف کامل صداهای مزاحم', icon: Icons.graphic_eq_rounded, color: Color(0xFF6366F1)),
  zenChimes(title: 'کاسه تبتی و ذن', subtitle: 'طنین مدیتیشن و تمرکز عمیق', icon: Icons.self_improvement_rounded, color: Color(0xFF8B5CF6));

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const AmbientSoundType({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class AmbientSoundSheet extends StatefulWidget {
  final bool isEnabled;
  final AmbientSoundType selectedSound;
  final double volume;
  final ValueChanged<bool> onToggle;
  final ValueChanged<AmbientSoundType> onSoundSelected;
  final ValueChanged<double> onVolumeChanged;

  const AmbientSoundSheet({
    super.key,
    required this.isEnabled,
    required this.selectedSound,
    required this.volume,
    required this.onToggle,
    required this.onSoundSelected,
    required this.onVolumeChanged,
  });

  static void show(
    BuildContext context, {
    required bool isEnabled,
    required AmbientSoundType selectedSound,
    required double volume,
    required ValueChanged<bool> onToggle,
    required ValueChanged<AmbientSoundType> onSoundSelected,
    required ValueChanged<double> onVolumeChanged,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AmbientSoundSheet(
        isEnabled: isEnabled,
        selectedSound: selectedSound,
        volume: volume,
        onToggle: onToggle,
        onSoundSelected: onSoundSelected,
        onVolumeChanged: onVolumeChanged,
      ),
    );
  }

  @override
  State<AmbientSoundSheet> createState() => _AmbientSoundSheetState();
}

class _AmbientSoundSheetState extends State<AmbientSoundSheet>
    with SingleTickerProviderStateMixin {
  bool _enabled = false;
  AmbientSoundType _sound = AmbientSoundType.rain;
  double _volume = 70.0;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _enabled = widget.isEnabled;
    _sound = widget.selectedSound;
    _volume = widget.volume;

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  String _formatPersianDigits(String input) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsiDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(englishDigits[i], farsiDigits[i]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header with Master Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _sound.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_sound.icon, color: _sound.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'صداهای محیطی تمرکز (Zen Audio)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _enabled ? 'در حال پخش: ${_sound.title}' : 'غیرفعال',
                        style: TextStyle(
                          fontSize: 12,
                          color: _enabled ? _sound.color : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Switch(
                value: _enabled,
                activeThumbColor: _sound.color,
                onChanged: (val) {
                  setState(() => _enabled = val);
                  widget.onToggle(val);
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Equalizer Visualizer & Volume Bar
          if (_enabled) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceContainerLow
                    : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _sound.color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Animated Equalizer Wave
                  AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(24, (index) {
                          final phase = (index / 24.0) * 2 * pi;
                          final heightFactor = (sin(_waveController.value * 2 * pi + phase) + 1) / 2;
                          final barHeight = 6.0 + (heightFactor * 18.0 * (_volume / 100.0));

                          return Container(
                            width: 3.5,
                            height: barHeight,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: _sound.color.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Volume Slider
                  Row(
                    children: [
                      Icon(
                        Icons.volume_down_rounded,
                        size: 20,
                        color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                      ),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          min: 0,
                          max: 100,
                          activeColor: _sound.color,
                          inactiveColor: _sound.color.withValues(alpha: 0.2),
                          onChanged: (val) {
                            setState(() => _volume = val);
                            widget.onVolumeChanged(val);
                          },
                        ),
                      ),
                      Text(
                        '${_formatPersianDigits(_volume.toInt().toString())}٪',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _sound.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Soundscapes Grid / List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: AmbientSoundType.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final sound = AmbientSoundType.values[index];
                final isSelected = _sound == sound;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _sound = sound;
                      _enabled = true;
                    });
                    widget.onSoundSelected(sound);
                    widget.onToggle(true);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? sound.color.withValues(alpha: isDark ? 0.2 : 0.1)
                          : (isDark
                              ? AppColors.darkSurfaceContainerLow
                              : AppColors.surfaceContainerLowest),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? sound.color
                            : (isDark
                                ? AppColors.darkOutlineVariant.withValues(alpha: 0.3)
                                : AppColors.outlineVariant.withValues(alpha: 0.3)),
                        width: isSelected ? 1.5 : 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: sound.color.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(sound.icon, color: sound.color, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sound.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? sound.color
                                      : (isDark ? AppColors.darkOnSurface : AppColors.onSurface),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                sound.subtitle,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.darkOnSurfaceVariant
                                      : AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected && _enabled)
                          Icon(Icons.check_circle_rounded, color: sound.color, size: 22),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

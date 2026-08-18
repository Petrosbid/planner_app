import 'package:flutter/material.dart';

enum AmbientSoundType {
  rain(
    title: 'باران ملایم',
    subtitle: 'صدای بارش قطرات آرام‌بخش',
    icon: Icons.water_drop_rounded,
    color: Color(0xFF0284C7),
  ),
  forest(
    title: 'طبیعت و جنگل',
    subtitle: 'آواز پرندگان و نسیم درختان',
    icon: Icons.forest_rounded,
    color: Color(0xFF16A34A),
  ),
  cafe(
    title: 'کافه شلوغ',
    subtitle: 'همهمه ملایم و انرژی محیطی',
    icon: Icons.coffee_rounded,
    color: Color(0xFFD97706),
  ),
  waves(
    title: 'امواج دریا',
    subtitle: 'ریتم آرامش‌بخش ساحل',
    icon: Icons.waves_rounded,
    color: Color(0xFF0D9488),
  ),
  whiteNoise(
    title: 'نویز سفید',
    subtitle: 'حذف کامل صداهای مزاحم',
    icon: Icons.graphic_eq_rounded,
    color: Color(0xFF6366F1),
  ),
  zenChimes(
    title: 'کاسه تبتی و ذن',
    subtitle: 'طنین مدیتیشن و تمرکز عمیق',
    icon: Icons.self_improvement_rounded,
    color: Color(0xFF8B5CF6),
  );

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

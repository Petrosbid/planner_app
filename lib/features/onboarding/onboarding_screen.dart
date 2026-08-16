import 'package:flutter/material.dart';

import '../../core/controllers/app_settings.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/progress_ring.dart';

/// First-launch welcome slider: intro pages → name → theme choice.
class OnboardingScreen extends StatefulWidget {
  final AppSettings settings;
  final VoidCallback onFinished;

  const OnboardingScreen({super.key, required this.settings, required this.onFinished});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  int _page = 0;
  ThemeMode _pickedTheme = ThemeMode.system;

  static const _pageCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pageCount - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 450), curve: Curves.easeOutCubic);
    }
  }

  Future<void> _finish() async {
    await widget.settings.completeOnboarding(
      name: _nameController.text.trim(),
      theme: _pickedTheme,
    );
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _introPage(
                    l10n.translate('onboardTitle1'),
                    l10n.translate('onboardBody1'),
                    Icons.event_note_rounded,
                    AppColors.primary,
                  ),
                  _introPage(
                    l10n.translate('onboardTitle2'),
                    l10n.translate('onboardBody2'),
                    Icons.timer_outlined,
                    AppColors.success,
                  ),
                  _introPage(
                    l10n.translate('onboardTitle3'),
                    l10n.translate('onboardBody3'),
                    Icons.insights_outlined,
                    AppColors.warning,
                  ),
                  _namePage(l10n),
                  _themePage(l10n),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page dots
                  Row(
                    children: List.generate(_pageCount, (i) {
                      final active = i == _page;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      if (_page > 0)
                        TextButton(
                          onPressed: () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 450),
                            curve: Curves.easeOutCubic,
                          ),
                          child: Text(l10n.translate('back')),
                        ),
                      const SizedBox(width: 8),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: _page == _pageCount - 1
                            ? FilledButton(
                                onPressed: _finish,
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                ),
                                child: Text(l10n.translate('getStarted')),
                              )
                            : FilledButton(
                                onPressed: _next,
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                ),
                                child: Text(l10n.translate('next')),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _introPage(String title, String body, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 700),
            curve: Curves.elasticOut,
            builder: (context, v, child) => Transform.scale(scale: 0.6 + 0.4 * v, child: child),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ProgressRing(
                  percentage: 76,
                  size: 130,
                  strokeWidth: 10,
                  primaryColor: color,
                  centerChild: Icon(icon, size: 48, color: color),
                ),
              ),
            ),
          ),
          const Spacer(),
          FadeSlideIn(
            delay: const Duration(milliseconds: 150),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.headlineLgMobile(color: AppColors.onSurface),
                ),
                const SizedBox(height: 16),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLg(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _namePage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Icon(Icons.waving_hand_rounded, size: 56, color: AppColors.primary),
          const SizedBox(height: 24),
          Text(
            l10n.translate('onboardNameTitle'),
            textAlign: TextAlign.center,
            style: AppTypography.headlineLgMobile(color: AppColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.translate('onboardNameSubtitle'),
            textAlign: TextAlign.center,
            style: AppTypography.bodySm(),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _next(),
            decoration: InputDecoration(
              hintText: l10n.translate('onboardNameHint'),
              prefixIcon: const Icon(Icons.person_outline_rounded),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget _themePage(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Text(
            l10n.translate('onboardThemeTitle'),
            textAlign: TextAlign.center,
            style: AppTypography.headlineLgMobile(color: AppColors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.translate('onboardThemeSubtitle'),
            textAlign: TextAlign.center,
            style: AppTypography.bodySm(),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _themeOption(
                  l10n.translate('lightLabel'),
                  Icons.light_mode_outlined,
                  ThemeMode.light,
                  const Color(0xFFF7F9FF),
                  AppColors.onSurface,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _themeOption(
                  l10n.translate('darkLabel'),
                  Icons.dark_mode_outlined,
                  ThemeMode.dark,
                  const Color(0xFF16171B),
                  Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _themeOption(
                  l10n.translate('systemLabel'),
                  Icons.settings_suggest_outlined,
                  ThemeMode.system,
                  AppColors.surfaceContainerLow,
                  AppColors.onSurface,
                ),
              ),
            ],
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget _themeOption(String label, IconData icon, ThemeMode mode, Color preview, Color previewIcon) {
    final selected = _pickedTheme == mode;
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: selected ? 1.05 : 1.0,
      child: GestureDetector(
        onTap: () => setState(() => _pickedTheme = mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: preview, shape: BoxShape.circle),
                child: Icon(icon, color: previewIcon, size: 24),
              ),
              const SizedBox(height: 10),
              Text(label, style: AppTypography.labelCaps()),
            ],
          ),
        ),
      ),
    );
  }
}

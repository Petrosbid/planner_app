import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../data/models/planner_models.dart';

/// 4-step daily reflection wizard. Saves a real [DailyReviewRecord];
/// reopening the same day edits it.
class DailyReviewScreen extends StatefulWidget {
  const DailyReviewScreen({super.key});

  @override
  State<DailyReviewScreen> createState() => _DailyReviewScreenState();
}

class _DailyReviewScreenState extends State<DailyReviewScreen> {
  final PageController _pageController = PageController();
  int _step = 0;

  int _energy = 3;
  int _focus = 3;
  final _obstacleController = TextEditingController();
  final _reflectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final existing = AppScope.of(context).store.todayReview;
    if (existing != null) {
      _energy = existing.energyRating;
      _focus = existing.focusRating;
      _obstacleController.text = existing.obstacles;
      _reflectionController.text = existing.reflection;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _obstacleController.dispose();
    _reflectionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await AppScope.of(context).store.saveDailyReview(DailyReviewRecord(
          date: DateTime.now(),
          energyRating: _energy,
          focusRating: _focus,
          obstacles: _obstacleController.text.trim(),
          reflection: _reflectionController.text.trim(),
        ));
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).translate('reviewSavedOk'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;
    final todayTasks = store.todayTasks;
    final done = todayTasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.dailyReviewTitle)),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_step + 1) / 4,
              backgroundColor: AppColors.surfaceContainerHigh,
              color: AppColors.primary,
              minHeight: 4,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  // 1. Accomplishments (real data)
                  ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Text(l10n.translate('accomplishments'), style: AppTypography.headlineMd()),
                      const SizedBox(height: 8),
                      Text(
                        '${ZedDateUtils.toFaDigits(done.length, fa: isFa)}/${ZedDateUtils.toFaDigits(todayTasks.length, fa: isFa)} ${l10n.translate('workloadProgress')}',
                        style: AppTypography.bodySm(),
                      ),
                      const SizedBox(height: 16),
                      if (done.isEmpty)
                        EmptyStateView(
                          icon: Icons.task_alt_rounded,
                          title: l10n.translate('emptyTasksTitle'),
                          message: l10n.translate('emptyTasksMessage'),
                        )
                      else
                        for (final t in done)
                          ListTile(
                            leading: const Icon(Icons.check_circle_rounded, color: AppColors.success),
                            title: Text(t.title),
                            contentPadding: EdgeInsets.zero,
                          ),
                    ],
                  ),
                  // 2. Energy & focus ratings
                  _ratingStep(l10n),
                  // 3. Obstacles
                  _textStep(
                    l10n.translate('mainObstacles'),
                    Icons.block_outlined,
                    _obstacleController,
                  ),
                  // 4. Reflection
                  _textStep(
                    l10n.translate('accomplishments'),
                    Icons.self_improvement_rounded,
                    _reflectionController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                        ),
                        child: Text(l10n.translate('back')),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: () {
                        if (_step < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                          );
                        } else {
                          _save();
                        }
                      },
                      child: Text(_step < 3 ? l10n.translate('next') : l10n.saveReview),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingStep(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeSlideIn(
            child: Column(
              children: [
                Text(l10n.energyLevel, style: AppTypography.headlineMd()),
                const SizedBox(height: 20),
                _ratingSelector(_energy, (v) => setState(() => _energy = v)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          FadeSlideIn(
            delay: const Duration(milliseconds: 100),
            child: Column(
              children: [
                Text(l10n.focusScore, style: AppTypography.headlineMd()),
                const SizedBox(height: 20),
                _ratingSelector(_focus, (v) => setState(() => _focus = v)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingSelector(int value, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final v = i + 1;
        final active = v <= value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () => onChanged(v),
            child: AnimatedScale(
              scale: active ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                active ? Icons.circle : Icons.circle_outlined,
                size: 28,
                color: active ? AppColors.primary : AppColors.outlineVariant,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _textStep(String title, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(title, textAlign: TextAlign.center, style: AppTypography.headlineMd()),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}

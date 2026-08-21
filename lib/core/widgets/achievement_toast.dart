import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/models/achievement_models.dart';
import '../localization/app_localizations.dart';
import '../theme/app_colors.dart';

class AchievementToastOverlay extends StatefulWidget {
  final Widget child;
  final VoidCallback? onOpenAchievements;

  const AchievementToastOverlay({
    super.key,
    required this.child,
    this.onOpenAchievements,
  });

  static AchievementToastOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<AchievementToastOverlayState>();
  }

  @override
  State<AchievementToastOverlay> createState() =>
      AchievementToastOverlayState();
}

class AchievementToastOverlayState extends State<AchievementToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  AchievementProgress? _currentToast;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    ));
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void showUnlockToast(AchievementProgress achievement) {
    _dismissTimer?.cancel();
    setState(() {
      _currentToast = achievement;
    });
    _animController.forward(from: 0.0);
    _dismissTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        _animController.reverse().then((_) {
          if (mounted) setState(() => _currentToast = null);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Stack(
      children: [
        widget.child,
        if (_currentToast != null)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: SlideTransition(
              position: _slideAnim,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: _buildToastCard(context, l10n, _currentToast!),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildToastCard(
    BuildContext context,
    AppLocalizations l10n,
    AchievementProgress item,
  ) {
    final tier = item.unlockedTier ?? AchievementTier.bronze;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _dismissTimer?.cancel();
        _animController.reverse().then((_) {
          if (mounted) setState(() => _currentToast = null);
        });
        widget.onOpenAchievements?.call();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurface.withValues(alpha: 0.9)
                  : Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: tier.color.withValues(alpha: 0.6),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: tier.glowColor,
                  blurRadius: 18,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Glowing Tier Badge Icon
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: tier.color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: tier.color, width: 2),
                  ),
                  child: Icon(
                    item.definition.iconData,
                    color: tier.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Text Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            size: 14,
                            color: tier.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.translate('unlockedBadge'),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: tier.color,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: tier.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tier.label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: tier.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        l10n.translate(item.definition.titleKey),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.translate(item.definition.descKey),
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

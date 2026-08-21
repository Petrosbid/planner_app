import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/achievement_models.dart';
import 'planner_store.dart';

class AchievementStore extends ChangeNotifier {
  static const _kUnlockedAchievements = 'store.unlocked_achievements';

  final SharedPreferences _prefs;

  // Map of achievementId -> Map containing 'tier' (index) and 'unlockedAt' (ISO String)
  final Map<String, Map<String, dynamic>> _unlockedData = {};

  // Queue of newly unlocked achievements for displaying in-app celebration toasts
  final List<AchievementProgress> _recentUnlocks = [];

  AchievementStore(this._prefs) {
    _loadUnlocked();
  }

  void _loadUnlocked() {
    final raw = _prefs.getString(_kUnlockedAchievements);
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        for (final entry in decoded.entries) {
          if (entry.value is Map) {
            _unlockedData[entry.key] = Map<String, dynamic>.from(entry.value as Map);
          }
        }
      } catch (_) {}
    }
  }

  Future<void> _persist() async {
    await _prefs.setString(_kUnlockedAchievements, jsonEncode(_unlockedData));
  }

  /// Check all achievements against current store state and trigger unlocks
  Future<List<AchievementProgress>> checkAndUnlock(PlannerStore store) async {
    final newlyUnlocked = <AchievementProgress>[];

    for (final def in AchievementCatalog.allAchievements) {
      final currentProgress = def.progressCalculator(store);
      final eligibleTier = def.getUnlockedTier(currentProgress);

      final prevData = _unlockedData[def.id];
      final prevTierIndex = prevData != null ? (prevData['tier'] as int?) : null;
      final prevTier = prevTierIndex != null ? AchievementTier.values[prevTierIndex] : null;

      if (eligibleTier != null) {
        final isNewUnlock = prevTier == null || eligibleTier.index > prevTier.index;

        if (isNewUnlock) {
          final now = DateTime.now();
          _unlockedData[def.id] = {
            'tier': eligibleTier.index,
            'unlockedAt': now.toIso8601String(),
          };

          final item = AchievementProgress(
            definition: def,
            currentProgress: currentProgress,
            unlockedTier: eligibleTier,
            nextThreshold: def.getNextThreshold(currentProgress),
            unlockedAt: now,
          );

          newlyUnlocked.add(item);
          _recentUnlocks.add(item);
        }
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      await _persist();
      notifyListeners();
    }

    return newlyUnlocked;
  }

  /// Get full computed progress objects for all achievements
  List<AchievementProgress> getAllProgress(PlannerStore store) {
    return AchievementCatalog.allAchievements.map((def) {
      final progress = def.progressCalculator(store);
      final prevData = _unlockedData[def.id];
      final unlockedTier = prevData != null && prevData['tier'] != null
          ? AchievementTier.values[prevData['tier'] as int]
          : def.getUnlockedTier(progress);

      final unlockedAt = prevData != null && prevData['unlockedAt'] != null
          ? DateTime.tryParse(prevData['unlockedAt'] as String)
          : null;

      return AchievementProgress(
        definition: def,
        currentProgress: progress,
        unlockedTier: unlockedTier,
        nextThreshold: def.getNextThreshold(progress),
        unlockedAt: unlockedAt,
      );
    }).toList();
  }

  /// Get achievements filtered by category
  List<AchievementProgress> getByCategory(
      PlannerStore store, AchievementCategory category) {
    return getAllProgress(store)
        .where((a) => a.definition.category == category)
        .toList();
  }

  /// Total count of unlocked achievements (at least Bronze)
  int get unlockedCount => _unlockedData.length;

  /// Overall completion percentage (0.0 to 1.0)
  double get overallProgressPercentage {
    if (AchievementCatalog.allAchievements.isEmpty) return 0.0;
    return (_unlockedData.length / AchievementCatalog.allAchievements.length)
        .clamp(0.0, 1.0);
  }

  /// Total score/points earned from achievements
  int get totalAchievementPoints {
    var points = 0;
    for (final data in _unlockedData.values) {
      final tierIndex = data['tier'] as int? ?? 0;
      // Bronze: 10, Silver: 25, Gold: 50, Diamond: 100
      switch (tierIndex) {
        case 0:
          points += 10;
          break;
        case 1:
          points += 25;
          break;
        case 2:
          points += 50;
          break;
        case 3:
          points += 100;
          break;
      }
    }
    return points;
  }

  /// Pop the next pending toast unlock item, if any
  AchievementProgress? consumeRecentUnlock() {
    if (_recentUnlocks.isEmpty) return null;
    return _recentUnlocks.removeAt(0);
  }

  /// Clear achievement history if reset requested
  Future<void> clearAll() async {
    _unlockedData.clear();
    _recentUnlocks.clear();
    await _prefs.remove(_kUnlockedAchievements);
    notifyListeners();
  }
}

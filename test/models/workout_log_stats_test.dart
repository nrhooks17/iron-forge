import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout_log_stats.dart';

void main() {
  group('WorkoutLogStats', () {
    test('should create stats with all required fields', () {
      final lastWorkout = DateTime(2024, 1, 15);
      final stats = WorkoutLogStats(
        totalWorkouts: 10,
        fullyCompleted: 8,
        totalSets: 150,
        totalDuration: const Duration(hours: 15, minutes: 30),
        lastWorkoutDate: lastWorkout,
      );

      expect(stats.totalWorkouts, 10);
      expect(stats.fullyCompleted, 8);
      expect(stats.totalSets, 150);
      expect(stats.totalDuration, const Duration(hours: 15, minutes: 30));
      expect(stats.lastWorkoutDate, lastWorkout);
    });

    test('should create stats without last workout date', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 0,
        fullyCompleted: 0,
        totalSets: 0,
        totalDuration: Duration.zero,
      );

      expect(stats.totalWorkouts, 0);
      expect(stats.fullyCompleted, 0);
      expect(stats.totalSets, 0);
      expect(stats.totalDuration, Duration.zero);
      expect(stats.lastWorkoutDate, isNull);
    });

    test('should format duration with hours and minutes', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 5,
        fullyCompleted: 4,
        totalSets: 75,
        totalDuration: const Duration(hours: 3, minutes: 45),
      );

      expect(stats.formattedTotalDuration, '3h 45m');
    });

    test('should format duration with only minutes', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 2,
        fullyCompleted: 2,
        totalSets: 30,
        totalDuration: const Duration(minutes: 90),
      );

      expect(stats.formattedTotalDuration, '90m');
    });

    test('should format duration with zero hours correctly', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 1,
        fullyCompleted: 1,
        totalSets: 15,
        totalDuration: const Duration(minutes: 30),
      );

      expect(stats.formattedTotalDuration, '30m');
    });

    test('should handle zero duration', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 0,
        fullyCompleted: 0,
        totalSets: 0,
        totalDuration: Duration.zero,
      );

      expect(stats.formattedTotalDuration, '0m');
    });

    test('should handle large durations correctly', () {
      final stats = WorkoutLogStats(
        totalWorkouts: 100,
        fullyCompleted: 85,
        totalSets: 2000,
        totalDuration: const Duration(hours: 50, minutes: 15),
      );

      expect(stats.formattedTotalDuration, '50h 15m');
    });
  });
}
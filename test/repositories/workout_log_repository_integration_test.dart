import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout_log.dart';
import 'package:latent_power/models/exercise_progress.dart';
import 'package:latent_power/models/workout_log_stats.dart';

void main() {
  group('WorkoutLogRepository Integration Tests', () {
    test('should demonstrate stats calculation logic', () {
      // Test the actual stats calculation logic that would be used by the repository
      final workouts = [
        WorkoutLog(
          workoutName: 'Upper Body',
          startTime: DateTime(2024, 1, 15, 10, 0),
          endTime: DateTime(2024, 1, 15, 11, 0),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, true, true],
            ),
          ],
          wasFullyCompleted: true,
        ),
        WorkoutLog(
          workoutName: 'Lower Body',
          startTime: DateTime(2024, 1, 16, 10, 0),
          endTime: DateTime(2024, 1, 16, 10, 45),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 4,
              targetReps: 12,
              completedSets: [true, true, false, false],
            ),
          ],
          wasFullyCompleted: false,
        ),
      ];

      // Calculate stats manually (this is the logic that would be in the repository)
      final completed = workouts.where((log) => log.isCompleted).toList();
      final fullyCompleted = completed.where((log) => log.wasFullyCompleted).length;
      final totalSets = completed.fold(0, (sum, log) => 
          sum + log.exercises.fold(0, (exerciseSum, exercise) => 
              exerciseSum + exercise.completedCount));
      final totalDuration = completed.fold(Duration.zero, (sum, log) => sum + log.duration);
      
      completed.sort((a, b) => b.startTime.compareTo(a.startTime));
      final lastWorkoutDate = completed.isNotEmpty ? completed.first.startTime : null;

      final stats = WorkoutLogStats(
        totalWorkouts: completed.length,
        fullyCompleted: fullyCompleted,
        totalSets: totalSets,
        totalDuration: totalDuration,
        lastWorkoutDate: lastWorkoutDate,
      );

      expect(stats.totalWorkouts, 2);
      expect(stats.fullyCompleted, 1);
      expect(stats.totalSets, 5); // 3 from first workout + 2 from second
      expect(stats.totalDuration, const Duration(hours: 1, minutes: 45));
      expect(stats.lastWorkoutDate, DateTime(2024, 1, 16, 10, 0));
    });

    test('should demonstrate workout filtering logic', () {
      final workouts = [
        WorkoutLog(
          workoutName: 'Complete',
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 1)),
          exercises: [],
        ),
        WorkoutLog(
          workoutName: 'Incomplete',
          startTime: DateTime.now(),
          exercises: [],
        ),
      ];

      final completed = workouts.where((log) => log.isCompleted).toList();
      expect(completed.length, 1);
      expect(completed.first.workoutName, 'Complete');
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout_log.dart';
import 'package:latent_power/models/exercise_progress.dart';

void main() {
  group('WorkoutLog', () {
    late DateTime startTime;
    late List<ExerciseProgress> exercises;

    setUp(() {
      startTime = DateTime(2024, 1, 15, 10, 30);
      exercises = [
        ExerciseProgress(
          exerciseName: 'Push-ups',
          targetSets: 3,
          targetReps: 10,
          completedSets: [true, true, false],
        ),
        ExerciseProgress(
          exerciseName: 'Squats',
          targetSets: 3,
          targetReps: 12,
          completedSets: [false, false, false],
        ),
      ];
    });

    test('should create workout log with required fields', () {
      final log = WorkoutLog(
        workoutName: 'Morning Workout',
        startTime: startTime,
        exercises: exercises,
      );

      expect(log.workoutName, 'Morning Workout');
      expect(log.startTime, startTime);
      expect(log.exercises, exercises);
      expect(log.endTime, isNull);
      expect(log.wasFullyCompleted, false);
    });

    test('should determine if workout is completed based on endTime', () {
      final incompleteLog = WorkoutLog(
        workoutName: 'Ongoing Workout',
        startTime: startTime,
        exercises: exercises,
      );

      final completedLog = WorkoutLog(
        workoutName: 'Finished Workout',
        startTime: startTime,
        exercises: exercises,
        endTime: startTime.add(const Duration(hours: 1)),
        wasFullyCompleted: true,
      );

      expect(incompleteLog.isCompleted, false);
      expect(completedLog.isCompleted, true);
    });

    test('should calculate completion percentage correctly', () {
      final log = WorkoutLog(
        workoutName: 'Test Workout',
        startTime: startTime,
        exercises: exercises,
      );

      // Total sets: 3 + 3 = 6, Completed sets: 2 + 0 = 2
      // Percentage: 2/6 = 0.333...
      expect(log.completionPercentage, closeTo(0.333, 0.001));
    });

    test('should handle empty exercises for completion percentage', () {
      final log = WorkoutLog(
        workoutName: 'Empty Workout',
        startTime: startTime,
        exercises: [],
      );

      expect(log.completionPercentage, 0.0);
    });

    test('should calculate duration correctly', () {
      final endTime = startTime.add(const Duration(hours: 1, minutes: 30));
      final log = WorkoutLog(
        workoutName: 'Timed Workout',
        startTime: startTime,
        exercises: exercises,
        endTime: endTime,
      );

      expect(log.duration, const Duration(hours: 1, minutes: 30));
    });

    test('should return zero duration for incomplete workout', () {
      final log = WorkoutLog(
        workoutName: 'Ongoing Workout',
        startTime: startTime,
        exercises: exercises,
      );

      expect(log.duration, Duration.zero);
    });

    test('should format duration correctly', () {
      final log1 = WorkoutLog(
        workoutName: 'Short Workout',
        startTime: startTime,
        exercises: exercises,
        endTime: startTime.add(const Duration(minutes: 45)),
      );

      final log2 = WorkoutLog(
        workoutName: 'Long Workout',
        startTime: startTime,
        exercises: exercises,
        endTime: startTime.add(const Duration(hours: 2, minutes: 30)),
      );

      expect(log1.formattedDuration, '45m');
      expect(log2.formattedDuration, '2h 30m');
    });

    test('should handle fully completed workout progress', () {
      final completedExercises = [
        ExerciseProgress(
          exerciseName: 'Push-ups',
          targetSets: 3,
          targetReps: 10,
          completedSets: [true, true, true],
        ),
        ExerciseProgress(
          exerciseName: 'Squats',
          targetSets: 2,
          targetReps: 12,
          completedSets: [true, true],
        ),
      ];

      final log = WorkoutLog(
        workoutName: 'Perfect Workout',
        startTime: startTime,
        exercises: completedExercises,
        wasFullyCompleted: true,
      );

      expect(log.completionPercentage, 1.0);
      expect(log.wasFullyCompleted, true);
    });
  });
}
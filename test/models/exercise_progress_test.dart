import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/exercise_progress.dart';

void main() {
  group('ExerciseProgress', () {
    test('should create exercise progress with required fields', () {
      final progress = ExerciseProgress(
        exerciseName: 'Push-ups',
        targetSets: 3,
        targetReps: 10,
        completedSets: [false, false, false],
      );

      expect(progress.exerciseName, 'Push-ups');
      expect(progress.targetSets, 3);
      expect(progress.targetReps, 10);
      expect(progress.completedSets, [false, false, false]);
    });

    test('should calculate completed count correctly', () {
      final progress = ExerciseProgress(
        exerciseName: 'Squats',
        targetSets: 4,
        targetReps: 12,
        completedSets: [true, false, true, false],
      );

      expect(progress.completedCount, 2);
    });

    test('should determine if exercise is completed', () {
      final completedProgress = ExerciseProgress(
        exerciseName: 'Bench Press',
        targetSets: 3,
        targetReps: 8,
        completedSets: [true, true, true],
      );

      final incompleteProgress = ExerciseProgress(
        exerciseName: 'Deadlift',
        targetSets: 3,
        targetReps: 5,
        completedSets: [true, false, true],
      );

      expect(completedProgress.isCompleted, true);
      expect(incompleteProgress.isCompleted, false);
    });

    test('should handle empty completed sets', () {
      final progress = ExerciseProgress(
        exerciseName: 'Plank',
        targetSets: 0,
        targetReps: 1,
        completedSets: [],
      );

      expect(progress.completedCount, 0);
      expect(progress.isCompleted, true); // 0 == 0
    });

    test('should handle all sets completed', () {
      final progress = ExerciseProgress(
        exerciseName: 'Pull-ups',
        targetSets: 5,
        targetReps: 6,
        completedSets: [true, true, true, true, true],
      );

      expect(progress.completedCount, 5);
      expect(progress.isCompleted, true);
    });

    test('should allow modification of fields', () {
      final progress = ExerciseProgress(
        exerciseName: 'Rows',
        targetSets: 3,
        targetReps: 10,
        completedSets: [false, false, false],
      );

      progress.exerciseName = 'Barbell Rows';
      progress.targetSets = 4;
      progress.targetReps = 12;
      progress.completedSets = [true, false, true, false];

      expect(progress.exerciseName, 'Barbell Rows');
      expect(progress.targetSets, 4);
      expect(progress.targetReps, 12);
      expect(progress.completedCount, 2);
    });
  });
}
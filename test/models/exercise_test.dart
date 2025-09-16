import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/exercise.dart';

void main() {
  group('Exercise', () {
    test('should create exercise with required fields', () {
      final exercise = Exercise(
        name: 'Push-ups',
        sets: 3,
        reps: 10,
      );

      expect(exercise.name, 'Push-ups');
      expect(exercise.sets, 3);
      expect(exercise.reps, 10);
    });

    test('should create exercise with different values', () {
      final exercise = Exercise(
        name: 'Bench Press',
        sets: 4,
        reps: 8,
      );

      expect(exercise.name, 'Bench Press');
      expect(exercise.sets, 4);
      expect(exercise.reps, 8);
    });

    test('should allow modification of mutable fields', () {
      final exercise = Exercise(
        name: 'Squats',
        sets: 3,
        reps: 12,
      );

      exercise.name = 'Deep Squats';
      exercise.sets = 4;
      exercise.reps = 15;

      expect(exercise.name, 'Deep Squats');
      expect(exercise.sets, 4);
      expect(exercise.reps, 15);
    });

    test('should handle edge case values', () {
      final exercise = Exercise(
        name: 'Plank',
        sets: 1,
        reps: 1,
      );

      expect(exercise.name, 'Plank');
      expect(exercise.sets, 1);
      expect(exercise.reps, 1);
    });

    test('should handle high rep exercises', () {
      final exercise = Exercise(
        name: 'Jump Rope',
        sets: 5,
        reps: 100,
      );

      expect(exercise.name, 'Jump Rope');
      expect(exercise.sets, 5);
      expect(exercise.reps, 100);
    });
  });
}
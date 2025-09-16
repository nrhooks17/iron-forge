import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout.dart';
import 'package:latent_power/models/exercise.dart';

void main() {
  group('Workout', () {
    test('should create workout with name and exercises', () {
      final exercises = [
        Exercise(name: 'Push-ups', sets: 3, reps: 10),
        Exercise(name: 'Squats', sets: 4, reps: 12),
      ];

      final workout = Workout(
        name: 'Upper Body',
        exercises: exercises,
      );

      expect(workout.name, 'Upper Body');
      expect(workout.exercises, exercises);
      expect(workout.exercises.length, 2);
    });

    test('should create workout with empty exercises list', () {
      final workout = Workout(
        name: 'Rest Day',
        exercises: [],
      );

      expect(workout.name, 'Rest Day');
      expect(workout.exercises, isEmpty);
    });

    test('should allow modification of fields', () {
      final workout = Workout(
        name: 'Leg Day',
        exercises: [
          Exercise(name: 'Squats', sets: 3, reps: 12),
        ],
      );

      workout.name = 'Heavy Leg Day';
      workout.exercises.add(Exercise(name: 'Deadlifts', sets: 3, reps: 8));

      expect(workout.name, 'Heavy Leg Day');
      expect(workout.exercises.length, 2);
      expect(workout.exercises[1].name, 'Deadlifts');
    });

    test('should handle workout with multiple different exercises', () {
      final exercises = [
        Exercise(name: 'Bench Press', sets: 3, reps: 8),
        Exercise(name: 'Deadlift', sets: 3, reps: 5),
        Exercise(name: 'Push-ups', sets: 2, reps: 15),
      ];

      final workout = Workout(
        name: 'Strength Training',
        exercises: exercises,
      );

      expect(workout.exercises[0].name, 'Bench Press');
      expect(workout.exercises[0].sets, 3);
      expect(workout.exercises[1].reps, 5);
      expect(workout.exercises[2].sets, 2);
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout_log.dart';
import 'package:latent_power/models/exercise_progress.dart';
import 'package:latent_power/utils/workout_utils.dart';

void main() {
  group('WorkoutUtils', () {
    group('isWorkoutComplete', () {
      test('should return true for fully completed workout', () {
        final workout = WorkoutLog(
          workoutName: 'Test Workout',
          startTime: DateTime.now(),
          exercises: [
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
          ],
        );

        expect(WorkoutUtils.isWorkoutComplete(workout), true);
      });

      test('should return false for incomplete workout', () {
        final workout = WorkoutLog(
          workoutName: 'Test Workout',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, false, true],
            ),
          ],
        );

        expect(WorkoutUtils.isWorkoutComplete(workout), false);
      });

      test('should return false for empty workout', () {
        final workout = WorkoutLog(
          workoutName: 'Empty Workout',
          startTime: DateTime.now(),
          exercises: [],
        );

        expect(WorkoutUtils.isWorkoutComplete(workout), false);
      });
    });

    group('calculateCompletionPercentage', () {
      test('should calculate correct percentage', () {
        final workout = WorkoutLog(
          workoutName: 'Test Workout',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 4,
              targetReps: 10,
              completedSets: [true, true, false, false], // 2/4 completed
            ),
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 2,
              targetReps: 12,
              completedSets: [true, true], // 2/2 completed
            ),
          ],
        );

        // Total sets: 4 + 2 = 6, Completed: 2 + 2 = 4
        // Percentage: 4/6 = 0.6666...
        expect(WorkoutUtils.calculateCompletionPercentage(workout), closeTo(0.667, 0.001));
      });

      test('should return 0 for empty workout', () {
        final workout = WorkoutLog(
          workoutName: 'Empty',
          startTime: DateTime.now(),
          exercises: [],
        );

        expect(WorkoutUtils.calculateCompletionPercentage(workout), 0.0);
      });

      test('should return 1.0 for fully completed workout', () {
        final workout = WorkoutLog(
          workoutName: 'Complete',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, true, true],
            ),
          ],
        );

        expect(WorkoutUtils.calculateCompletionPercentage(workout), 1.0);
      });
    });

    group('getTotalSets', () {
      test('should calculate total sets correctly', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [false, false, false],
            ),
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 4,
              targetReps: 12,
              completedSets: [false, false, false, false],
            ),
          ],
        );

        expect(WorkoutUtils.getTotalSets(workout), 7);
      });

      test('should return 0 for empty workout', () {
        final workout = WorkoutLog(
          workoutName: 'Empty',
          startTime: DateTime.now(),
          exercises: [],
        );

        expect(WorkoutUtils.getTotalSets(workout), 0);
      });
    });

    group('getCompletedSets', () {
      test('should calculate completed sets correctly', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, false, true], // 2 completed
            ),
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 4,
              targetReps: 12,
              completedSets: [true, true, true, false], // 3 completed
            ),
          ],
        );

        expect(WorkoutUtils.getCompletedSets(workout), 5);
      });
    });

    group('getRemainingExercises', () {
      test('should calculate remaining exercises correctly', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, true, true], // Complete
            ),
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 3,
              targetReps: 12,
              completedSets: [true, false, false], // Incomplete
            ),
            ExerciseProgress(
              exerciseName: 'Pull-ups',
              targetSets: 2,
              targetReps: 8,
              completedSets: [false, false], // Incomplete
            ),
          ],
        );

        expect(WorkoutUtils.getRemainingExercises(workout), 2);
      });
    });

    group('getWorkoutDuration', () {
      test('should calculate duration for completed workout', () {
        final startTime = DateTime(2024, 1, 15, 10, 0);
        final endTime = startTime.add(const Duration(hours: 1, minutes: 30));
        
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: startTime,
          endTime: endTime,
          exercises: [],
        );

        expect(WorkoutUtils.getWorkoutDuration(workout), const Duration(hours: 1, minutes: 30));
      });

      test('should calculate duration for ongoing workout', () {
        // For ongoing workouts, we can't test exact duration due to DateTime.now()
        // But we can verify it returns a non-negative duration
        final workout = WorkoutLog(
          workoutName: 'Ongoing',
          startTime: DateTime.now().subtract(const Duration(minutes: 30)),
          exercises: [],
        );

        final duration = WorkoutUtils.getWorkoutDuration(workout);
        expect(duration.inMinutes >= 29, true); // Should be at least 29 minutes
      });
    });

    group('getStatusText', () {
      test('should return victory message for completed workout', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [],
          wasFullyCompleted: true,
        );

        expect(WorkoutUtils.getStatusText(workout), 'VICTORY - CONQUEST ACHIEVED');
      });

      test('should return defeat message for incomplete workout', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [],
          wasFullyCompleted: false,
        );

        expect(WorkoutUtils.getStatusText(workout), 'DEFEAT - YOU FAILED');
      });
    });

    group('getCompletionText', () {
      test('should format completion text correctly', () {
        final workout = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 4,
              targetReps: 10,
              completedSets: [true, true, false, false], // 2/4
            ),
            ExerciseProgress(
              exerciseName: 'Squats',
              targetSets: 2,
              targetReps: 12,
              completedSets: [true, true], // 2/2
            ),
          ],
        );

        // 4 completed out of 6 total = 67%
        expect(WorkoutUtils.getCompletionText(workout), '4/6 sets • 67% complete');
      });
    });

    group('canCompleteSet', () {
      test('should return true when sets can still be completed', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Push-ups',
          targetSets: 3,
          targetReps: 10,
          completedSets: [true, false, false],
        );

        expect(WorkoutUtils.canCompleteSet(exercise), true);
      });

      test('should return false when all sets are completed', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Push-ups',
          targetSets: 3,
          targetReps: 10,
          completedSets: [true, true, true],
        );

        expect(WorkoutUtils.canCompleteSet(exercise), false);
      });
    });

    group('isExerciseComplete', () {
      test('should return true for completed exercise', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Squats',
          targetSets: 2,
          targetReps: 12,
          completedSets: [true, true],
        );

        expect(WorkoutUtils.isExerciseComplete(exercise), true);
      });

      test('should return false for incomplete exercise', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Pull-ups',
          targetSets: 3,
          targetReps: 8,
          completedSets: [true, false, false],
        );

        expect(WorkoutUtils.isExerciseComplete(exercise), false);
      });
    });

    group('getExerciseStatusText', () {
      test('should return COMPLETE for finished exercise', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Push-ups',
          targetSets: 3,
          targetReps: 10,
          completedSets: [true, true, true],
        );

        expect(WorkoutUtils.getExerciseStatusText(exercise), 'COMPLETE');
      });

      test('should return progress for incomplete exercise', () {
        final exercise = ExerciseProgress(
          exerciseName: 'Squats',
          targetSets: 4,
          targetReps: 12,
          completedSets: [true, false, true, false],
        );

        expect(WorkoutUtils.getExerciseStatusText(exercise), '2/4');
      });
    });
  });
}
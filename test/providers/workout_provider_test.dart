import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/models/workout.dart';
import 'package:latent_power/models/exercise.dart';
import 'package:latent_power/models/workout_log.dart';
import 'package:latent_power/models/exercise_progress.dart';
import 'package:latent_power/models/workout_log_stats.dart';
import 'package:latent_power/providers/workout_provider.dart';
import 'package:latent_power/repositories/workout_repository.dart';
import 'package:latent_power/repositories/workout_log_repository.dart';
import 'package:latent_power/exceptions/workout_validation_exception.dart';
import 'package:latent_power/exceptions/exercise_validation_exception.dart';

// Mock repositories for testing
class MockWorkoutRepository extends WorkoutRepository {
  final List<Workout> _workouts = [];

  @override
  List<Workout> getAllWorkouts() => List.from(_workouts);

  @override
  Future<void> addWorkout(Workout workout) async {
    _workouts.add(workout);
  }

  @override
  Future<void> deleteWorkout(int index) async {
    if (index >= 0 && index < _workouts.length) {
      _workouts.removeAt(index);
    }
  }

  @override
  int get workoutCount => _workouts.length;

  @override
  bool get isEmpty => _workouts.isEmpty;

  @override
  Workout? getWorkoutAt(int index) {
    if (index >= 0 && index < _workouts.length) {
      return _workouts[index];
    }
    return null;
  }
}

class MockWorkoutLogRepository extends WorkoutLogRepository {
  final List<WorkoutLog> _logs = [];

  @override
  List<WorkoutLog> getAllWorkoutLogs() => List.from(_logs);

  @override
  List<WorkoutLog> getCompletedWorkouts() => 
      _logs.where((log) => log.isCompleted).toList();

  @override
  Future<void> addWorkoutLog(WorkoutLog log) async {
    _logs.add(log);
  }

  @override
  Future<void> updateWorkoutLog(WorkoutLog log) async {
    // In real implementation, this would save to Hive
    // For tests, we assume the log is already in memory
  }

  @override
  WorkoutLogStats getStats() {
    final completed = getCompletedWorkouts();
    final fullyCompleted = completed.where((log) => log.wasFullyCompleted).length;
    final totalSets = completed.fold(0, (sum, log) => 
        sum + log.exercises.fold(0, (exerciseSum, exercise) => 
            exerciseSum + exercise.completedCount));
    final totalDuration = completed.fold(Duration.zero, (sum, log) => sum + log.duration);
    
    DateTime? lastWorkoutDate;
    if (completed.isNotEmpty) {
      completed.sort((a, b) => b.startTime.compareTo(a.startTime));
      lastWorkoutDate = completed.first.startTime;
    }

    return WorkoutLogStats(
      totalWorkouts: completed.length,
      fullyCompleted: fullyCompleted,
      totalSets: totalSets,
      totalDuration: totalDuration,
      lastWorkoutDate: lastWorkoutDate,
    );
  }
}

void main() {
  group('WorkoutProvider', () {
    late WorkoutProvider provider;
    late MockWorkoutRepository mockWorkoutRepo;
    late MockWorkoutLogRepository mockLogRepo;

    setUp(() {
      mockWorkoutRepo = MockWorkoutRepository();
      mockLogRepo = MockWorkoutLogRepository();
      provider = WorkoutProvider(mockWorkoutRepo, mockLogRepo);
    });

    group('createWorkout', () {
      test('should create workout with valid data', () async {
        final exercises = [
          Exercise(name: 'Push-ups', sets: 3, reps: 10),
          Exercise(name: 'Squats', sets: 3, reps: 12),
        ];

        await provider.createWorkout('Upper Body', exercises);

        expect(mockWorkoutRepo.workoutCount, 1);
        expect(mockWorkoutRepo.getAllWorkouts().first.name, 'Upper Body');
        expect(mockWorkoutRepo.getAllWorkouts().first.exercises.length, 2);
      });

      test('should throw exception for empty workout name', () async {
        final exercises = [Exercise(name: 'Push-ups', sets: 3, reps: 10)];

        expect(
          () => provider.createWorkout('', exercises),
          throwsA(isA<WorkoutValidationException>()),
        );
      });

      test('should throw exception for whitespace-only workout name', () async {
        final exercises = [Exercise(name: 'Push-ups', sets: 3, reps: 10)];

        expect(
          () => provider.createWorkout('   ', exercises),
          throwsA(isA<WorkoutValidationException>()),
        );
      });

      test('should throw exception for empty exercises', () async {
        expect(
          () => provider.createWorkout('Test Workout', []),
          throwsA(isA<WorkoutValidationException>()),
        );
      });

      test('should trim workout name', () async {
        final exercises = [Exercise(name: 'Push-ups', sets: 3, reps: 10)];

        await provider.createWorkout('  Spaced Name  ', exercises);

        expect(mockWorkoutRepo.getAllWorkouts().first.name, 'Spaced Name');
      });
    });

    group('validateExercise', () {
      test('should validate correct exercise data', () async {
        await provider.validateExercise('Push-ups', 3, 10);
        // Should not throw
      });

      test('should throw exception for empty exercise name', () async {
        expect(
          () => provider.validateExercise('', 3, 10),
          throwsA(isA<ExerciseValidationException>()),
        );
      });

      test('should throw exception for zero sets', () async {
        expect(
          () => provider.validateExercise('Push-ups', 0, 10),
          throwsA(isA<ExerciseValidationException>()),
        );
      });

      test('should throw exception for too many sets', () async {
        expect(
          () => provider.validateExercise('Push-ups', 25, 10),
          throwsA(isA<ExerciseValidationException>()),
        );
      });

      test('should throw exception for zero reps', () async {
        expect(
          () => provider.validateExercise('Push-ups', 3, 0),
          throwsA(isA<ExerciseValidationException>()),
        );
      });

      test('should throw exception for too many reps', () async {
        expect(
          () => provider.validateExercise('Push-ups', 3, 250),
          throwsA(isA<ExerciseValidationException>()),
        );
      });

      test('should accept boundary values', () async {
        await provider.validateExercise('Test', 1, 1);
        await provider.validateExercise('Test', 20, 200);
        // Should not throw
      });
    });

    group('startWorkout', () {
      test('should create workout log from workout', () async {
        final workout = Workout(
          name: 'Test Workout',
          exercises: [
            Exercise(name: 'Push-ups', sets: 3, reps: 10),
            Exercise(name: 'Squats', sets: 2, reps: 15),
          ],
        );

        final log = await provider.startWorkout(workout);

        expect(log.workoutName, 'Test Workout');
        expect(log.exercises.length, 2);
        expect(log.exercises[0].exerciseName, 'Push-ups');
        expect(log.exercises[0].targetSets, 3);
        expect(log.exercises[0].completedSets.length, 3);
        expect(log.exercises[0].completedSets, [false, false, false]);
      });

      test('should add log to repository', () async {
        final workout = Workout(
          name: 'Test Workout',
          exercises: [Exercise(name: 'Push-ups', sets: 3, reps: 10)],
        );

        await provider.startWorkout(workout);

        expect(mockLogRepo.getAllWorkoutLogs().length, 1);
      });
    });

    group('finishWorkout', () {
      test('should mark workout as completed when all exercises done', () async {
        final log = WorkoutLog(
          workoutName: 'Test Workout',
          startTime: DateTime.now().subtract(const Duration(hours: 1)),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 2,
              targetReps: 10,
              completedSets: [true, true],
            ),
          ],
        );

        final result = await provider.finishWorkout(log);

        expect(result, true);
        expect(log.wasFullyCompleted, true);
        expect(log.endTime, isNotNull);
      });

      test('should mark workout as incomplete when exercises not done', () async {
        final log = WorkoutLog(
          workoutName: 'Test Workout',
          startTime: DateTime.now().subtract(const Duration(hours: 1)),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 3,
              targetReps: 10,
              completedSets: [true, false, false],
            ),
          ],
        );

        final result = await provider.finishWorkout(log);

        expect(result, false);
        expect(log.wasFullyCompleted, false);
        expect(log.endTime, isNotNull);
      });
    });

    group('shouldAutoComplete', () {
      test('should return true when all exercises completed and workout not finished', () {
        final log = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 2,
              targetReps: 10,
              completedSets: [true, true],
            ),
          ],
        );

        expect(provider.shouldAutoComplete(log), true);
      });

      test('should return false when exercises not completed', () {
        final log = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 2,
              targetReps: 10,
              completedSets: [true, false],
            ),
          ],
        );

        expect(provider.shouldAutoComplete(log), false);
      });

      test('should return false when workout already completed', () {
        final log = WorkoutLog(
          workoutName: 'Test',
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          exercises: [
            ExerciseProgress(
              exerciseName: 'Push-ups',
              targetSets: 2,
              targetReps: 10,
              completedSets: [true, true],
            ),
          ],
        );

        expect(provider.shouldAutoComplete(log), false);
      });
    });

    group('deleteWorkout', () {
      test('should delete workout at correct index', () async {
        // Add some workouts first
        await provider.createWorkout('Workout 1', [Exercise(name: 'A', sets: 1, reps: 1)]);
        await provider.createWorkout('Workout 2', [Exercise(name: 'B', sets: 1, reps: 1)]);
        await provider.createWorkout('Workout 3', [Exercise(name: 'C', sets: 1, reps: 1)]);

        await provider.deleteWorkout(1); // Delete "Workout 2"

        final remaining = provider.getAllWorkouts();
        expect(remaining.length, 2);
        expect(remaining[0].name, 'Workout 1');
        expect(remaining[1].name, 'Workout 3');
      });
    });
  });
}
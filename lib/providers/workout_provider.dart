import '../models/workout.dart';
import '../models/exercise.dart';
import '../models/workout_log.dart';
import '../models/workout_log_stats.dart';
import '../models/exercise_progress.dart';
import '../repositories/workout_repository.dart';
import '../repositories/workout_log_repository.dart';
import '../exceptions/workout_validation_exception.dart';
import '../exceptions/exercise_validation_exception.dart';

class WorkoutProvider {
  final WorkoutRepository _workoutRepository;
  final WorkoutLogRepository _logRepository;

  WorkoutProvider(this._workoutRepository, this._logRepository);

  Future<void> createWorkout(String name, List<Exercise> exercises) async {
    if (name.trim().isEmpty || exercises.isEmpty) {
      throw WorkoutValidationException('Workout name and exercises are required');
    }

    final workout = Workout(
      name: name.trim(),
      exercises: exercises,
    );

    await _workoutRepository.addWorkout(workout);
  }

  Future<void> validateExercise(String name, int sets, int reps) async {
    if (name.trim().isEmpty) {
      throw ExerciseValidationException('Exercise name is required');
    }

    if (sets <= 0 || sets > 20) {
      throw ExerciseValidationException('Sets must be between 1-20');
    }

    if (reps <= 0 || reps > 200) {
      throw ExerciseValidationException('Reps must be between 1-200');
    }
  }

  Future<WorkoutLog> startWorkout(Workout workout) async {
    final log = WorkoutLog(
      workoutName: workout.name,
      startTime: DateTime.now(),
      exercises: workout.exercises
          .map((e) => ExerciseProgress(
                exerciseName: e.name,
                targetSets: e.sets,
                targetReps: e.reps,
                completedSets: List.filled(e.sets, false),
              ))
          .toList(),
    );

    await _logRepository.addWorkoutLog(log);
    return log;
  }

  Future<void> updateWorkoutProgress(WorkoutLog log, int exerciseIndex, int setIndex, bool completed) async {
    log.exercises[exerciseIndex].completedSets[setIndex] = completed;
    await _logRepository.updateWorkoutLog(log);
  }

  Future<bool> finishWorkout(WorkoutLog log) async {
    final allExercisesCompleted = log.exercises.every((exercise) => exercise.isCompleted);
    
    log.endTime = DateTime.now();
    log.wasFullyCompleted = allExercisesCompleted;
    
    await _logRepository.updateWorkoutLog(log);
    return allExercisesCompleted;
  }

  bool shouldAutoComplete(WorkoutLog log) {
    return log.exercises.every((exercise) => exercise.isCompleted) && !log.isCompleted;
  }

  List<Workout> getAllWorkouts() {
    return _workoutRepository.getAllWorkouts();
  }

  List<WorkoutLog> getCompletedWorkouts() {
    return _logRepository.getCompletedWorkouts();
  }

  WorkoutLogStats getWorkoutStats() {
    return _logRepository.getStats();
  }

  Future<void> deleteWorkout(int index) async {
    await _workoutRepository.deleteWorkout(index);
  }
}


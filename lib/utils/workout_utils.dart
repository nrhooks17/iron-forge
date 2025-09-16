import '../models/workout_log.dart';
import '../models/exercise_progress.dart';

class WorkoutUtils {
  static bool isWorkoutComplete(WorkoutLog workout) {
    if (workout.exercises.isEmpty) return false;
    
    return workout.exercises.every((exercise) => 
        exercise.completedCount >= exercise.targetSets);
  }

  static double calculateCompletionPercentage(WorkoutLog workout) {
    if (workout.exercises.isEmpty) return 0.0;
    
    final totalSets = workout.exercises.fold(0, (sum, exercise) => sum + exercise.targetSets);
    final completedSets = workout.exercises.fold(0, (sum, exercise) => sum + exercise.completedCount);
    
    return totalSets > 0 ? completedSets / totalSets : 0.0;
  }

  static int getTotalSets(WorkoutLog workout) {
    return workout.exercises.fold(0, (sum, exercise) => sum + exercise.targetSets);
  }

  static int getCompletedSets(WorkoutLog workout) {
    return workout.exercises.fold(0, (sum, exercise) => sum + exercise.completedCount);
  }

  static int getRemainingExercises(WorkoutLog workout) {
    return workout.exercises.where((exercise) => 
        exercise.completedCount < exercise.targetSets).length;
  }

  static Duration getWorkoutDuration(WorkoutLog workout) {
    if (workout.endTime == null) {
      return DateTime.now().difference(workout.startTime);
    }
    return workout.endTime!.difference(workout.startTime);
  }

  static String getStatusText(WorkoutLog workout) {
    if (workout.wasFullyCompleted) {
      return 'VICTORY - CONQUEST ACHIEVED';
    } else {
      return 'DEFEAT - YOU FAILED';
    }
  }

  static String getCompletionText(WorkoutLog workout) {
    final completedSets = getCompletedSets(workout);
    final totalSets = getTotalSets(workout);
    final percentage = (calculateCompletionPercentage(workout) * 100).round();
    
    return '$completedSets/$totalSets sets • $percentage% complete';
  }

  static bool canCompleteSet(ExerciseProgress exercise) {
    return exercise.completedCount < exercise.targetSets;
  }

  static bool isExerciseComplete(ExerciseProgress exercise) {
    return exercise.completedCount >= exercise.targetSets;
  }

  static String getExerciseStatusText(ExerciseProgress exercise) {
    if (isExerciseComplete(exercise)) {
      return 'COMPLETE';
    } else {
      return '${exercise.completedCount}/${exercise.targetSets}';
    }
  }
}
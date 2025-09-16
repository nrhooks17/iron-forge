import 'package:hive/hive.dart';
import 'exercise_progress.dart';

part 'workout_log.g.dart';

@HiveType(typeId: 2)
class WorkoutLog extends HiveObject {
  @HiveField(0)
  String workoutName;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  DateTime? endTime;

  @HiveField(3)
  List<ExerciseProgress> exercises;

  @HiveField(4)
  bool wasFullyCompleted;

  WorkoutLog({
    required this.workoutName,
    required this.startTime,
    this.endTime,
    required this.exercises,
    this.wasFullyCompleted = false,
  });

  bool get isCompleted => endTime != null;
  
  double get completionPercentage {
    if (exercises.isEmpty) return 0.0;
    final totalSets = exercises.fold(0, (sum, exercise) => sum + exercise.targetSets);
    final completedSets = exercises.fold(0, (sum, exercise) => sum + exercise.completedCount);
    return totalSets > 0 ? completedSets / totalSets : 0.0;
  }

  Duration get duration {
    if (endTime == null) return Duration.zero;
    return endTime!.difference(startTime);
  }

  String get formattedDuration {
    final dur = duration;
    final hours = dur.inHours;
    final minutes = dur.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}


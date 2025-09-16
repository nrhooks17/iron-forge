import 'package:hive/hive.dart';

part 'exercise_progress.g.dart';

@HiveType(typeId: 3)
class ExerciseProgress extends HiveObject {
  @HiveField(0)
  String exerciseName;

  @HiveField(1)
  int targetSets;

  @HiveField(2)
  int targetReps;

  @HiveField(3)
  List<bool> completedSets;

  ExerciseProgress({
    required this.exerciseName,
    required this.targetSets,
    required this.targetReps,
    required this.completedSets,
  });

  int get completedCount => completedSets.where((completed) => completed).length;
  bool get isCompleted => completedCount == targetSets;
}
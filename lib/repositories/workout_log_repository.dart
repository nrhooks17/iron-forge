import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/workout_log.dart';
import '../models/workout_log_stats.dart';

class WorkoutLogRepository {
  static const String _boxName = 'workout_logs';
  
  Box<WorkoutLog> get _box => Hive.box<WorkoutLog>(_boxName);

  List<WorkoutLog> getAllWorkoutLogs() {
    return _box.values.toList();
  }

  List<WorkoutLog> getCompletedWorkouts() {
    return _box.values.where((log) => log.isCompleted).toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  Future<void> addWorkoutLog(WorkoutLog log) async {
    await _box.add(log);
  }

  Future<void> updateWorkoutLog(WorkoutLog log) async {
    await log.save();
  }

  Future<void> deleteWorkoutLog(int index) async {
    await _box.deleteAt(index);
  }

  WorkoutLog? getWorkoutLogAt(int index) {
    return _box.getAt(index);
  }

  int get logCount => _box.length;

  bool get isEmpty => _box.isEmpty;

  ValueListenable<Box<WorkoutLog>> get listenable => _box.listenable();

  WorkoutLogStats getStats() {
    final completed = getCompletedWorkouts();
    final totalWorkouts = completed.length;
    final fullyCompleted = completed.where((log) => log.wasFullyCompleted).length;
    final totalSets = completed.fold(0, (sum, log) => 
        sum + log.exercises.fold(0, (exerciseSum, exercise) => 
            exerciseSum + exercise.completedCount));
    final totalDuration = completed.fold(Duration.zero, (sum, log) => sum + log.duration);
    
    DateTime? lastWorkoutDate;
    if (completed.isNotEmpty) {
      lastWorkoutDate = completed.first.startTime;
    }

    return WorkoutLogStats(
      totalWorkouts: totalWorkouts,
      fullyCompleted: fullyCompleted,
      totalSets: totalSets,
      totalDuration: totalDuration,
      lastWorkoutDate: lastWorkoutDate,
    );
  }
}


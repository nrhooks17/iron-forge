import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/workout.dart';

class WorkoutRepository {
  static const String _boxName = 'workouts';
  
  Box<Workout> get _box => Hive.box<Workout>(_boxName);

  List<Workout> getAllWorkouts() {
    return _box.values.toList();
  }

  Future<void> addWorkout(Workout workout) async {
    await _box.add(workout);
  }

  Future<void> updateWorkout(int index, Workout workout) async {
    await _box.putAt(index, workout);
  }

  Future<void> deleteWorkout(int index) async {
    await _box.deleteAt(index);
  }

  Workout? getWorkoutAt(int index) {
    return _box.getAt(index);
  }

  int get workoutCount => _box.length;

  bool get isEmpty => _box.isEmpty;

  ValueListenable<Box<Workout>> get listenable => _box.listenable();
}
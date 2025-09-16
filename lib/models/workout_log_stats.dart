class WorkoutLogStats {
  final int totalWorkouts;
  final int fullyCompleted;
  final int totalSets;
  final Duration totalDuration;
  final DateTime? lastWorkoutDate;

  WorkoutLogStats({
    required this.totalWorkouts,
    required this.fullyCompleted,
    required this.totalSets,
    required this.totalDuration,
    this.lastWorkoutDate,
  });

  String get formattedTotalDuration {
    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
class AppConstants {
  static const String appName = 'IRON FORGE';
  static const String appVersion = '1.0.0';
  
  static const String hiveBoxWorkouts = 'workouts';
  static const String hiveBoxWorkoutLogs = 'workout_logs';
  
  static const List<String> motivationalQuotes = [
    'FORGE YOUR STRENGTH',
    'PAIN IS TEMPORARY, VICTORY IS ETERNAL',
    'SWEAT TODAY, SHINE TOMORROW',
    'NO EXCUSES, ONLY RESULTS',
    'PUSH YOUR LIMITS',
    'CONQUER YOUR FEARS',
    'STRENGTH THROUGH STRUGGLE',
    'BATTLE TESTED, WARRIOR APPROVED',
    'RISE ABOVE THE CHALLENGE',
    'FORGE AHEAD WITH FIRE',
  ];
  
  static const int maxWorkoutNameLength = 50;
  static const int maxExerciseNameLength = 100;
  static const int maxReps = 999;
  static const int maxSets = 50;
  static const double maxWeight = 9999.0;
  
  static const Duration workoutTimeout = Duration(hours: 6);
  static const Duration autoSaveInterval = Duration(seconds: 30);
  
  static const String victoryMessage = 'VICTORY - CONQUEST ACHIEVED';
  static const String defeatMessage = 'DEFEAT - YOU FAILED';
  
  static const String emptyWorkoutsTitle = 'NO BATTLES FOUGHT';
  static const String emptyWorkoutsMessage = 'Create your first workout template and begin your journey to greatness.';
  
  static const String emptyHistoryTitle = 'NO VICTORIES RECORDED';
  static const String emptyHistoryMessage = 'Complete your first workout to start tracking your conquest history.';
  
  static const String emptyExercisesTitle = 'NO EXERCISES PREPARED';
  static const String emptyExercisesMessage = 'Add exercises to this workout template to begin your training regimen.';
}
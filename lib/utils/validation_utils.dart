class ValidationUtils {
  static bool isValidWorkoutName(String? name) {
    if (name == null || name.trim().isEmpty) return false;
    return name.trim().length >= 2 && name.trim().length <= 50;
  }

  static bool isValidExerciseName(String? name) {
    if (name == null || name.trim().isEmpty) return false;
    return name.trim().length >= 2 && name.trim().length <= 100;
  }

  static bool isValidReps(int? reps) {
    return reps != null && reps > 0 && reps <= 999;
  }

  static bool isValidSets(int? sets) {
    return sets != null && sets > 0 && sets <= 50;
  }

  static bool isValidWeight(double? weight) {
    return weight != null && weight >= 0 && weight <= 9999;
  }

  static String? validateWorkoutName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Workout name is required';
    }
    if (value.trim().length < 2) {
      return 'Workout name must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Workout name must be less than 50 characters';
    }
    return null;
  }

  static String? validateExerciseName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Exercise name is required';
    }
    if (value.trim().length < 2) {
      return 'Exercise name must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Exercise name must be less than 100 characters';
    }
    return null;
  }

  static String? validateReps(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Reps are required';
    }
    final reps = int.tryParse(value);
    if (reps == null) {
      return 'Please enter a valid number';
    }
    if (reps <= 0) {
      return 'Reps must be greater than 0';
    }
    if (reps > 999) {
      return 'Reps must be less than 1000';
    }
    return null;
  }

  static String? validateSets(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Sets are required';
    }
    final sets = int.tryParse(value);
    if (sets == null) {
      return 'Please enter a valid number';
    }
    if (sets <= 0) {
      return 'Sets must be greater than 0';
    }
    if (sets > 50) {
      return 'Sets must be less than 51';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Please enter a valid weight';
    }
    if (weight < 0) {
      return 'Weight cannot be negative';
    }
    if (weight > 9999) {
      return 'Weight must be less than 10000';
    }
    return null;
  }
}
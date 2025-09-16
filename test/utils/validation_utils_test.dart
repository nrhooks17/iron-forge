import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/utils/validation_utils.dart';

void main() {
  group('ValidationUtils', () {
    group('isValidWorkoutName', () {
      test('should accept valid workout names', () {
        expect(ValidationUtils.isValidWorkoutName('Push Day'), true);
        expect(ValidationUtils.isValidWorkoutName('Upper Body Strength'), true);
        expect(ValidationUtils.isValidWorkoutName('Ab'), true); // 2 chars minimum
      });

      test('should reject invalid workout names', () {
        expect(ValidationUtils.isValidWorkoutName(null), false);
        expect(ValidationUtils.isValidWorkoutName(''), false);
        expect(ValidationUtils.isValidWorkoutName('  '), false);
        expect(ValidationUtils.isValidWorkoutName('A'), false); // Too short
        expect(ValidationUtils.isValidWorkoutName('A' * 51), false); // Too long
      });

      test('should handle edge cases', () {
        expect(ValidationUtils.isValidWorkoutName('  Valid  '), true); // Trims to valid length
        expect(ValidationUtils.isValidWorkoutName('A' * 50), true); // Exactly 50 chars
      });
    });

    group('isValidExerciseName', () {
      test('should accept valid exercise names', () {
        expect(ValidationUtils.isValidExerciseName('Push-ups'), true);
        expect(ValidationUtils.isValidExerciseName('Barbell Back Squats'), true);
        expect(ValidationUtils.isValidExerciseName('Ab'), true);
      });

      test('should reject invalid exercise names', () {
        expect(ValidationUtils.isValidExerciseName(null), false);
        expect(ValidationUtils.isValidExerciseName(''), false);
        expect(ValidationUtils.isValidExerciseName('  '), false);
        expect(ValidationUtils.isValidExerciseName('A'), false);
        expect(ValidationUtils.isValidExerciseName('A' * 101), false);
      });
    });

    group('isValidReps', () {
      test('should accept valid rep counts', () {
        expect(ValidationUtils.isValidReps(1), true);
        expect(ValidationUtils.isValidReps(12), true);
        expect(ValidationUtils.isValidReps(999), true);
      });

      test('should reject invalid rep counts', () {
        expect(ValidationUtils.isValidReps(null), false);
        expect(ValidationUtils.isValidReps(0), false);
        expect(ValidationUtils.isValidReps(-5), false);
        expect(ValidationUtils.isValidReps(1000), false);
      });
    });

    group('isValidSets', () {
      test('should accept valid set counts', () {
        expect(ValidationUtils.isValidSets(1), true);
        expect(ValidationUtils.isValidSets(5), true);
        expect(ValidationUtils.isValidSets(50), true);
      });

      test('should reject invalid set counts', () {
        expect(ValidationUtils.isValidSets(null), false);
        expect(ValidationUtils.isValidSets(0), false);
        expect(ValidationUtils.isValidSets(-1), false);
        expect(ValidationUtils.isValidSets(51), false);
      });
    });

    group('isValidWeight', () {
      test('should accept valid weights', () {
        expect(ValidationUtils.isValidWeight(0.0), true);
        expect(ValidationUtils.isValidWeight(135.5), true);
        expect(ValidationUtils.isValidWeight(9999.0), true);
      });

      test('should reject invalid weights', () {
        expect(ValidationUtils.isValidWeight(null), false);
        expect(ValidationUtils.isValidWeight(-1.0), false);
        expect(ValidationUtils.isValidWeight(10000.0), false);
      });
    });

    group('validateWorkoutName', () {
      test('should return null for valid names', () {
        expect(ValidationUtils.validateWorkoutName('Push Day'), null);
        expect(ValidationUtils.validateWorkoutName('Upper Body'), null);
      });

      test('should return error messages for invalid names', () {
        expect(ValidationUtils.validateWorkoutName(null), 'Workout name is required');
        expect(ValidationUtils.validateWorkoutName(''), 'Workout name is required');
        expect(ValidationUtils.validateWorkoutName('  '), 'Workout name is required');
        expect(ValidationUtils.validateWorkoutName('A'), 'Workout name must be at least 2 characters');
        expect(ValidationUtils.validateWorkoutName('A' * 51), 'Workout name must be less than 50 characters');
      });
    });

    group('validateExerciseName', () {
      test('should return null for valid names', () {
        expect(ValidationUtils.validateExerciseName('Push-ups'), null);
        expect(ValidationUtils.validateExerciseName('Squats'), null);
      });

      test('should return error messages for invalid names', () {
        expect(ValidationUtils.validateExerciseName(null), 'Exercise name is required');
        expect(ValidationUtils.validateExerciseName(''), 'Exercise name is required');
        expect(ValidationUtils.validateExerciseName('A'), 'Exercise name must be at least 2 characters');
        expect(ValidationUtils.validateExerciseName('A' * 101), 'Exercise name must be less than 100 characters');
      });
    });

    group('validateReps', () {
      test('should return null for valid reps', () {
        expect(ValidationUtils.validateReps('10'), null);
        expect(ValidationUtils.validateReps('1'), null);
        expect(ValidationUtils.validateReps('999'), null);
      });

      test('should return error messages for invalid reps', () {
        expect(ValidationUtils.validateReps(null), 'Reps are required');
        expect(ValidationUtils.validateReps(''), 'Reps are required');
        expect(ValidationUtils.validateReps('abc'), 'Please enter a valid number');
        expect(ValidationUtils.validateReps('0'), 'Reps must be greater than 0');
        expect(ValidationUtils.validateReps('-5'), 'Reps must be greater than 0');
        expect(ValidationUtils.validateReps('1000'), 'Reps must be less than 1000');
      });
    });

    group('validateSets', () {
      test('should return null for valid sets', () {
        expect(ValidationUtils.validateSets('3'), null);
        expect(ValidationUtils.validateSets('1'), null);
        expect(ValidationUtils.validateSets('50'), null);
      });

      test('should return error messages for invalid sets', () {
        expect(ValidationUtils.validateSets(null), 'Sets are required');
        expect(ValidationUtils.validateSets(''), 'Sets are required');
        expect(ValidationUtils.validateSets('abc'), 'Please enter a valid number');
        expect(ValidationUtils.validateSets('0'), 'Sets must be greater than 0');
        expect(ValidationUtils.validateSets('51'), 'Sets must be less than 51');
      });
    });

    group('validateWeight', () {
      test('should return null for valid weights', () {
        expect(ValidationUtils.validateWeight('135.5'), null);
        expect(ValidationUtils.validateWeight('0'), null);
        expect(ValidationUtils.validateWeight('9999'), null);
        expect(ValidationUtils.validateWeight(null), null); // Weight is optional
        expect(ValidationUtils.validateWeight(''), null); // Weight is optional
      });

      test('should return error messages for invalid weights', () {
        expect(ValidationUtils.validateWeight('abc'), 'Please enter a valid weight');
        expect(ValidationUtils.validateWeight('-5'), 'Weight cannot be negative');
        expect(ValidationUtils.validateWeight('10000'), 'Weight must be less than 10000');
      });
    });
  });
}
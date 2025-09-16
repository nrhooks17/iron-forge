import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/exceptions/workout_validation_exception.dart';

void main() {
  group('WorkoutValidationException', () {
    test('should create exception with message', () {
      const message = 'Invalid workout data';
      final exception = WorkoutValidationException(message);

      expect(exception.message, message);
    });

    test('should implement Exception', () {
      final exception = WorkoutValidationException('Test');
      expect(exception, isA<Exception>());
    });

    test('should provide meaningful toString', () {
      const message = 'Workout name cannot be empty';
      final exception = WorkoutValidationException(message);

      expect(exception.toString(), 'WorkoutValidationException: $message');
    });

    test('should handle empty message', () {
      final exception = WorkoutValidationException('');
      expect(exception.message, '');
      expect(exception.toString(), 'WorkoutValidationException: ');
    });

    test('should handle special characters in message', () {
      const message = 'Invalid: "workout" with @special #characters!';
      final exception = WorkoutValidationException(message);

      expect(exception.message, message);
      expect(exception.toString(), 'WorkoutValidationException: $message');
    });
  });
}
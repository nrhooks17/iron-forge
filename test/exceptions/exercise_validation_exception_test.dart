import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/exceptions/exercise_validation_exception.dart';

void main() {
  group('ExerciseValidationException', () {
    test('should create exception with message', () {
      const message = 'Invalid exercise data';
      final exception = ExerciseValidationException(message);

      expect(exception.message, message);
    });

    test('should implement Exception', () {
      final exception = ExerciseValidationException('Test');
      expect(exception, isA<Exception>());
    });

    test('should provide meaningful toString', () {
      const message = 'Sets must be greater than zero';
      final exception = ExerciseValidationException(message);

      expect(exception.toString(), 'ExerciseValidationException: $message');
    });

    test('should handle empty message', () {
      final exception = ExerciseValidationException('');
      expect(exception.message, '');
      expect(exception.toString(), 'ExerciseValidationException: ');
    });

    test('should handle special characters in message', () {
      const message = 'Reps: "invalid" value @123 #error!';
      final exception = ExerciseValidationException(message);

      expect(exception.message, message);
      expect(exception.toString(), 'ExerciseValidationException: $message');
    });
  });
}
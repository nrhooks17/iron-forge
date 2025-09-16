class ExerciseValidationException implements Exception {
  final String message;
  ExerciseValidationException(this.message);
  
  @override
  String toString() => 'ExerciseValidationException: $message';
}
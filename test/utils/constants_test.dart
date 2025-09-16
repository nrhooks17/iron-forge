import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/utils/constants.dart';

void main() {
  group('AppConstants', () {
    group('App Info', () {
      test('should have correct app name and version', () {
        expect(AppConstants.appName, 'IRON FORGE');
        expect(AppConstants.appVersion, '1.0.0');
      });

      test('should have correct Hive box names', () {
        expect(AppConstants.hiveBoxWorkouts, 'workouts');
        expect(AppConstants.hiveBoxWorkoutLogs, 'workout_logs');
      });
    });

    group('Motivational Quotes', () {
      test('should have motivational quotes list', () {
        expect(AppConstants.motivationalQuotes, isNotEmpty);
        expect(AppConstants.motivationalQuotes, contains('FORGE YOUR STRENGTH'));
        expect(AppConstants.motivationalQuotes, contains('PAIN IS TEMPORARY, VICTORY IS ETERNAL'));
        expect(AppConstants.motivationalQuotes, contains('NO EXCUSES, ONLY RESULTS'));
      });

      test('should have at least 5 quotes', () {
        expect(AppConstants.motivationalQuotes.length, greaterThanOrEqualTo(5));
      });

      test('should have unique quotes', () {
        final uniqueQuotes = AppConstants.motivationalQuotes.toSet();
        expect(uniqueQuotes.length, AppConstants.motivationalQuotes.length);
      });
    });

    group('Validation Limits', () {
      test('should have correct name length limits', () {
        expect(AppConstants.maxWorkoutNameLength, 50);
        expect(AppConstants.maxExerciseNameLength, 100);
      });

      test('should have correct exercise limits', () {
        expect(AppConstants.maxReps, 999);
        expect(AppConstants.maxSets, 50);
        expect(AppConstants.maxWeight, 9999.0);
      });
    });

    group('Duration Constants', () {
      test('should have reasonable workout timeout', () {
        expect(AppConstants.workoutTimeout, const Duration(hours: 6));
      });

      test('should have auto-save interval', () {
        expect(AppConstants.autoSaveInterval, const Duration(seconds: 30));
      });
    });

    group('Status Messages', () {
      test('should have victory and defeat messages', () {
        expect(AppConstants.victoryMessage, 'VICTORY - CONQUEST ACHIEVED');
        expect(AppConstants.defeatMessage, 'DEFEAT - YOU FAILED');
      });

      test('should maintain consistent military theme', () {
        expect(AppConstants.victoryMessage, contains('VICTORY'));
        expect(AppConstants.victoryMessage, contains('CONQUEST'));
        expect(AppConstants.defeatMessage, contains('DEFEAT'));
        expect(AppConstants.defeatMessage, contains('FAILED'));
      });
    });

    group('Empty State Messages', () {
      test('should have empty workouts messages', () {
        expect(AppConstants.emptyWorkoutsTitle, 'NO BATTLES FOUGHT');
        expect(AppConstants.emptyWorkoutsMessage, contains('Create your first workout'));
        expect(AppConstants.emptyWorkoutsMessage, contains('greatness'));
      });

      test('should have empty history messages', () {
        expect(AppConstants.emptyHistoryTitle, 'NO VICTORIES RECORDED');
        expect(AppConstants.emptyHistoryMessage, contains('Complete your first workout'));
        expect(AppConstants.emptyHistoryMessage, contains('conquest history'));
      });

      test('should have empty exercises messages', () {
        expect(AppConstants.emptyExercisesTitle, 'NO EXERCISES PREPARED');
        expect(AppConstants.emptyExercisesMessage, contains('Add exercises'));
        expect(AppConstants.emptyExercisesMessage, contains('training regimen'));
      });

      test('should maintain consistent battle theme in empty states', () {
        expect(AppConstants.emptyWorkoutsTitle, contains('BATTLES'));
        expect(AppConstants.emptyHistoryTitle, contains('VICTORIES'));
        expect(AppConstants.emptyExercisesMessage, contains('training regimen'));
      });
    });

    group('Message Consistency', () {
      test('should use consistent terminology throughout', () {
        final allMessages = [
          AppConstants.victoryMessage,
          AppConstants.defeatMessage,
          AppConstants.emptyWorkoutsTitle,
          AppConstants.emptyWorkoutsMessage,
          AppConstants.emptyHistoryTitle,
          AppConstants.emptyHistoryMessage,
          AppConstants.emptyExercisesTitle,
          AppConstants.emptyExercisesMessage,
        ].join(' ').toUpperCase();

        // Should use battle/military terminology
        expect(allMessages, contains('VICTORY'));
        expect(allMessages, contains('BATTLE'));
        expect(allMessages, anyOf(contains('CONQUEST'), contains('TRAINING')));
      });

      test('should maintain uppercase styling for titles', () {
        expect(AppConstants.emptyWorkoutsTitle, equals(AppConstants.emptyWorkoutsTitle.toUpperCase()));
        expect(AppConstants.emptyHistoryTitle, equals(AppConstants.emptyHistoryTitle.toUpperCase()));
        expect(AppConstants.emptyExercisesTitle, equals(AppConstants.emptyExercisesTitle.toUpperCase()));
        expect(AppConstants.victoryMessage, equals(AppConstants.victoryMessage.toUpperCase()));
        expect(AppConstants.defeatMessage, equals(AppConstants.defeatMessage.toUpperCase()));
      });
    });
  });
}
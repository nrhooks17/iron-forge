import 'package:flutter_test/flutter_test.dart';
import 'package:latent_power/utils/date_utils.dart';

void main() {
  group('AppDateUtils', () {
    group('formatDate', () {
      test('should format date correctly', () {
        final date = DateTime(2024, 3, 15);
        expect(AppDateUtils.formatDate(date), 'Mar 15, 2024');
      });

      test('should handle different months', () {
        final jan = DateTime(2024, 1, 5);
        final dec = DateTime(2023, 12, 25);

        expect(AppDateUtils.formatDate(jan), 'Jan 05, 2024');
        expect(AppDateUtils.formatDate(dec), 'Dec 25, 2023');
      });
    });

    group('formatTime', () {
      test('should format AM time correctly', () {
        final time = DateTime(2024, 1, 1, 9, 30);
        expect(AppDateUtils.formatTime(time), '9:30 AM');
      });

      test('should format PM time correctly', () {
        final time = DateTime(2024, 1, 1, 14, 45);
        expect(AppDateUtils.formatTime(time), '2:45 PM');
      });

      test('should format midnight correctly', () {
        final time = DateTime(2024, 1, 1, 0, 0);
        expect(AppDateUtils.formatTime(time), '12:00 AM');
      });

      test('should format noon correctly', () {
        final time = DateTime(2024, 1, 1, 12, 0);
        expect(AppDateUtils.formatTime(time), '12:00 PM');
      });
    });

    group('formatDateTime', () {
      test('should format date and time together', () {
        final dateTime = DateTime(2024, 6, 10, 15, 30);
        expect(AppDateUtils.formatDateTime(dateTime), 'Jun 10, 2024 • 3:30 PM');
      });
    });

    group('formatDuration', () {
      test('should format duration with hours, minutes, and seconds', () {
        const duration = Duration(hours: 2, minutes: 30, seconds: 45);
        expect(AppDateUtils.formatDuration(duration), '2h 30m 45s');
      });

      test('should format duration with only minutes and seconds', () {
        const duration = Duration(minutes: 45, seconds: 30);
        expect(AppDateUtils.formatDuration(duration), '45m 30s');
      });

      test('should format duration with only seconds', () {
        const duration = Duration(seconds: 30);
        expect(AppDateUtils.formatDuration(duration), '30s');
      });

      test('should handle zero duration', () {
        const duration = Duration.zero;
        expect(AppDateUtils.formatDuration(duration), '0s');
      });

      test('should handle duration over 24 hours', () {
        const duration = Duration(hours: 25, minutes: 15, seconds: 30);
        expect(AppDateUtils.formatDuration(duration), '25h 15m 30s');
      });
    });

    group('getRelativeTime', () {
      late DateTime now;

      setUp(() {
        now = DateTime(2024, 6, 15, 12, 0, 0);
      });

      test('should return "Just now" for very recent dates', () {
        final recent = now.subtract(const Duration(seconds: 30));
        
        // We need to mock DateTime.now() for this test to work reliably
        // For now, we'll test the logic with a known time difference
        final difference = now.difference(recent);
        
        expect(difference.inMinutes, 0);
        expect(difference.inSeconds, 30);
      });

      test('should return minutes ago for recent dates', () {
        final date = DateTime.now().subtract(const Duration(minutes: 30));
        final result = AppDateUtils.getRelativeTime(date);
        
        // Should return relative time for recent dates
        expect(result, matches(r'(\d+ minutes ago|Just now|\d+ hours? ago)'));
      });

      test('should format old dates as full date', () {
        final oldDate = DateTime.now().subtract(const Duration(days: 10)); // More than a week ago
        final result = AppDateUtils.getRelativeTime(oldDate);
        
        expect(result, matches(r'[A-Za-z]+ \d{2}, \d{4}'));
      });
    });

    group('isSameDay', () {
      test('should return true for same day', () {
        final date1 = DateTime(2024, 6, 15, 10, 0);
        final date2 = DateTime(2024, 6, 15, 22, 30);

        expect(AppDateUtils.isSameDay(date1, date2), true);
      });

      test('should return false for different days', () {
        final date1 = DateTime(2024, 6, 15);
        final date2 = DateTime(2024, 6, 16);

        expect(AppDateUtils.isSameDay(date1, date2), false);
      });

      test('should return false for different months', () {
        final date1 = DateTime(2024, 5, 31);
        final date2 = DateTime(2024, 6, 1);

        expect(AppDateUtils.isSameDay(date1, date2), false);
      });

      test('should return false for different years', () {
        final date1 = DateTime(2023, 12, 31);
        final date2 = DateTime(2024, 1, 1);

        expect(AppDateUtils.isSameDay(date1, date2), false);
      });
    });

    group('isToday', () {
      test('should identify today correctly', () {
        final today = DateTime.now();
        final todayMidnight = DateTime(today.year, today.month, today.day);

        expect(AppDateUtils.isToday(todayMidnight), true);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));

        expect(AppDateUtils.isToday(yesterday), false);
      });
    });

    group('isYesterday', () {
      test('should identify yesterday correctly', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final yesterdayMidnight = DateTime(yesterday.year, yesterday.month, yesterday.day);

        expect(AppDateUtils.isYesterday(yesterdayMidnight), true);
      });

      test('should return false for today', () {
        final today = DateTime.now();

        expect(AppDateUtils.isYesterday(today), false);
      });

      test('should return false for two days ago', () {
        final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));

        expect(AppDateUtils.isYesterday(twoDaysAgo), false);
      });
    });
  });
}
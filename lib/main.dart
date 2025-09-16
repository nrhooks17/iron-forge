import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/exercise.dart';
import 'models/workout.dart';
import 'models/workout_log.dart';
import 'models/exercise_progress.dart';
import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WorkoutLogAdapter());
  Hive.registerAdapter(ExerciseProgressAdapter());
  
  await Hive.openBox<Workout>('workouts');
  await Hive.openBox<WorkoutLog>('workout_logs');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IRON FORGE',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Color(0xFFFF6B35), // Fiery orange
          onPrimary: Color(0xFF000000),
          secondary: Color(0xFFF7931E), // Amber
          onSecondary: Color(0xFF000000),
          tertiary: Color(0xFFDC143C), // Crimson red
          surface: Color(0xFF1C1C1E), // Dark charcoal
          onSurface: Color(0xFFE5E5E7),
          surfaceContainer: Color(0xFF2C2C2E),
          surfaceContainerHigh: Color(0xFF3A3A3C),
          error: Color(0xFFFF453A),
          outline: Color(0xFF8E8E93),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: Color(0xFFFFFFFF),
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.25,
            color: Color(0xFFFFFFFF),
          ),
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
            color: Color(0xFFFFFFFF),
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
            color: Color(0xFFFFFFFF),
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
            color: Color(0xFFFFFFFF),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: Color(0xFFE5E5E7),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Color(0xFFE5E5E7),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
            color: Color(0xFFE5E5E7),
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.25,
            color: Color(0xFFFFFFFF),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35),
            foregroundColor: const Color(0xFF000000),
            elevation: 8,
            shadowColor: const Color(0xFFFF6B35).withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 8,
          shadowColor: Color(0x4D000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          color: Color(0xFF2C2C2E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C1C1E),
          foregroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.15,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}


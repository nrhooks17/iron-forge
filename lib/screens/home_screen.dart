import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/workout.dart';
import '../models/workout_log.dart';
import '../repositories/workout_repository.dart';
import '../repositories/workout_log_repository.dart';
import '../providers/workout_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/motivational_header.dart';
import '../widgets/gradient_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/gradient_card.dart';
import '../widgets/empty_state.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart';
import '../utils/theme_constants.dart';
import 'create_workout_screen.dart';
import 'workout_session_screen.dart';
import 'workout_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WorkoutProvider _workoutProvider = WorkoutProvider(
    WorkoutRepository(),
    WorkoutLogRepository(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: AppConstants.appName,
        leadingIcon: Icons.fitness_center,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkoutHistoryScreen()),
              ),
              icon: Icon(
                Icons.history,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: 'Battle History',
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
          ),
        ),
        child: Column(
          children: [
            const MotivationalHeader(
              quotes: AppConstants.motivationalQuotes,
              subtitle: "Ready to dominate today's workout?",
            ),
            _buildStatsSection(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Workout>('workouts').listenable(),
                builder: (context, Box<Workout> box, _) {
                  if (box.isEmpty) {
                    return EmptyState(
                      icon: Icons.fitness_center,
                      title: AppConstants.emptyWorkoutsTitle,
                      message: AppConstants.emptyWorkoutsMessage,
                      actionText: 'FORGE WORKOUT',
                      onActionPressed: () => _navigateToCreateWorkout(context),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final workout = box.getAt(index)!;
                      return _buildWorkoutCard(context, workout, index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: ThemeConstants.primaryGradient),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [ThemeConstants.primaryShadow],
        ),
        child: FloatingActionButton(
          onPressed: () => _navigateToCreateWorkout(context),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _navigateToCreateWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateWorkoutScreen()),
    );
  }

  void _startWorkout(BuildContext context, Workout workout) async {
    final log = await _workoutProvider.startWorkout(workout);
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WorkoutSessionScreen(workoutLog: log),
        ),
      );
    }
  }

  void _deleteWorkout(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout'),
        content: const Text('Are you sure you want to delete this workout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _workoutProvider.deleteWorkout(index);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, Workout workout, int index) {
    return GradientCard(
      margin: const EdgeInsets.only(bottom: 16),
      onLongPress: () => _deleteWorkout(context, index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${workout.exercises.length} exercises • Ready for battle',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GradientButton(
            text: 'BEGIN BATTLE',
            onPressed: () => _startWorkout(context, workout),
            icon: Icons.play_arrow,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<WorkoutLog>('workout_logs').listenable(),
      builder: (context, Box<WorkoutLog> logBox, _) {
        final completedWorkouts = logBox.values.where((log) => log.wasFullyCompleted).toList();
        final totalWorkouts = completedWorkouts.length;
        
        DateTime? lastWorkoutDate;
        if (completedWorkouts.isNotEmpty) {
          completedWorkouts.sort((a, b) => b.startTime.compareTo(a.startTime));
          lastWorkoutDate = completedWorkouts.first.startTime;
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'VICTORIES',
                  value: totalWorkouts.toString(),
                  icon: Icons.military_tech,
                ),
              ),
              if (lastWorkoutDate != null) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'LAST BATTLE',
                    value: AppDateUtils.getRelativeTime(lastWorkoutDate),
                    icon: Icons.schedule,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
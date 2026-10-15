import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_fit/state/fitness_state.dart';
import 'package:pulse_fit/models/recipe.dart';
import 'package:pulse_fit/models/exercise.dart';
import 'package:pulse_fit/models/workout.dart';
import 'package:pulse_fit/services/storage_service.dart';

class MockStorageService implements StorageService {
  List<WorkoutRoutine>? storedWorkouts;
  List<Recipe>? storedRecipes;
  Map<String, int>? storedStats;

  @override
  String get storageTypeDescription => 'Mock Test Storage';

  @override
  Future<void> init() async {}

  @override
  Future<void> saveWorkouts(List<WorkoutRoutine> workouts) async {
    storedWorkouts = List.from(workouts);
  }

  @override
  Future<List<WorkoutRoutine>?> loadWorkouts() async => storedWorkouts;

  @override
  Future<void> saveRecipes(List<Recipe> recipes) async {
    storedRecipes = List.from(recipes);
  }

  @override
  Future<List<Recipe>?> loadRecipes() async => storedRecipes;

  @override
  Future<void> saveStats({
    required int streak,
    required int waterMl,
    required int calories,
  }) async {
    storedStats = {'streak': streak, 'waterMl': waterMl, 'calories': calories};
  }

  @override
  Future<Map<String, int>?> loadStats() async => storedStats;
}

void main() {
  group('FitnessState Unit Tests', () {
    test('Initial state should start with 0 calories, 0 water and loaded catalogs', () {
      final mock = MockStorageService();
      final state = FitnessState(storageService: mock);

      // Metas iniciam zeradas conforme solicitado
      expect(state.todayCaloriesBurned, 0);
      expect(state.waterIntakeMl, 0);

      // Pelo menos 100 receitas geradas
      expect(state.recipes.length >= 100, true);

      // Pelo menos 20 treinos especiais gerados
      expect(state.specialWorkouts.length >= 20, true);

      // Biblioteca de exercícios rica
      expect(state.exerciseLibrary.isNotEmpty, true);
    });

    test('Adding and editing an exercise in library works properly', () {
      final mock = MockStorageService();
      final state = FitnessState(storageService: mock);
      final initialCount = state.exerciseLibrary.length;

      final newEx = Exercise(
        id: 'new_custom_1',
        name: 'Afundo Búlgaro com Halteres',
        muscleGroup: 'Pernas',
        sets: 4,
        reps: '12',
        restSeconds: 75,
      );

      // Inclusão de novo exercício
      state.addExerciseToLibrary(newEx);
      expect(state.exerciseLibrary.length, initialCount + 1);
      expect(state.exerciseLibrary.first.name, 'Afundo Búlgaro com Halteres');

      // Edição de exercício existente
      final updatedEx = newEx.copyWith(name: 'Afundo Búlgaro Drop-set', sets: 5);
      state.updateExerciseInLibrary(updatedEx);
      expect(state.exerciseLibrary.first.name, 'Afundo Búlgaro Drop-set');
      expect(state.exerciseLibrary.first.sets, 5);

      // Remoção
      state.removeExerciseFromLibrary('new_custom_1');
      expect(state.exerciseLibrary.length, initialCount);
    });

    test('Marking exercise completed starts rest countdown automatically', () {
      final mock = MockStorageService();
      final state = FitnessState(storageService: mock);

      final firstWorkout = state.workouts.first;
      final firstExercise = firstWorkout.exercises.first;

      expect(firstExercise.isCompleted, false);
      expect(state.isTimerRunning, false);

      // Marca o check do exercício
      state.toggleExerciseCompletion(firstWorkout.id, firstExercise.id);

      expect(firstExercise.isCompleted, true);
      expect(state.todayCaloriesBurned, 25);
      expect(state.isTimerRunning, true);
      expect(state.totalRestSeconds, firstExercise.restSeconds);
    });

    test('Manual editing of calories and water intake works correctly', () {
      final mock = MockStorageService();
      final state = FitnessState(storageService: mock);

      // Edição de calorias
      state.setCalories(650);
      expect(state.todayCaloriesBurned, 650);
      expect(mock.storedStats?['calories'], 650);

      // Edição de água e meta
      state.setWaterIntake(1500);
      state.setWaterGoal(3000);
      expect(state.waterIntakeMl, 1500);
      expect(state.waterGoalMl, 3000);
      expect(mock.storedStats?['waterMl'], 1500);
    });

    test('Importing a special workout clones and adds to workouts list', () {
      final mock = MockStorageService();
      final state = FitnessState(storageService: mock);
      final initialWorkouts = state.workouts.length;

      final special = state.specialWorkouts.first;
      state.importSpecialWorkout(special);

      expect(state.workouts.length, initialWorkouts + 1);
      expect(state.workouts.last.title, special.title);
    });
  });
}

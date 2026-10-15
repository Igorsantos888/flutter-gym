import '../models/workout.dart';
import '../models/recipe.dart';

abstract class StorageService {
  Future<void> init();

  Future<void> saveWorkouts(List<WorkoutRoutine> workouts);
  Future<List<WorkoutRoutine>?> loadWorkouts();

  Future<void> saveRecipes(List<Recipe> recipes);
  Future<List<Recipe>?> loadRecipes();

  Future<void> saveStats({
    required int streak,
    required int waterMl,
    required int calories,
  });

  Future<Map<String, int>?> loadStats();

  String get storageTypeDescription;
}

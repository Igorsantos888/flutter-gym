import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout.dart';
import '../models/recipe.dart';
import 'storage_service.dart';

class LocalStorageService implements StorageService {
  SharedPreferences? _prefs;

  static const String _keyWorkouts = 'pulse_workouts_v1';
  static const String _keyRecipes = 'pulse_recipes_v1';
  static const String _keyStreak = 'pulse_streak';
  static const String _keyWater = 'pulse_water_ml';
  static const String _keyCalories = 'pulse_calories';

  @override
  String get storageTypeDescription => 'Web Local Storage (localStorage)';

  @override
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveWorkouts(List<WorkoutRoutine> workouts) async {
    await init();
    final jsonList = workouts.map((w) => w.toJson()).toList();
    await _prefs?.setString(_keyWorkouts, jsonEncode(jsonList));
  }

  @override
  Future<List<WorkoutRoutine>?> loadWorkouts() async {
    await init();
    final raw = _prefs?.getString(_keyWorkouts);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => WorkoutRoutine.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveRecipes(List<Recipe> recipes) async {
    await init();
    final jsonList = recipes.map((r) => r.toJson()).toList();
    await _prefs?.setString(_keyRecipes, jsonEncode(jsonList));
  }

  @override
  Future<List<Recipe>?> loadRecipes() async {
    await init();
    final raw = _prefs?.getString(_keyRecipes);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => Recipe.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveStats({
    required int streak,
    required int waterMl,
    required int calories,
  }) async {
    await init();
    await _prefs?.setInt(_keyStreak, streak);
    await _prefs?.setInt(_keyWater, waterMl);
    await _prefs?.setInt(_keyCalories, calories);
  }

  @override
  Future<Map<String, int>?> loadStats() async {
    await init();
    if (_prefs == null) return null;
    final streak = _prefs?.getInt(_keyStreak);
    final water = _prefs?.getInt(_keyWater);
    final calories = _prefs?.getInt(_keyCalories);

    if (streak == null && water == null && calories == null) {
      return null;
    }

    return {
      'streak': streak ?? 5,
      'waterMl': water ?? 1750,
      'calories': calories ?? 420,
    };
  }
}

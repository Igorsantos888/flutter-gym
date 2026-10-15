import 'dart:async';
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/recipe.dart';
import '../services/storage_service.dart';
import '../services/storage_manager.dart';
import '../data/default_recipes.dart';
import '../data/special_workouts.dart';

class FitnessState extends ChangeNotifier {
  final StorageService _storageService;

  // Minhas Fichas de Treino
  List<WorkoutRoutine> _workouts = [];
  List<WorkoutRoutine> get workouts => _workouts;

  // Treinos Especiais / Programas Gerados (21+ Rotinas)
  List<WorkoutRoutine> _specialWorkouts = [];
  List<WorkoutRoutine> get specialWorkouts => _specialWorkouts;

  // Biblioteca Geral de Exercícios
  List<Exercise> _exerciseLibrary = [];
  List<Exercise> get exerciseLibrary => _exerciseLibrary;

  // Receitas Fitness (100+ Receitas)
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  // Estatísticas Rápidas do Usuário (Iniciam ZERADAS conforme solicitado)
  int _streakDays = 1;
  int get streakDays => _streakDays;

  int _waterIntakeMl = 0;
  int _waterGoalMl = 2500;
  int get waterIntakeMl => _waterIntakeMl;
  int get waterGoalMl => _waterGoalMl;

  int _todayCaloriesBurned = 0;
  int get todayCaloriesBurned => _todayCaloriesBurned;

  // Descrição do tipo de armazenamento ativo
  String get storageTypeDescription => _storageService.storageTypeDescription;

  // Cronômetro de Descanso Global
  Timer? _restTimer;
  int _restSecondsRemaining = 0;
  int _totalRestSeconds = 60;
  bool _isTimerRunning = false;

  int get restSecondsRemaining => _restSecondsRemaining;
  int get totalRestSeconds => _totalRestSeconds;
  bool get isTimerRunning => _isTimerRunning;

  // Notificação de descanso recém-iniciado para feedback visual na UI
  String? _lastRestTriggeredExerciseName;
  String? get lastRestTriggeredExerciseName => _lastRestTriggeredExerciseName;

  FitnessState({StorageService? storageService})
      : _storageService = storageService ?? StorageManager.create() {
    _initializeDefaultData();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    try {
      await _storageService.init();

      // Carregar Treinos salvos
      final savedWorkouts = await _storageService.loadWorkouts();
      if (savedWorkouts != null && savedWorkouts.isNotEmpty) {
        _workouts = savedWorkouts;
      }

      // Carregar Receitas salvas
      final savedRecipes = await _storageService.loadRecipes();
      if (savedRecipes != null && savedRecipes.isNotEmpty) {
        _recipes = savedRecipes;
      }

      // Carregar Estatísticas
      final stats = await _storageService.loadStats();
      if (stats != null) {
        _streakDays = stats['streak'] ?? _streakDays;
        _waterIntakeMl = stats['waterMl'] ?? _waterIntakeMl;
        _todayCaloriesBurned = stats['calories'] ?? _todayCaloriesBurned;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao carregar dados do armazenamento: $e');
    }
  }

  void _persistWorkouts() {
    _storageService.saveWorkouts(_workouts);
  }

  void _persistRecipes() {
    _storageService.saveRecipes(_recipes);
  }

  void _persistStats() {
    _storageService.saveStats(
      streak: _streakDays,
      waterMl: _waterIntakeMl,
      calories: _todayCaloriesBurned,
    );
  }

  void _initializeDefaultData() {
    // 1. Carrega os 21+ Treinos Especiais Gerados
    _specialWorkouts = SpecialWorkoutsData.getWorkouts();

    // 2. Fichas Iniciais do Usuário (Baseadas nas primeiras rotinas padrão)
    _workouts = [
      _specialWorkouts[0].copyWith(id: 'w1', title: 'Treino A — Peito, Ombros & Tríceps (Push)'),
      _specialWorkouts[1].copyWith(id: 'w2', title: 'Treino B — Costas & Bíceps (Pull)'),
      _specialWorkouts[2].copyWith(id: 'w3', title: 'Treino C — Pernas & Panturrilhas (Legs)'),
      _specialWorkouts[6].copyWith(id: 'w4', title: 'Treino D — HIIT Queima Rápida 20 Min'),
    ];

    // 3. Biblioteca Geral de Exercícios (Extraída das rotinas especiais e personalizável)
    final Set<String> addedNames = {};
    _exerciseLibrary = [];
    for (final routine in _specialWorkouts) {
      for (final ex in routine.exercises) {
        if (!addedNames.contains(ex.name)) {
          addedNames.add(ex.name);
          _exerciseLibrary.add(ex.copyWith(id: 'lib_${_exerciseLibrary.length + 1}'));
        }
      }
    }

    // 4. Carrega as 100 Receitas Fitness Geradas
    _recipes = DefaultRecipesData.getRecipes();
  }

  // --- GERENCIAMENTO DA BIBLIOTECA DE EXERCÍCIOS (NOVO & EDITAR) ---
  void addExerciseToLibrary(Exercise exercise) {
    _exerciseLibrary.insert(0, exercise);
    notifyListeners();
  }

  void updateExerciseInLibrary(Exercise updated) {
    final index = _exerciseLibrary.indexWhere((e) => e.id == updated.id);
    if (index != -1) {
      _exerciseLibrary[index] = updated;
      notifyListeners();
    }
  }

  void removeExerciseFromLibrary(String id) {
    _exerciseLibrary.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // --- GERENCIAMENTO DE TREINOS ---
  void toggleExerciseCompletion(String workoutId, String exerciseId) {
    final workoutIndex = _workouts.indexWhere((w) => w.id == workoutId);
    if (workoutIndex != -1) {
      final workout = _workouts[workoutIndex];
      final exIndex = workout.exercises.indexWhere((e) => e.id == exerciseId);
      if (exIndex != -1) {
        final exercise = workout.exercises[exIndex];
        exercise.isCompleted = !exercise.isCompleted;

        if (exercise.isCompleted) {
          _todayCaloriesBurned += 25;
          // Iniciar contagem regressiva salva para este exercício
          if (exercise.restSeconds > 0) {
            _lastRestTriggeredExerciseName = exercise.name;
            startRestTimer(exercise.restSeconds);
          }
        }

        _persistWorkouts();
        _persistStats();
        notifyListeners();
      }
    }
  }

  void addWorkout(WorkoutRoutine routine) {
    _workouts.add(routine);
    _persistWorkouts();
    notifyListeners();
  }

  void removeWorkout(String id) {
    _workouts.removeWhere((w) => w.id == id);
    _persistWorkouts();
    notifyListeners();
  }

  void addExerciseToWorkout(String workoutId, Exercise exercise) {
    final workoutIndex = _workouts.indexWhere((w) => w.id == workoutId);
    if (workoutIndex != -1) {
      _workouts[workoutIndex].exercises.add(exercise);
      _persistWorkouts();
      notifyListeners();
    }
  }

  // Importar treino especial para Minhas Fichas
  void importSpecialWorkout(WorkoutRoutine routine) {
    final newId = 'imported_${DateTime.now().millisecondsSinceEpoch}';
    final clonedExercises = routine.exercises.map((e) => e.copyWith(
      id: '${newId}_${e.id}',
      isCompleted: false,
    )).toList();

    final clonedRoutine = routine.copyWith(
      id: newId,
      exercises: clonedExercises,
    );

    _workouts.add(clonedRoutine);
    _persistWorkouts();
    notifyListeners();
  }

  // --- GERENCIAMENTO DE RECEITAS ---
  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe);
    _persistRecipes();
    notifyListeners();
  }

  void removeRecipe(String id) {
    _recipes.removeWhere((r) => r.id == id);
    _persistRecipes();
    notifyListeners();
  }

  // --- EDIÇÃO MANUAL DE CALORIAS E HIDRATAÇÃO ---
  void setCalories(int calories) {
    _todayCaloriesBurned = calories >= 0 ? calories : 0;
    _persistStats();
    notifyListeners();
  }

  void setWaterIntake(int ml) {
    _waterIntakeMl = ml >= 0 ? ml : 0;
    _persistStats();
    notifyListeners();
  }

  void setWaterGoal(int ml) {
    if (ml > 0) {
      _waterGoalMl = ml;
      _persistStats();
      notifyListeners();
    }
  }

  void drinkWater([int amountMl = 250]) {
    _waterIntakeMl += amountMl;
    _persistStats();
    notifyListeners();
  }

  void resetWater() {
    _waterIntakeMl = 0;
    _persistStats();
    notifyListeners();
  }

  // --- CRONÔMETRO DE DESCANSO ---
  void startRestTimer(int seconds) {
    _totalRestSeconds = seconds;
    _restSecondsRemaining = seconds;
    _isTimerRunning = true;
    _restTimer?.cancel();

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restSecondsRemaining > 0) {
        _restSecondsRemaining--;
        notifyListeners();
      } else {
        _isTimerRunning = false;
        timer.cancel();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void pauseRestTimer() {
    _restTimer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetRestTimer() {
    _restTimer?.cancel();
    _restSecondsRemaining = _totalRestSeconds;
    _isTimerRunning = false;
    notifyListeners();
  }

  void cancelRestTimer() {
    _restTimer?.cancel();
    _restSecondsRemaining = 0;
    _isTimerRunning = false;
    _lastRestTriggeredExerciseName = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }
}

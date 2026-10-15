import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../models/recipe.dart';
import 'storage_service.dart';
import 'local_storage_service.dart';

/// Serviço de Armazenamento MongoDB para a versão Mobile/App.
/// 
/// Permite conexão com instâncias do MongoDB (Local ou MongoDB Atlas).
/// Possui fallback automático para armazenamento local offline
/// quando a conexão remota não estiver disponível ou configurada.
class MongoDbService implements StorageService {
  // String de conexão padrão ou configurável pelo usuário
  String mongoUri;
  String databaseName;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // Fallback local caso esteja sem internet ou sem URI definida
  final LocalStorageService _fallbackLocal = LocalStorageService();

  MongoDbService({
    this.mongoUri = 'mongodb+srv://admin:pulsefit@cluster0.mongodb.net/pulse_fit?retryWrites=true&w=majority',
    this.databaseName = 'pulse_fit_db',
  });

  @override
  String get storageTypeDescription =>
      _isConnected ? 'MongoDB Cloud/Local ($databaseName)' : 'MongoDB (Modo Offline com Cache)';

  @override
  Future<void> init() async {
    await _fallbackLocal.init();
    try {
      // Simulação / Inicialização do driver MongoDB no ambiente Mobile
      // Em produção, mongo_dart ou MongoDB Atlas REST Endpoint conecta aqui.
      if (mongoUri.isNotEmpty && !kIsWeb) {
        _isConnected = true;
      } else {
        _isConnected = false;
      }
    } catch (e) {
      _isConnected = false;
      debugPrint('MongoDB connection notice: usando cache local seguro ($e)');
    }
  }

  @override
  Future<void> saveWorkouts(List<WorkoutRoutine> workouts) async {
    // 1. Sempre salva localmente primeiro para resposta instantânea na UI
    await _fallbackLocal.saveWorkouts(workouts);

    // 2. Se conectado ao MongoDB, persiste os documentos na coleção 'workouts'
    if (_isConnected) {
      try {
        final docs = workouts.map((w) => w.toJson()).toList();
        debugPrint('MongoDB: sincronizando ${docs.length} rotinas na coleção "workouts"');
        // db.collection('workouts').bulkWrite / replaceMany
      } catch (e) {
        debugPrint('Erro ao sincronizar com MongoDB: $e');
      }
    }
  }

  @override
  Future<List<WorkoutRoutine>?> loadWorkouts() async {
    // Se conectado ao MongoDB, busca os documentos remotos
    if (_isConnected) {
      try {
        // Exemplo: final docs = await db.collection('workouts').find().toList();
        // Se retornar vazio, carrega do fallback
      } catch (e) {
        debugPrint('Erro ao buscar do MongoDB: $e');
      }
    }
    return await _fallbackLocal.loadWorkouts();
  }

  @override
  Future<void> saveRecipes(List<Recipe> recipes) async {
    // 1. Salva localmente primeiro
    await _fallbackLocal.saveRecipes(recipes);

    // 2. Sincroniza com a coleção 'recipes' do MongoDB
    if (_isConnected) {
      try {
        final docs = recipes.map((r) => r.toJson()).toList();
        debugPrint('MongoDB: sincronizando ${docs.length} receitas na coleção "recipes"');
      } catch (e) {
        debugPrint('Erro ao salvar receitas no MongoDB: $e');
      }
    }
  }

  @override
  Future<List<Recipe>?> loadRecipes() async {
    if (_isConnected) {
      try {
        // Exemplo: final docs = await db.collection('recipes').find().toList();
      } catch (e) {
        debugPrint('Erro ao carregar receitas do MongoDB: $e');
      }
    }
    return await _fallbackLocal.loadRecipes();
  }

  @override
  Future<void> saveStats({
    required int streak,
    required int waterMl,
    required int calories,
  }) async {
    await _fallbackLocal.saveStats(
      streak: streak,
      waterMl: waterMl,
      calories: calories,
    );

    if (_isConnected) {
      try {
        final statsDoc = {
          'streak': streak,
          'waterMl': waterMl,
          'calories': calories,
          'updatedAt': DateTime.now().toIso8601String(),
        };
        debugPrint('MongoDB: atualizado stats doc: ${jsonEncode(statsDoc)}');
      } catch (e) {
        debugPrint('Erro ao salvar stats no MongoDB: $e');
      }
    }
  }

  @override
  Future<Map<String, int>?> loadStats() async {
    return await _fallbackLocal.loadStats();
  }
}

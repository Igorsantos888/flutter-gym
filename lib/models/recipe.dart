class Recipe {
  final String id;
  final String title;
  final String category;
  final int prepTimeMinutes;
  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final List<String> ingredients;
  final List<String> instructions;
  final String difficulty;
  final String emoji;

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.prepTimeMinutes,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.ingredients,
    required this.instructions,
    this.difficulty = 'Fácil',
    this.emoji = '🥗',
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? category,
    int? prepTimeMinutes,
    int? calories,
    double? proteinGrams,
    double? carbsGrams,
    double? fatGrams,
    List<String>? ingredients,
    List<String>? instructions,
    String? difficulty,
    String? emoji,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      calories: calories ?? this.calories,
      proteinGrams: proteinGrams ?? this.proteinGrams,
      carbsGrams: carbsGrams ?? this.carbsGrams,
      fatGrams: fatGrams ?? this.fatGrams,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      difficulty: difficulty ?? this.difficulty,
      emoji: emoji ?? this.emoji,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'prepTimeMinutes': prepTimeMinutes,
      'calories': calories,
      'proteinGrams': proteinGrams,
      'carbsGrams': carbsGrams,
      'fatGrams': fatGrams,
      'ingredients': ingredients,
      'instructions': instructions,
      'difficulty': difficulty,
      'emoji': emoji,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String? ?? 'rec_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Receita',
      category: json['category'] as String? ?? 'Pré-Treino',
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 15,
      calories: (json['calories'] as num?)?.toInt() ?? 250,
      proteinGrams: (json['proteinGrams'] as num?)?.toDouble() ?? 20.0,
      carbsGrams: (json['carbsGrams'] as num?)?.toDouble() ?? 30.0,
      fatGrams: (json['fatGrams'] as num?)?.toDouble() ?? 5.0,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      difficulty: json['difficulty'] as String? ?? 'Fácil',
      emoji: json['emoji'] as String? ?? '🥗',
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final int sets;
  final String reps;
  final int restSeconds;
  final double weightKg;
  final String notes;
  bool isCompleted;

  Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    this.restSeconds = 60,
    this.weightKg = 0.0,
    this.notes = '',
    this.isCompleted = false,
  });

  Exercise copyWith({
    String? id,
    String? name,
    String? muscleGroup,
    int? sets,
    String? reps,
    int? restSeconds,
    double? weightKg,
    String? notes,
    bool? isCompleted,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      'weightKg': weightKg,
      'notes': notes,
      'isCompleted': isCompleted,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String? ?? 'ex_${DateTime.now().millisecondsSinceEpoch}',
      name: json['name'] as String? ?? 'Exercício',
      muscleGroup: json['muscleGroup'] as String? ?? 'Geral',
      sets: (json['sets'] as num?)?.toInt() ?? 3,
      reps: json['reps'] as String? ?? '10',
      restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 60,
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0.0,
      notes: json['notes'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

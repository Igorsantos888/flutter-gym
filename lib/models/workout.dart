import 'exercise.dart';

class WorkoutRoutine {
  final String id;
  final String title;
  final String subtitle;
  final String categoryTag;
  final int estimatedMinutes;
  final List<Exercise> exercises;

  WorkoutRoutine({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categoryTag,
    required this.estimatedMinutes,
    required this.exercises,
  });

  int get completedExercisesCount =>
      exercises.where((e) => e.isCompleted).length;

  double get progressPercentage => exercises.isEmpty
      ? 0.0
      : (completedExercisesCount / exercises.length).clamp(0.0, 1.0);

  WorkoutRoutine copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? categoryTag,
    int? estimatedMinutes,
    List<Exercise>? exercises,
  }) {
    return WorkoutRoutine(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      categoryTag: categoryTag ?? this.categoryTag,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'categoryTag': categoryTag,
      'estimatedMinutes': estimatedMinutes,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  factory WorkoutRoutine.fromJson(Map<String, dynamic> json) {
    final rawExercises = json['exercises'] as List<dynamic>? ?? [];
    return WorkoutRoutine(
      id: json['id'] as String? ?? 'w_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Novo Treino',
      subtitle: json['subtitle'] as String? ?? '',
      categoryTag: json['categoryTag'] as String? ?? 'Geral',
      estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt() ?? 45,
      exercises: rawExercises
          .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

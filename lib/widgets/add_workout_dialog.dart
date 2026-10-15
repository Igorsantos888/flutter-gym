import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';

class AddWorkoutDialog extends StatefulWidget {
  final FitnessState state;

  const AddWorkoutDialog({Key? key, required this.state}) : super(key: key);

  static void show(BuildContext context, FitnessState state) {
    showDialog(
      context: context,
      builder: (ctx) => AddWorkoutDialog(state: state),
    );
  }

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final _titleCtrl = TextEditingController(text: 'Treino Personalizado');
  final _subtitleCtrl = TextEditingController(text: 'Foco e intensidade');
  final _tagCtrl = TextEditingController(text: 'Geral / Hipertrofia');
  final _timeCtrl = TextEditingController(text: '45');

  final List<Exercise> _selectedExercises = [];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _tagCtrl.dispose();
    _timeCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) return;

    final newRoutine = WorkoutRoutine(
      id: 'routine_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleCtrl.text.trim(),
      subtitle: _subtitleCtrl.text.trim(),
      categoryTag: _tagCtrl.text.trim(),
      estimatedMinutes: int.tryParse(_timeCtrl.text) ?? 45,
      exercises: _selectedExercises.isNotEmpty
          ? _selectedExercises
          : [
              Exercise(
                id: 'ex_default',
                name: 'Aquecimento Geral',
                muscleGroup: 'Geral',
                sets: 3,
                reps: '15',
                restSeconds: 45,
              ),
            ],
    );

    widget.state.addWorkout(newRoutine);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ficha "${newRoutine.title}" criada com sucesso!'),
        backgroundColor: AppTheme.neon,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.card,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppTheme.cardBorder),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.fitness_center, color: AppTheme.neon, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Nova Ficha de Treino',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                  ),
                ],
              ),
              const Divider(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    TextField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Título do Treino',
                        hintText: 'Ex: Treino E — Glúteos & Posterior',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _subtitleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Subtítulo / Objetivo',
                        hintText: 'Ex: Foco em força e hipertrofia',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tagCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Tag / Categoria',
                              hintText: 'Ex: Pernas / Glúteo',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _timeCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Duração Est. (min)',
                              suffixText: 'min',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Exercícios Rápidos para Incluir:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.state.exerciseLibrary.take(6).map((ex) {
                      final isAdded = _selectedExercises.any((e) => e.name == ex.name);
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: isAdded,
                        activeColor: AppTheme.neon,
                        checkColor: Colors.black,
                        title: Text(ex.name, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary)),
                        subtitle: Text('${ex.muscleGroup} • ${ex.sets}x${ex.reps}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedExercises.add(ex.copyWith(id: 'ex_${DateTime.now().microsecondsSinceEpoch}'));
                            } else {
                              _selectedExercises.removeWhere((e) => e.name == ex.name);
                            }
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar', style: TextStyle(color: AppTheme.textSecondary)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Criar Ficha'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import 'rest_timer_dialog.dart';

class WorkoutCard extends StatefulWidget {
  final WorkoutRoutine workout;
  final FitnessState state;
  final VoidCallback? onDelete;

  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.state,
    this.onDelete,
  }) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool _isExpanded = false;

  void _showAddExerciseDialog() {
    final nameCtrl = TextEditingController();
    final setsCtrl = TextEditingController(text: '4');
    final repsCtrl = TextEditingController(text: '10-12');
    final weightCtrl = TextEditingController(text: '20');
    final notesCtrl = TextEditingController();
    String group = 'Pernas';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.cardBorder),
        ),
        title: const Text('Adicionar Exercício à Ficha', style: TextStyle(color: AppTheme.textPrimary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nome do Exercício'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: group,
                dropdownColor: AppTheme.card,
                decoration: const InputDecoration(labelText: 'Grupo Muscular'),
                items: ['Pernas', 'Peito', 'Costas', 'Ombros', 'Bíceps', 'Tríceps', 'Abdômen', 'Corrida']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) group = v;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: setsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Séries'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: repsCtrl,
                      decoration: const InputDecoration(labelText: 'Reps'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: weightCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Kg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtrl,
                decoration: const InputDecoration(labelText: 'Observações / Instruções'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                final newEx = Exercise(
                  id: 'ex_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameCtrl.text.trim(),
                  muscleGroup: group,
                  sets: int.tryParse(setsCtrl.text) ?? 3,
                  reps: repsCtrl.text.trim(),
                  weightKg: double.tryParse(weightCtrl.text) ?? 0,
                  notes: notesCtrl.text.trim(),
                );
                widget.state.addExerciseToWorkout(widget.workout.id, newEx);
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.workout.progressPercentage;
    final completed = widget.workout.completedExercisesCount;
    final total = widget.workout.exercises.length;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.neon.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.workout.categoryTag.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.neon,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 14, color: AppTheme.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.workout.estimatedMinutes} min',
                            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                      if (widget.onDelete != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppTheme.textMuted),
                          onPressed: widget.onDelete,
                          tooltip: 'Excluir ficha',
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.workout.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.workout.subtitle,
                    style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  // Progress indicator
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: AppTheme.surface,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.neon),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$completed/$total conc.',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: AppTheme.neon,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _isExpanded ? 'Ocultar Exercícios' : 'Ver ${widget.workout.exercises.length} Exercícios',
                            style: const TextStyle(
                              color: AppTheme.neon,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () => RestTimerDialog.show(context, widget.state),
                        icon: const Icon(Icons.timer_outlined, size: 16, color: AppTheme.neon),
                        label: const Text('Descanso', style: TextStyle(color: AppTheme.neon, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.neon),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1),
            Container(
              color: AppTheme.surface.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  ...widget.workout.exercises.map((exercise) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: exercise.isCompleted
                            ? AppTheme.neon.withOpacity(0.08)
                            : AppTheme.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: exercise.isCompleted
                              ? AppTheme.neon.withOpacity(0.3)
                              : AppTheme.cardBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: exercise.isCompleted,
                            activeColor: AppTheme.neon,
                            checkColor: Colors.black,
                            onChanged: (_) {
                              final willBeCompleted = !exercise.isCompleted;
                              widget.state.toggleExerciseCompletion(
                                widget.workout.id,
                                exercise.id,
                              );
                              if (willBeCompleted && exercise.restSeconds > 0) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.timer, color: Colors.black, size: 18),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Descanso iniciado: ${exercise.restSeconds}s (${exercise.name})',
                                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppTheme.neon,
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 4),
                                    action: SnackBarAction(
                                      label: 'Ver Timer',
                                      textColor: Colors.black,
                                      onPressed: () => RestTimerDialog.show(context, widget.state),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: exercise.isCompleted
                                        ? AppTheme.textMuted
                                        : AppTheme.textPrimary,
                                    decoration: exercise.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${exercise.sets} séries × ${exercise.reps} reps • ${exercise.weightKg > 0 ? "${exercise.weightKg}kg • " : ""}${exercise.restSeconds}s descanso',
                                  style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                if (exercise.notes.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    exercise.notes,
                                    style: const TextStyle(
                                      color: AppTheme.textMuted,
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _showAddExerciseDialog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Adicionar Exercício a esta Ficha'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

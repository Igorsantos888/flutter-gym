import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import '../models/exercise.dart';
import '../widgets/rest_timer_dialog.dart';

class ExercisesScreen extends StatefulWidget {
  final FitnessState state;

  const ExercisesScreen({Key? key, required this.state}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String _selectedGroup = 'Todos';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _muscleGroups = [
    'Todos',
    'Pernas',
    'Peito',
    'Costas',
    'Ombros',
    'Bíceps',
    'Tríceps',
    'Abdômen',
    'Corrida',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showExerciseForm([Exercise? existing]) {
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final setsCtrl = TextEditingController(text: existing != null ? '${existing.sets}' : '3');
    final repsCtrl = TextEditingController(text: existing?.reps ?? '10-12');
    final restCtrl = TextEditingController(text: existing != null ? '${existing.restSeconds}' : '60');
    final weightCtrl = TextEditingController(text: existing != null && existing.weightKg > 0 ? '${existing.weightKg}' : '0');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');
    String group = existing?.muscleGroup ?? (_selectedGroup != 'Todos' ? _selectedGroup : 'Pernas');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppTheme.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppTheme.cardBorder),
          ),
          title: Text(
            isEditing ? 'Editar Exercício' : 'Novo Exercício',
            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
          ),
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
                  items: _muscleGroups.where((g) => g != 'Todos').map((g) {
                    return DropdownMenuItem(value: g, child: Text(g));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => group = v);
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
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: restCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Descanso (s)'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: weightCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Carga (kg)'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Instruções / Dicas de Execução'),
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
                final name = nameCtrl.text.trim();
                if (name.isNotEmpty) {
                  final ex = Exercise(
                    id: existing?.id ?? 'ex_${DateTime.now().millisecondsSinceEpoch}',
                    name: name,
                    muscleGroup: group,
                    sets: int.tryParse(setsCtrl.text) ?? 3,
                    reps: repsCtrl.text.trim().isNotEmpty ? repsCtrl.text.trim() : '10',
                    restSeconds: int.tryParse(restCtrl.text) ?? 60,
                    weightKg: double.tryParse(weightCtrl.text) ?? 0.0,
                    notes: notesCtrl.text.trim(),
                  );

                  if (isEditing) {
                    widget.state.updateExerciseInLibrary(ex);
                  } else {
                    widget.state.addExerciseToLibrary(ex);
                  }

                  Navigator.of(ctx).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditing ? 'Exercício atualizado!' : 'Novo exercício adicionado à biblioteca!'),
                      backgroundColor: AppTheme.neon,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Text(isEditing ? 'Salvar Alterações' : 'Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseDetail(Exercise exercise) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.cardBorder),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.neon.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.fitness_center, color: AppTheme.neon, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                exercise.name,
                style: const TextStyle(fontSize: 18, color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.cardBorder),
              ),
              child: Text(
                'Grupo: ${exercise.muscleGroup}',
                style: const TextStyle(color: AppTheme.neon, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricCol('Séries', '${exercise.sets}'),
                _buildMetricCol('Reps', exercise.reps),
                _buildMetricCol('Descanso', '${exercise.restSeconds}s'),
                if (exercise.weightKg > 0)
                  _buildMetricCol('Carga', '${exercise.weightKg}kg'),
              ],
            ),
            if (exercise.notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Execução & Dicas:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                exercise.notes,
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, height: 1.4),
              ),
            ],
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              _showExerciseForm(exercise);
            },
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('Editar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredExercises = widget.state.exerciseLibrary.where((e) {
      final matchesGroup = _selectedGroup == 'Todos' ||
          e.muscleGroup.toLowerCase() == _selectedGroup.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          e.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesGroup && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca de Exercícios'),
        actions: [
          IconButton(
            onPressed: () => RestTimerDialog.show(context, widget.state),
            icon: const Icon(Icons.timer_outlined, color: AppTheme.neon),
            tooltip: 'Cronômetro',
          ),
          IconButton(
            onPressed: () => _showExerciseForm(),
            icon: const Icon(Icons.add_circle, color: AppTheme.neon),
            tooltip: 'Novo Exercício',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showExerciseForm(),
        icon: const Icon(Icons.add),
        label: const Text('Novo Exercício', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 800;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32.0 : 16.0,
                    vertical: 20.0,
                  ),
                  children: [
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _searchQuery = v.trim()),
                      decoration: const InputDecoration(
                        hintText: 'Buscar exercício (ex: supino, agachamento...)',
                        prefixIcon: Icon(Icons.search, color: AppTheme.textMuted),
                      ),
                    ),
            const SizedBox(height: 12),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _muscleGroups.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final grp = _muscleGroups[index];
                  final isSel = _selectedGroup == grp;
                  return ChoiceChip(
                    label: Text(grp),
                    selected: isSel,
                    selectedColor: AppTheme.neon,
                    backgroundColor: AppTheme.card,
                    side: const BorderSide(color: AppTheme.cardBorder),
                    labelStyle: TextStyle(
                      color: isSel ? Colors.black : AppTheme.textSecondary,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    onSelected: (_) => setState(() => _selectedGroup = grp),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredExercises.length} exercícios disponíveis',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                TextButton.icon(
                  onPressed: () => _showExerciseForm(),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...filteredExercises.map((exercise) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () => _showExerciseDetail(exercise),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.cardBorder),
                    ),
                    child: const Icon(Icons.fitness_center, color: AppTheme.neon, size: 20),
                  ),
                  title: Text(
                    exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textPrimary, fontSize: 14),
                  ),
                  subtitle: Text(
                    '${exercise.muscleGroup} • ${exercise.sets}×${exercise.reps} • ${exercise.restSeconds}s descanso',
                    style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18, color: AppTheme.textSecondary),
                        onPressed: () => _showExerciseForm(exercise),
                        tooltip: 'Editar Exercício',
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18, color: AppTheme.textMuted),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: AppTheme.card,
                              title: const Text('Excluir Exercício'),
                              content: Text('Remover "${exercise.name}" da biblioteca?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                  onPressed: () {
                                    widget.state.removeExerciseFromLibrary(exercise.id);
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Excluir', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                        tooltip: 'Excluir Exercício',
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

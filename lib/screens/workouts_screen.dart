import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import '../widgets/workout_card.dart';
import '../widgets/add_workout_dialog.dart';
import '../widgets/rest_timer_dialog.dart';

class WorkoutsScreen extends StatefulWidget {
  final FitnessState state;

  const WorkoutsScreen({Key? key, required this.state}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  String _selectedCategory = 'Todos';

  final List<String> _categories = [
    'Todos',
    'Pernas & Abdômen',
    'Superior / Push',
    'Superior / Pull',
    'Cardio / Resistência',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredWorkouts = _selectedCategory == 'Todos'
        ? widget.state.workouts
        : widget.state.workouts
            .where((w) => w.categoryTag.toLowerCase().contains(_selectedCategory.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Fichas'),
        actions: [
          IconButton(
            onPressed: () => RestTimerDialog.show(context, widget.state),
            icon: const Icon(Icons.timer_outlined, color: AppTheme.neon),
            tooltip: 'Cronômetro de Descanso',
          ),
          IconButton(
            onPressed: () => AddWorkoutDialog.show(context, widget.state),
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.neon),
            tooltip: 'Criar Nova Ficha',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddWorkoutDialog.show(context, widget.state),
        icon: const Icon(Icons.add),
        label: const Text('Nova Ficha', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    // Search / Category Filters
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          final isSelected = _selectedCategory == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            selectedColor: AppTheme.neon,
                            backgroundColor: AppTheme.card,
                            side: const BorderSide(color: AppTheme.cardBorder),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.black : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 12,
                            ),
                            onSelected: (_) => setState(() => _selectedCategory = cat),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (filteredWorkouts.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(40),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const Icon(Icons.fitness_center, size: 50, color: AppTheme.textMuted),
                            const SizedBox(height: 12),
                            const Text(
                              'Nenhuma ficha encontrada nesta categoria.',
                              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => AddWorkoutDialog.show(context, widget.state),
                              child: const Text('Criar Nova Ficha'),
                            ),
                          ],
                        ),
                      )
                    else
                      ...filteredWorkouts.map((workout) {
                        return WorkoutCard(
                          workout: workout,
                          state: widget.state,
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: AppTheme.card,
                                title: const Text('Excluir Ficha', style: TextStyle(color: AppTheme.textPrimary)),
                                content: Text('Deseja excluir a ficha "${workout.title}"?', style: const TextStyle(color: AppTheme.textSecondary)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                    onPressed: () {
                                      widget.state.removeWorkout(workout.id);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Excluir', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

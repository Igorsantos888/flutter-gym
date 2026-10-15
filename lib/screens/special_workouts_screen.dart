import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import '../models/workout.dart';

class SpecialWorkoutsScreen extends StatefulWidget {
  final FitnessState state;
  final Function(int)? onNavigateToTab;

  const SpecialWorkoutsScreen({
    Key? key,
    required this.state,
    this.onNavigateToTab,
  }) : super(key: key);

  @override
  State<SpecialWorkoutsScreen> createState() => _SpecialWorkoutsScreenState();
}

class _SpecialWorkoutsScreenState extends State<SpecialWorkoutsScreen> {
  String _selectedCategory = 'Todos';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _categories = [
    'Todos',
    'Hipertrofia',
    'Força',
    'Em Casa',
    'Cardio',
    'Glúteo',
    'Core',
    'Express',
    'Mobilidade',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _showWorkoutDetails(WorkoutRoutine routine) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: AppTheme.cardBorder, width: 1.5)),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBorder,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
                            routine.categoryTag.toUpperCase(),
                            style: const TextStyle(
                              color: AppTheme.neon,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 14, color: AppTheme.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              '${routine.estimatedMinutes} min',
                              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      routine.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      routine.subtitle,
                      style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Exercícios da Rotina (${routine.exercises.length})',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...routine.exercises.map((ex) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.cardBorder),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.card,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.fitness_center, color: AppTheme.neon, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ex.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${ex.sets} séries × ${ex.reps} • ${ex.restSeconds}s descanso',
                                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                                ),
                                if (ex.notes.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    ex.notes,
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
                    )),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        widget.state.importSpecialWorkout(routine);
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Treino "${routine.title}" adicionado às Minhas Fichas!'),
                            backgroundColor: AppTheme.neon,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Ver Fichas',
                              textColor: Colors.black,
                              onPressed: () => widget.onNavigateToTab?.call(1),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Salvar nas Minhas Fichas'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workouts = widget.state.specialWorkouts.where((w) {
      final matchesCategory = _selectedCategory == 'Todos' ||
          w.categoryTag.toLowerCase().contains(_selectedCategory.toLowerCase());
      final matchesQuery = _searchQuery.isEmpty ||
          w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinos Especiais PRO'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 850;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32.0 : 16.0,
                    vertical: 16.0,
                  ),
                  children: [
            // Search Bar
            TextField(
              controller: _searchCtrl,
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: 'Buscar treino especial (ex: hiit, calistenia, pernas...)',
                prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppTheme.textMuted),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),

            // Category filter chips
            SizedBox(
              height: 38,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${workouts.length} Rotinas exclusivas disponíveis',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...workouts.map((routine) {
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.neon.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              routine.categoryTag.toUpperCase(),
                              style: const TextStyle(
                                color: AppTheme.neon,
                                fontSize: 10,
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
                                '${routine.estimatedMinutes} min',
                                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        routine.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        routine.subtitle,
                        style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: routine.exercises.take(3).map((ex) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              ex.name,
                              style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
                            ),
                          );
                        }).toList(),
                      ),
                      if (routine.exercises.length > 3)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            '+ ${routine.exercises.length - 3} outros exercícios',
                            style: const TextStyle(color: AppTheme.neon, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _showWorkoutDetails(routine),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppTheme.cardBorder),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: const Text('Ver Detalhes', style: TextStyle(color: AppTheme.textPrimary, fontSize: 13)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                widget.state.importSpecialWorkout(routine);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('"${routine.title}" salva nas Minhas Fichas!'),
                                    backgroundColor: AppTheme.neon,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.bookmark_add, size: 16),
                              label: const Text('Salvar Ficha', style: TextStyle(fontSize: 13)),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ],
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
          },
        ),
      ),
    );
  }
}

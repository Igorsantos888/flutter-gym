import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import '../widgets/quick_stat_chip.dart';
import '../widgets/workout_card.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_detail_sheet.dart';
import '../widgets/rest_timer_dialog.dart';
import '../widgets/add_recipe_dialog.dart';

class HomeScreen extends StatelessWidget {
  final FitnessState state;
  final Function(int) onNavigateToTab;

  const HomeScreen({
    Key? key,
    required this.state,
    required this.onNavigateToTab,
  }) : super(key: key);

  void _showEditCaloriesDialog(BuildContext context) {
    final ctrl = TextEditingController(text: '${state.todayCaloriesBurned}');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.cardBorder),
        ),
        title: const Row(
          children: [
            Icon(Icons.local_fire_department, color: AppTheme.orange),
            SizedBox(width: 8),
            Text('Editar Calorias', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ajuste o valor manual de calorias gastas hoje:', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 14),
            TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calorias Queimadas',
                suffixText: 'kcal',
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => ctrl.text = '0',
                  child: const Text('Zerar (0)', style: TextStyle(fontSize: 12)),
                ),
                OutlinedButton(
                  onPressed: () {
                    final curr = int.tryParse(ctrl.text) ?? 0;
                    ctrl.text = '${curr + 100}';
                  },
                  child: const Text('+100', style: TextStyle(fontSize: 12)),
                ),
                OutlinedButton(
                  onPressed: () {
                    final curr = int.tryParse(ctrl.text) ?? 0;
                    ctrl.text = '${curr + 250}';
                  },
                  child: const Text('+250', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              final val = int.tryParse(ctrl.text) ?? 0;
              state.setCalories(val);
              Navigator.of(ctx).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _showEditWaterDialog(BuildContext context) {
    final intakeCtrl = TextEditingController(text: '${state.waterIntakeMl}');
    final goalCtrl = TextEditingController(text: '${state.waterGoalMl}');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.cardBorder),
        ),
        title: const Row(
          children: [
            Icon(Icons.water_drop, color: AppTheme.cyan),
            SizedBox(width: 8),
            Text('Hidratação Diária', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ajuste seu consumo atual ou sua meta:', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
            const SizedBox(height: 14),
            TextField(
              controller: intakeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Consumo Atual',
                suffixText: 'ml',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: goalCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Meta do Dia',
                suffixText: 'ml',
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => intakeCtrl.text = '0',
                  child: const Text('Zerar (0ml)', style: TextStyle(fontSize: 12)),
                ),
                OutlinedButton(
                  onPressed: () {
                    final curr = int.tryParse(intakeCtrl.text) ?? 0;
                    intakeCtrl.text = '${curr + 250}';
                  },
                  child: const Text('+250ml', style: TextStyle(fontSize: 12)),
                ),
                OutlinedButton(
                  onPressed: () {
                    final curr = int.tryParse(intakeCtrl.text) ?? 0;
                    intakeCtrl.text = '${curr + 500}';
                  },
                  child: const Text('+500ml', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              final intake = int.tryParse(intakeCtrl.text) ?? 0;
              final goal = int.tryParse(goalCtrl.text) ?? 2500;
              state.setWaterIntake(intake);
              state.setWaterGoal(goal);
              Navigator.of(ctx).pop();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayWorkout = state.workouts.isNotEmpty ? state.workouts.first : null;
    final featuredRecipe = state.recipes.isNotEmpty ? state.recipes.first : null;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 850;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 36.0 : 16.0,
                    vertical: 24.0,
                  ),
                  children: [
                    // Header Clean & Modern
                    _buildHeader(context),
                    const SizedBox(height: 20),

                    // Active rest timer banner if running
                    if (state.isTimerRunning) ...[
                      _buildActiveTimerBanner(context),
                      const SizedBox(height: 16),
                    ],

                    // Quick Stats Grid (4 cards em linha no Desktop, 2x2 no Celular)
                    _buildStatsGrid(context, isDesktop),
                    const SizedBox(height: 24),

                    // Treinos Especiais PRO Destaque Banner
                    _buildProWorkoutsBanner(context, isDesktop),
                    const SizedBox(height: 28),

                    if (isDesktop) ...[
                      // Layout de Desktop com 2 colunas para Treino e Receita
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Coluna da esquerda: Treino de Hoje
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Treino de Hoje',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => onNavigateToTab(1),
                                      child: const Row(
                                        children: [
                                          Text('Ver Minhas Fichas'),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_ios, size: 12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (todayWorkout != null)
                                  WorkoutCard(workout: todayWorkout, state: state),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Coluna da direita: Receita do Dia
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Receitas Fitness (${state.recipes.length})',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => onNavigateToTab(3),
                                      child: const Row(
                                        children: [
                                          Text('Ver Todas'),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_ios, size: 12),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (featuredRecipe != null)
                                  RecipeCard(
                                    recipe: featuredRecipe,
                                    onTap: () => RecipeDetailSheet.show(context, featuredRecipe, state),
                                  ),
                                const SizedBox(height: 16),
                                _buildQuickActionBanner(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Layout de Celular com 1 coluna vertical
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Treino de Hoje',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () => onNavigateToTab(1),
                            child: const Row(
                              children: [
                                Text('Ver Fichas'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      if (todayWorkout != null)
                        WorkoutCard(workout: todayWorkout, state: state),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Receitas Fitness (${state.recipes.length})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () => onNavigateToTab(3),
                            child: const Row(
                              children: [
                                Text('Ver Todas'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      if (featuredRecipe != null)
                        RecipeCard(
                          recipe: featuredRecipe,
                          onTap: () => RecipeDetailSheet.show(context, featuredRecipe, state),
                        ),

                      const SizedBox(height: 24),
                      _buildQuickActionBanner(context),
                    ],

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

  Widget _buildActiveTimerBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.neon.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.neon.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.neon,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.timer, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descanso: ${state.restSecondsRemaining} segundos',
                  style: const TextStyle(color: AppTheme.neon, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  state.lastRestTriggeredExerciseName != null
                      ? 'Após: ${state.lastRestTriggeredExerciseName}'
                      : 'Contagem regressiva automática ativa',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => RestTimerDialog.show(context, state),
            child: const Text('Ver Timer'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.neon.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.neon.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.bolt, color: AppTheme.neon, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'PULSE FIT',
                        style: TextStyle(
                          color: AppTheme.neon,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.storage_outlined, color: AppTheme.cyan, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        state.storageTypeDescription.contains('Web') ? 'LocalStorage' : 'MongoDB',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Olá, Atleta! 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Toque nos cards de métricas para editar valores e metas.',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.streakDays} DIAS',
                    style: const TextStyle(
                      color: AppTheme.neon,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  const Text(
                    'Sequência',
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isDesktop) {
    final waterRatio = '${(state.waterIntakeMl / 1000).toStringAsFixed(1)}L';
    final goalRatio = '${(state.waterGoalMl / 1000).toStringAsFixed(1)}L';

    // No Desktop: Exatamente os 4 cards em linha como no screenshot enviado
    if (isDesktop) {
      return Row(
        children: [
          Expanded(
            child: QuickStatChip(
              icon: Icons.local_fire_department,
              label: 'Calorias Queimadas',
              value: '${state.todayCaloriesBurned}',
              unit: 'kcal',
              accentColor: AppTheme.orange,
              onTap: () => _showEditCaloriesDialog(context),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: QuickStatChip(
              icon: Icons.water_drop,
              label: 'Hidratação (+250ml)',
              value: waterRatio,
              unit: '/ $goalRatio',
              accentColor: AppTheme.cyan,
              onTap: () => _showEditWaterDialog(context),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: QuickStatChip(
              icon: Icons.fitness_center,
              label: 'Fichas Criadas',
              value: '${state.workouts.length}',
              unit: 'rotinas',
              accentColor: AppTheme.neon,
              onTap: () => onNavigateToTab(1),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: QuickStatChip(
              icon: Icons.timer,
              label: 'Cronômetro Descanso',
              value: state.isTimerRunning
                  ? '${state.restSecondsRemaining}s'
                  : '${state.totalRestSeconds}s',
              unit: state.isTimerRunning ? 'ativo' : 'parado',
              accentColor: AppTheme.purple,
              onTap: () => RestTimerDialog.show(context, state),
            ),
          ),
        ],
      );
    }

    // No Celular: 2x2 Grid para caber na tela
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QuickStatChip(
                icon: Icons.local_fire_department,
                label: 'Calorias (editar)',
                value: '${state.todayCaloriesBurned}',
                unit: 'kcal',
                accentColor: AppTheme.orange,
                onTap: () => _showEditCaloriesDialog(context),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: QuickStatChip(
                icon: Icons.water_drop,
                label: 'Água (editar)',
                value: waterRatio,
                unit: '/ $goalRatio',
                accentColor: AppTheme.cyan,
                onTap: () => _showEditWaterDialog(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: QuickStatChip(
                icon: Icons.fitness_center,
                label: 'Fichas Ativas',
                value: '${state.workouts.length}',
                unit: 'rotinas',
                accentColor: AppTheme.neon,
                onTap: () => onNavigateToTab(1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: QuickStatChip(
                icon: Icons.timer,
                label: 'Descanso',
                value: state.isTimerRunning
                    ? '${state.restSecondsRemaining}s'
                    : '${state.totalRestSeconds}s',
                unit: state.isTimerRunning ? 'ativo' : 'parado',
                accentColor: AppTheme.purple,
                onTap: () => RestTimerDialog.show(context, state),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProWorkoutsBanner(BuildContext context, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 22 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.neon.withOpacity(0.15),
            AppTheme.card,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.neon.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.neon,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.workspace_premium, color: Colors.black, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '21+ Treinos Especiais PRO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Programas completos: PPL, Golden Era, 5x5, Calistenia, HIIT, Glúteos de Elite e mais.',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary.withOpacity(0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => onNavigateToTab(2),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            child: const Text('Explorar Treinos'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.neon.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restaurant_menu, color: AppTheme.neon, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tem uma receita fitness favorita?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Cadastre com cálculo de macros e tempo.',
                  style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => AddRecipeDialog.show(context, state),
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Criar Receita', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import 'home_screen.dart';
import 'workouts_screen.dart';
import 'special_workouts_screen.dart';
import 'recipes_screen.dart';
import 'exercises_screen.dart';
import '../widgets/rest_timer_dialog.dart';

class MainScreen extends StatefulWidget {
  final FitnessState state;

  const MainScreen({Key? key, required this.state}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.state,
      builder: (context, _) {
        final screens = [
          HomeScreen(
            state: widget.state,
            onNavigateToTab: _onTabSelected,
          ),
          WorkoutsScreen(state: widget.state),
          SpecialWorkoutsScreen(
            state: widget.state,
            onNavigateToTab: _onTabSelected,
          ),
          RecipesScreen(state: widget.state),
          ExercisesScreen(state: widget.state),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 800;

            // ==================== TELA NORMAL DE DESKTOP ====================
            if (isDesktop) {
              return Scaffold(
                backgroundColor: AppTheme.background,
                body: Row(
                  children: [
                    // Barra Lateral Completa de Desktop
                    NavigationRail(
                      selectedIndex: _currentIndex,
                      onDestinationSelected: _onTabSelected,
                      labelType: NavigationRailLabelType.all,
                      minWidth: 90,
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppTheme.neon.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppTheme.neon.withOpacity(0.4),
                                ),
                              ),
                              child: const Icon(
                                Icons.bolt,
                                color: AppTheme.neon,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'PULSE',
                              style: TextStyle(
                                color: AppTheme.neon,
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: IconButton(
                              icon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.state.isTimerRunning
                                      ? AppTheme.neon
                                      : AppTheme.surface,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppTheme.cardBorder),
                                ),
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: widget.state.isTimerRunning
                                      ? Colors.black
                                      : AppTheme.neon,
                                  size: 24,
                                ),
                              ),
                              onPressed: () => RestTimerDialog.show(context, widget.state),
                              tooltip: 'Cronômetro de Descanso',
                            ),
                          ),
                        ),
                      ),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.dashboard_outlined),
                          selectedIcon: Icon(Icons.dashboard),
                          label: Text('Início'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.fitness_center_outlined),
                          selectedIcon: Icon(Icons.fitness_center),
                          label: Text('Minhas Fichas'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.workspace_premium_outlined),
                          selectedIcon: Icon(Icons.workspace_premium),
                          label: Text('Treinos PRO'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.restaurant_menu_outlined),
                          selectedIcon: Icon(Icons.restaurant_menu),
                          label: Text('Receitas Fit'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.format_list_bulleted_outlined),
                          selectedIcon: Icon(Icons.format_list_bulleted),
                          label: Text('Exercícios'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1, color: AppTheme.cardBorder),
                    // Conteúdo principal expandido ocupando toda a tela desktop
                    Expanded(
                      child: IndexedStack(
                        index: _currentIndex,
                        children: screens,
                      ),
                    ),
                  ],
                ),
              );
            }

            // ==================== TELA RESPONSIVA DE CELULAR ====================
            return Scaffold(
              backgroundColor: AppTheme.background,
              body: IndexedStack(
                index: _currentIndex,
                children: screens,
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: _onTabSelected,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(Icons.dashboard),
                    label: 'Início',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.fitness_center_outlined),
                    selectedIcon: Icon(Icons.fitness_center),
                    label: 'Fichas',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.workspace_premium_outlined),
                    selectedIcon: Icon(Icons.workspace_premium),
                    label: 'Treinos PRO',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.restaurant_menu_outlined),
                    selectedIcon: Icon(Icons.restaurant_menu),
                    label: 'Receitas',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.format_list_bulleted_outlined),
                    selectedIcon: Icon(Icons.format_list_bulleted),
                    label: 'Exercícios',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';

class RecipeDetailSheet extends StatelessWidget {
  final Recipe recipe;
  final FitnessState state;

  const RecipeDetailSheet({
    Key? key,
    required this.recipe,
    required this.state,
  }) : super(key: key);

  static void show(BuildContext context, Recipe recipe, FitnessState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => RecipeDetailSheet(recipe: recipe, state: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalGrams = recipe.proteinGrams + recipe.carbsGrams + recipe.fatGrams;
    final proteinPct = totalGrams > 0 ? (recipe.proteinGrams / totalGrams * 100).round() : 33;
    final carbsPct = totalGrams > 0 ? (recipe.carbsGrams / totalGrams * 100).round() : 33;
    final fatPct = totalGrams > 0 ? (recipe.fatGrams / totalGrams * 100).round() : 34;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: AppTheme.cardBorder, width: 1.5)),
          ),
          child: Column(
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 48,
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
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  children: [
                    // Top row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppTheme.cardBorder),
                          ),
                          alignment: Alignment.center,
                          child: Text(recipe.emoji, style: const TextStyle(fontSize: 34)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.neon.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  recipe.category.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppTheme.neon,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                recipe.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Quick info tags
                    Row(
                      children: [
                        _buildInfoTag(Icons.timer_outlined, '${recipe.prepTimeMinutes} min de preparo'),
                        const SizedBox(width: 12),
                        _buildInfoTag(Icons.local_fire_department, '${recipe.calories} kcal'),
                        const SizedBox(width: 12),
                        _buildInfoTag(Icons.bolt, recipe.difficulty),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Macronutrients breakdown
                    const Text(
                      'Divisão de Macronutrientes',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMacroCard('Proteína', '${recipe.proteinGrams.toStringAsFixed(0)}g', '$proteinPct%', AppTheme.neon),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMacroCard('Carboidratos', '${recipe.carbsGrams.toStringAsFixed(0)}g', '$carbsPct%', AppTheme.cyan),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMacroCard('Gorduras', '${recipe.fatGrams.toStringAsFixed(0)}g', '$fatPct%', AppTheme.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Ingredients
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...recipe.ingredients.map((ing) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6.0, right: 10.0),
                            child: Icon(Icons.check_circle_outline, color: AppTheme.neon, size: 16),
                          ),
                          Expanded(
                            child: Text(
                              ing,
                              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    )),

                    const SizedBox(height: 24),

                    // Modo de Preparo
                    const Text(
                      'Modo de Preparo',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(recipe.instructions.length, (idx) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.only(right: 12, top: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.surface,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.cardBorder),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${idx + 1}',
                                style: const TextStyle(
                                  color: AppTheme.neon,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                recipe.instructions[idx],
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 24),
                    // Action button to close
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Concluído'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCard(String label, String value, String pct, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(pct, style: TextStyle(color: color.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

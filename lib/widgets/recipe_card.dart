import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.onTap,
    this.onDelete,
  }) : super(key: key);

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pré-treino':
        return AppTheme.neon;
      case 'pós-treino':
        return AppTheme.cyan;
      case 'almoço / jantar':
        return AppTheme.orange;
      case 'doces & sobremesas':
        return AppTheme.purple;
      default:
        return AppTheme.cyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final catColor = _getCategoryColor(recipe.category);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: catColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: catColor.withOpacity(0.25)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      recipe.emoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: catColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                recipe.category.toUpperCase(),
                                style: TextStyle(
                                  color: catColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 13,
                                  color: AppTheme.textMuted,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${recipe.prepTimeMinutes} min',
                                  style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Nutritional macronutrients pills
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMacroItem(
                      label: 'Calorias',
                      value: '${recipe.calories} kcal',
                      color: AppTheme.textPrimary,
                    ),
                    _buildDivider(),
                    _buildMacroItem(
                      label: 'Proteínas',
                      value: '${recipe.proteinGrams.toStringAsFixed(0)}g',
                      color: AppTheme.neon,
                    ),
                    _buildDivider(),
                    _buildMacroItem(
                      label: 'Carbos',
                      value: '${recipe.carbsGrams.toStringAsFixed(0)}g',
                      color: AppTheme.cyan,
                    ),
                    _buildDivider(),
                    _buildMacroItem(
                      label: 'Gorduras',
                      value: '${recipe.fatGrams.toStringAsFixed(0)}g',
                      color: AppTheme.orange,
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

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 20,
      color: AppTheme.cardBorder,
    );
  }

  Widget _buildMacroItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

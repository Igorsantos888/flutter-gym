import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_detail_sheet.dart';
import '../widgets/add_recipe_dialog.dart';

class RecipesScreen extends StatefulWidget {
  final FitnessState state;

  const RecipesScreen({Key? key, required this.state}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _selectedCategory = 'Todas';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _categories = [
    'Todas',
    'Pré-Treino',
    'Pós-Treino',
    'Almoço / Jantar',
    'Lanches Rápidos',
    'Doces & Sobremesas',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = widget.state.recipes.where((r) {
      final matchesCategory = _selectedCategory == 'Todas' ||
          r.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.ingredients.any((ing) => ing.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Fitness'),
        actions: [
          IconButton(
            onPressed: () => AddRecipeDialog.show(context, widget.state),
            icon: const Icon(Icons.add_circle, color: AppTheme.neon),
            tooltip: 'Adicionar Nova Receita',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddRecipeDialog.show(context, widget.state),
        icon: const Icon(Icons.add),
        label: const Text('Nova Receita', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 800;
            final isWide = constraints.maxWidth >= 1200;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32.0 : 16.0,
                    vertical: 20.0,
                  ),
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchCtrl,
                      onChanged: (val) => setState(() => _searchQuery = val.trim()),
                      decoration: InputDecoration(
                        hintText: 'Buscar por receita ou ingrediente (ex: whey, frango, aveia...)',
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
                    const SizedBox(height: 16),

                    // Filter category chips
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
                              fontSize: 13,
                            ),
                            onSelected: (_) => setState(() => _selectedCategory = cat),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Top Banner with total count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${filteredRecipes.length} Receitas encontradas',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => AddRecipeDialog.show(context, widget.state),
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Cadastrar mais'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (filteredRecipes.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(40),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const Text('🥗', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 12),
                            const Text(
                              'Nenhuma receita encontrada para os filtros atuais.',
                              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => AddRecipeDialog.show(context, widget.state),
                              icon: const Icon(Icons.add),
                              label: const Text('Adicionar Receita Agora'),
                            ),
                          ],
                        ),
                      )
                    else if (isDesktop)
                      // No Desktop: Grid com 2 ou 3 colunas
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isWide ? 3 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 175,
                        ),
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () => RecipeDetailSheet.show(context, recipe, widget.state),
                          );
                        },
                      )
                    else
                      // No Celular: 1 coluna vertical fluida
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredRecipes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () => RecipeDetailSheet.show(context, recipe, widget.state),
                          );
                        },
                      ),

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

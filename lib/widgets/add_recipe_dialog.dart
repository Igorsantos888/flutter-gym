import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';

class AddRecipeDialog extends StatefulWidget {
  final FitnessState state;

  const AddRecipeDialog({Key? key, required this.state}) : super(key: key);

  static void show(BuildContext context, FitnessState state) {
    showDialog(
      context: context,
      builder: (ctx) => AddRecipeDialog(state: state),
    );
  }

  @override
  State<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _prepTimeController = TextEditingController(text: '15');
  final _caloriesController = TextEditingController(text: '350');
  final _proteinController = TextEditingController(text: '30');
  final _carbsController = TextEditingController(text: '35');
  final _fatController = TextEditingController(text: '8');
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  String _selectedCategory = 'Pré-Treino';
  String _selectedEmoji = '🥗';

  final List<String> _categories = [
    'Pré-Treino',
    'Pós-Treino',
    'Almoço / Jantar',
    'Lanches Rápidos',
    'Doces & Sobremesas',
  ];

  final List<String> _emojis = ['🥗', '🥞', '🍗', '🥤', '🌮', '🍫', '🍳', '🥩', '🥑', '🥣'];

  @override
  void dispose() {
    _titleController.dispose();
    _prepTimeController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _saveRecipe() {
    if (_formKey.currentState?.validate() ?? false) {
      final ingredients = _ingredientsController.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final instructions = _instructionsController.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final newRecipe = Recipe(
        id: 'rec_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        category: _selectedCategory,
        prepTimeMinutes: int.tryParse(_prepTimeController.text) ?? 15,
        calories: int.tryParse(_caloriesController.text) ?? 300,
        proteinGrams: double.tryParse(_proteinController.text) ?? 20,
        carbsGrams: double.tryParse(_carbsController.text) ?? 30,
        fatGrams: double.tryParse(_fatController.text) ?? 8,
        ingredients: ingredients.isNotEmpty
            ? ingredients
            : ['Ingredientes a gosto'],
        instructions: instructions.isNotEmpty
            ? instructions
            : ['Misture e prepare conforme seu gosto!'],
        emoji: _selectedEmoji,
      );

      widget.state.addRecipe(newRecipe);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receita "${newRecipe.title}" adicionada com sucesso!'),
          backgroundColor: AppTheme.neon,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
        constraints: const BoxConstraints(maxWidth: 550, maxHeight: 750),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.restaurant_menu, color: AppTheme.neon, size: 24),
                        SizedBox(width: 10),
                        Text(
                          'Nova Receita Fitness',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      // Emoji Selector
                      const Text(
                        'Ícone da Receita',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _emojis.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (ctx, i) {
                            final emoji = _emojis[i];
                            final isSel = _selectedEmoji == emoji;
                            return InkWell(
                              onTap: () => setState(() => _selectedEmoji = emoji),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isSel
                                      ? AppTheme.neon.withOpacity(0.2)
                                      : AppTheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSel ? AppTheme.neon : AppTheme.cardBorder,
                                    width: isSel ? 2 : 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(emoji, style: const TextStyle(fontSize: 22)),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Nome da Receita',
                          hintText: 'Ex: Mingau Proteico Noturno',
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Insira um nome' : null,
                      ),
                      const SizedBox(height: 16),

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        dropdownColor: AppTheme.card,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                        ),
                        items: _categories.map((c) {
                          return DropdownMenuItem(value: c, child: Text(c));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCategory = val);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Prep time & Calories
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _prepTimeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Preparo (min)',
                                suffixText: 'min',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _caloriesController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Calorias',
                                suffixText: 'kcal',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Macros
                      const Text(
                        'Macronutrientes (por porção)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _proteinController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Proteína',
                                suffixText: 'g',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _carbsController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Carbo',
                                suffixText: 'g',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _fatController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Gordura',
                                suffixText: 'g',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Ingredients
                      TextFormField(
                        controller: _ingredientsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Ingredientes (um por linha)',
                          hintText: '1 scoop de Whey\n100ml de leite\n30g de aveia',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Instructions
                      TextFormField(
                        controller: _instructionsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Modo de Preparo (um passo por linha)',
                          hintText: 'Passo 1: Misture todos os secos.\nPasso 2: Adicione o leite e mexa bem.',
                        ),
                      ),
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
                    ElevatedButton.icon(
                      onPressed: _saveRecipe,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Salvar Receita'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

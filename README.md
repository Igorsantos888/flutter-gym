# ⚡ PULSE FIT — Treinos, Musculação & Receitas Fitness

Aplicativo moderno e de alta performance desenvolvido em **Flutter**, com suporte nativo e responsivo para **Flutter Web**, **Android**, **iOS**, **Windows** e **macOS**.

Inspirado no visual escuro com toques neon (*Volt Lime & Cyber Cyan*) da referência web, trazendo melhorias substanciais de UX/UI, usabilidade, organização e as novas abas solicitadas.

---

## 🚀 Principais Melhorias em Relação ao Site Original

1. **Tela Inicial Mais Clean & Fluida:**
   - Em vez de uma tela sobrecarregada, a Home traz um dashboard moderno com saudação personalizada, contador de dias de sequência (Streak), atalhos rápidos e status de hidratação interativo (+250ml por toque).
   - Card em destaque para o **Treino do Dia** e para a **Receita Fitness em Destaque**.

2. **Aba Exclusiva de Receitas Fitness:**
   - Banco de receitas balanceadas para atletas (Pré-Treino, Pós-Treino, Almoço/Jantar, Lanches Rápidos e Doces Fit).
   - Visualização com contagem calórica e divisão exata de macronutrientes (**Proteínas**, **Carboidratos** e **Gorduras**).
   - Modal detalhado com lista de ingredientes e modo de preparo passo a passo.

3. **Espaço Dinâmico para Cadastrar Novas Receitas:**
   - Botão flutuante **"+ Nova Receita"** com formulário completo: nome, categoria, tempo de preparo, calorias, macros (P/C/G), ingredientes e instruções.

4. **Aba de Treinos & Fichas Completas:**
   - Rotinas divididas por grupos (Treino A: Pernas & Abdômen, Treino B: Peito/Ombros/Bíceps, Treino C: Costas/Tríceps, Treino D: Desafio Corrida).
   - Checklist interativo para marcar séries/exercícios concluídos com atualização de calorias em tempo real.
   - Opção para adicionar novos exercícios a qualquer ficha ou criar novas fichas customizadas.

5. **Cronômetro de Descanso Interativo:**
   - Diálogo com contador regressivo circular e botões de atalho rápido (30s, 45s, 60s, 90s, 120s) para cronometrar a pausa entre séries.

6. **100% Responsivo (Web & Mobile):**
   - **Telas Grandes / Web:** Barra lateral de navegação (`NavigationRail`), mantendo a visualização centralizada e sem esticar desproporcionalmente em monitores ultrawide.
   - **Dispositivos Móveis:** Barra de navegação inferior suave (`NavigationBar`) no padrão Material 3.

7. **Persistência Híbrida & Inteligente (Web vs Mobile):**
   - **Na Web:** Salvamento automático no **Local Storage do navegador (`localStorage`)** via JSON codificado, garantindo que o usuário recarregue a página sem perder nada.
   - **No App Mobile:** Preparado para **MongoDB** com coleções estruturadas (`workouts`, `recipes`, `stats`) e modo offline com cache local para funcionamento sem interrupções mesmo sem sinal de internet.

---

## 📁 Estrutura de Arquivos

```
pulse_fit/
├── web/
│   ├── index.html           # Setup para Flutter Web (dark theme + loader neon)
│   └── manifest.json        # PWA manifest
├── lib/
│   ├── main.dart            # Ponto de entrada do app
│   ├── theme/
│   │   └── app_theme.dart   # Tema escuro moderno com cores neon volt e ciano
│   ├── models/
│   │   ├── exercise.dart    # Modelo de exercício com séries, reps, peso e notas
│   │   ├── workout.dart     # Modelo de rotina de treino e cálculo de progresso
│   │   └── recipe.dart      # Modelo de receita com macros, tempo e preparo
│   ├── state/
│   │   └── fitness_state.dart # Gerenciamento de estado reativo (ChangeNotifier)
│   ├── screens/
│   │   ├── main_screen.dart # Container adaptativo (NavigationRail vs NavigationBar)
│   │   ├── home_screen.dart # Tela inicial clean com métricas e destaques
│   │   ├── workouts_screen.dart # Gestão de fichas e treinos
│   │   ├── recipes_screen.dart  # Lista de receitas fitness com filtros e busca
│   │   └── exercises_screen.dart # Biblioteca de exercícios por grupo muscular
│   └── widgets/
│       ├── workout_card.dart        # Card expansível com checklist
│       ├── recipe_card.dart         # Card com visualização de macros
│       ├── recipe_detail_sheet.dart # Modal completo de preparo da receita
│       ├── add_recipe_dialog.dart   # Formulário para cadastrar novas receitas
│       ├── add_workout_dialog.dart  # Formulário para cadastrar novas fichas
│       ├── rest_timer_dialog.dart   # Cronômetro circular de descanso
│       └── quick_stat_chip.dart     # Chips de estatísticas rápidas
└── test/
    └── fitness_app_test.dart        # Testes unitários do estado e modelos
```

---

## 🏃 Como Executar

Abra o terminal na pasta do projeto:

```bash
cd "C:\Users\Igor Santos\.gemini\antigravity\scratch\pulse_fit"
```

### 1. Rodar no Navegador (Flutter Web):
```bash
flutter run -d chrome
```

### 2. Rodar em Dispositivo Mobile (Android/iOS):
```bash
flutter run
```

### 3. Rodar Testes Unitários:
```bash
flutter test
```

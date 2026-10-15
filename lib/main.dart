import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'state/fitness_state.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final fitnessState = FitnessState();
  runApp(PulseFitApp(fitnessState: fitnessState));
}

class PulseFitApp extends StatelessWidget {
  final FitnessState fitnessState;

  const PulseFitApp({Key? key, required this.fitnessState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PULSE FIT — Treinos & Receitas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: MainScreen(state: fitnessState),
    );
  }
}

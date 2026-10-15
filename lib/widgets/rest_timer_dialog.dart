import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/fitness_state.dart';

class RestTimerDialog extends StatelessWidget {
  final FitnessState state;

  const RestTimerDialog({Key? key, required this.state}) : super(key: key);

  static void show(BuildContext context, FitnessState state) {
    showDialog(
      context: context,
      builder: (ctx) => AnimatedBuilder(
        animation: state,
        builder: (ctx, _) => RestTimerDialog(state: state),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = state.totalRestSeconds == 0
        ? 0.0
        : (state.restSecondsRemaining / state.totalRestSeconds).clamp(0.0, 1.0);

    return Dialog(
      backgroundColor: AppTheme.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppTheme.cardBorder),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.timer_outlined, color: AppTheme.neon, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Descanso entre Séries',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Circular progress timer
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 10,
                      backgroundColor: AppTheme.cardBorder,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.neon),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(state.restSecondsRemaining),
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.neon,
                          fontFeatures: [],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.isTimerRunning
                            ? 'RECUPERANDO...'
                            : (state.restSecondsRemaining == 0 ? 'PRONTO!' : 'PAUSADO'),
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Preset chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [30, 45, 60, 90, 120].map((sec) {
                  final isSelected = state.totalRestSeconds == sec;
                  return ChoiceChip(
                    label: Text('${sec}s'),
                    selected: isSelected,
                    selectedColor: AppTheme.neon,
                    backgroundColor: AppTheme.surface,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (_) {
                      state.startRestTimer(sec);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => state.resetRestTimer(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Reiniciar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textPrimary,
                      side: const BorderSide(color: AppTheme.cardBorder),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (state.isTimerRunning) {
                        state.pauseRestTimer();
                      } else {
                        if (state.restSecondsRemaining <= 0) {
                          state.startRestTimer(state.totalRestSeconds > 0 ? state.totalRestSeconds : 60);
                        } else {
                          state.startRestTimer(state.restSecondsRemaining);
                        }
                      }
                    },
                    icon: Icon(state.isTimerRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(state.isTimerRunning ? 'Pausar' : 'Iniciar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/duration_formatter.dart';
import 'player_provider.dart';

class SleepTimerDialog extends ConsumerStatefulWidget {
  const SleepTimerDialog({super.key});

  @override
  ConsumerState<SleepTimerDialog> createState() => _SleepTimerDialogState();
}

class _SleepTimerDialogState extends ConsumerState<SleepTimerDialog> {
  int _selectedHours = 0;
  int _selectedMinutes = 15;

  @override
  Widget build(BuildContext context) {
    // Usamos ref.read para el tiempo restante o escuchamos solo lo necesario
    final playerState = ref.watch(playerProvider);
    final remaining = playerState.sleepTimerRemaining;

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Row(
        children: const [
          Icon(Icons.bedtime_rounded, color: AppColors.primary),
          SizedBox(width: 10),
          Text(
            'Temporizador de Apagado',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador si ya hay un temporizador en marcha
            if (remaining != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Se apaga en:',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    Text(
                      formatDuration(remaining),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  ref.read(playerProvider.notifier).cancelSleepTimer();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.timer_off_rounded, color: Colors.redAccent, size: 20),
                label: const Text(
                  'Desactivar temporizador',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              const Divider(color: AppColors.surfaceLight, height: 24),
            ],

            const Text(
              'Ajusta el tiempo de apagado:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Selector estable de Horas y Minutos (Ruedas estables en Material)
            // Selector de Horas y Minutos corregido
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Columna Horas
                  _buildWheelColumn(
                    label: 'Horas',
                    value: _selectedHours,
                    max: 12,
                    onChanged: (val) => setState(() => _selectedHours = val),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Columna Minutos
                  _buildWheelColumn(
                    label: 'Minutos',
                    value: _selectedMinutes,
                    max: 59,
                    onChanged: (val) => setState(() => _selectedMinutes = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Botón para Iniciar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(
                  (_selectedHours == 0 && _selectedMinutes == 0)
                      ? 'Selecciona un tiempo'
                      : 'Iniciar (${_selectedHours > 0 ? '${_selectedHours}h ' : ''}${_selectedMinutes}m)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: (_selectedHours == 0 && _selectedMinutes == 0)
                    ? null
                    : () {
                  final duration = Duration(
                    hours: _selectedHours,
                    minutes: _selectedMinutes,
                  );
                  ref.read(playerProvider.notifier).setSleepTimer(duration);
                  Navigator.of(context).pop();
                },
              ),
            ),

            const SizedBox(height: 16),
            const Divider(color: AppColors.surfaceLight, height: 1),
            const SizedBox(height: 12),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Accesos rápidos:',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [15, 30, 45, 60].map((mins) {
                return ActionChip(
                  label: Text('$mins min'),
                  labelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  backgroundColor: AppColors.surfaceLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    ref
                        .read(playerProvider.notifier)
                        .setSleepTimer(Duration(minutes: mins));
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: AppColors.textMuted)),
        ),
      ],
    );
  }

  Widget _buildWheelColumn({
    required String label,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 90,
          width: 60,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 30,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: value),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: max + 1,
              builder: (context, index) {
                final isSelected = index == value;
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
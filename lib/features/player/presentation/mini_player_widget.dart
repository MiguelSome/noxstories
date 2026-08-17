import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/duration_formatter.dart';
import 'player_provider.dart';

class MiniPlayerWidget extends ConsumerWidget {
  const MiniPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final story = playerState.currentStory;

    if (story == null) return const SizedBox.shrink();

    final currentPos = playerState.position;
    final totalDur = playerState.duration;
    final maxMs = totalDur.inMilliseconds > 0 ? totalDur.inMilliseconds.toDouble() : 1.0;
    final currentMs = currentPos.inMilliseconds.toDouble().clamp(0.0, maxMs);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  story.coverUrl,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 44,
                    height: 44,
                    color: AppColors.surface,
                    child: const Icon(Icons.music_note, color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      story.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Botón saltar -10s
              IconButton(
                iconSize: 22,
                icon: const Icon(Icons.replay_10_rounded, color: AppColors.textSecondary),
                onPressed: () {
                  final newPos = currentPos - const Duration(seconds: 10);
                  ref.read(playerProvider.notifier).seek(newPos < Duration.zero ? Duration.zero : newPos);
                },
              ),
              // Botón Play / Pause
              IconButton(
                iconSize: 30,
                icon: Icon(
                  playerState.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  ref.read(playerProvider.notifier).togglePlayPause();
                },
              ),
              // Botón saltar +10s
              IconButton(
                iconSize: 22,
                icon: const Icon(Icons.forward_10_rounded, color: AppColors.textSecondary),
                onPressed: () {
                  final newPos = currentPos + const Duration(seconds: 10);
                  ref.read(playerProvider.notifier).seek(newPos > totalDur ? totalDur : newPos);
                },
              ),
            ],
          ),
          // Barra de progreso deslizante con marcas de tiempo
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.surface,
              thumbColor: AppColors.secondary,
            ),
            child: Slider(
              value: currentMs,
              min: 0.0,
              max: maxMs,
              onChanged: (value) {
                ref.read(playerProvider.notifier).seek(
                  Duration(milliseconds: value.toInt()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(currentPos, referenceDuration: totalDur),
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
                Text(
                  formatDuration(totalDur),
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
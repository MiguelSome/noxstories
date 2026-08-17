import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_stories.dart';
import '../../../core/models/story_model.dart';
import '../../../core/utils/duration_formatter.dart';
import '../../player/presentation/player_provider.dart';

// Fondos oscuros de galaxia / estrellas para los recuadros
const List<String> _galaxyBackgrounds = [
  'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?q=80&w=800&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=800&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1538370965046-79c0d6907d47?q=80&w=800&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=800&auto=format&fit=crop',
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final Story _featuredStory;

  @override
  void initState() {
    super.initState();
    // Selecciona una historia aleatoria para "Esta noche aconsejamos"
    final List<Story> allStories = List.from(MockStories.sampleStories);
    allStories.shuffle();
    _featuredStory = allStories.first;
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);

    // Filtra historias que hayan empezado y no hayan terminado
    // (Ejemplo simulado si la historia actual está en progreso)
    final List<Story> continueStories = [];
    if (playerState.currentStory != null &&
        playerState.position.inSeconds > 0 &&
        playerState.position < playerState.duration) {
      continueStories.add(playerState.currentStory!);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.nights_stay_rounded, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'NoxStories',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECCIÓN 1: ESTA NOCHE ACONSEJAMOS ---
            _buildFeaturedCard(
              context: context,
              story: _featuredStory,
              bgUrl: _galaxyBackgrounds[0],
              onTap: () {
                ref.read(playerProvider.notifier).playStory(_featuredStory);
              },
            ),

            const SizedBox(height: 28),

            // --- SECCIÓN 2: CONTINUAR ---
            const Text(
              'Continuar escuchando',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (continueStories.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceLight),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.play_circle_outline, color: AppColors.textMuted, size: 36),
                    SizedBox(height: 8),
                    Text(
                      'No tienes ningún audio a medias',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: continueStories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final story = continueStories[index];
                  final bgIndex = (index + 1) % _galaxyBackgrounds.length;

                  return _buildContinueCard(
                    context: context,
                    story: story,
                    bgUrl: _galaxyBackgrounds[bgIndex],
                    currentPos: playerState.position,
                    totalDur: playerState.duration,
                    onTap: () {
                      ref.read(playerProvider.notifier).playStory(story);
                    },
                  );
                },
              ),

            const SizedBox(height: 80), // Espacio para el mini player
          ],
        ),
      ),
    );
  }

  // Tarjeta destacada "Esta noche aconsejamos"
  Widget _buildFeaturedCard({
    required BuildContext context,
    required Story story,
    required String bgUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Imagen de fondo (Galaxia/Cielo estrellado)
            Positioned.fill(
              child: Image.network(
                bgUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surface,
                ),
              ),
            ),
            // Capa de degradado para legibilidad del texto
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.85),
                      Colors.black.withValues(alpha: 0.4),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Contenido
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pestaña "Esta noche aconsejamos"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star_rounded, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Esta noche aconsejamos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          story.coverUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 70,
                            height: 70,
                            color: AppColors.surface,
                            child: const Icon(Icons.music_note, color: AppColors.accent),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              story.author,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded,
                                    color: AppColors.accent, size: 13),
                                const SizedBox(width: 4),
                                Text(
                                  formatDuration(story.duration),
                                  style: const TextStyle(
                                    color: AppColors.accent,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Botón Escuchar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.9),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: onTap,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text(
                        'Escuchar ahora',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjetas para "Continuar escuchando"
  Widget _buildContinueCard({
    required BuildContext context,
    required Story story,
    required String bgUrl,
    required Duration currentPos,
    required Duration totalDur,
    required VoidCallback onTap,
  }) {
    final progress = totalDur.inMilliseconds > 0
        ? (currentPos.inMilliseconds / totalDur.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Fondo Galaxia
            Positioned.fill(
              child: Image.network(
                bgUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surface,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.75),
              ),
            ),

            // Contenido
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            story.coverUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 50,
                              height: 50,
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
                              const SizedBox(height: 2),
                              Text(
                                '${formatDuration(currentPos, referenceDuration: totalDur)} de ${formatDuration(totalDur)}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.play_circle_fill_rounded,
                          color: AppColors.primary,
                          size: 36,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Barra de progreso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor: AppColors.surfaceLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
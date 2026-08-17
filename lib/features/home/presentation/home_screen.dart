import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_stories.dart';
import '../../../core/models/story_model.dart';
import '../../player/presentation/player_provider.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'Todos');

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<String> categories = [
    'Todos',
    'Historia',
    'Mitología',
    'Misterio',
    'Ciencia Ficción',
    'Meditación',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final allStories = MockStories.sampleStories;

    final filteredStories = selectedCategory == 'Todos'
        ? allStories
        : allStories.where((s) => s.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NoxStories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Selector interactivo de Categorías
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Explorar Campos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(category),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surface,
                          checkmarkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (_) {
                            ref.read(selectedCategoryProvider.notifier).state = category;
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text(
                    'Historias para la Noche',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Lista de historias filtradas
          filteredStories.isEmpty
              ? const SliverFillRemaining(
            child: Center(
              child: Text(
                'No hay historias disponibles en esta categoría',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          )
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final story = filteredStories[index];
                return _StoryCard(story: story);
              },
              childCount: filteredStories.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends ConsumerWidget {
  final Story story;

  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final isCurrent = playerState.currentStory?.id == story.id;
    final isPlaying = isCurrent && playerState.isPlaying;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            story.coverUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60,
              height: 60,
              color: AppColors.surfaceLight,
              child: const Icon(Icons.menu_book_rounded, color: AppColors.primary),
            ),
          ),
        ),
        title: Text(
          story.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        subtitle: Text(
          '${story.author} • ${story.category}',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            color: AppColors.primary,
            size: 40,
          ),
          onPressed: () {
            if (isCurrent) {
              ref.read(playerProvider.notifier).togglePlayPause();
            } else {
              ref.read(playerProvider.notifier).playStory(story);
            }
          },
        ),
      ),
    );
  }
}
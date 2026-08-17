import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_stories.dart';
import '../../../core/models/story_model.dart';
import '../../../core/utils/duration_formatter.dart';
import '../../player/presentation/player_provider.dart';

// Estructura de categorías y subtemas
class CategoryItem {
  final String title;
  final IconData icon;
  final List<SubCategoryItem> subcategories;

  const CategoryItem({
    required this.title,
    required this.icon,
    required this.subcategories,
  });
}

class SubCategoryItem {
  final String title;
  final List<String> topics;

  const SubCategoryItem({
    required this.title,
    required this.topics,
  });
}

final List<CategoryItem> categoryTree = [
  const CategoryItem(
    title: 'Historia Universal',
    icon: Icons.auto_stories_rounded,
    subcategories: [
      SubCategoryItem(
        title: 'Prehistoria',
        topics: ['Edad de Piedra', 'Paleolítico', 'Mesolítico', 'Neolítico', 'Edad de los Metales'],
      ),
      SubCategoryItem(
        title: 'Historia Antigua',
        topics: ['Mesopotamia', 'Egipto', 'Grecia Arcaica/Clásica', 'Roma'],
      ),
      SubCategoryItem(
        title: 'Edad Media',
        topics: ['Alta Edad Media', 'Plena Edad Media', 'Baja Edad Media'],
      ),
      SubCategoryItem(
        title: 'Edad Moderna',
        topics: ['Siglos XVI, XVII, XVIII', 'Renacimiento', 'Barroco', 'Ilustración'],
      ),
      SubCategoryItem(
        title: 'Edad Contemporánea',
        topics: ['Siglo XIX', 'Siglo XX', 'Siglo XXI'],
      ),
    ],
  ),
  const CategoryItem(
    title: 'Mitologías del Mundo',
    icon: Icons.account_balance_rounded,
    subcategories: [
      SubCategoryItem(
        title: 'Clásica',
        topics: ['Grecia', 'Roma'],
      ),
      SubCategoryItem(
        title: 'Europea',
        topics: ['Nórdica', 'Celta', 'Eslava', 'Finlandesa / Kalevala'],
      ),
      SubCategoryItem(
        title: 'Próximo Oriente y África',
        topics: ['Egipcia', 'Mesopotámica', 'Persa', 'Yoruba', 'Zulú'],
      ),
      SubCategoryItem(
        title: 'Asiática',
        topics: ['Hindú / Védica', 'China', 'Japonesa / Sintoísta', 'Coreana', 'Tibetana'],
      ),
      SubCategoryItem(
        title: 'Américas',
        topics: ['Azteca', 'Maya', 'Inca', 'Guaraní', 'Muisca', 'Nativos Norteamericanos'],
      ),
      SubCategoryItem(
        title: 'Oceanía',
        topics: ['Aborigen Australiana', 'Polinesia', 'Melanesia'],
      ),
    ],
  ),
  const CategoryItem(
    title: 'Misterio & Otros',
    icon: Icons.visibility_rounded,
    subcategories: [
      SubCategoryItem(
        title: 'Casos Paranormales & Leyendas',
        topics: ['Leyendas Urbanas Documentadas', 'Fenómenos Sin Explicación'],
      ),
      SubCategoryItem(
        title: 'Viajes Sonoros',
        topics: ['Naturaleza', 'Paisajes Acústicos Nocturnos'],
      ),
    ],
  ),
  const CategoryItem(
    title: 'Relajación & Meditación',
    icon: Icons.spa_rounded,
    subcategories: [
      SubCategoryItem(
        title: 'Viajes Sonoros',
        topics: ['Naturaleza y Paisajes Acústicos', 'Ruido Blanco y Tormentas'],
      ),
    ],
  ),
];

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    // Filtrar historias según búsqueda
    final stories = MockStories.sampleStories.where((story) {
      final matchesSearch = _searchQuery.isEmpty ||
          story.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          story.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || story.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Explorar Catálogo',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda
            TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Buscar audios, historias, mitos...',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.accent),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Selector rápido de categorías
            if (_selectedCategory != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ChoiceChip(
                  label: Text('Filtrado: $_selectedCategory'),
                  selected: true,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                  selectedColor: AppColors.primary,
                  labelStyle: const TextStyle(color: Colors.white),
                  avatar: const Icon(Icons.close_rounded, size: 16, color: Colors.white),
                ),
              ),

            // Arbol de Categorías Principales
            const Text(
              'Categorías y Temas',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryTree.length,
              itemBuilder: (context, index) {
                final category = categoryTree[index];
                return _buildCategoryCard(category);
              },
            ),

            const SizedBox(height: 24),

            // Resultados / Recomendados
            Text(
              _searchQuery.isNotEmpty || _selectedCategory != null
                  ? 'Resultados'
                  : 'Historias destacadas',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (stories.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'No se encontraron contenidos para este filtro.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return _buildStoryItem(story);
                },
              ),

            const SizedBox(height: 80), // Espacio para mini reproductor
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(category.icon, color: AppColors.accent),
          title: Text(
            category.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: category.subcategories.map((sub) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    sub.title,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: sub.topics.map((topic) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category.title;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.surfaceLight),
                        ),
                        child: Text(
                          topic,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStoryItem(Story story) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            story.coverUrl,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 54,
              height: 54,
              color: AppColors.surfaceLight,
              child: const Icon(Icons.music_note, color: AppColors.accent),
            ),
          ),
        ),
        title: Text(
          story.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${story.category} • ${story.subcategory}',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
            const SizedBox(height: 2),
            Text(
              formatDuration(story.duration),
              style: const TextStyle(color: AppColors.accent, fontSize: 11),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.primary, size: 36),
          onPressed: () {
            ref.read(playerProvider.notifier).playStory(story);
          },
        ),
      ),
    );
  }
}
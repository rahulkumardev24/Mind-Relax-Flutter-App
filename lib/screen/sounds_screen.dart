import 'package:flutter/material.dart';
import 'package:mind_relax/models/sound_model.dart';

import '../utils/app_colors.dart';
import '../widgets/sound_card.dart';

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  final Map<String, bool> _playingStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text('Relaxing Sounds', style: AppTextStyles.headlineLarge),
                ],
              ),

              const SizedBox(height: 20),

              // Search Bar
              _buildSearchBar(),

              const SizedBox(height: 30),

              // Categories
              _buildCategorySection('Nature Sounds', 'nature'),
              const SizedBox(height: 20),
              _buildCategorySection('Ambient Sounds', 'ambient'),
              const SizedBox(height: 20),
              _buildCategorySection('Instruments', 'instruments'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search sounds...',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          border: InputBorder.none,
          icon: Icon(Icons.search_rounded, color: AppColors.textSecondary),
        ),
        style: TextStyle(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildCategorySection(String title, String category) {
    final categorySounds = SoundData.sounds
        .where(
          (sound) => sound.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium.copyWith(fontSize: 20)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: categorySounds.length,
          itemBuilder: (context, index) {
            final sound = categorySounds[index];
            return SoundCard(
              sound: sound,
              isPlaying: _playingStates[sound.id] ?? false,
              onTap: () => _toggleSound(sound),
            );
          },
        ),
      ],
    );
  }

  void _toggleSound(Sound sound) {
    setState(() {
      _playingStates[sound.id] = !(_playingStates[sound.id] ?? false);
    });
  }
}

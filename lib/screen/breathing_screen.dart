import 'package:flutter/material.dart';
import 'package:mind_relax/widgets/breathing_widget.dart';

import '../utils/app_colors.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  String _selectedPattern = '4-7-8';
  bool _isBreathing = false;

  final Map<String, List<int>> _breathingPatterns = {
    '4-7-8': [4, 7, 8], // Inhale, Hold, Exhale
    'Box': [4, 4, 4, 4], // Inhale, Hold, Exhale, Hold
    'Calm': [5, 0, 5], // Inhale, No Hold, Exhale
    'Relax': [4, 2, 6], // Inhale, Hold, Exhale
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Breathing Exercise',
                    style: AppTextStyles.headlineLarge,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Breathing Animation
              Expanded(
                child: Center(
                  child: BreathingWidget(
                    pattern: _breathingPatterns[_selectedPattern]!,
                    isBreathing: _isBreathing,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Pattern Selection
              _buildPatternSelection(),

              const SizedBox(height: 30),

              // Start/Stop Button
              _buildControlButton(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatternSelection() {
    return Column(
      children: [
        Text(
          'Breathing Pattern',
          style: AppTextStyles.headlineMedium.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _breathingPatterns.keys.map((pattern) {
            return ChoiceChip(
              label: Text(pattern),
              selected: _selectedPattern == pattern,
              onSelected: _isBreathing ? null : (selected) {
                setState(() {
                  _selectedPattern = pattern;
                });
              },
              backgroundColor: AppColors.cardColor,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: _selectedPattern == pattern ? Colors.white : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildControlButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isBreathing = !_isBreathing;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isBreathing ? Colors.red : AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),
        child: Text(
          _isBreathing ? 'STOP BREATHING' : 'START BREATHING',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
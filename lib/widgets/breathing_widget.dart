import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class BreathingWidget extends StatefulWidget {
  final List<int> pattern;
  final bool isBreathing;

  const BreathingWidget({
    super.key,
    required this.pattern,
    required this.isBreathing,
  });

  @override
  State<BreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends State<BreathingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _currentPhase = 'Inhale';
  int _currentSecond = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
  }

  @override
  void didUpdateWidget(covariant BreathingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isBreathing && !_controller.isAnimating) {
      _startBreathing();
    } else if (!widget.isBreathing && _controller.isAnimating) {
      _stopBreathing();
    }
  }

  void _startBreathing() {
    _controller.repeat(reverse: true);
    _startBreathingCycle();
  }

  void _stopBreathing() {
    _controller.stop();
    _currentPhase = 'Inhale';
    _currentSecond = 0;
  }

  void _startBreathingCycle() {
    // This would be implemented with a timer to cycle through phases
    // For demo purposes, we'll just show the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Breathing Circle
        Container(
          width: 200 * _animation.value,
          height: 200 * _animation.value,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              _getPhaseIcon(),
              color: Colors.white,
              size: 40 * _animation.value,
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Instructions
        Text(
          _currentPhase,
          style: AppTextStyles.headlineLarge.copyWith(fontSize: 28),
        ),

        const SizedBox(height: 16),

        Text(
          _getPhaseDescription(),
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        // Timer
        Text(
          '$_currentSecond',
          style: AppTextStyles.headlineLarge.copyWith(
            fontSize: 48,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  IconData _getPhaseIcon() {
    switch (_currentPhase) {
      case 'Inhale':
        return Icons.air_rounded;
      case 'Hold':
        return Icons.pause_rounded;
      case 'Exhale':
        return Icons.air_rounded;
      default:
        return Icons.air_rounded;
    }
  }

  String _getPhaseDescription() {
    switch (_currentPhase) {
      case 'Inhale':
        return 'Breathe in slowly through your nose';
      case 'Hold':
        return 'Hold your breath';
      case 'Exhale':
        return 'Breathe out slowly through your mouth';
      default:
        return 'Follow the circle animation';
    }
  }
}
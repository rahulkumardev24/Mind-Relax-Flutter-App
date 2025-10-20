import 'package:flutter/material.dart';

class BreathingAnimation extends StatefulWidget {
  final Duration inhaleDuration;
  final Duration holdDuration;
  final Duration exhaleDuration;
  final VoidCallback onCycleComplete;

  const BreathingAnimation({
    Key? key,
    required this.inhaleDuration,
    required this.holdDuration,
    required this.exhaleDuration,
    required this.onCycleComplete,
  }) : super(key: key);

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _currentPhase = 'Inhale';
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.inhaleDuration + widget.holdDuration + widget.exhaleDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.33, curve: Curves.easeInOut),
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _cycleCount++;
        widget.onCycleComplete();
        _controller.reset();
        _startBreathingCycle();
      }
    });

    _startBreathingCycle();
  }

  void _startBreathingCycle() {
    _setPhase('Inhale');
    _controller.forward().then((_) {
      _setPhase('Hold');
      Future.delayed(widget.holdDuration, () {
        _setPhase('Exhale');
        // Exhale animation would be handled by the reverse
      });
    });
  }

  void _setPhase(String phase) {
    setState(() {
      _currentPhase = phase;
    });
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
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 200 * _animation.value,
              height: 200 * _animation.value,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  _currentPhase,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
          _currentPhase,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Cycle: $_cycleCount',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
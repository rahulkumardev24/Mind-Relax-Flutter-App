import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/app_colors.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // State variables
  bool _isMeditating = false;
  int _selectedTime = 5;
  String _selectedSound = 'None';
  double _volume = 0.5;
  String _breathingPhase = 'Tap Start to Begin';
  int _remainingTime = 0; // in seconds
  late int _totalTime; // in seconds

  // Timer
  Timer? _meditationTimer;

  // Available options
  final List<int> _timeOptions = [1, 5, 10, 15, 20];
  final List<String> _soundOptions = [
    'None',
    'Ocean Waves',
    'Forest',
    'Rain',
    'Tibetan Bowl',
  ];

  @override
  void initState() {
    super.initState();
    _totalTime = _selectedTime * 60;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation =
        Tween<double>(begin: 0.8, end: 1.3).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          )
          ..addListener(() => setState(() {}))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (_isMeditating) {
                  _controller.reverse();
                  _updateBreathingPhase('Exhale');
                }
              });
            } else if (status == AnimationStatus.dismissed) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (_isMeditating) {
                  _controller.forward();
                  _updateBreathingPhase('Inhale');
                }
              });
            }
          });
  }

  void _updateBreathingPhase(String phase) {
    setState(() {
      _breathingPhase = phase;
    });
  }

  void _startMeditation() {
    setState(() {
      _isMeditating = true;
      _breathingPhase = 'Inhale';
      _remainingTime = _selectedTime * 60;
    });

    // Start breathing animation
    _controller.forward();

    // Start meditation timer
    _startTimer();
  }

  void _stopMeditation() {
    setState(() {
      _isMeditating = false;
      _breathingPhase = 'Tap Start to Begin';
      _remainingTime = _selectedTime * 60;
    });

    // Stop breathing animation and reset to initial size
    _controller.stop();
    // Cancel timer
    _cancelTimer();
  }

  void _startTimer() {
    _meditationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        // Time's up - auto stop meditation
        _stopMeditation();
        _showCompletionDialog();
      }
    });
  }

  void _cancelTimer() {
    if (_meditationTimer != null) {
      _meditationTimer!.cancel();
      _meditationTimer = null;
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Meditation Complete! 🎉',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'You completed $_selectedTime minutes of meditation',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [_buildQuickActions()],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 1.h),
                // Progress Section
                _buildProgressSection(),
                SizedBox(height: 1.h),
                // Timer Section
                _buildTimerSection(),

                const SizedBox(height: 10),

                // Breathing Animation
                Expanded(flex: 1, child: _buildBreathingAnimation()),

                const SizedBox(height: 10),

                _buildBreathingInfo(),
                SizedBox(height: 5.h),

                // Controls button
                _buildControlButtons(),

                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// --------- Widgets -------- ///

  // Progress Section
  Widget _buildProgressSection() {
    double progress = _totalTime > 0
        ? (_totalTime - _remainingTime) / _totalTime
        : 0;
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: AppColors.cardColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
      borderRadius: BorderRadius.circular(10),
      minHeight: 8,
    );
  }

  // Timer Section
  Widget _buildTimerSection() {
    final elapsedTime =
        _totalTime - _remainingTime; // 👈 elapsed time calculate
    final formattedElapsed = _formatTime(elapsedTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formattedElapsed, // 👈 yahan elapsed time show hoga
          style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
        ),
        Text(
          _formatTime(_totalTime), // 👈 total meditation time
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // Breathing Animation
  Widget _buildBreathingAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Ripple Effects (only during meditation)
        if (_isMeditating) ...[
          // Ripple Effect - Outer Circle 3
          AnimatedContainer(
            duration: Duration(
              milliseconds: _breathingPhase == 'Inhale' ? 4000 : 4000,
            ),
            width: 90.w * _animation.value,
            height: 90.w * _animation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _breathingPhase == 'Inhale'
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),

          // Ripple Effect - Outer Circle 2
          AnimatedContainer(
            duration: Duration(
              milliseconds: _breathingPhase == 'Inhale' ? 3000 : 3000,
            ),
            width: 85.w * _animation.value,
            height: 85.w * _animation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _breathingPhase == 'Inhale'
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.orange.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
          ),

          // Ripple Effect - Outer Circle 1
          AnimatedContainer(
            duration: Duration(
              milliseconds: _breathingPhase == 'Inhale' ? 2000 : 2000,
            ),
            width: 65.w * _animation.value,
            height: 65.w * _animation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _breathingPhase == 'Inhale'
                    ? Colors.green.withValues(alpha: 0.3)
                    : Colors.orange.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          ),
        ],

        // Outer pulsing circle
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 65.w * _animation.value,
          height: 65.w * _animation.value,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: _breathingPhase == 'Inhale'
                  ? Colors.green.withValues(alpha: 0.8)
                  : _breathingPhase == 'Exhale'
                  ? Colors.orange.withValues(alpha: 0.8)
                  : AppColors.primary,
              width: 1,
            ),
          ),
        ),

        // Main breathing circle
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 50.w * _animation.value,
          height: 50.w * _animation.value,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: _breathingPhase == 'Inhale'
                  ? [
                      Colors.green.shade400,
                      Colors.green.shade600,
                      Colors.green.shade800,
                    ]
                  : _breathingPhase == 'Exhale'
                  ? [
                      Colors.orange.shade400,
                      Colors.orange.shade600,
                      Colors.orange.shade800,
                    ]
                  : [const Color(0xFF36D1DC), const Color(0xFF4A90E2)],
              center: Alignment.center,
              radius: 0.8,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isMeditating
                  ? (_breathingPhase == 'Inhale'
                        ? Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.white,
                            size: 40 * (_animation.value * 0.8 + 0.6),
                          )
                        : Icon(
                            Icons.arrow_circle_down_rounded,
                            color: Colors.white,
                            size: 40 * (_animation.value * 0.8 + 0.6),
                          ))
                  : Icon(
                      Icons.self_improvement_rounded,
                      color: Colors.white,
                      size: 40 * (_animation.value * 0.8 + 0.6),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreathingInfo() {
    return _isMeditating
        ? Container(
            height: 15.w,
            width: 50.w,
            decoration: BoxDecoration(
              color: _breathingPhase == 'Inhale'
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _breathingPhase == 'Inhale'
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _breathingPhase == 'Inhale'
                      ? "assets/images/inhale.png"
                      : "assets/images/exhale.png",
                  height: 4.h,
                  color: _breathingPhase == 'Inhale'
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  _breathingPhase == 'Inhale' ? 'INHALE' : 'EXHALE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _breathingPhase == 'Inhale'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ],
            ),
          )
        : SizedBox(height: 15.w);
  }

  // Control Buttons
  Widget _buildControlButtons() {
    return SizedBox(
      width: 70.w,
      child: ElevatedButton(
        onPressed: _isMeditating ? _stopMeditation : _startMeditation,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isMeditating ? Colors.red : AppColors.green,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
        child: Text(
          _isMeditating ? 'STOP' : 'START',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildQuickAction(Icons.timer_rounded, () {
          _showTimerOptions(context);
        }),
        _buildQuickAction(Icons.music_note_rounded, () {
          _showSoundOptions(context);
        }),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      onPressed: onTap,
    );
  }

  // Timer Options Dialog
  void _showTimerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Meditation Time',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              // Current Selected Time
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Text(
                  'Selected: $_selectedTime minutes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Time Options Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: _timeOptions.length,
                itemBuilder: (context, index) {
                  final time = _timeOptions[index];
                  return _buildTimeOptionCard(time, context);
                },
              ),

              const SizedBox(height: 20),

              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeOptionCard(int time, BuildContext context) {
    bool isSelected = _selectedTime == time;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = time;
          _totalTime = time * 60;
          _remainingTime = _totalTime;
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$time',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'min',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sound Options Dialog
  void _showSoundOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Background Sound',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              // Sound Options List
              ..._soundOptions.map((sound) {
                return _buildSoundOptionTile(sound);
              }).toList(),

              const SizedBox(height: 20),

              // Volume Slider if sound is selected
              if (_selectedSound != 'None') ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.volume_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Slider(
                        value: _volume,
                        onChanged: (value) {
                          setState(() {
                            _volume = value;
                          });
                        },
                        activeColor: AppColors.primary,
                        inactiveColor: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      Icons.volume_up_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSoundOptionTile(String sound) {
    bool isSelected = _selectedSound == sound;

    return ListTile(
      leading: Icon(
        Icons.music_note_rounded,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        sound,
        style: TextStyle(
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
      onTap: () {
        setState(() {
          _selectedSound = sound;
        });
      },
    );
  }

  // Helper Methods
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

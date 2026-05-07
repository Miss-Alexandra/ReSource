import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _secondsRemaining = 4;
  Timer? _timer;

  final Map<BreathingPhase, int> phaseDuration = {
    BreathingPhase.inhale: 4,
    BreathingPhase.hold: 7,
    BreathingPhase.exhale: 8,
  };

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _startPhase(BreathingPhase.inhale);
  }

  void _startPhase(BreathingPhase phase) {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _currentPhase = phase;
      _secondsRemaining = phaseDuration[phase]!;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          BreathingPhase nextPhase;
          switch (_currentPhase) {
            case BreathingPhase.inhale:
              nextPhase = BreathingPhase.hold;
              break;
            case BreathingPhase.hold:
              nextPhase = BreathingPhase.exhale;
              break;
            case BreathingPhase.exhale:
              nextPhase = BreathingPhase.inhale;
              break;
          }
          _startPhase(nextPhase);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дыхательное упражнение'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _timer?.cancel();
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return SizedBox(
                      width: 250,
                      height: 250,
                      child: CustomPaint(
                        painter: WavePainter(
                          animationValue: _waveController.value,
                          centerColor: AppColors.primaryBlue,
                          waveColor: AppColors.primaryBlue.withOpacity(0.4),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                Text(
                  _getPhaseText(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$_secondsRemaining сек',
                  style: const TextStyle(
                    fontSize: 24,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _getInstructionText(),
                  style: const TextStyle(fontSize: 16, color: AppColors.primaryBlue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () {
                    _timer?.cancel();
                    _startPhase(BreathingPhase.inhale);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(color: AppColors.primaryBlue),
                  ),
                  child: const Text('Начать заново'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPhaseText() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return 'Вдох';
      case BreathingPhase.hold:
        return 'Задержка';
      case BreathingPhase.exhale:
        return 'Выдох';
    }
  }

  String _getInstructionText() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        return 'Медленно вдыхайте через нос';
      case BreathingPhase.hold:
        return 'Задержите дыхание';
      case BreathingPhase.exhale:
        return 'Медленно выдыхайте через рот';
    }
  }
}

enum BreathingPhase { inhale, hold, exhale }

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color centerColor;
  final Color waveColor;

  WavePainter({
    required this.animationValue,
    required this.centerColor,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    const int waveCount = 3;
    for (int i = 0; i < waveCount; i++) {
      double phase = (animationValue - i * 0.33) % 1.0;
      if (phase < 0) phase += 1.0;

      double radius = 20.0 + (maxRadius - 20.0) * phase;
      double opacity = (1.0 - phase).clamp(0.0, 1.0) * 0.6;

      final paint = Paint()
        ..color = waveColor.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawCircle(center, radius, paint);
    }

    final centerPaint = Paint()
      ..color = centerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 50, centerPaint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
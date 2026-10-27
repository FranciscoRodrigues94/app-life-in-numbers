
import 'dart:math' as math;
import 'package:flutter/material.dart';

class MascotWidget extends StatefulWidget {
  const MascotWidget({super.key, this.size = 280});

  final double size;

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget> with TickerProviderStateMixin {
  late final AnimationController _idleController;
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
  }

  @override
  void dispose() {
    _idleController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  Widget _layer(String name) {
    return Image.asset(
      'assets/mascot/$name.png',
      fit: BoxFit.contain,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Mascot asset error ($name): $error');
        return const SizedBox.shrink();
      },
    );
  }

  Widget _animatedArm(String name, double angle, Alignment origin) {
    return Transform.rotate(
      angle: angle,
      alignment: origin,
      child: _layer(name),
    );
  }

  double _waveAngle(double progress) {
    if (progress <= 0 || progress >= 1) return 0;
    final envelope = math.sin(progress * math.pi);
    final oscillation = math.sin(progress * 4 * math.pi);
    return envelope * (0.12 + oscillation * 0.10);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_idleController, _waveController]),
        builder: (context, child) {
          final phase = _idleController.value * 2 * math.pi;
          final breathing = math.sin(phase) * 2;
          final armAngle = math.sin(phase) * 0.035;
          final waveAngle = _waveAngle(_waveController.value);

          return Transform.translate(
            offset: Offset(0, breathing),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _layer('left_leg'),
                _layer('right_leg'),
                _animatedArm('left_arm', armAngle + waveAngle, const Alignment(0.60, 0.25)),
                _animatedArm('right_arm', -armAngle, const Alignment(0.55, 0.20)),
                _layer('body'),
                _layer('side_knob'),
                _layer('top_button'),
              ],
            ),
          );
        },
      ),
    );
  }
}

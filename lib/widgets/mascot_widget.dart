
import 'dart:math' as math;
import 'package:flutter/material.dart';

class MascotWidget extends StatefulWidget {
  const MascotWidget({super.key, this.size = 280});

  final double size;

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _idleController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _idleController.dispose();
    super.dispose();
  }

  Widget _layer(String name) {
    return Image.asset(
      'assets/mascot/$name.png',
      fit: BoxFit.fill,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Mascot asset error ($name): $error');
        return const SizedBox.shrink();
      },
    );
  }

  Widget _animatedPart(String name, double angle, Alignment origin) {
    return Transform.rotate(
      angle: angle,
      alignment: origin,
      child: _layer(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _idleController,
        builder: (context, child) {
          final phase = _idleController.value * 2 * math.pi;
          final breathing = math.sin(phase) * 1.2;
          final leftArmWave = math.sin(phase) * 0.025;
          final rightArmSwing = math.sin(phase) * 0.065;

          return Transform.translate(
            offset: Offset(0, breathing),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _layer('Left_Leg'),
                _layer('Right_Leg'),
                _animatedPart(
                  'Left_Arm',
                  leftArmWave,
                  const Alignment(0.10, 0.10),
                ),
                _animatedPart(
                  'Right_Arm',
                  rightArmSwing,
                  const Alignment(0.50, 0.27),
                ),
                _layer('Main_Body'),
              ],
            ),
          );
        },
      ),
    );
  }
}

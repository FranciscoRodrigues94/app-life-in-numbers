import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1900),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) widget.onFinished();
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _progress(double begin, double end) {
    return ((_controller.value - begin) / (end - begin)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF6),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final appear = Curves.easeOutBack.transform(_progress(0.0, 0.37));
              final titleProgress = Curves.easeOut.transform(_progress(0.42, 0.72));
              final jumpProgress = _progress(0.27, 0.60);
              final jump = math.sin(jumpProgress * math.pi) * 13;
              final exit = Curves.easeIn.transform(_progress(0.85, 1.0));
              return Opacity(
                opacity: 1 - exit,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -jump),
                      child: Transform.scale(
                        scale: 0.68 + 0.32 * appear,
                        child: Opacity(
                          opacity: _progress(0.0, 0.25),
                          child: Image.asset(
                            'assets/icon/app_icon.png',
                            width: (MediaQuery.sizeOf(context).width * 0.44).clamp(130.0, 200.0).toDouble(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Opacity(
                      opacity: titleProgress,
                      child: Transform.translate(
                        offset: Offset(0, 12 * (1 - titleProgress)),
                        child: Text(
                          'LIFE IN NUMBERS',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: const Color(0xFF18344B),
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

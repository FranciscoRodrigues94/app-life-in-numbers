
import 'package:flutter/material.dart';

class MascotWidget extends StatelessWidget {
  const MascotWidget({super.key, this.height = 290});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: height * 0.88,
                height: height * 0.88,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9EFE5),
                  shape: BoxShape.circle,
                ),
              ),
              Transform.rotate(
                angle: -0.06,
                child: Container(
                  width: height * 0.72,
                  height: height * 0.65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3DE),
                    borderRadius: BorderRadius.circular(42),
                    border: Border.all(color: const Color(0xFF344857), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF18344B).withValues(alpha: 0.12),
                        blurRadius: 15,
                        offset: const Offset(0, 9),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 17),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF263B49),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: FittedBox(
                          child: Text(
                            'HELLO',
                            style: TextStyle(
                              color: const Color(0xFFFFF7E8),
                              fontSize: height * 0.095,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.sentiment_very_satisfied_rounded, color: Color(0xFF18344B), size: 45),
                          Container(width: 18, height: 18, decoration: const BoxDecoration(color: Color(0xFFFFBE9F), shape: BoxShape.circle)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Icon(Icons.auto_awesome_rounded, color: const Color(0xFFFFBC70), size: height * 0.13),
              ),
              Positioned(
                right: 0,
                top: height * 0.2,
                child: Icon(Icons.waving_hand_rounded, color: const Color(0xFF18344B), size: height * 0.14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

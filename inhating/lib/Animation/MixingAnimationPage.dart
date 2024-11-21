import 'package:flutter/material.dart';
import 'dart:math';

class MixingAnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            LiquidMixWaveAnimation(), // 곡선의 출렁임 애니메이션
            BubbleAnimation(), // 기포가 올라와 곡선에 닿으면 사라지는 애니메이션
          ],
        ),
      ),
    );
  }
}

// 곡선 애니메이션 위젯
class LiquidMixWaveAnimation extends StatefulWidget {
  static double getWaveY(double x, Size size, double waveHeight,
      double waveSpeed, double waveProgress, double phaseShift) {
    double waveLength = size.width;
    double baseHeight = size.height * 0.5;
    return baseHeight +
        sin((x / waveLength * 2 * pi * waveSpeed) + waveProgress + phaseShift) *
            waveHeight;
  }

  @override
  _LiquidMixWaveAnimationState createState() => _LiquidMixWaveAnimationState();
}

class _LiquidMixWaveAnimationState extends State<LiquidMixWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  double get waveProgress => _waveAnimation.value;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();

    _waveAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_waveController);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(waveProgress: waveProgress),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

// 곡선을 그리는 Painter
class WavePainter extends CustomPainter {
  final double waveProgress;

  WavePainter({required this.waveProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color.fromARGB(255, 172, 217, 255).withOpacity(0.4);
    final paint2 = Paint()
      ..color = const Color.fromARGB(255, 255, 162, 24).withOpacity(0.7);

    final path1 = Path();
    final path2 = Path();

    // 파도 1의 속도, 높이, 위상
    double waveHeight1 = 6;
    double waveSpeed1 = 1.2;
    double phaseShift1 = 0;

    // 파도 2의 속도, 높이, 위상
    double waveHeight2 = 10;
    double waveSpeed2 = 0.8;
    double phaseShift2 = pi / 2;

    // 파도 1 그리기
    path1.moveTo(
        0,
        LiquidMixWaveAnimation.getWaveY(
            0, size, waveHeight1, waveSpeed1, waveProgress, phaseShift1));
    for (double i = 0; i <= size.width; i++) {
      path1.lineTo(
          i,
          LiquidMixWaveAnimation.getWaveY(
              i, size, waveHeight1, waveSpeed1, waveProgress, phaseShift1));
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // 파도 2 그리기
    path2.moveTo(
        0,
        LiquidMixWaveAnimation.getWaveY(
            0, size, waveHeight2, waveSpeed2, waveProgress, phaseShift2));
    for (double i = 0; i <= size.width; i++) {
      path2.lineTo(
          i,
          LiquidMixWaveAnimation.getWaveY(
              i, size, waveHeight2, waveSpeed2, waveProgress, phaseShift2));
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 기포 애니메이션 위젯
class BubbleAnimation extends StatefulWidget {
  @override
  _BubbleAnimationState createState() => _BubbleAnimationState();
}

class _BubbleAnimationState extends State<BubbleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _bubbleController;
  List<Bubble> bubbles = [];

  @override
  void initState() {
    super.initState();

    _bubbleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..addListener(() {
        setState(() {
          for (var bubble in bubbles) {
            if (bubble.isOutOfScreen) {
              bubble.reset();
            }
          }
        });
      });

    bubbles = List.generate(10, (_) => Bubble.random());
    _bubbleController.repeat();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblesPainter(
            bubbles: bubbles,
            waveProgress: _bubbleController.value * 2 * pi,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

// 기포 속성 클래스
class Bubble {
  double x;
  double y;
  double size;
  double speed;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
  });

  bool get isOutOfScreen => y <= 0;

  void reset() {
    final random = Random();
    x = random.nextDouble();
    y = 1.2;
    size = 2 + random.nextDouble() * 3;
    speed = 0.2 + random.nextDouble() * 0.3;
  }

  factory Bubble.random() {
    final random = Random();
    return Bubble(
      x: random.nextDouble(),
      y: 1.2,
      size: 2 + random.nextDouble() * 3,
      speed: 0.2 + random.nextDouble() * 0.3,
    );
  }
}

// 기포 애니메이션을 그리는 Painter
class BubblesPainter extends CustomPainter {
  final List<Bubble> bubbles;
  final double waveProgress;

  BubblesPainter({required this.bubbles, required this.waveProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.7);

    for (var bubble in bubbles) {
      bubble.y -= bubble.speed * 0.008;

      final dx = bubble.x * size.width;
      final dy = size.height * bubble.y;

      // 곡선의 위치 계산
      double waveY = LiquidMixWaveAnimation.getWaveY(
          bubble.x * size.width, size, 8, 1.2, waveProgress, 0);

      if (dy <= waveY) {
        bubble.reset(); // 곡선의 높이에 닿으면 기포 리셋
      } else {
        canvas.drawCircle(Offset(dx, dy), bubble.size, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

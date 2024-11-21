import 'package:flutter/material.dart';
import 'package:inhating/Animation/MixingAnimationPage.dart'; // MixingAnimationPage import

class AlcholTingMatch extends StatefulWidget {
  @override
  _AlcholTingMatchState createState() => _AlcholTingMatchState();
}

class _AlcholTingMatchState extends State<AlcholTingMatch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isMatching = false; // 매칭 상태를 직접 관리

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startMatching() {
    setState(() {
      isMatching = true; // 매칭 상태 변경
    });
    _controller.forward(); // 물 차오르는 애니메이션 시작
  }

  void _stopMatching() {
    setState(() {
      isMatching = false; // 매칭 상태 변경
    });
    _controller.reverse(); // 물 내려가는 애니메이션 시작
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Background.png"), // 배경 이미지
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[400]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Mixing Animation (물이 차오르는 애니메이션)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Positioned(
                          bottom: 0, // 애니메이션이 아래에서 시작하도록 설정
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity, // Constrain width
                            height: _animation
                                .value, // Constrained height with animation
                            child:
                                MixingAnimationPage(), // Mixing animation page
                          ),
                        );
                      },
                    ),

                    // 버튼과 텍스트
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isMatching ? '상대를 찾는 중' : '대충 니 티어',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 350,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  isMatching ? _stopMatching : _startMatching,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isMatching
                                    ? const Color.fromARGB(
                                        255, 255, 106, 95) // 중지 버튼 색상
                                    : Colors.grey[500], // 매칭 시작 버튼 색상
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                isMatching ? '중지' : '매칭 시작',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

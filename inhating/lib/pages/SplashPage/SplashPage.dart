import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 3초 후 LoginPage로 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Container(
        // 그라데이션 배경 설정
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6BCFF), // 연한 파랑색
              Color(0xFF98D3F6), // 조금 더 진한 파랑색
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '인하대의 대학생 커뮤니티를 위한',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
              Image.asset(
                'assets/image.png', // 이미지 파일 경로
                width: 500,
                height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

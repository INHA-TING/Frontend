import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50), // 위쪽 여백을 줄임
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 위에서부터 정렬
            children: [
              Text(
                '인하대의 모든 팅',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/MainLogoBlue.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              // 아이디 입력 필드
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  style: TextStyle(fontSize: 20), // 입력 및 라벨 텍스트 크기 통일
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // 비밀번호 입력 필드
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 20), // 입력 및 라벨 텍스트 크기 통일
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0), // 입력 필드와 동일한 패딩 적용
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 아이디 비밀번호 찾기 기능 추가
                      },
                      child: Text(
                        '아이디 / 비밀번호 찾기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // 로그인 및 회원가입 버튼
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로그인 버튼
                  SizedBox(
                    width: 350, // 버튼 너비를 고정
                    child: ElevatedButton(
                      onPressed: () {
                        // 로그인 기능 추가
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0077B6), // 로그인 버튼 색상
                        foregroundColor: Colors.white, // 텍스트 색상
                        padding: EdgeInsets.symmetric(vertical: 10), // 버튼 높이 조정
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('로그인'),
                    ),
                  ),
                  SizedBox(height: 10), // 버튼 간의 간격
                  // 회원가입 버튼
                  SizedBox(
                    width: 350, // 버튼 너비를 고정
                    child: ElevatedButton(
                      onPressed: () {
                        // 회원가입 기능 추가
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD0E3FF), // 회원가입 버튼 색상
                        foregroundColor: Colors.black, // 텍스트 색상
                        padding: EdgeInsets.symmetric(vertical: 10), // 버튼 높이 조정
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('회원가입'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:inhating/pages/Chat/Communication.dart';
import 'package:inhating/pages/OnboardingPage/Onboarding.dart';
import 'package:inhating/pages/Register_Login/AgreementPage.dart';
import 'package:inhating/pages/Register_Login/Register.dart';
import 'package:inhating/pages/Register_Login/UserAuthentication.dart';
import 'package:inhating/pages/UserPage/MyPage.dart';
import 'package:provider/provider.dart';
import 'package:inhating/pages/MainPage/AlcholTing/AlcholTing.dart';
import 'package:inhating/pages/MainPage/MajorTIng/MajorTing.dart';
import 'package:inhating/pages/MainPage/TaxiTing/TaxiTing.dart';
import 'package:inhating/Providers/MatchingProvider.dart';
import 'package:inhating/pages/SplashPage/SplashPage.dart';
import 'package:inhating/pages/Register_Login/LoginPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MatchingProvider()), // MatchingProvider 등록
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // 초기 라우트를 스플래시 페이지로 설정
      routes: {
        '/': (context) => const SplashPage(), // 스플래시 페이지
        '/login': (context) => const LoginPage(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/agreement': (context) => const AgreementPage(),
        '/userAuthentication': (context) => const UserAuthenticationPage(),
        '/signup': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(), // 메인 홈 페이지
        '/communication': (context) =>
            const CommunicationPage(), // 친구 목록 페이지 라우트 추가
        '/myPage': (context) => const MyPage(),
      },
    );
  }
}

// Home Page with Tabs
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.png'), // 배경 이미지 경로
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 32.0), // 로고와 프로필 위에 공간 추가

            // 사용자 아이콘과 로고를 페이지 상단에 배치
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/', // 로고 이미지 경로
                    height: 40,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.grey),
                    onPressed: () {Navigator.pushNamed(context, '/myPage');},
                  ),
                ],
              ),
            ),

            // 탭 바 설정 (하이라이트 효과 적용)
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicator: BoxDecoration(
                color: Colors.blue[100], // 하이라이트 배경색
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              indicatorSize: TabBarIndicatorSize.tab, // 하이라이트 크기 설정
              tabs: const [
                Tab(text: '술배팅'),
                Tab(text: '과팅'),
                Tab(text: '택시팅'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(), // 스와이프 비활성화
                children: const [
                  AlcholTing(), // 첫 번째 탭: 술배팅 페이지
                  MajorTIng(), // 두 번째 탭: 과팅 페이지
                  TaxiTIng(), // 세 번째 탭: 택시팅 페이지
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // 버튼 색상
        onPressed: () {
          Navigator.pushNamed(context, '/communication');
        },
        child: const Icon(Icons.chat, color: Colors.white), // 채팅 아이콘
      ),
    );
  }
}

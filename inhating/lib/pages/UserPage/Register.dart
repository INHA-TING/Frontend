import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // 재사용 가능한 입력 필드 위젯
  Widget buildInputField(String labelText,
      {int maxLines = 1, bool hideLabel = false, String hintText = '입력하세요'}) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    // 입력이 시작될 때와 포커스를 잃을 때 상태를 갱신
    focusNode.addListener(() {
      if (!focusNode.hasFocus && controller.text.isEmpty) {
        controller.text = ''; // 힌트를 보이게 유지
      }
    });

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!hideLabel)
                Expanded(
                  flex: 1,
                  child: Text(
                    labelText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              if (!hideLabel) const SizedBox(width: 8.0), // 레이블과 입력창 사이의 간격
              Expanded(
                flex: hideLabel ? 4 : 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                    ),
                    style: const TextStyle(fontSize: 14),
                    onChanged: (text) {
                      // 입력 시 상태 갱신
                      if (text.isNotEmpty && focusNode.hasFocus) {
                        controller.notifyListeners(); // 강제 업데이트
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10), // 각 필드 사이의 간격
      ],
    );
  }

  // 중앙 정렬된 섹션 제목 위젯
  Widget buildSectionTitle(String title) {
    return Column(
      children: [
        const SizedBox(height: 20), // 제목 위에 공간 추가
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 10), // 제목과 다음 필드 사이의 간격
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 고정된 상단 박스
            Container(
              width: double.infinity,
              height: 250,
              color: const Color(0xFFD0E3FF).withOpacity(0.8),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/logo.png',
                        height: 60,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '자신의 정보를 입력해 주세요',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true, // 스크롤바가 항상 보이도록 설정
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 아바타 선택 박스
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '아바타 선택',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 중앙 정렬된 섹션 제목
                              buildSectionTitle('학과 정보 입력'),
                              buildInputField('학과'),
                              buildInputField('학번'),
                              buildSectionTitle('개인 정보 및 성향'),
                              buildInputField('성별'),
                              buildInputField('나이'),
                              buildInputField('MBTI'),
                              buildSectionTitle('주량 및 흡연 여부'),
                              buildInputField('주량'),
                              buildInputField('흡연'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 자기소개 섹션
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildSectionTitle('자기소개'),
                              buildInputField(
                                '', // 레이블을 숨기기 위해 빈 문자열 전달
                                maxLines: 4,
                                hideLabel: true,
                                hintText: '자기소개를 입력해 주세요', // 자기소개 전용 힌트 텍스트
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // 버튼 클릭 시 동작 추가
                  },
                  child: const Text(
                    '시작하기',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

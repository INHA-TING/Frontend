import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  // 재사용 가능한 입력 필드 위젯
  Widget buildInputField(String labelText,
      {int maxLines = 1, bool hideLabel = false, String hintText = '입력하세요'}) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

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
              if (!hideLabel) const SizedBox(width: 8.0),
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
                      if (text.isNotEmpty && focusNode.hasFocus) {
                        controller.notifyListeners();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
        const SizedBox(height: 10),
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
            // 상단 헤더
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
                        'assets/InhaTingLogoMain.png',
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
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
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
                    // 회원가입 완료 메시지 및 로그인 페이지로 이동
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('회원가입 완료'),
                        content: const Text('회원가입이 완료되었습니다. 입력하신 정보는 추후 수정이 가능합니다.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacementNamed(
                                  context, '/login'); // Login 페이지로 이동
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
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

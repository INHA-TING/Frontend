import 'package:flutter/material.dart';
import 'package:inhating/pages/MainPage/MajorTIng/MajorTingMatch.dart';
import 'package:inhating/pages/MainPage/MajorTIng/MajorList.dart'; // MajorList import

class MajorTIng extends StatelessWidget {
  const MajorTIng({super.key});

  // 목록 미리보기 데이터 제공 메서드
  static List<String> fetchPreviewItems(int limit) {
    return List.generate(limit, (index) => "과팅 목록 ${index + 1}"); // 예제 데이터 생성
  }

  @override
  Widget build(BuildContext context) {
    // 미리보기 데이터 (상위 4개만 가져오기)
    final previewItems = fetchPreviewItems(4);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 맨 위 박스
              _buildTopBox(),

              const SizedBox(height: 16),

              // 실시간 과팅 매칭 박스
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MajorTingMatch(),
                    ),
                  );
                },
                child: _buildMatchingBox(),
              ),

              const SizedBox(height: 16),

              // 목록 미리보기 박스
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MajorList(), // limit 전달 X
                    ),
                  );
                },
                child: _buildPreviewBox('목록', previewItems),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBox() {
    return Container(
      width: double.infinity,
      height: 185,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '뭔가 있어야 할 거 같음.. 없으면 허전할 듯. Maybe 오늘의 추천..?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchingBox() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        image: const DecorationImage(
          image: AssetImage('assets/MajorTingButton.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '실시간 과팅 매칭',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // 두 텍스트 간 간격
          Text(
            '과팅이 어쩌구 저쩌구 너내끼리 잼나게 놀아라~',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewBox(String title, List<String> items) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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

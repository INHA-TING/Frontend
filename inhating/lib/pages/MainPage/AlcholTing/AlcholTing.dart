import 'package:flutter/material.dart';
import 'package:inhating/Animation/MixingAnimationPage.dart'; // MixingAnimationPage import
import 'package:inhating/pages/MainPage/AlcholTing/Ranking.dart';
import 'package:inhating/pages/MainPage/AlcholTing/Record.dart';
import 'package:provider/provider.dart';
import 'package:inhating/Providers/MatchingProvider.dart'; // MatchingProvider import

class AlcholTing extends StatefulWidget {
  const AlcholTing({super.key});

  @override
  _AlcholTingState createState() => _AlcholTingState();
}

class _AlcholTingState extends State<AlcholTing>
    with SingleTickerProviderStateMixin {
  bool showConditionBox = false; // 조건 선택 박스 표시 여부
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.reset(); // 애니메이션 초기화
    _controller.forward(); // 애니메이션 시작
  }

  void _stopAnimation() {
    _controller.stop(); // 애니메이션 중지
  }

  @override
  Widget build(BuildContext context) {
    final matchingProvider = Provider.of<MatchingProvider>(context);
    final isMatching = matchingProvider.isMatching; // 전역 매칭 상태

    // 매칭 상태에 따라 애니메이션 상태 동기화
    if (isMatching) {
      _startAnimation();
    } else {
      _stopAnimation();
    }

    final previewPosts = RecordPage.getPreviewPosts(4); // 게시글 미리보기 데이터
    final previewRankings = RankingPage.getPreviewRankings(4); // 랭킹 미리보기 데이터

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

              // '팅 잡기' 버튼 또는 매칭 화면
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: isMatching
                    ? _buildConditionOrMatchingBox(isMatching, matchingProvider)
                    : showConditionBox
                        ? _buildConditionOrMatchingBox(
                            isMatching, matchingProvider)
                        : _buildFindButton(),
              ),

              const SizedBox(height: 16),

              // 게시판 박스
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecordPage()),
                  );
                },
                child: _buildPreviewBox('목록', previewPosts),
              ),

              const SizedBox(height: 16),

              // 랭킹 박스
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RankingPage()),
                  );
                },
                child: _buildPreviewBox('랭킹', previewRankings),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: const EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '티어 / 매너온도 (lv)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    endIndent: 16,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '어쩌구 저쩌구',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFindButton() {
    return GestureDetector(
      onTap: () {
        _startAnimation();
        setState(() {
          showConditionBox = true; // 조건 선택 박스 표시
        });
      },
      child: Container(
        width: double.infinity,
        height: 60,
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '팅 잡기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionOrMatchingBox(
      bool isMatching, MatchingProvider matchingProvider) {
    final boxHeight = isMatching ? 150.0 : 250.0; // 매칭 중 높이: 150, 조건 박스 높이: 250

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: boxHeight, // 매칭 상태에 따라 높이 변경
      decoration: BoxDecoration(
        color: isMatching ? Colors.white : Colors.grey[400],
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
          // Mixing Animation
          if (isMatching)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150 * _animation.value,
                    child: MixingAnimationPage(),
                  ),
                );
              },
            ),

          // 텍스트와 버튼
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isMatching)
                  const Text(
                    '조건을 선택해 주세요',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                if (!isMatching) const SizedBox(height: 16),
                if (!isMatching)
                  Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '박스 내용 추가 가능',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                if (!isMatching) const SizedBox(height: 16),
                if (isMatching) ...[
                  const Text(
                    '상대를 찾는 중...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: 350,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isMatching) // 매칭 중이 아닐 때만 뒤로 가기 버튼 표시
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showConditionBox = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              '뒤로 가기',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      if (!isMatching) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isMatching) {
                              matchingProvider.stopMatching();
                              setState(() {
                                showConditionBox = true;
                              });
                            } else {
                              matchingProvider.startMatching();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isMatching
                                ? const Color.fromARGB(255, 255, 106, 95)
                                : Colors.grey[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isMatching ? '중지' : '매칭 시작',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

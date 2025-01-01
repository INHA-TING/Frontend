import 'package:flutter/material.dart';

class PlusFriend extends StatefulWidget {
  final Function(int friendId) onConfirm; // 선택된 친구 ID를 전달하는 콜백
  final double friendBoxHeight; // 내부 친구 박스의 높이 지정

  const PlusFriend({
    super.key,
    required this.onConfirm,
    this.friendBoxHeight = 50, required int currentCount, // 기본 높이 설정
  });

  @override
  _PlusFriendState createState() => _PlusFriendState();
}

class _PlusFriendState extends State<PlusFriend> {
  final List<bool> _isCheckedList =
      List.generate(20, (index) => false); // 20명의 친구 체크 상태 관리

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '친구 추가',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // 회색 배경 박스
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8), // 모서리 둥글기
              ),
              child: ListView.builder(
                itemCount: 20, // Assume 20 friends
                padding: const EdgeInsets.only(
                  top: 8.0, // 첫 번째 박스 위 간격
                  bottom: 8.0, // 마지막 박스 아래 간격
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ), // 박스 간격 설정
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12), // 내부 패딩 설정
                    height: widget.friendBoxHeight, // 외부에서 지정한 높이 적용
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12), // 테두리
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // 원형 도형 추가
                            CircleAvatar(
                              radius: 16, // 원형 크기
                              backgroundColor: Colors.blue[300], // 배경 색상
                              child: Text(
                                '${index + 1}', // 친구 번호
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12), // 원형과 텍스트 간 간격
                            Text(
                              'Friend_s ID ${index + 1}', // 친구 이름
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: _isCheckedList[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckedList[index] = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 팝업 닫기
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('닫기'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 체크된 친구 ID만 필터링하여 부모로 전달
                for (int i = 0; i < _isCheckedList.length; i++) {
                  if (_isCheckedList[i]) {
                    widget.onConfirm(i + 1); // 체크된 친구 ID 전달
                  }
                }
                Navigator.pop(context); // 팝업 닫기
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}

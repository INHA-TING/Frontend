import 'package:flutter/material.dart';

class FriendBox extends StatefulWidget {
  final int id; // FriendBox의 고유 ID
  final int? expandedId; // 현재 확장된 박스의 ID
  final VoidCallback onExpand; // 박스 확장 콜백
  final VoidCallback onRemove; // 박스 삭제 콜백
  final String friendText; // 동적 텍스트

  const FriendBox({
    super.key,
    required this.id,
    required this.expandedId,
    required this.onExpand,
    required this.onRemove,
    required this.friendText, // 동적 텍스트 추가
  });

  @override
  _FriendBoxState createState() => _FriendBoxState();
}

class _FriendBoxState extends State<FriendBox>
    with SingleTickerProviderStateMixin {
  bool get _isExpanded => widget.id == widget.expandedId; // 현재 박스가 확장 상태인지 확인

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onExpand, // 확장 콜백 호출
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 동적 텍스트 표시
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                widget.friendText, // 전달받은 텍스트를 렌더링
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // 버튼 영역
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint('정보 보기 클릭');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 218, 218, 218),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('정보 보기'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onRemove, // "삭제" 버튼 클릭 시 콜백 호출
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 138, 138, 138),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('삭제'),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const SizedBox.shrink(), // 축소 상태일 때 빈 공간
            ),
          ],
        ),
      ),
    );
  }
}

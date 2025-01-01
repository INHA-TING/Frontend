import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inhating/Providers/MatchingProvider.dart';
import 'PlusFriend.dart';
import 'package:inhating/pages/Friend/FriendBox.dart';

class MajorTingMatch extends StatefulWidget {
  const MajorTingMatch({super.key});

  @override
  State<MajorTingMatch> createState() => _MajorTingMatchState();
}

class _MajorTingMatchState extends State<MajorTingMatch> {
  int? _expandedId; // 현재 확장된 박스의 ID
  final int maxFriends = 4; // 최대 친구 수 제한

  void _toggleExpand(int id) {
    setState(() {
      _expandedId = (_expandedId == id) ? null : id; // 클릭된 박스만 확장
    });
  }

  void _showSingleMessage(String message) {
    if (ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).clearSnackBars(); // 기존 메시지 제거
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchingProvider = Provider.of<MatchingProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 콘텐츠
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '실시간 과팅',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '어쩌구 저쩌구 약간 간략한 설명',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 조건 박스
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                    child: Column(
                      children: [
                        const Text(
                          '매칭 환경',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              '과팅 세부 사항',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 팀원 박스
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                    child: Column(
                      children: [
                        const Text(
                          '팀원',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // "본인" 박스
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Your ID',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 친구 목록
                        ...matchingProvider.majorSelectedFriends.map(
                          (id) => FriendBox(
                            id: id,
                            expandedId: _expandedId,
                            onExpand: () => _toggleExpand(id),
                            onRemove: () =>
                                matchingProvider.removeMajorFriend(id),
                            friendText: 'Friend_s ID $id',
                          ),
                        ),
                        if (matchingProvider.majorSelectedFriends.length <
                                maxFriends &&
                            !matchingProvider.isMajorMatching)
                          GestureDetector(
                            onTap: () {
                              if (matchingProvider
                                      .majorSelectedFriends.length >=
                                  maxFriends) {
                                _showSingleMessage('최대 4명까지만 친구를 추가할 수 있습니다.');
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: [
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            color: const Color.fromARGB(
                                                    255, 173, 173, 173)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        Center(
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: PlusFriend(
                                              onConfirm: (friendId) {
                                                if (matchingProvider
                                                        .majorSelectedFriends
                                                        .length >=
                                                    maxFriends) {
                                                  _showSingleMessage(
                                                      '최대 4명까지만 친구를 추가할 수 있습니다.');
                                                } else {
                                                  matchingProvider
                                                      .addMajorFriend(friendId);
                                                }
                                              },
                                               currentCount: matchingProvider.majorSelectedFriends.length, // 추가된 매개변수
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        // 매칭 시작 버튼
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: matchingProvider.isMajorMatching
                                ? const Color.fromARGB(255, 103, 103, 255)
                                : const Color.fromARGB(255, 255, 103, 103),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (matchingProvider.isAlcholMatching) {
                                _showSingleMessage(
                                    '술배팅 매칭 중에는 과팅 매칭을 시작할 수 없습니다.');
                                return;
                              }
                              if (matchingProvider.majorSelectedFriends.length +
                                      1 <
                                  2) {
                                _showSingleMessage('매칭을 시작하려면 최소 2명이 필요합니다.');
                                return;
                              }
                              if (matchingProvider.isMajorMatching) {
                                matchingProvider.stopMajorMatching();
                              } else {
                                matchingProvider.startMajorMatching();
                              }
                            },
                            child: Text(
                              matchingProvider.isMajorMatching ? '중지' : '매칭 시작',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
          ),
        ],
      ),
    );
  }
}

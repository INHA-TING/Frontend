import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  // 전체 랭킹 데이터
  static final List<String> rankings = [
    "1위: 홍길동",
    "2위: 김철수",
    "3위: 이영희",
    "4위: 박영수",
    "5위: 박민수",
    "6위: 최영환",
  ];

  // 랭킹 미리보기 데이터 제공 메서드
  static List<String> getPreviewRankings(int limit) {
    return rankings.take(limit).toList(); // 상위 limit개의 데이터 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('랭킹'),
      ),
      body: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rankings[index]),
            leading: const Icon(Icons.star), // 랭킹 아이콘
          );
        },
      ),
    );
  }
}

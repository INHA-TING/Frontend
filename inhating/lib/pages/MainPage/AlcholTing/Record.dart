import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  // 전체 게시판 데이터
  static final List<String> posts = [
    "게시판 내용 1",
    "게시판 내용 2",
    "게시판 내용 3",
    "게시판 내용 4",
    "게시판 내용 5",
    "게시판 내용 6",
  ];

  // 게시판 미리보기 데이터 제공 메서드
  static List<String> getPreviewPosts(int limit) {
    return posts.take(limit).toList(); // 상위 limit개의 데이터 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시판'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index]),
            leading: const Icon(Icons.article), // 게시글 아이콘
            onTap: () {
              // 게시글 클릭 시 동작 정의 가능
            },
          );
        },
      ),
    );
  }
}

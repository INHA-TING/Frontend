import 'package:flutter/material.dart';

class MajorList extends StatelessWidget {
  const MajorList({super.key});

  // 데이터를 서버에서 가져온다고 가정 (limit에 따라 동적으로 생성)
  List<String> fetchItems(int limit) {
    return List.generate(limit, (index) => "과팅 목록 ${index + 1}");
  }

  @override
  Widget build(BuildContext context) {
    const limit = 100; // 전체 목록 개수
    final items = fetchItems(limit);

    return Scaffold(
      appBar: AppBar(
        title: const Text('목록'),
        centerTitle: true,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                items[index],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

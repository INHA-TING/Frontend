import 'package:flutter/material.dart';
import 'package:inhating/pages/Chat/Chat.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2개의 탭
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 샘플 친구 데이터
    final List<Map<String, String>> friends = [
      {"name": "김민기", "status": "온라인"},
      {"name": "김종연", "status": "온라인"},
      {"name": "박근채", "status": "온라인"},
    ];

    // 샘플 채팅 데이터
    final List<Map<String, String>> chats = [
      {"name": "김민기", "lastMessage": "씨바"},
      {"name": "김종연", "lastMessage": "존나게"},
      {"name": "박근채", "lastMessage": "하기 싫다"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니케이션'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: '친구'),
            Tab(text: '채팅'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Friends 탭
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '신규 요청',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(
                          '정', // 첫 글자
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: const Text(
                        '정연우',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('오프라인'),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Opening chat with 정연우')),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '친구 목록',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                       color: Colors.grey[400],
                  
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: friends.map((friend) {
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Text(
                              friend['name']![0], // 첫 글자
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(friend['name']!),
                          subtitle: Text(friend['status']!),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Opening chat with ${friend['name']}')),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Chats 탭
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '개인',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    
                    decoration: BoxDecoration(
                         color: Colors.grey[400],
                    
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: chats.map((chat) {
                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                chat['name']![0], // 첫 글자
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(chat['name']!),
                            subtitle: Text(chat['lastMessage']!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    userName: chat['name']!,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '술배팅',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                         color: Colors.grey[400],
                      
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: const Text('술배팅 내용 예시'),
                        subtitle: const Text('술배팅에 참여하세요!'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                userName: '술배팅',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '과팅',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                         color: Colors.grey[400],
                      
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: const Text('과팅 내용 예시'),
                        subtitle: const Text('과팅에 참여하세요!'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                userName: '과팅',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '택시팅',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                         color: Colors.grey[400],
                      
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: const Text('택시팅 내용 예시'),
                        subtitle: const Text('택시팅에 참여하세요!'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                userName: '택시팅',
                              ),
                            ),
                          );
                        },
                      ),
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

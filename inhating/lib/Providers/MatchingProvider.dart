import 'package:flutter/material.dart';

class MatchingProvider extends ChangeNotifier {
  // 술배팅 매칭 상태
  bool _isAlcholMatching = false;

  // 과팅 매칭 상태
  bool _isMajorMatching = false;

  // 과팅 친구 상태
  final List<int> _majorSelectedFriends = [];

  // 술배팅 매칭 상태
  bool get isAlcholMatching => _isAlcholMatching;

  void startAlcholMatching() {
    if (_isMajorMatching) {
      // 알림: 과팅 매칭 중이라 시작 불가
      notifyListeners();
      return;
    }
    _isAlcholMatching = true;
    notifyListeners();
  }

  void stopAlcholMatching() {
    _isAlcholMatching = false;
    notifyListeners();
  }

  // 과팅 매칭 상태
  bool get isMajorMatching => _isMajorMatching;

  void startMajorMatching() {
    if (_isAlcholMatching) {
      // 알림: 술배팅 매칭 중이라 시작 불가
      notifyListeners();
      return;
    }
    _isMajorMatching = true;
    notifyListeners();
  }

  void stopMajorMatching() {
    _isMajorMatching = false;
    notifyListeners();
  }

  // 과팅 친구 관리
  List<int> get majorSelectedFriends => _majorSelectedFriends;

  void addMajorFriend(int friendId) {
    if (!_majorSelectedFriends.contains(friendId)) {
      _majorSelectedFriends.add(friendId);
      notifyListeners();
    }
  }

  void removeMajorFriend(int friendId) {
    _majorSelectedFriends.remove(friendId);
    notifyListeners();
  }

  void clearMajorFriends() {
    _majorSelectedFriends.clear();
    notifyListeners();
  }
}

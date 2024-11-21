import 'package:flutter/material.dart';

class MatchingProvider extends ChangeNotifier {
  bool _isMatching = false;

  bool get isMatching => _isMatching;

  void startMatching() {
    _isMatching = true;
    notifyListeners();
  }

  void stopMatching() {
    _isMatching = false;
    notifyListeners();
  }
}

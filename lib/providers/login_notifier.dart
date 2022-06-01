import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  bool _enabledButtons = false;

  bool get isLoading1 => _isLoading1;
  bool get isLoading2 => _isLoading2;
  bool get isLoading3 => _isLoading3;
  bool get enabledButtons => _enabledButtons;

  void changeLoad1() {
    _isLoading1 = !_isLoading1;
    notifyListeners();
  }

  void changeLoad2() {
    _isLoading2 = !_isLoading2;
    notifyListeners();
  }

  void changeLoad3() {
    _isLoading3 = !_isLoading3;
    notifyListeners();
  }

  void changeEnabledButtons() {
    _enabledButtons = !_enabledButtons;
    notifyListeners();
  }
}

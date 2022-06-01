import 'package:flutter/material.dart';

class AddCampaignState extends ChangeNotifier {
  bool _isNotLoading = true;
  bool _isNotEnabled = false;
  String _loadMessage = "Procesando";

  bool get isNotLoading => _isNotLoading;
  bool get isEnabled => _isNotEnabled;
  String get loadMessage => _loadMessage;

  void changeLoad() {
    _isNotLoading = !_isNotLoading;
    notifyListeners();
  }

  void chengeEnabled() {
    _isNotEnabled = !_isNotEnabled;
    notifyListeners();
  }

  void loadMessageComplete() {
    _loadMessage = "Completado, redirigiendo";
  }

  void recoveryLoadMessage() {
    _loadMessage = "Procesando";
  }
}

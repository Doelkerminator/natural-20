import 'package:flutter/material.dart';

class AddCampaignState extends ChangeNotifier {
  bool _isNotLoading = true;
  bool _isNotEnabled = false;
  String _loadMessage = "Procesando";
  String _imageStatus = "Ninguna Imagen Seleccionada";

  bool get isNotLoading => _isNotLoading;
  bool get isEnabled => _isNotEnabled;
  String get loadMessage => _loadMessage;
  String get imageStatus => _imageStatus;

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
    notifyListeners();
  }

  void recoveryLoadMessage() {
    _loadMessage = "Procesando";
    notifyListeners();
  }

  void imageStatusTypeNotCorrect() {
    _imageStatus = "Solo se pueden seleccionar archivos PBG y JPG";
    notifyListeners();
  }

  void imageStatusSelected() {
    _imageStatus = "Imagen seleccionada";
    notifyListeners();
  }
}

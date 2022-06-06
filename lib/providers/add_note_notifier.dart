import 'package:flutter/cupertino.dart';
import '../models/notes_model.dart';

class AddNoteState extends ChangeNotifier {
  Note? _noteE = null;
  String _stateNotes = "List";
  bool _isNotLoading = true;
  bool _isNotEnabled = false;
  String _loadMessage = "Procesando";
  String _imageStatus = "Ninguna Imagen Seleccionada";

  String get stateNotes => _stateNotes;
  bool get isNotLoading => _isNotLoading;
  bool get isNotEnabled => _isNotEnabled;
  String get loadMessage => _loadMessage;
  String get imageStatus => _imageStatus;
  Note? get noteE => _noteE;

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

  void imageStatusNoSelected() {
    _imageStatus = "Ninguna Imagen Seleccionada";
    notifyListeners();
  }



  void imageStatusTypeNotCorrectNotLoad() {
    _imageStatus = "Solo se pueden seleccionar archivos PBG y JPG";
  }

  void imageStatusSelectedNotLoad() {
    _imageStatus = "Imagen seleccionada";
  }

  void imageStatusNoSelectedNotLoad() {
    _imageStatus = "Ninguna Imagen Seleccionada";
  }



  void loadMessageDelete() {
    _loadMessage = "Eliminando";
    notifyListeners();
  }

  void changeStateToCreate() {
    _stateNotes = "Create";
    notifyListeners();
  }

  void changeStateToEdit() {
    _stateNotes = "Edit";
    notifyListeners();
  }

  void changeStateToList() {
    _stateNotes = "List";
    notifyListeners();
  }

  Note? changeNoteE(Note? n) {
    _noteE = n;
    notifyListeners();
  }
}

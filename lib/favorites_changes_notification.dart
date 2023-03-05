import 'package:flutter/material.dart';

class ChangesInFavorites extends ChangeNotifier {
  void rebuildFavorites() {
    notifyListeners();
  }
}
// todo delete this

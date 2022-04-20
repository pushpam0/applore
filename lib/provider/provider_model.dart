import 'package:flutter/foundation.dart';

class ProviderModel extends ChangeNotifier {
  var image;

  void imageSet(value) {
    image = value;
    notifyListeners();
  }
}

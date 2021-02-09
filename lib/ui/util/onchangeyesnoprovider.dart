import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OnChangeYesNo extends ChangeNotifier {
  void setState() {
    notifyListeners();
  }
}

import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/service/navigation_service.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';


class BaseModel extends ChangeNotifier {
  final navigationService = getIt<NavigationService>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:flutter/material.dart';

class AppThemeViewModel extends BaseModel{
  ThemeData _themeData;

  AppThemeViewModel(this._themeData);

  getTheme()=>_themeData;
  setTheme(ThemeData theme){
    _themeData=theme;
    setState(ViewState.Idle);
  }
}
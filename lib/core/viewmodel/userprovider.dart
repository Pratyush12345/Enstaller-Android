import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends BaseModel{
  UserModel _user;

  UserProvider(this._user);

  UserModel get logInUser =>_user;
  setTheme(UserModel userModel){
    _user=userModel;
    Prefs.setUserProfile(userModel);
    setState(ViewState.Idle);
  }
}
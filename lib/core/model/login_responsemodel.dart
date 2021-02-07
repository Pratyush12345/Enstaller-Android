import 'package:enstaller/core/model/user_model.dart';

class LoginResponseModel{
  String errorMessage;
  String responseMessage;
  UserModel userDetails;
  LoginResponseModel({this.errorMessage,this.responseMessage,this.userDetails});
}
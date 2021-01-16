import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/login_credentials.dart';
import 'package:enstaller/core/model/login_responsemodel.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInViewModel extends BaseModel{

  ApiService _apiService=ApiService();

  bool rememberMe=false;

  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void onChangeRememberMe(){
    rememberMe =!rememberMe;
    setState(ViewState.Idle);
  }

  void logInWithUserNameAndPassword(BuildContext context)async{
    setState(ViewState.Busy);
    LoginResponseModel response=await _apiService.loginWithUserNamePassword(LoginCredential(
      userName: userNameController.text,
      password: passwordController.text,
      groupType: 'password'
    ));
    if(response.errorMessage!=null){
      setState(ViewState.Idle);
      AppConstants.showFailToast(context,response.errorMessage);
    }else{
      setState(ViewState.Idle);

      Map<String, dynamic> decodedToken = JwtDecoder.decode(response.userDetails.accessToken);
      if(decodedToken!=null) {
        print(decodedToken);
        response.userDetails.username = decodedToken["unique_name"];
        response.userDetails.intEngineerId = decodedToken["EngineerId"];
        response.userDetails.strEngineerName = decodedToken["EngineerName"];
        response.userDetails.role = decodedToken["role"];
        response.userDetails.email = decodedToken["email"];
        response.userDetails.id=decodedToken['nameid'];
      }
       response.userDetails.rememberMe=true;



      Prefs.setUserProfile(response.userDetails);
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('ups', passwordController.text);

      Navigator.of(context).pushNamed("/home");
    }
  }
}
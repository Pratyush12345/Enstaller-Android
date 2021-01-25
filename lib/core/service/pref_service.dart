
import 'package:enstaller/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static Future<UserModel> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String access_token = preferences.getString("access_token");
    String token_type= preferences.getString('token_type');
    String expires_in= preferences.getString('expires_in');
    String id= preferences.getString('id');
    String username= preferences.getString('username');
    String name= preferences.getString('name');
    String email= preferences.getString('email');
    String role=preferences.getString('role');
    String intEngineerId=preferences.getString('intEngineerId');
    String strEngineerName=preferences.getString('strEngineerName');
    String issued=preferences.getString('.issued');
    String expires=preferences.getString('.expires');
    bool rememberMe=preferences.getBool('remember');




    if(intEngineerId!=null){
      return UserModel(id: id ,accessToken: access_token, tokenType: token_type, username: username,
          name: name, role: role,intEngineerId: intEngineerId,strEngineerName: strEngineerName,
      email: email,
      rememberMe: rememberMe,
      issued: issued,expires: expires,expiresIn: int.parse(expires_in));
    }else{
      return UserModel();
    }



  }


  static void setCurrentIndex(int currentIndex) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("currentIndex", currentIndex);

    preferences.commit();
  }
  static Future getCurrentIndex()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int currentIndex=preferences.getInt('currentIndex');
    return currentIndex;
  }

  static void setUserProfile(UserModel userModel) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("access_token", userModel.accessToken.toString());
    preferences.setString("token_type", userModel.tokenType);
    preferences.setString("expires_in", userModel.expiresIn.toString());
    preferences.setString("id", userModel.id);
    preferences.setString("username", userModel.username);
    preferences.setString("email", userModel.email);
    preferences.setString("name", userModel.name);
    preferences.setString('role', userModel.role);
    preferences.setString('intEngineerId',userModel.intEngineerId);
    preferences.setString('strEngineerName', userModel.strEngineerName);
    preferences.setString('.issued', userModel.issued);
    preferences.setString('.expires', userModel.expires);
    preferences.setBool('remember', userModel.rememberMe);
    preferences.commit();
  }


  static void logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("access_token", null);
    preferences.setString("token_type", null);
    preferences.setString("expires_in", null);
    preferences.setString("id", null);
    preferences.setString("username", null);
    preferences.setString("name", null);
    preferences.setString('role', null);
    preferences.setString('intEngineerId', null);
    preferences.setString('strEngineerName', null);
    preferences.setString('.issued', null);
    preferences.setString('.expires', null);
    preferences.commit();
  }
  static void setFirstTime()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogin', true);
    preferences.commit();
  }

  static Future<bool>getFirstTime()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLogin')??false;

  }


}
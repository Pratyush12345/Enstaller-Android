import 'package:enstaller/app_router.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/app_themes.dart';
import 'package:enstaller/core/get_it.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/userprovider.dart';
import 'package:enstaller/ui/login_screen.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:enstaller/ui/screen/warehouse_screens/check_order_assign_stcok.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'core/constant/app_colors.dart';
import 'core/viewmodel/appthemeviewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global = new DevHttpOverrides();
  setupLocator();
  Prefs.getUser().then((value){
    runApp(MyApp(logInUser: value,));
  });

}

class MyApp extends StatelessWidget {
  UserModel logInUser;
  MyApp({this.logInUser});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppThemeViewModel(AppThemes.light)),
        ChangeNotifierProvider.value(value: UserProvider(logInUser))
      ],
      child: MainMaterialApp(loginUser: logInUser,),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  UserModel loginUser;
  MainMaterialApp({this.loginUser});


  @override
  Widget build(BuildContext context) {

    final themeProvider=Provider.of<AppThemeViewModel>(context);

    if(loginUser.rememberMe){
      FlutterStatusbarcolor.setStatusBarColor(AppColors.appThemeColor);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: themeProvider.getTheme(),
        //initialRoute: loginUser.rememberMe ?GlobalVar.roleId == 5? "/checkAssignOrder" :"/home": "/login" ,
        routes: {
          '/login': (BuildContext context) => new LoginScreen(),
          '/home': (BuildContext context) => new HomeScreen(),
          '/checkAssignOrder' : (BuildContext context) => new CheckAndAssignOrder()
        },
      onGenerateRoute: AppRouter.generateRoute,
      home: loginUser.rememberMe? (GlobalVar.roleId == 5? CheckAndAssignOrder() :HomeScreen()) :LoginScreen()  ,
//    home: TestPage(),
    );
  }
}





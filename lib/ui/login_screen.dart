import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/login_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/app_text_field_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isChecked = false;
  bool autoValidation = false;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      body: BaseView<LogInViewModel>(
        builder: (context,model,child){
          return SingleChildScrollView(
            child: Form(
              autovalidate: autoValidation,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight*.3,
                    child: Center(
                      child: Image.asset(ImageFile.logo,height: MediaQuery.of(context).size.height*0.068,),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor
                    ),
                  ),
                  Container(
//                width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight*.76,
                    decoration: BoxDecoration(
                      color: AppColors.loginBottomColor,
                    ),
                    child: Column(
                      children: [
                        SizeConfig.verticalSpace(SizeConfig.screenHeight*.07),
                        Text(AppStrings.logInTitle,style: AppStyles.loginTitle,),
                        SizeConfig.verticalSpace(SizeConfig.screenHeight*.06),
                        AppTextFieldWidget(
                          width:SizeConfig.screenWidth*.8,
                          controller: model.userNameController,
                          hintText: AppStrings.userName,
                          preFix: Icons.person_outline,
                          assetPath: ImageFile.loginUser,

                        ),
                        SizeConfig.verticalSpaceMedium(),
                        AppTextFieldWidget(
                          obsecureText: true,

                          width:SizeConfig.screenWidth*.8,
                          controller: model.passwordController,
                          hintText: AppStrings.password,
                          assetPath: ImageFile.loginPass,

                        ),
                        SizeConfig.verticalSpaceMedium(),

                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.015,
                        ),
                        SizeConfig.verticalSpaceMedium(),
                        model.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
                        AppButton(buttonText: 'Sign In',
                          textStyle: TextStyle(fontWeight: FontWeight.w400,color: AppColors.whiteColor,
                          fontSize: SizeConfig.screenHeight*.02),
                          height: MediaQuery.of(context).size.height*0.06,
                          width: SizeConfig.screenWidth*.8,color: AppColors.loginButtonColor,


                          radius: 20,
                          onTap: (){
                          if(model.userNameController.text.isEmpty){
                            AppConstants.showFailToast(context,"username is required");
                          }
                          else if(model.passwordController.text.isEmpty){
                            AppConstants.showFailToast(context,"password is required");
                          }
                           else{
//                            Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>HomeScreen()));

                              model.logInWithUserNameAndPassword(context);
                            }
                          },),

                        SizeConfig.verticalSpace(SizeConfig.screenHeight*.06),

                        Text('Forgot Password',textAlign: TextAlign.right,style: AppStyles.blueLightThemeTextStyle(context),)
                      ],
                    ),

                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

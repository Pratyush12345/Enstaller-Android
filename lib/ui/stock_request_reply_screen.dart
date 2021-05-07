import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/stock_request_reply_viewmodel.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StockRequestReplyScreen extends StatefulWidget {
  final int intRequestId;

  StockRequestReplyScreen({this.intRequestId});

  @override
  _StockRequestReplyScreenState createState() => _StockRequestReplyScreenState();
}

class _StockRequestReplyScreenState extends State<StockRequestReplyScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<StockRequestReplyViewModel>(
      onModelReady: (model) => model.initializeData(widget.intRequestId),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,

            appBar: AppBar(
              
              brightness: Brightness.dark,
              backgroundColor: AppColors.appThemeColor,
              title: Text(
                "${AppStrings.REPLY_TO_REQUEST}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              automaticallyImplyLeading: true,
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    ImageFile.notification,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : Form(
                  key: form,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizeConfig.CVerticalSpaceBig(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 4,
                      decoration: InputDecoration(

                        labelText: 'Serial Numbers',
                          hintText:'Enter nos. separated by comma',
                          border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'required';
                        }
                        else
                          return null;
                      },
                      onSaved: (value) => model.serialNos = value,
                    ),
                  ),
                SizeConfig.CVerticalSpaceBig(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 4,
                    decoration: InputDecoration(

                      labelText: 'Comment',
                      hintText:'Add your comment',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      // if(value.isEmpty){
                      //   return 'required';
                      // }
                      // else
                        return null;
                    },
                    onSaved: (value) => model.comment = value??'',
                  ),
                ),
                SizeConfig.CVerticalSpaceBig(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: AppButton(
                      height: SizeConfig.screenHeight*.05,
                      buttonText: AppStrings.SEND,
                      color: AppColors.appThemeColor,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor
                      ),
                      radius: 20,
                      onTap: (){
                        // check serial nos.
                        model.sendReply(form, context);
                      },
                    ),
                  ),
              ],

        ),
                ));
      },
    );
  }
}

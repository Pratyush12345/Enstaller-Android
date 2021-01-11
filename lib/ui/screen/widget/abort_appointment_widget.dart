import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/abort_appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/core/viewmodel/userprovider.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbortAppoinmentWidget extends StatefulWidget {
  final String appointmentID;
  AbortAppoinmentWidget({this.appointmentID});
  @override
  _AbortAppoinmentWidgetState createState() => _AbortAppoinmentWidgetState();
}

class _AbortAppoinmentWidgetState extends State<AbortAppoinmentWidget> {
  @override
  Widget build(BuildContext context) {
    return  BaseView<AbortAppointmentViewModel>( 
      onModelReady: (model)=>model.getAbortAppointmentCode(widget.appointmentID),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }else{
          return Container(
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      topLeft: Radius.circular(7)
                    ),
                    color: AppColors.green,),
                  child: Padding(
                    padding: SizeConfig.padding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.abort_text,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear,color: AppColors.whiteColor,))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(AppStrings.abortappointmentCode),
                ),
                SizeConfig.verticalSpaceSmall(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.veryLightGrayColor
                    ),
                    child: commonTextFormField(
                        model.commentController,
                        "Type Code",
                        TextInputType.text,
                        null,
                        true,
                        context,
                        10,
                        false),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              color: AppColors.darkBlue,
                              child: Center(
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 40,
                              color: AppColors.darkBlue,
                              child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        }
      },
    );
  }
}

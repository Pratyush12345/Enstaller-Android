import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/core/viewmodel/userprovider.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentDialogWidget extends StatefulWidget {
  final String appointmentID;
  CommentDialogWidget({this.appointmentID});
  @override
  _CommentDialogWidgetState createState() => _CommentDialogWidgetState();
}

class _CommentDialogWidgetState extends State<CommentDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return  BaseView<CommentDialogViewModel>(
      onModelReady: (model)=>model.getComments(widget.appointmentID),
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
                        Text(AppStrings.APPOINTMENT_COMMENTS,
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
                  child: Text(AppStrings.addComment),
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
                        "Type Comment",
                        TextInputType.text,
                        null,
                        true,
                        context,
                        10,
                        false),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Padding(
                  padding:SizeConfig.sidepadding,
                  child: AppButton(
                    height: SizeConfig.screenHeight*.05,
                    radius: 20,
                    color: AppColors.green,
                    buttonText: AppStrings.submit,
                    textStyle: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),
                    onTap: (){
                      model.onSubmitComment(widget.appointmentID);
                    },

                  ),
                ),
                SizeConfig.verticalSpaceMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(
                    AppStrings.appointmentCommentDetails,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: ListView(
                  children: [
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              color: AppColors.darkBlue,
                              child: Center(
                                  child: Text(
                                    "Date & Time",
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
                                    "Comments",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
              shrinkWrap: true,
                        itemCount: model.comments.length,
              physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: SizeConfig.sidepadding,
                            child: Container(
                              decoration: BoxDecoration(
                                color: index%2==0?AppColors.veryLightGrayColor:AppColors.whiteColor
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child:
                                            Text(AppConstants.formattedSingeDate(DateTime.parse(model.comments[index].dteCapturedAt))),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    color: AppColors.darkGrayColor.withOpacity(.08),
                                    height: 50,

                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 50,
                                      child:
                                      Center(child: Text(model.comments[index].strcomments)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                )),


              ],
            ),
          );
        }
      },
    );
  }
}

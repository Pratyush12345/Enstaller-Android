import 'dart:convert';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/ui/screen/both_close_job.dart';
import 'package:enstaller/ui/screen/elec_close_job.dart';
import 'package:enstaller/ui/screen/gas_close_job.dart';
import 'package:enstaller/ui/screen/warehouse_screens/check_order_assign_stcok.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/survey_screen_viewmodel.dart';
import 'package:enstaller/core/model/survey_response_model.dart';
import 'package:enstaller/ui/screen/signature.dart';
import 'package:enstaller/ui/screen/widget/survey/error_widget.dart';
import 'package:enstaller/ui/screen/widget/survey/show_base64_image.dart';
import 'package:enstaller/ui/screen/widget/survey/show_p_image_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/shared/custom_expanded_tile_widget.dart';
import 'package:enstaller/ui/util/onchangeyesnoprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/scheduler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:enstaller/ui/screen/widget/survey/custom_drop_down.dart';

class SurveyArguments {
  String customerID;
  String appointmentID;
  bool edit;
  DetailsScreenViewModel dsmodel;
  SurveyArguments({this.customerID,this.appointmentID, this.edit, this.dsmodel, });
}

class SurveyScreen extends StatefulWidget {
  static const String routeName = '/surveyScreen';

  final SurveyArguments arguments;
  SurveyScreen({this.arguments});
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  ProgressDialog progressDialog;

  Map<String, String> _processid = {
    "EMREM": "6",
    "GMREM": "81",
    "GICOM": "79",
    "EICOM": "1"
  };
  
  @override
  Widget build(BuildContext context) {
      progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    progressDialog.style(message: 'Please Wait');
  
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          key: _scaffoldKey,
//          drawer: Drawer(
//            child:AppDrawerWidget(),
//          ),
          appBar: AppBar(
            backgroundColor: AppColors.green,
//            leading:Padding(
//              padding: const EdgeInsets.all(18.0),
//              child: InkWell(
//                  onTap: () {
//                    _scaffoldKey.currentState.openDrawer();
//                  },
//                  child: Image.asset(
//                    ImageFile.menuIcon,color: AppColors.whiteColor,
//                  )),
//            ),
            title: Text(
              AppStrings.survey,
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
          body: 
           BaseView<SurveyScreenViewModel>(
            onModelReady: (model) => model.initializeData(
                widget.arguments.appointmentID, widget.arguments.edit, context,  widget.arguments.dsmodel.checkCloseJobModel ),
            builder: (context, model, child) {
              if (model.state == ViewState.Busy) {
                print('busyyyyyyyyyy');
                return AppConstants.circulerProgressIndicator();
              } else {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // model.sectionQuestions[model.sectionQuestions.keys.first]
                      //                 .length ==
                      //             0 &&
                      //         model
                      //                 .sectionAnswers[
                      //                     model.sectionAnswers.keys.first]
                      //                 .length ==
                      //             0
                      model.sectionQuestions.keys.isEmpty &&
                              model.sectionAnswers.keys.isEmpty
                          ? Center(child: Text(AppStrings.surveyDataNotFound))
                          : ListView.builder(
                              controller: scrollController,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              key: Key('builder ${model.selected.toString()}'),
                              itemCount: model.sectionQuestions.keys.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return CustomExpandedTile(
                                  expanded: model.selected == index,
                                  firstChild: InkWell(
                                    child: Container(
                                      color: AppColors.green,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              _getHeaderText(index, model),
                                              style: getTextStyle(
                                                  color: Colors.white,
                                                  isBold: true,
                                                  fontSize: 16.0),
                                            ),
                                            Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      model.onChangeSelected(index);
                                    },
                                  ),
                                  secondChild: Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          color: AppColors.green,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 20, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  _getHeaderText(index, model),
                                                  style: getTextStyle(
                                                      color: Colors.white,
                                                      isBold: true,
                                                      fontSize: 16.0),
                                                ),
                                                RotatedBox(
                                                    quarterTurns: 2,
                                                    child: Icon(
                                                        Icons.arrow_drop_down))
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          model.closeExpand();
                                        },
                                      ),
                                      model.selected >= 0 &&
                                              model.selected <
                                                  model.sectionQuestions.keys
                                                      .length &&
                                              model.selected == index
                                          ? _getChildrenWidget(
                                              model.selected, model)
                                          : Container()
                                    ],
                                  ),
                                );
                              }),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }

  // get header text
  String _getHeaderText(int index, SurveyScreenViewModel model) {
    int i = 0;
    for (int j = 0; j < model.sectionQuestions.keys.length; j++) {
      if (index == i) {
        print(model.sectionQuestions.keys.toList()[index]);
        return model.sectionNames[model.sectionNames.keys.toList()[index]];
      }

      i++;
    }
    
  }

  //get widgets data  as per text
  Widget _getChildrenWidget(int index, SurveyScreenViewModel model) {
    print('object');
    int i = 0;
    for (int j = 0; j < model.sectionQuestions.keys.length; j++) {
      if (index == i) {
        print(model.sectionQuestions.keys.toList()[index]);
        return _getData(
            model.sectionQuestions[model.sectionQuestions.keys.toList()[index]],
            model,
            model.sectionAnswers[model.sectionAnswers.keys.toList()[index]]);
      }

      i++;
    }

    
  }
  void scrollup(){
    scrollController.jumpTo(10.0);
  }
  
  //column data
  Widget _getColumnData(
      SurveyResponseModel surveyResponseModel, SurveyScreenViewModel model) {
    return _getTypeWidget(surveyResponseModel, model, model.validationValue);
  }

  Widget _getData(List<SurveyResponseModel> questions,
      SurveyScreenViewModel model, List<QuestionAnswer> answers) {
    if (!widget.arguments.edit) {
      print('line 270' + questions.length.toString());
      return questions.length == 0
          ? Center(
              child: Text(AppStrings.surveyDataNotFound),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questions.length > 0
                  ? questions.length + 1
                  : questions.length,
              itemBuilder: (context, i) {
                if (i == questions.length && questions.length > 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        AppButton(
                            width: 100,
                            height: 40,
                            radius: 10,
                            color: AppColors.green,
                            buttonText: model.selected <
                                    model.sectionQuestions.keys.length - 2
                                ? AppStrings.next
                                : AppStrings.submit,
                            
                            onTap: () async {
                              if(!model.issubmitted){
                              if (!widget.arguments.edit) {
                                print(model.selected.toString() + 'line 314');
                                int validateconter = 0;
                                // model.clearAnswer();
                                model.onValidation();
                                for (int i = 0; i < questions.length; i++) {
                                  print(questions[i].validate);
                                  if (questions[i].validate != null || questions[i].intQuestionNo == 7|| questions[i].intQuestionNo == 8
                                     || model.sectionDisableQuestions[questions[i].intSectionId].contains(questions[i].intQuestionNo.toString())
                                     || questions[i].isMandatoryOptional == "O") {
                                    
                                    validateconter++;
                                    String reqexp = questions[i].requireExplainationstr;
                                      if(reqexp==null)
                                      reqexp = "";
                                    int index = -1; 
                                    print("length of anserlist is ....................${model.answerList.length} ");
                                    index = model.answerList.indexWhere((element) => element.intsurveyquetionid.trim() == questions[i].intQuestionNo.toString().trim());
                                    if(index == -1){
                                        if(questions[i].validate != null && questions[i].validate != "NotNull" 
                                        && questions[i].intQuestionNo!=null && widget.arguments.appointmentID!=null 
                                        && (model.selected + 1).toString()!=null && model.user.intEngineerId!=null
                                        && !model.sectionDisableQuestions[questions[i].intSectionId].contains(questions[i].intQuestionNo.toString()) ){
                                            model.onAddAnswer(AnswerCredential(
                                            intsurveyquetionid:
                                                questions[i].intQuestionNo.toString(),
                                            intappointmentid:
                                                widget.arguments.appointmentID,
                                            intsurveyid:
                                                (model.selected + 1).toString(),
                                            stranswer: questions[i].validate,
                                            intcreatedby: model.user.intEngineerId,
                                            bisalive: questions[i].bisAlive,
                                            strfilename: "",
                                            strRequireExplaination: reqexp
                                            ));
                                        }
                                    }
                                    else{
                                        model.onAddAnsweratindex(AnswerCredential(
                                            intsurveyquetionid:
                                                questions[i].intQuestionNo.toString(),
                                            intappointmentid:
                                                widget.arguments.appointmentID,
                                            intsurveyid:
                                                (model.selected + 1).toString(),
                                            stranswer: questions[i].validate,
                                            intcreatedby: model.user.intEngineerId,
                                            bisalive: questions[i].bisAlive,
                                            strfilename: "",
                                            strRequireExplaination: reqexp
                                            ), index );
                                    }
                                  } else {
                                    print(validateconter.toString() + 'line 327');
                                    print(questions.length);
                                    print("oooooooooooooooooooo");
                                    // setState(() {
                                    //   if (questions[i].strQuestiontype == 'P' &&
                                    //       validateconter ==
                                    //           questions.length - 2) {
                                    //   } else {}
                                    // });
                                  }
                                }
                                print("llllllllllllllllllll");
                                print(validateconter);
                                print(questions.length);
                                //print(model.disableQuestions.length);
                                //print(model.enableQuestions.length);
                                print(model.sectionDisableQuestions);
                                print("8888888888888888888");
                                print(model.sectionEnableQuestions);

                                print(model
                                    .sectionDisableQuestions[
                                        questions[0].intSectionId]
                                    .length);
                                if (validateconter == questions.length) {
                                  model.incrementCounter(widget.arguments.edit, widget.arguments.appointmentID, questions[0].intSectionId);
                                if(questions[0].strSectionName != "Sign Off" && questions[0].strSectionName != "Abort" )
                                  scrollup();
                                 else{
                                  
                                   progressDialog.show();
                                 } 
                                 print("iiiiiiiiiiiiiiiiiiiiiiiiii");
                                 print(model.issubmitted);
                                 print("iiiiiiiiiiiiiiiiiiiiiiiiii");
                                 String response;
                                     response = await model.onSubmit(
                                      model.selected,
                                      widget.arguments.appointmentID,
                                      context,
                                      widget.arguments.dsmodel,
                                      questions[0].strSectionName
                                      );
                                 
                                if(response == "Sign Off"){
                                    progressDialog.hide();
                                    if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "ELECTRICITY")
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ElecCloseJob(list: model.checkCloseJobModel.table , fromTab: false,
                                    dsmodel: widget.arguments.dsmodel,)));
                                    else if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "GAS")
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GasCloseJob(list: model.checkCloseJobModel.table, fromTab: false,
                                     dsmodel: widget.arguments.dsmodel)));
                                    else if(model.checkCloseJobModel.table.length ==2)
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BothCloseJob(list: model.checkCloseJobModel.table,
                                     dsmodel: widget.arguments.dsmodel)));
                                  }else{
                                    progressDialog.hide();
                                  } 
                                } else {
                                  print("-------------");
                                  print(validateconter);
                                  print(questions.length);
                                  print("-------------");
                                }
                              } else {
                                print(questions[0].intSectionId);
                                model.incrementCounter(widget.arguments.edit, widget.arguments.appointmentID, questions[0].intSectionId);
                              }
                            }
                            },
                          ),
                          if(questions[0].strSectionName.trim() == "Abort")
                          AppButton(
                            width: 100,
                            height: 40,
                            radius: 10,
                            color: AppColors.green,
                            buttonText: "Cancel" ,
                            
                            onTap: () async {
                              if(model.lastselected==-1){
                                Navigator.of(context).pop();
                              }
                              else{
                                SurveyResponseModel surveyResponseModel = model.sectionQuestions[questions[0].intSectionId].firstWhere((element) =>element.intQuestionNo== model.lastSelectedQuestion);
                                int index =  model.sectionQuestions[questions[0].intSectionId].indexWhere((element) =>element.intQuestionNo== model.lastSelectedQuestion);
                                model.sectionQuestions[questions[0].intSectionId][index] = surveyResponseModel;
                                surveyResponseModel.yesNoPressedVal = null;
                                surveyResponseModel.validate = null;

                                model.goToSection(model.lastselected);
                              }
                            },
                          ),
                          
                      ],
                    ),
                  );
                }

                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        _getColumnData(questions[i], model),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
    } else {
      return answers.length == 0
          ? Center(
              child: const Text(AppStrings.surveyDataNotFound),
            )
          : ListView.builder(
              itemCount:
                  answers.length > 0 ? answers.length + 1 : answers.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                if (index == answers.length && answers.length > 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        model.selected < model.sectionQuestions.keys.length - 1
                            ? AppButton(
                                width: 100,
                                height: 40,
                                radius: 10,
                                color: AppColors.green,
                                buttonText: AppStrings.next,
                                onTap: () {
                                  
                                  model.incrementCounter(widget.arguments.edit, widget.arguments.appointmentID, 1);
                                },
                              )
                            : widget.arguments.edit && widget.arguments.dsmodel.appointmentDetails.appointment.appointmentEventType=="OnSite"?
                          AppButton(
                            width: 100,
                            height: 40,
                            radius: 10,
                            color: AppColors.green,
                            buttonText: "Close Job",
                            onTap: (){
                                  if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "ELECTRICITY")
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ElecCloseJob(list: model.checkCloseJobModel.table , fromTab: false,
                                    dsmodel: widget.arguments.dsmodel,)));
                                    else if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "GAS")
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GasCloseJob(list: model.checkCloseJobModel.table, fromTab: false,
                                     dsmodel: widget.arguments.dsmodel)));
                                    else if(model.checkCloseJobModel.table.length ==2)
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BothCloseJob(list: model.checkCloseJobModel.table,
                                    dsmodel: widget.arguments.dsmodel)));
                                  
                            },
                          ): Container()
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: SizeConfig.sidepadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Q: ${answers[index]?.intSurveyQuetionId} " +
                                  answers[index]?.strQuestionText ??
                              "",
                          textAlign: TextAlign.left,
                          style:
                              getTextStyle(color: Colors.black, isBold: true),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      answers[index].strQuestiontype == 'P' &&
                              answers[index].strFileName != ''
                          ? ViewPAnswerImageWidget(
                              url: answers[index].fileUrlPath,
                            )
                          : answers[index].strQuestiontype == 'P' &&
                                  answers[index].strFileName == ''
                              ? ShowBase64Image(
                                  base64String: answers[index]
                                      .strAnswer
                                      .replaceAll('data:image/png;base64,', ''),
                                )
                              : answers[index].strQuestiontype == 'S'
                                  ? ShowBase64Image(
                                      base64String: answers[index]
                                          .strAnswer
                                          .replaceAll(
                                              'data:image/png;base64,', ''),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Ans: " + answers[index]?.strAnswer ??
                                            "",
                                        textAlign: TextAlign.left,
                                        style: getTextStyle(
                                            color: Colors.black, isBold: true),
                                      ),
                                    ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              });
    }
  }

  TextEditingController editController = TextEditingController();

  Widget _getQuestion(SurveyResponseModel surveyResponseModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Q: ${surveyResponseModel.intQuestionNo} " +
                    surveyResponseModel?.strQuestionText ??
                "",
            textAlign: TextAlign.left,
            style: getTextStyle(color: Colors.black, isBold: true),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
  Widget _getImageWidget(SurveyResponseModel surveyResponseModel, SurveyScreenViewModel model){

    int index = model.localSurveyQuestion.indexWhere((element) => 
    element.intQuestionNo == surveyResponseModel.intQuestionNo && element.imagePath == surveyResponseModel.imagePath);
    
    try{
      print("indexxxxxxxxxxxxxxxxxxxxxxxxxx........................$index");
      if(index != -1){
           model.localSurveyQuestion.removeAt(index);
           return ShowBase64Image(
                  base64String: surveyResponseModel.validate
                  .replaceAll('data:image/png;base64,', ''));
      } 
       return Image.file(
              surveyResponseModel?.image,
              height: 100,
              width: 100,
              );

    }catch(e){
      print(e);
      return ShowBase64Image(
                  base64String: surveyResponseModel.validate
                  .replaceAll('data:image/png;base64,', ''));
                      
      
    } 
  }
    Future showErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('Are You Sure, want to abort the survey?'), actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop("Yes");
              },
              elevation: 5.0,
              child: Text('YES'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop("No");
              },
              elevation: 5.0,
              child: Text('NO'),
            )
          ]);
        });
  }

  Widget _getTypeWidget(SurveyResponseModel surveyResponseModel,
      SurveyScreenViewModel model, bool showMessage) {
    switch (surveyResponseModel.strQuestiontype) {
      case "YN":
        return Consumer<OnChangeYesNo>(builder: (context, value, child) {
          String reqexp;
          if(surveyResponseModel.strRequireExplanation.trim() == "Yes"){
            reqexp = "true";
          }
          else if(surveyResponseModel.strRequireExplanation.trim() == "No"){
            reqexp = "false";
          }
          if(surveyResponseModel.yesNoPressedVal ==0){
           surveyResponseModel.requireExplainationstr= "";
          }
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString()) 
               ||
               (surveyResponseModel.intQuestionNo == 7 &&
               !surveyResponseModel.strShowIf.trim().contains(widget.arguments.dsmodel.appointmentDetails.appointment.strJobType.trim()))
               ||
               (surveyResponseModel.intQuestionNo == 8 &&
               !surveyResponseModel.strShowIf.trim().contains(widget.arguments.dsmodel.appointmentDetails.appointment.strJobType.trim()))
               ) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // SizedBox(height: 10),
                  _getQuestion(surveyResponseModel),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40.0,
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                surveyResponseModel?.yesNoPressedVal = 1;
                                surveyResponseModel?.validate = 'true';
                                model.onChangeYesNo(surveyResponseModel);
                                value.setState();
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFF05A22),
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: (surveyResponseModel?.yesNoPressedVal == 1)
                                      ? Colors.red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      AppStrings.yes,
                                      style: TextStyle(
                                        color:
                                            (surveyResponseModel?.yesNoPressedVal ==
                                                    1)
                                                ? Colors.white
                                                : Colors.red,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 40.0,
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                if(surveyResponseModel.strAbandonJobOn == "No"){
                                 showErrorDialog(context).then((onValue) {
                                      if (onValue == "Yes") {
                                model.lastSelectedQuestion = surveyResponseModel.intQuestionNo;      
                                surveyResponseModel?.yesNoPressedVal = 0;
                                surveyResponseModel?.validate = 'false';
                                model.onChangeYesNo(surveyResponseModel);
                                value.setState();
                                      }
                                    });
                                }else{
                                  
                                surveyResponseModel?.yesNoPressedVal = 0;
                                surveyResponseModel?.validate = 'false';
                                model.onChangeYesNo(surveyResponseModel);
                                value.setState();
                                }
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: (surveyResponseModel?.yesNoPressedVal == 0)
                                      ? Colors.red
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      AppStrings.no,
                                      style: TextStyle(
                                        color:
                                            (surveyResponseModel?.yesNoPressedVal ==
                                                    0)
                                                ? Colors.white
                                                : Colors.red,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if(reqexp == surveyResponseModel?.validate && reqexp!=null)
                      Column(
                        children: [
                          MyTile2(
                            isOnlyNumeric: false,
                            surveyResponseModel: surveyResponseModel,
                          ),
                          showMessage && surveyResponseModel?.requireExplainationstr == null
                          ? ErrorTextWidget()
                          : Container(),
                      SizedBox(height: 10)
                    
                        ],
                      ),
                      ],
                  ),
                  showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                      ? ErrorTextWidget()
                      : Container(),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        }
            // child:
            );
        break;

      case "L":
        surveyResponseModel.listOutput.replaceAll(new RegExp(r"\s+"), "");

        var arr = surveyResponseModel.listOutput.split(',');
        List<String> itemList = List<String>();

        for (var item in arr) {
          itemList.add(item.replaceAll(new RegExp(r"\s+"), " "));
        }
          final onchange = Provider.of<OnChangeYesNo>(context, listen: false);
        
        return Column(
          children: [
            Consumer<OnChangeYesNo>(
              builder: (ctx, value, child) { 
                if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
               return Container();

               }
               else{
                 
                 bool reqexp;
        
          if(surveyResponseModel.strRequireExplanation?.trim() == "Other" && surveyResponseModel.validate?.trim() == "Other" ){
            reqexp = true;
          }
          else {
            reqexp = false;
          }
          if(surveyResponseModel.validate?.trim() != "Other"){
           surveyResponseModel.requireExplainationstr= "";
          }
        
               return Column(
                 children: [
                    _getQuestion(surveyResponseModel),
                   Column(
                     children: [
                       CustomDropDown(
                        hintText: surveyResponseModel?.dropDownValue,
                        items: itemList.map((String val) {
                          return CustomDropDownItems(val, val);
                        }).toList(),
                        height: SizeConfig.screenHeight * 0.8,
                        width: SizeConfig.screenWidth,
                        callback: (String val) {
                          print('object');
                          print('val==$val');
                          // setState(() {
                          surveyResponseModel?.dropDownValue = val;
                          surveyResponseModel?.validate = val;
                          // });
                          model.onChangeYesNo(surveyResponseModel);
                          onchange.setState();
                          
                        },
              ),
              if(reqexp && reqexp!=null)
              Column(
                        children: [
                          MyTile2(
                            isOnlyNumeric: true,
                            surveyResponseModel: surveyResponseModel,
                          ),
                          showMessage && surveyResponseModel?.requireExplainationstr == null
                          ? ErrorTextWidget()
                          : Container(),
                      SizedBox(height: 10)
                    
                        ],
                      ),
                     ],
                   ),
              showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                ? ErrorTextWidget()
                : Container(),
            SizedBox(height: 10),
                 ],
               );
              }
              }
            ),
          ],
        );

        break;

      case "P":
        return Consumer<OnChangeYesNo>(builder: (context, value, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            print("survey  nnnnnnnnnnnnnnnnnnnnnnnn................${surveyResponseModel.validate}");
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                InkWell(
                  onTap: () {
                    _showMyDialog(surveyResponseModel: surveyResponseModel,
                    model : model);
                  },
                  child: (surveyResponseModel?.imagePath == null)
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFF05A22),
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      AppStrings.choosePhoto,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("")
                        ],
                      )
                        : _getImageWidget(surveyResponseModel, model)
                ),
                showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;
      case "S":
        return Consumer<OnChangeYesNo>(builder: (ctx, val, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                InkWell(
                  onTap: () async {
                    // signature screen
                    var result = await Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (context) => SignatureScreen()));

                    if (result != null) {
                      setState(() {
                        surveyResponseModel?.signatureImage = result;
                        surveyResponseModel.validate =
                            'data:image/png;base64,' +
                                base64.encode(result.buffer.asUint8List());
                      });
                    }
                  },
                  child: (surveyResponseModel?.signatureImage == null)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFF05A22),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  AppStrings.clickHereForSignature,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.memory(
                            surveyResponseModel?.signatureImage.buffer
                                .asUint8List(),
                          )),
                ),
                showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });

        break;

      case "C":
        return Consumer<OnChangeYesNo>(builder: (context, value, child) {
          print("iiiiiiiiiiiiiiii");
          print(
              model.sectionDisableQuestions[surveyResponseModel.intSectionId]);
          print(surveyResponseModel.intQuestionNo.toString());
          print("iiiiiiiiiiiiiiiiii");
          
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                MyTile(
                  isOnlyNumeric: false,
                  surveyResponseModel: surveyResponseModel,
                ),
                showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;

      case "St":
        return Consumer<OnChangeYesNo>(builder: (context, value, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                MyTile(
                  isOnlyNumeric: false,
                  surveyResponseModel: surveyResponseModel,
                ),
                showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;

      case "N":
        return Consumer<OnChangeYesNo>(builder: (ctx, val, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                MyTile(
                    isOnlyNumeric: true,
                    surveyResponseModel: surveyResponseModel),
                showMessage && surveyResponseModel?.validate == null && surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;

      case "R":
        return Consumer<OnChangeYesNo>(builder: (ctx, val, child) {
           String msg;
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            String btnstr;
            bool isXCANC = false;
            try{
            btnstr =  surveyResponseModel.strQuestionText.split("-")[1].trim();
            }
            catch(e){
            btnstr =  surveyResponseModel.strQuestionText.trim();
            if(btnstr.contains("XCANC")){
               isXCANC = true;
               msg = model.checkXCANC(widget.arguments.dsmodel.electricGasMeterList);
               
            }
            }
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                !isXCANC? InkWell(
                  onTap: () {
                    String _processID;
                    _processid.forEach((key, value) { 
                      if(surveyResponseModel.strQuestionText.contains(key)){
                       _processID = value;  
                      }
                    });
                    model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processID,
                                    widget.arguments.dsmodel.electricGasMeterList
                                    );
                  },
                  child: (surveyResponseModel.imagePath == null)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFF05A22),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Raise $btnstr",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Image.file(
                          surveyResponseModel?.image,
                          height: 100,
                          width: 100,
                        ),
                ):
                
                // showMessage && surveyResponseModel?.validate == null
                //     ? ErrorTextWidget()
                //     : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;

      case "D":
        return Consumer(builder: (ctx, val, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                MyTile(
                  isOnlyNumeric: true,
                  surveyResponseModel: surveyResponseModel,
                ),
                showMessage && surveyResponseModel?.validate == null&& surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });
        break;

      case "B":
        var result = "";
        return Consumer<OnChangeYesNo>(builder: (ctx, val, child) {
          if (model.sectionDisableQuestions[surveyResponseModel.intSectionId]
              .contains(surveyResponseModel.intQuestionNo.toString())) {
            return Container();
          } else {
            return Column(
              children: [
                // SizedBox(height: 10),
                _getQuestion(surveyResponseModel),
                InkWell(
                    onTap: () async {
                      String barcodeScanRes;
                      // Platform messages may fail, so we use a try/catch PlatformException.
                      try {
                        var result = await BarcodeScanner.scan();
                        print(result.rawContent);
                        setState(() {
                          surveyResponseModel?.barCodeScanVal =
                              result.rawContent.toString();
                          surveyResponseModel?.validate =
                              result.rawContent.toString();
                        });
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
                    child: (surveyResponseModel?.barCodeScanVal?.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFF05A22),
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    AppStrings.scanBarCode,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text("${AppStrings.barCode} : " +
                            surveyResponseModel?.barCodeScanVal)),
                showMessage && surveyResponseModel?.validate == null&& surveyResponseModel?.isMandatoryOptional =="M"
                    ? ErrorTextWidget()
                    : Container(),
                SizedBox(height: 10),
              ],
            );
          }
        });

      default:
        return Container();
    }
  }

  // text field form
  Widget _textFieldForm(
      {TextEditingController controller,
      TextInputType keyboardType,
      String hint,
      FormFieldValidator<String> validator,
      int maxLines = 1,
      FocusNode currentFocusNode,
      FocusNode nextFocusNode,
      BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: 150,
        buildCounter: (BuildContext context,
            {int currentLength, int maxLength, bool isFocused}) {
          /* setState(() {
            numOfChare=currentLength.toString();
          });*/
        },
        style: TextStyle(color: Colors.black),
        focusNode: currentFocusNode,
        onSubmitted: (term) {
          currentFocusNode?.unfocus();
          if (nextFocusNode != null)
            FocusScope.of(context).requestFocus(nextFocusNode);
        },
        decoration: new InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[50],
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8),
            ),
            borderSide: new BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
      {SurveyResponseModel surveyResponseModel, File image, SurveyScreenViewModel model}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // used for the gallery
            new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      _choosFile(
                        surveyResponseModel: surveyResponseModel,
                        mImage: image,
                        context: context,
                        imageSource: ImageSource.gallery,
                        model: model
                      );
                    },
                    child: new CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.filter),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    ' ${AppStrings.gallery}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            // used  for the camera
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      _choosFile(
                        surveyResponseModel: surveyResponseModel,
                        mImage: image,
                        context: context,
                        imageSource: ImageSource.camera,
                        model: model
                      );
                    },
                    child: new CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.camera),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    ' ${AppStrings.camera}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
      },
    );
  }

   File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }

//chooose file
  Future<void> _choosFile(
      {SurveyResponseModel surveyResponseModel,
      SurveyScreenViewModel model,
      File mImage,
      BuildContext context,
      ImageSource imageSource}) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    if (image != null) {
      
      var compressedFile = await FlutterImageCompress.compressWithFile(
      image?.path,
      quality: 50,
      minWidth: 1800,
      minHeight: 1280,
    );
      final dir = await path_provider.getTemporaryDirectory();

      setState(() {

        File file = createFile("${dir.absolute.path}/${image.path}/test.png");
        file.writeAsBytesSync(compressedFile);
        surveyResponseModel?.image = file;
        surveyResponseModel?.imagePath = image.path;
      
//        List<int> imageBytes = image.readAsBytesSync();
//        String base64Image = base64Encode(imageBytes);
        String base64Image = base64Encode(compressedFile);
        print('image$base64Image');
//        String base64Image = BASE64.encode(imageBytes);
        surveyResponseModel?.validate = 'data:image/png;base64,' + base64Image;
        
        ///have to work
      });
    }

    Navigator.pop(context);
  }
}

class MyTile extends StatefulWidget {
  SurveyResponseModel surveyResponseModel;

  bool isOnlyNumeric = false;

  MyTile({this.isOnlyNumeric, this.surveyResponseModel});

  @override
  _MyTileState createState() => _MyTileState();
}

// A custom list tile
class _MyTileState extends State<MyTile> {
  // Initalliy make the TextField uneditable.
  bool editable =false ;
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: TextField(
              readOnly: !editable,
              autofocus: editable,
              focusNode: _focusNode,
              maxLines: null,
              controller: controller
              ..text = widget.surveyResponseModel.validate
              ..selection = controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
              enabled: true,
              keyboardType: widget.isOnlyNumeric
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: widget.isOnlyNumeric
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9_ ]')),
                    ],
              decoration: InputDecoration(
                  hintText: AppStrings.writeHere,
                  hintStyle: TextStyle(color: Colors.black)),
              onEditingComplete: () {
                // After editing is complete, make the editable false
                setState(() {
                  editable = !editable;
                  if (controller.text != '') {
                    widget.surveyResponseModel.validate = controller.text;
                  }
                  else{
                    widget.surveyResponseModel.validate = null;
                  }
                });
              },
            ),
          ),
          SizeConfig.horizontalSpaceSmall(),
          RaisedButton(
            elevation: 1.0,
            child: Text(!editable ? AppStrings.edit : AppStrings.done),
            onPressed: () {
              // When edit is pressed, make the editable true
              
              setState(() {

                editable = !editable;
                if (controller.text != '') {
                  widget.surveyResponseModel.validate = controller.text;
                  
                }
                else{
                    widget.surveyResponseModel.validate = null;
                  }
                final onchange = Provider.of<OnChangeYesNo>(context, listen: false).setState();
  
              });
              if(editable){
                   _focusNode.requestFocus();
                   
              }else{
                _focusNode.unfocus();
              }
            },
          )
        ],
      ),
    );
  }
}

class MyTile2 extends StatefulWidget {
  SurveyResponseModel surveyResponseModel;

  bool isOnlyNumeric = false;

  MyTile2({this.isOnlyNumeric, this.surveyResponseModel});

  @override
  _MyTile2State createState() => _MyTile2State();
}

// A custom list tile
class _MyTile2State extends State<MyTile2> {
  // Initalliy make the TextField uneditable.
  bool editable = false;
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: editable,
              focusNode: _focusNode,
              maxLines: null,
              controller: controller
              ..text = widget.surveyResponseModel.requireExplainationstr
              ..selection = controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
              enabled: true,
              readOnly: !editable,
              keyboardType: widget.isOnlyNumeric
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: widget.isOnlyNumeric
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z_ ]')),
                    ],
              decoration: InputDecoration(
                  hintText: AppStrings.writeHere,
                  hintStyle: TextStyle(color: Colors.black)),
              onEditingComplete: () {
                // After editing is complete, make the editable false
                setState(() {
                  editable = !editable;
                  if (controller.text != '') {
                    widget.surveyResponseModel.requireExplainationstr = controller.text;
                  }
                });
              },
            ),
          ),
          SizeConfig.horizontalSpaceSmall(),
          RaisedButton(
            elevation: 1.0,
            child: Text(!editable ? AppStrings.edit : AppStrings.done),
            onPressed: () {
              // When edit is pressed, make the editable true
              //FocusScope.of(context).unfocus();
              setState(() {
                editable = !editable;
                if (controller.text != '') {
                  widget.surveyResponseModel.requireExplainationstr = controller.text;
                }
              });
              if(editable){
                   _focusNode.requestFocus();
              }else{
                _focusNode.unfocus();
              }
            },
          )
        ],
      ),
    );
  }
}

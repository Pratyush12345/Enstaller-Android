import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/survey_screen_viewmodel.dart';
import 'package:enstaller/core/model/survey_response_model.dart';
import 'package:enstaller/ui/screen/signature.dart';
import 'package:enstaller/ui/screen/widget/survey/error_widget.dart';
import 'package:enstaller/ui/screen/widget/survey/show_base64_image.dart';
import 'package:enstaller/ui/screen/widget/survey/show_p_image_widget.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/shared/custom_expanded_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SurveyArguments{
  String appointmentID;
  bool edit;
  SurveyArguments({this.appointmentID,this.edit});
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


  @override
  Widget build(BuildContext context) {

    return WillPopScope(

      onWillPop: ()async{

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
            title: Text(AppStrings.survey,style: TextStyle(color: AppColors.whiteColor),),
          ),
          body: BaseView<SurveyScreenViewModel>(
            onModelReady: (model)=>model.initializeData(widget.arguments.appointmentID,widget.arguments.edit),
            builder: (context,model,child){
              if(model.state==ViewState.Busy){
                return AppConstants.circulerProgressIndicator();
              }else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      model.firstQuestions.length==0&&model.firstAnswers.length==0?
                      Center(child: Text(AppStrings.surveyDataNotFound)):ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          key:  Key('builder ${model.selected.toString()}'),
                          itemCount: 3,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return CustomExpandedTile(
                              expanded: model.selected==index,
                              firstChild:InkWell(
                                child: Container(
                                  color:AppColors.green,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 20, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          _getHeaderText(index),
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
                                onTap: (){
                                  model.onChangeSelected(index);
                                },
                              ),
                              secondChild: Column(
                                children: [
                                  InkWell(
                                    child: Container(
                                      color:AppColors.green,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 20, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              _getHeaderText(index),
                                              style: getTextStyle(
                                                  color: Colors.white,
                                                  isBold: true,
                                                  fontSize: 16.0),
                                            ),
                                            RotatedBox(
                                                quarterTurns: 2,
                                                child: Icon(Icons.arrow_drop_down))
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      model.closeExpand();
                                    },
                                  ),
                                  model.selected>=0&&model.selected<3?_getChildrenWidget(model.selected,model):Container()
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
  String _getHeaderText(int index) {
    switch (index) {
      case 0:
        return AppStrings.confirmations;
        break;

      case 1:
        return AppStrings.commissioning;
        break;

      case 2:
        return AppStrings.electricityOldMeterDetails;
        break;
    }
  }

  //get widgets data  as per text
  Widget _getChildrenWidget(int index,SurveyScreenViewModel model) {
    switch (index) {
      case 0:
        return _getData(model.firstQuestions,model,model.firstAnswers);
        break;

      case 1:
        return _getData(model.secondQuestions,model,model.secondAnswers);
        break;
      case 2:
        return _getData(model.thirdQuestions,model,model.thirdAnswers);
        break;
    }
  }

  //column data
  Widget _getColumnData(SurveyResponseModel surveyResponseModel,SurveyScreenViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Q: ${surveyResponseModel.intQuestionNo} " + surveyResponseModel?.strQuestionText ?? "",
            textAlign: TextAlign.left,
            style: getTextStyle(color: Colors.black, isBold: true),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _getTypeWidget(surveyResponseModel,model,model.validationValue),
      ],
    );
  }

  Widget _getData(List<SurveyResponseModel>questions,SurveyScreenViewModel model,List<QuestionAnswer>answers) {

    if(!widget.arguments.edit){
      return questions.length==0?Center(child: Text(AppStrings.surveyDataNotFound),):ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length>0?questions.length+1:questions.length,
        itemBuilder: (context, i) {
          if(i==questions.length&&questions.length>0){
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  AppButton(
                    width: 100,
                    height: 40,
                    radius: 10,
                    color: AppColors.green,
                    buttonText: model.selected<2?AppStrings.next:AppStrings.submit,
                    onTap: ()async{

                      if(!widget.arguments.edit){
                        int validateconter=0;
                        model.clearAnswer();
                        model.onValidation();
                        for (int i=0;i<questions.length;i++){
                          if(questions[i].validate!=null){
                            setState(() {
                              validateconter++;


                            });
                            model.onAddAnswer(AnswerCredential(
                                intsurveyquetionid: questions[i].intQuestionNo.toString(),
                                intappointmentid:widget.arguments.appointmentID,
                                intsurveyid:(model.selected+1).toString(),
                                stranswer:questions[i].validate,
                                intcreatedby:model.user.intEngineerId,
                                bisalive:questions[i].bisAlive?'1':'0',
                                strfilename:""
                            ));
                          }else{
                            setState(() {
                              print(validateconter);
                              print(questions.length);
                              if(questions[i].strQuestiontype=='P'&&validateconter==questions.length-2){

                              }else{

                              }
                            });
                          }
                        }
                        if(validateconter==questions.length){

                          model.onSubmit();
                        }
                      }else{
                        model.incrementCounter();
                      }




                    },
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  _getColumnData(questions[i],model),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }else{
      return answers.length==0?Center(child: Text(AppStrings.surveyDataNotFound),):
      ListView.builder(itemCount: answers.length>0?answers.length+1:answers.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,int index){
            if(index==answers.length&&answers.length>0){
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    model.selected<2?AppButton(
                      width: 100,
                      height: 40,
                      radius: 10,
                      color: AppColors.green,
                      buttonText: AppStrings.next,
                      onTap: (){
                        model.incrementCounter();

                      },
                    ):Container(),
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
                  "Q: ${answers[index]?.intSurveyQuetionId} " + answers[index]?.strQuestionText ?? "",
                  textAlign: TextAlign.left,
                  style: getTextStyle(color: Colors.black, isBold: true),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              answers[index].strQuestiontype=='P'&&answers[index].strFileName!=''?ViewPAnswerImageWidget(
                url: answers[index].fileUrlPath,
              ):answers[index].strQuestiontype=='P'&&answers[index].strFileName==''?ShowBase64Image(
                base64String: answers[index].strAnswer.
                replaceAll('data:image/png;base64,', ''),
              ):answers[index].strQuestiontype=='S'?ShowBase64Image(
                base64String: answers[index].strAnswer.
                replaceAll('data:image/png;base64,', ''),
              ):Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ans: " + answers[index]?.strAnswer ?? "",
                  textAlign: TextAlign.left,
                  style: getTextStyle(color: Colors.black, isBold: true),
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
  TextEditingController editController=TextEditingController();

  Widget _getTypeWidget(SurveyResponseModel surveyResponseModel,SurveyScreenViewModel model,bool showMessage) {
    switch (surveyResponseModel.strQuestiontype) {
      case "YN":
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40.0,
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          surveyResponseModel?.yesNoPressedVal = 1;
                          surveyResponseModel?.validate='true';
                          model.onChangeYesNo(surveyResponseModel);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF05A22),
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: (surveyResponseModel?.yesNoPressedVal==1)
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
                                color: (surveyResponseModel?.yesNoPressedVal==1)?Colors.white:
                                Colors.red,
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
                        setState(() {
                          surveyResponseModel?.yesNoPressedVal = 0;
                          surveyResponseModel?.validate='false';
                          model.onChangeYesNo(surveyResponseModel);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: (surveyResponseModel?.yesNoPressedVal==0)
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
                                color: (surveyResponseModel?.yesNoPressedVal==0)
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
              showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
            ],
          ),
        );
        break;

      case "L":
        surveyResponseModel.listOutput.replaceAll(new RegExp(r"\s+"), "");

        var arr = surveyResponseModel.listOutput.split(',');
        List<String> itemList = List<String>();

        for (var item in arr) {
          itemList.add(item.replaceAll(new RegExp(r"\s+"), ""));
        }
        return Column(
          children: [
             DropdownButton<String>(
                items: itemList.map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: new Text(
                      val,
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                style: TextStyle(color: Colors.blue),
                hint: Text(surveyResponseModel?.dropDownValue),
                onChanged: (String val) {

                  print('object');
                  print('val==$val');
                  setState(() {
                    surveyResponseModel?.dropDownValue = val;
                    surveyResponseModel?.validate = val;


                  });
                  model.onChangeYesNo(surveyResponseModel);
                }),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );

        break;

      case "P":
        return Column(
          children: [
            InkWell(
              onTap: () {
                _showMyDialog(surveyResponseModel: surveyResponseModel);
              },
              child: (surveyResponseModel?.image == null)
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10.0, right: 20),
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
                    )
                  : Image.file(
                      surveyResponseModel?.image,
                      height: 100,
                      width: 100,
                    ),
            ),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );
        break;
      case "S":
        return Column(
          children: [
            InkWell(
              onTap: () async {
                // signature screen
               var result =await  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => SignatureScreen()));

               if(result!=null){
                 setState(() {
                   surveyResponseModel?.signatureImage= result;
                   surveyResponseModel.validate= 'data:image/png;base64,'+base64.encode(result.buffer.asUint8List());
                 });
               }

              },
              child: (surveyResponseModel?.signatureImage == null)
                  ? Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 10.0, right: 20),
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
                  child: Image.memory(surveyResponseModel?.signatureImage.buffer.asUint8List(),)),
            ),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );

        break;


      case "C" :
        return Column(
          children: [
            MyTile(isOnlyNumeric: false,surveyResponseModel: surveyResponseModel,),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );
        break;


      case "N" :
        return Column(
          children: [
            MyTile(isOnlyNumeric: true,surveyResponseModel: surveyResponseModel),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );
        break;

      case "R" :

        return Column(
          children: [
            MyTile(isOnlyNumeric: true,surveyResponseModel: surveyResponseModel,),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );
        break;

        case "D" :
          return Column(
            children: [
              MyTile(isOnlyNumeric: true,surveyResponseModel: surveyResponseModel,),
              showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
            ],
          );
//        return TextField(
//
//          keyboardType: TextInputType.numberWithOptions(decimal: true),
//          inputFormatters:  <TextInputFormatter>[
//            FilteringTextInputFormatter.digitsOnly
//          ] ,
//          decoration: InputDecoration(
//              hintText: "Write here",
//
//              hintStyle: TextStyle(color: Colors.black)
//          ),
//          onChanged: (val){
//            setState(() {
//              surveyResponseModel?.validate=val;
//            });
//          },
//          onEditingComplete: (){
//
//          },
//        );
        break;






      case "B":
        var result="";
        return Column(
          children: [
            InkWell(
              onTap: () async {
                String barcodeScanRes;
                // Platform messages may fail, so we use a try/catch PlatformException.
                try {
                  var result = await BarcodeScanner.scan();
                  print(result.rawContent);
                  setState(() {
                    surveyResponseModel?.barCodeScanVal =result.rawContent.toString();
                    surveyResponseModel?.validate=result.rawContent.toString();
                  });

                } on PlatformException {
                  barcodeScanRes = 'Failed to get platform version.';
                }

              },
              child: (surveyResponseModel?.barCodeScanVal?.isEmpty)
                  ? Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 10.0, right: 20),
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
                  : Text("${AppStrings.barCode} : "+surveyResponseModel?.barCodeScanVal)
            ),
            showMessage&&surveyResponseModel?.validate==null?ErrorTextWidget():Container()
          ],
        );

      default: return Container();
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
              fontWeight:
              FontWeight.w500,
              fontSize: 14.0,
              color: Colors.grey),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(
               Radius.circular(8),
            ),
            borderSide:  BorderSide(
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
      {SurveyResponseModel surveyResponseModel, File image}) async {
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

//chooose file
  Future<void> _choosFile(
      {SurveyResponseModel surveyResponseModel,
      File mImage,
      BuildContext context,
      ImageSource imageSource}) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        surveyResponseModel?.image = image;
//        List<int> imageBytes = image.readAsBytesSync();
//        String base64Image = base64Encode(imageBytes);
        String base64Image = base64Encode(image.readAsBytesSync());
        print('image$base64Image');
//        String base64Image = BASE64.encode(imageBytes);
        surveyResponseModel.validate='data:image/png;base64,'+base64Image;


        ///have to work

      });
    }

    Navigator.pop(context);
  }


}


class MyTile extends StatefulWidget {
  SurveyResponseModel surveyResponseModel;


  bool isOnlyNumeric =false;

  MyTile({this.isOnlyNumeric,this.surveyResponseModel});

  @override
  _MyTileState createState() => _MyTileState();
}

// A custom list tile
class _MyTileState extends State<MyTile> {
  // Initalliy make the TextField uneditable.
  bool editable = false;
  TextEditingController controller =TextEditingController();

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
                controller: controller,
              enabled: editable,
          keyboardType: widget.isOnlyNumeric ? TextInputType.number : TextInputType.text,
                inputFormatters:  widget.isOnlyNumeric ?  <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ] :  <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                decoration: InputDecoration(
                  hintText: AppStrings.writeHere,

                  hintStyle: TextStyle(color: Colors.black)
              ),
              onEditingComplete: (){
                // After editing is complete, make the editable false
                setState(() {
                  editable = !editable;
                  if(controller.text!=''){
                    widget.surveyResponseModel.validate=controller.text;
                  }

                });
              },
            ),
          ),
          SizeConfig.horizontalSpaceSmall(),

          RaisedButton(
            elevation: 1.0,
            child: Text(!editable?AppStrings.edit:AppStrings.done),
            onPressed: (){
              // When edit is pressed, make the editable true
              FocusScope.of(context).unfocus();
              setState(() {
                editable = !editable;
                if(controller.text!=''){
                  widget.surveyResponseModel.validate=controller.text;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
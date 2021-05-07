import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/gas_job_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/gas_close_job_viewmodel.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GasCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  final bool fromTab;
  final String status;
  final DetailsScreenViewModel dsmodel;
  
  GasCloseJob({@required this.list, @required this.fromTab, @required this.dsmodel, @required this.status});
  
  @override
  _GasCloseJobState createState() => _GasCloseJobState();
}

class _GasCloseJobState extends State<GasCloseJob> {
  showDateTimePicker(TextEditingController controller, String question) async{
    
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate:  DateTime(DateTime.now().year - 5), 
      lastDate: DateTime(DateTime.now().year + 5)
      );
      setState(() {
        if(question == "Start Date"){
          GasJobViewModel.instance.startDate = date;
        }
        if(question == "End Date"){
          GasJobViewModel.instance.endDate = date;
        }
        if(date!=null)
        controller.text = date.day.toString()+"/"+date.month.toString() + "/"+ date.year.toString() ;
      });
  }


  _callAPI() async {

    Map<String, dynamic> json = {
      "meterList" : [],
    };

    json["intAppointmentId"] = widget.list[0].intId;

    GasJobViewModel.instance.addGasCloseJobList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });
    GasJobViewModel.instance.siteVisitList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });
    if(GasJobViewModel.instance.transactionList.isNotEmpty)
    GasJobViewModel.instance.transactionList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });
   
   if(GasJobViewModel.instance.metermap.isNotEmpty){
       Map<String, dynamic> meterjson;
      GasJobViewModel.instance.metermap.forEach((meterkey, meterval) { 
        meterjson  = {
          "registerList" : [],
          "converterList" : []
        };
        meterval.forEach((element) { 
            if(element.type == "text")
            meterjson[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            meterjson[element.jsonfield] = element.checkBoxVal;
        });

         Map<String, dynamic> registerjson;

        GasJobViewModel.instance.registermap[meterkey].forEach((registerkey, registerval) { 
            registerjson = {};
            registerval.forEach((element) { 
                if(element.type == "text")
                registerjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                registerjson[element.jsonfield] = element.checkBoxVal;
            });
            meterjson["registerList"].add(registerjson);
        });

        if(GasJobViewModel.instance.convertersmap.isNotEmpty){
         Map<String, dynamic> convertersjson;

        GasJobViewModel.instance.convertersmap[meterkey].forEach((converterskey, convertersval) { 
            convertersjson = {};
            convertersval.forEach((element) { 
                if(element.type == "text")
                convertersjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                convertersjson[element.jsonfield] = element.checkBoxVal;
            });
            meterjson["converterList"].add(convertersjson);
        });
        }
       
       json["meterList"].add(meterjson);   
      });
    } 
        ConnectivityResult result = await GasJobViewModel.instance.connectivity.checkConnectivity();
        String status = _updateConnectionStatus(result);
        if (status != "NONE") {
          ResponseModel response  = await ApiService().saveGasJob( GasCloseJobModel.fromJson(json));
          GasJobViewModel.instance.showIndicator = false;
          setState(() {
          });
          if (response.statusCode == 1) {
            if(!widget.fromTab){
             await  widget.dsmodel.onUpdateStatusOnCompleted(context, widget.list[0].intId.toString());
            }else{
              GlobalVar.gasCloseJob++;
            }
            if(!widget.fromTab){
            AppConstants.showSuccessToast(context, response.response);
            
            Navigator.of(context).pop("submitted");
            }
            else
            AppConstants.showSuccessToast(context, "Saved");

            
          } else {
            AppConstants.showFailToast(context, response.response);
          }
        } else {
          print("********online*****");
          Set<String> _setofUnSubmittedjob = {};
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(widget.list[0].intId.toString()+"GasJob", jsonEncode(GasCloseJobModel.fromJson(json)));
          GlobalVar.closejobsubmittedoffline = true;
          GasJobViewModel.instance.showIndicator = false;
          setState(() {
          });
          
          if (preferences.getStringList("listOfUnSubmittedJob") != null) {
            _setofUnSubmittedjob =
                preferences.getStringList("listOfUnSubmittedJob").toSet();
          }
          _setofUnSubmittedjob.add(widget.list[0].intId.toString());

          preferences.setStringList(
              "listOfUnSubmittedJob", _setofUnSubmittedjob.toList());
          if(widget.fromTab){
            AppConstants.showSuccessToast(context, "Saved Offline");
          
          }else{
            AppConstants.showSuccessToast(context, "Submitted Offline");
            Navigator.of(context).pop("submitted");
          }
            
         }
  }

String _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return "WIFI";
        break;
      case ConnectivityResult.mobile:
        return "MOBILE";
        break;
      case ConnectivityResult.none:
        return "NONE";
        break;
      default:
        return "NO RECORD";
        break;
    }
  }
  showTimePicker2(TextEditingController controller) async{
    TimeOfDay time = await showTimePicker(

      context: context,
      initialTime: TimeOfDay.now(),
      );
      setState(() {
        controller.text = time.format(context);
      });
  }
 
  
  void validate() {
    if (GasJobViewModel.instance.formKey.currentState.validate()) {
      print("validate");
      _callAPI();
      setState(() {
        GasJobViewModel.instance.showIndicator = true;
      });
    } else {
      print("Not validate");
    }
  }
  List<Widget> _getParticularWidgets(String headername, {int pos, int meterpos}) {
    List<Widget> _list = [];
    List<CloseJobQuestionModel> _closejobQuestionlist;
    if (headername == "Site Visit") {
      _closejobQuestionlist = GasJobViewModel.instance.siteVisitList;
    } else if (headername == "Transaction") {
      _closejobQuestionlist = GasJobViewModel.instance.transactionList;
    }

    _closejobQuestionlist.forEach((element) {
      Widget clmn;
      if (element.type == "text") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${element.strQuestion}"),
              TextFormField(
                readOnly: element.strQuestion.toLowerCase().contains("date") ||
                 element.strQuestion.toLowerCase().contains("time") ,
                enabled: true,
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                   return "${element.strQuestion} required";
                  else if(element.strQuestion == "End Date" && GasJobViewModel.instance.endDate!=null && GasJobViewModel.instance.startDate !=null){
                   if(GasJobViewModel.instance.endDate.difference(GasJobViewModel.instance.startDate).inDays<0)
                   return "End Date sould be greater than Start Date";
                   return null;
                  }
                  else
                   return null;
                },
                onFieldSubmitted: (val) {},
                controller: element.textController,
                decoration: InputDecoration(hintText: "Write here"),
              ),
              SizedBox(
                height: 8.0,
              ),
              if(element.strQuestion.toLowerCase().contains("date") ||
               element.strQuestion.toLowerCase().contains("time"))
              AppButton(
                onTap: (){
                  if(element.strQuestion.toLowerCase().contains("date"))
                  showDateTimePicker(element.textController, element.strQuestion);
                  else
                  showTimePicker2(element.textController);
                  },
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                radius: 10,
                color: Colors.orange,
                buttonText: element.strQuestion.toLowerCase().contains("date")? "Pick Date" : "Pick Time", 
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),                         
              ),
              if(element.strQuestion.toLowerCase().contains("date")||
              element.strQuestion.toLowerCase().contains("time"))
              SizedBox(height: 8.0,)            ],
          ),
        );
      } else if (element.type == "header") {
        clmn = Column(
          children: [
            Container(
              color: AppColors.appThemeColor,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
              ),
            ),
            
            SizedBox(height: 12.0,)
          ],
        );
      }
      _list.add(clmn);
    });
    return _list;
  }

  List<Widget> _getRegisterWidgets(int meterpos, int pos, List<CloseJobQuestionModel> _registerList) {
    List<Widget> _list = [];
    
    _registerList.forEach((element) {
      Widget clmn;
      if (element.type == "text") {
        clmn = Padding(
           padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text("${element.strQuestion}"),
              TextFormField(
                readOnly: element.strQuestion.toLowerCase().contains("date") ||
                 element.strQuestion.toLowerCase().contains("time") ,
                enabled: true,
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                   return "${element.strQuestion} required";
                  else if(element.strQuestion == "End Date" && GasJobViewModel.instance.endDate!=null && GasJobViewModel.instance.startDate !=null){
                   if(GasJobViewModel.instance.endDate.difference(GasJobViewModel.instance.startDate).inDays<0)
                   return "End Date sould be greater than Start Date";
                   return null;
                  }
                  else
                   return null;
                },
                onFieldSubmitted: (val) {},
                controller: element.textController,
                decoration: InputDecoration(hintText: "Write here"),
              ),
              SizedBox(
                height: 12.0,
              ),
              if(element.strQuestion.toLowerCase().contains("date") ||
               element.strQuestion.toLowerCase().contains("time"))
              AppButton(
                onTap: (){
                  if(element.strQuestion.toLowerCase().contains("date"))
                  showDateTimePicker(element.textController, element.strQuestion);
                  else
                  showTimePicker2(element.textController);
                  },
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                radius: 10,
                color: Colors.orange,
                buttonText: element.strQuestion.toLowerCase().contains("date")? "Pick Date" : "Pick Time", 
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),                         
              ),
              if(element.strQuestion.toLowerCase().contains("date")||
              element.strQuestion.toLowerCase().contains("time"))
              SizedBox(height: 8.0,)
            ],
          ),
        );
      } else if (element.type == "checkBox") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${element.strQuestion}"),
                Checkbox(
                    value: element.checkBoxVal ?? false,
                    onChanged: (val) {
                      if (!element.isMandatory)
                        setState(() {
                          element.checkBoxVal = val;
                        });
                    }),
              ],
            ),
            SizedBox(
              height: 12.0,
            )
          ]),
        );
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.appThemeColor,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                        children: [
                          if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.registerCount[meterpos]) {
                                  GasJobViewModel.instance.registermap[meterpos].remove(pos);
                                  GasJobViewModel.instance.registerCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.registerCount[meterpos]) {
                                  GasJobViewModel.instance.registerCount[meterpos]++;
                                  setState(() {});
                                }
                              },
                            ),
                        ],
                      ),
                    )
                    : SizedBox(),
              ),
            ),
            
            SizedBox(height: 12.0,)
          ],
        );
      }

      _list.add(clmn);
    });
    return _list;
  }
  List<Widget> _getConvertersWidgets(int meterpos, int pos, List<CloseJobQuestionModel> _converterList) {
    List<Widget> _list = [];
    
    _converterList.forEach((element) {
      Widget clmn;
      if (element.type == "text") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text("${element.strQuestion}"),
              TextFormField(
                readOnly: element.strQuestion.toLowerCase().contains("date") ||
                 element.strQuestion.toLowerCase().contains("time") ,
                enabled: true,
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                   return "${element.strQuestion} required";
                  else if(element.strQuestion == "End Date" && GasJobViewModel.instance.endDate!=null && GasJobViewModel.instance.startDate !=null){
                   if(GasJobViewModel.instance.endDate.difference(GasJobViewModel.instance.startDate).inDays<0)
                   return "End Date sould be greater than Start Date";
                   return null;
                  }
                  else
                   return null;
                },
                onFieldSubmitted: (val) {},
                controller: element.textController,
                decoration: InputDecoration(hintText: "Write here"),
              ),
              SizedBox(
                height: 12.0,
              ),
              if(element.strQuestion.toLowerCase().contains("date") ||
               element.strQuestion.toLowerCase().contains("time"))
              AppButton(
                onTap: (){
                  if(element.strQuestion.toLowerCase().contains("date"))
                  showDateTimePicker(element.textController, element.strQuestion);
                  else
                  showTimePicker2(element.textController);
                  },
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                radius: 10,
                color: Colors.orange,
                buttonText: element.strQuestion.toLowerCase().contains("date")? "Pick Date" : "Pick Time", 
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),                         
              ),
              if(element.strQuestion.toLowerCase().contains("date")||
              element.strQuestion.toLowerCase().contains("time"))
              SizedBox(height: 8.0,)
            ],
          ),
        );
      } else if (element.type == "checkBox") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${element.strQuestion}"),
                Checkbox(
                    value: element.checkBoxVal ?? false,
                    onChanged: (val) {
                      if (!element.isMandatory)
                        setState(() {
                          element.checkBoxVal = val;
                        });
                    }),
              ],
            ),
            SizedBox(
              height: 12.0,
            )
          ]),
        );
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.appThemeColor,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 30.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                        children: [
                          if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.converterCount[meterpos]) {
                                  GasJobViewModel.instance.convertersmap[meterpos].remove(pos);
                                  GasJobViewModel.instance.converterCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.converterCount[meterpos]) {
                                  GasJobViewModel.instance.converterCount[meterpos]++;
                                  setState(() {});
                                }
                              },
                            ),
                        ],
                      ),
                    )
                    : SizedBox(),
              ),
            ),
            
            SizedBox(height: 12.0,)
          ],
        );
      }

      _list.add(clmn);
    });
    return _list;
  }
  

  List<Widget> _getMeterWidget(int pos, List<CloseJobQuestionModel> _meterList) {
    List<Widget> _list = [];
    _meterList.forEach((element) {
      Widget clmn;
      if (element.type == "text") {
        clmn = Padding(
            padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text("${element.strQuestion}"),
              TextFormField(
                readOnly: element.strQuestion.toLowerCase().contains("date") ||
                 element.strQuestion.toLowerCase().contains("time") ,
                enabled: true,
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                   return "${element.strQuestion} required";
                  else if(element.strQuestion == "End Date" && GasJobViewModel.instance.endDate!=null && GasJobViewModel.instance.startDate !=null){
                   if(GasJobViewModel.instance.endDate.difference(GasJobViewModel.instance.startDate).inDays<0)
                   return "End Date sould be greater than Start Date";
                   return null;
                  }
                  else
                   return null;
                },
                onFieldSubmitted: (val) {},
                controller: element.textController,
                decoration: InputDecoration(hintText: "Write here"),
              ),
              SizedBox(
                height: 8.0,
              ),
              if(element.strQuestion.toLowerCase().contains("date") ||
               element.strQuestion.toLowerCase().contains("time"))
              AppButton(
                onTap: (){
                  if(element.strQuestion.toLowerCase().contains("date"))
                  showDateTimePicker(element.textController, element.strQuestion);
                  else
                  showTimePicker2(element.textController);
                  },
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                radius: 10,
                color: Colors.orange,
                buttonText: element.strQuestion.toLowerCase().contains("date")? "Pick Date" : "Pick Time", 
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),                         
              ),
              if(element.strQuestion.toLowerCase().contains("date")||
              element.strQuestion.toLowerCase().contains("time"))
              SizedBox(height: 8.0,)
            ],
          ),
        );
      } else if (element.type == "checkBox") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${element.strQuestion}"),
                Checkbox(
                    value: element.checkBoxVal ?? false,
                    onChanged: (val) {
                      if (!element.isMandatory)
                        setState(() {
                          element.checkBoxVal = val;
                        });
                    }),
              ],
            ),
            SizedBox(
              height: 12.0,
            )
          ]),
        );
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.appThemeColor,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                        children: [
                          
                             if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.meterCount) {
                                  GasJobViewModel.instance.metermap.remove(pos);
                                  GasJobViewModel.instance.registerCount.remove(pos);
                                  GasJobViewModel.instance.registermap.remove(pos);
                                  GasJobViewModel.instance.meterCount--;
                                  setState(() {});
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == GasJobViewModel.instance.meterCount) {
                                  GasJobViewModel.instance.meterCount++;
                                  setState(() {});
                                }
                              },
                            ),
                        ],
                      ),
                    )
                    : SizedBox(),
              ),
            ),
            
            SizedBox(height: 12.0,)
          ],
        );
      }
      _list.add(clmn);

      if (element.type == "checkBox" && element.strQuestion == "Register") {
        for (int i = 0; i <= GasJobViewModel.instance.registerCount[pos]; i++){
          if(!GasJobViewModel.instance.registermap[pos].keys.contains(i)){
            GasJobViewModel.instance.registermap[pos][i] = GasJobViewModel.registerList().registerList;
            
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getRegisterWidgets(pos ,i, GasJobViewModel.instance.registermap[pos][i]) ,
              ),
          ));
          _list.add(ctn);
        }
      }
      if (element.type == "checkBox" && element.strQuestion == "Converters") {
        if(element.checkBoxVal){
          if(GasJobViewModel.instance.converterCount[pos] == null){
            GasJobViewModel.instance.converterCount[pos] = 0;
          }
          if(GasJobViewModel.instance.convertersmap[pos] == null){
            GasJobViewModel.instance.convertersmap[pos] = {};
          }

        for (int i = 0; i <= GasJobViewModel.instance.converterCount[pos]; i++){
          if(!GasJobViewModel.instance.convertersmap[pos].keys.contains(i)){
            GasJobViewModel.instance.convertersmap[pos][i] = GasJobViewModel.converterList().convertersList; 
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children:_getConvertersWidgets(pos ,i, GasJobViewModel.instance.convertersmap[pos][i]) ,
              ),
          ));
          _list.add(ctn);
        }
        }else{
          GasJobViewModel.instance.converterCount = {};
          GasJobViewModel.instance.convertersmap = {};
        }
      }
    });
    return _list;
  }

  List<Widget> _getListViewWidget() {
    GasJobViewModel.instance.list = [];
    GasJobViewModel.instance.addGasCloseJobList.forEach((element) {
      Widget clmn;
      if (element.type == "text") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${element.strQuestion}"),
              TextFormField(
                readOnly: element.strQuestion.toLowerCase().contains("date") ||
                 element.strQuestion.toLowerCase().contains("time") ,
                enabled: true,
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                   return "${element.strQuestion} required";
                  else if(element.strQuestion == "End Date" && GasJobViewModel.instance.endDate!=null && GasJobViewModel.instance.startDate !=null){
                   if(GasJobViewModel.instance.endDate.difference(GasJobViewModel.instance.startDate).inDays<0)
                   return "End Date sould be greater than Start Date";
                   return null;
                  }
                  else
                   return null;
                },
                onFieldSubmitted: (val) {},
                controller: element.textController,
                decoration: InputDecoration(hintText: "Write here"),
              ),
              SizedBox(
                height: 8.0,
              ),
              if(element.strQuestion.toLowerCase().contains("date") ||
               element.strQuestion.toLowerCase().contains("time"))
              AppButton(
                onTap: (){
                  if(element.strQuestion.toLowerCase().contains("date"))
                  showDateTimePicker(element.textController, element.strQuestion);
                  else
                  showTimePicker2(element.textController);
                  },
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                radius: 10,
                color: Colors.orange,
                buttonText: element.strQuestion.toLowerCase().contains("date")? "Pick Date" : "Pick Time", 
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),                         
              ),
              if(element.strQuestion.toLowerCase().contains("date")||
              element.strQuestion.toLowerCase().contains("time"))
              SizedBox(height: 8.0,)
            ],
          ),
        );
      } else if (element.type == "checkBox") {
        clmn = Padding(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                  child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${element.strQuestion}"),
                Checkbox(
                    value: element.checkBoxVal ?? false,
                    onChanged: (val) {
                      setState(() {
                        element.checkBoxVal = val;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 8.0,
            )
          ]),
        );
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.appThemeColor,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
                trailing: element.isMandatory
                    ? IconButton(
                        icon: Icon(Icons.add, color: Colors.white,),
                        onPressed: () {
                          GasJobViewModel.instance.meterCount++;
                          setState(() {});
                        },
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(height: 12.0,)
          ],
        );
      }
      GasJobViewModel.instance.list.add(clmn);
      if (element.strQuestion == "Meters" ) {
        if(element.checkBoxVal){
        for (int i = 0; i <= GasJobViewModel.instance.meterCount; i++){
          if(!GasJobViewModel.instance.metermap.keys.contains(i)){
            GasJobViewModel.instance.metermap[i] = GasJobViewModel.meterList().meterList;
            GasJobViewModel.instance.registerCount[i] = 0;
            GasJobViewModel.instance.registermap[i] = {};
            
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getMeterWidget(i, GasJobViewModel.instance.metermap[i]) ,
              ),
          ));
          GasJobViewModel.instance.list.add(ctn);
        }
        }
        else{
          GasJobViewModel.instance.metermap = {};
          GasJobViewModel.instance.registermap = {};
          GasJobViewModel.instance.registerCount = {};
          GasJobViewModel.instance.converterCount = {};
          GasJobViewModel.instance.convertersmap = {};
          GasJobViewModel.instance.meterCount = 0;       
        }
      }
      if (element.strQuestion == "Site Visit" && element.type == "header") {
        Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("Site Visit") ,
              ),
          ));
          GasJobViewModel.instance.list.add(ctn);
      }
      if (element.strQuestion == "Transaction" && element.checkBoxVal) {
        Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("Transaction") ,
              ),
          ));
          GasJobViewModel.instance.list.add(ctn);

      }
    });

    GasJobViewModel.instance.list.add(
      Column(
        children: [
          AppButton(
            onTap: (){
            validate();
              },
            width: 100,
            height: 40,
            radius: 10,
            color: AppColors.appThemeColor,
            buttonText: widget.fromTab? "Save" : "Submit Job",     
            textStyle: TextStyle(
              color: Colors.white
            ),                     
          ),
          SizedBox(height: 20.0,)
        ],
      )     
    );
    return GasJobViewModel.instance.list;
  }

  @override
  void initState() {
    if(widget.status!="NONE")
    {
      GasJobViewModel.instance.initVariable(widget.list);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: !widget.fromTab? AppBar(
       backgroundColor: AppColors.appThemeColor,
       title: Text("Gas Close Job",
       style: TextStyle(color: Colors.white),),
       
       ):
     PreferredSize(
         preferredSize: Size.zero ,
         child: SizedBox(height: 0.0, width: 0.0,)) ,
     body: GasJobViewModel.instance.showIndicator? 
        AppConstants.circulerProgressIndicator():
        Form(
        key: GasJobViewModel.instance.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getListViewWidget() ,
              ),
          ))
          
        ),
      ),
    );
  }
}
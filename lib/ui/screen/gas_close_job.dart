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
  final DetailsScreenViewModel dsmodel;
  
  GasCloseJob({@required this.list, @required this.fromTab, @required this.dsmodel});
  
  @override
  _GasCloseJobState createState() => _GasCloseJobState();
}

class _GasCloseJobState extends State<GasCloseJob> {
  List<Widget> _list;
  GlobalKey<FormState> _formKey;
  Map<int, List<CloseJobQuestionModel>> _metermap;
  Map<int, Map<int, List<CloseJobQuestionModel>>> _registermap;
  Map<int, Map<int, List<CloseJobQuestionModel>>> _convertersmap;
  Map<int, int> _registerCount;
  Map<int, int> _converterCount;
  final Connectivity _connectivity = Connectivity();
  bool _showIndicator = false;
  showDateTimePicker(TextEditingController controller) async{
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year - 5), 
      lastDate: DateTime(DateTime.now().year + 5)
      );
      setState(() {
        controller.text = date.year.toString()+"/"+date.month.toString() + "/"+ date.day.toString();
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
   
   if(_metermap.isNotEmpty){
       Map<String, dynamic> meterjson;
      _metermap.forEach((meterkey, meterval) { 
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

        _registermap[meterkey].forEach((registerkey, registerval) { 
            registerjson = {};
            registerval.forEach((element) { 
                if(element.type == "text")
                registerjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                registerjson[element.jsonfield] = element.checkBoxVal;
            });
            meterjson["registerList"].add(registerjson);
        });

        if(_convertersmap.isNotEmpty){
         Map<String, dynamic> convertersjson;

        _convertersmap[meterkey].forEach((converterskey, convertersval) { 
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
        ConnectivityResult result = await _connectivity.checkConnectivity();
        String status = _updateConnectionStatus(result);
        if (status != "NONE") {
          ResponseModel response  = await ApiService().saveGasJob( GasCloseJobModel.fromJson(json));
          _showIndicator = false;
          setState(() {
          });
          if (response.statusCode == 1) {
            if(!widget.fromTab){
              widget.dsmodel.onUpdateStatusOnCompleted(context, widget.list[0].intId.toString());
            }else{
              GlobalVar.gasCloseJob++;
            }
            if(!widget.fromTab)
            AppConstants.showSuccessToast(context, response.response);
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
          _showIndicator = false;
          setState(() {
          });
          
          if (preferences.getStringList("listOfUnSubmittedJob") != null) {
            _setofUnSubmittedjob =
                preferences.getStringList("listOfUnSubmittedJob").toSet();
          }
          _setofUnSubmittedjob.add(widget.list[0].intId.toString());

          preferences.setStringList(
              "listOfUnSubmittedJob", _setofUnSubmittedjob.toList());
          if(widget.fromTab)
            AppConstants.showSuccessToast(context, "Saved");
            else
            AppConstants.showSuccessToast(context, "Submitted Offline");
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
    if (_formKey.currentState.validate()) {
      print("validate");
      _callAPI();
      setState(() {
        _showIndicator = true;
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
                enabled: !element.strQuestion.toLowerCase().contains("date") &&
                 !element.strQuestion.toLowerCase().contains("time") ,
                
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                    return "${element.strQuestion} required";
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
                  showDateTimePicker(element.textController);
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
              color: AppColors.green,
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
                enabled: !element.strQuestion.toLowerCase().contains("date") &&
                 !element.strQuestion.toLowerCase().contains("time") ,
                
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                    return "${element.strQuestion} required";
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
                  showDateTimePicker(element.textController);
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
              color: AppColors.green,
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
                                if (pos == _registerCount[meterpos]) {
                                  _registermap[meterpos].remove(pos);
                                  _registerCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == _registerCount[meterpos]) {
                                  _registerCount[meterpos]++;
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
                enabled: !element.strQuestion.toLowerCase().contains("date") &&
                 !element.strQuestion.toLowerCase().contains("time") ,
                
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                    return "${element.strQuestion} required";
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
                  showDateTimePicker(element.textController);
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
              color: AppColors.green,
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
                                if (pos == _converterCount[meterpos]) {
                                  _convertersmap[meterpos].remove(pos);
                                  _converterCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == _converterCount[meterpos]) {
                                  _converterCount[meterpos]++;
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
                enabled: !element.strQuestion.toLowerCase().contains("date") &&
                 !element.strQuestion.toLowerCase().contains("time") ,
                
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                    return "${element.strQuestion} required";
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
                  showDateTimePicker(element.textController);
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
              color: AppColors.green,
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
                                  _metermap.remove(pos);
                                  _registerCount.remove(pos);
                                  _registermap.remove(pos);
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
        for (int i = 0; i <= _registerCount[pos]; i++){
          if(!_registermap[pos].keys.contains(i)){
            _registermap[pos][i] = GasJobViewModel.registerList().registerList;
            
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getRegisterWidgets(pos ,i, _registermap[pos][i]) ,
              ),
          ));
          _list.add(ctn);
        }
      }
      if (element.type == "checkBox" && element.strQuestion == "Converters") {
        if(element.checkBoxVal){
          if(_converterCount[pos] == null){
            _converterCount[pos] = 0;
          }
          if(_convertersmap[pos] == null){
            _convertersmap[pos] = {};
          }

        for (int i = 0; i <= _converterCount[pos]; i++){
          if(!_convertersmap[pos].keys.contains(i)){
            _convertersmap[pos][i] = GasJobViewModel.converterList().convertersList; 
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children:_getConvertersWidgets(pos ,i, _convertersmap[pos][i]) ,
              ),
          ));
          _list.add(ctn);
        }
        }else{
          _converterCount = {};
          _convertersmap = {};
        }
      }
    });
    return _list;
  }

  List<Widget> _getListViewWidget() {
    _list = [];
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
                enabled: !element.strQuestion.toLowerCase().contains("date") &&
                 !element.strQuestion.toLowerCase().contains("time") ,
                
                validator: (val) {
                  if (val.isEmpty && element.isMandatory)
                    return "${element.strQuestion} required";
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
                  showDateTimePicker(element.textController);
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
              color: AppColors.green,
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
      _list.add(clmn);
      if (element.strQuestion == "Meters" ) {
        if(element.checkBoxVal){
        for (int i = 0; i <= GasJobViewModel.instance.meterCount; i++){
          if(!_metermap.keys.contains(i)){
            _metermap[i] = GasJobViewModel.meterList().meterList;
            _registerCount[i] = 0;
            _registermap[i] = {};
            
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getMeterWidget(i, _metermap[i]) ,
              ),
          ));
          _list.add(ctn);
        }
        }
        else{
          _metermap = {};
          _registermap = {};
          _registerCount = {};
          _converterCount = {};
          _convertersmap = {};
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
          _list.add(ctn);
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
          _list.add(ctn);

      }
    });

    _list.add(
      AppButton(
        onTap: (){
        validate();
          },
        width: 100,
        height: 40,
        radius: 10,
        color: AppColors.green,
        buttonText: widget.fromTab? "Save" : "Submit Job",                          
      )     
    );
    return _list;
  }

  @override
  void initState() {
    _list = [];
    _metermap = {};
    _registermap = {};
    _convertersmap = {};
    _registerCount = {};
    _converterCount = {};
    
    _formKey = GlobalKey<FormState>();
    try{
    CheckTable checkTable = widget.list.firstWhere((element) => element.strFuel.toString() == "GAS");
    GasJobViewModel.instance.initialize(checkTable);
    }catch(e){
     GasJobViewModel.instance.initialize(widget.list[0]);
      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: !widget.fromTab? AppBar(
       backgroundColor: AppColors.green,
       title: Text("Gas Close Job",
       style: TextStyle(color: Colors.white),),
       
       ):
     PreferredSize(
         preferredSize: Size.zero ,
         child: SizedBox(height: 0.0, width: 0.0,)) ,
     body: _showIndicator? 
        AppConstants.circulerProgressIndicator():
        Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              children: _getListViewWidget(),
            ),
        ),
      ),
    );
  }
}
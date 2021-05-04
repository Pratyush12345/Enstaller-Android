import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart' ;
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/elec_job_viewmodel.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElecCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  final bool fromTab;
  final DetailsScreenViewModel dsmodel;
  
  ElecCloseJob({@required this.list, @required this.fromTab, @required this.dsmodel});
  @override
  _ElecCloseJobState createState() => _ElecCloseJobState();
}

class _ElecCloseJobState extends State<ElecCloseJob> {
  List<Widget> _list;
  GlobalKey<FormState> _formKey;
  Map<int, List<CloseJobQuestionModel>> _metermap;
  Map<int, List<CloseJobQuestionModel>> _codeOfPractisemap;
  Map<int, Map<int, List<CloseJobQuestionModel>>> _registermap;
  Map<int, int> _registerCount;
  Map<int, Map<int, List<CloseJobQuestionModel>>> _readingmap;
  Map<int, Map<int,List<CloseJobQuestionModel>>> _regimesmap;

  Map<int, List<CloseJobQuestionModel>> _outStationmap;
  Map<int, List<CloseJobQuestionModel>> _codeOfPractiseOSmap;
  Map<int, Map<int, List<CloseJobQuestionModel>>> _commsmap;
  Map<int, int> _commsCount;
  Map<int, List<CloseJobQuestionModel>> _passwordmap;
  Map<int, List<CloseJobQuestionModel>> _usernamemap;
  bool _showIndicator = false;
  final Connectivity _connectivity = Connectivity();
  DateTime startDate;
  DateTime endDate;
  
  _callAPI() async {

    Map<String, dynamic> json = {
      "meterList" : [],
      "outStationsList" : []
    };

    json["intAppointmentId"] = widget.list[0].intId;

    ElecJobViewModel.instance.addElecCloseJobList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });
    ElecJobViewModel.instance.siteVisitList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });
    ElecJobViewModel.instance.supplyList.forEach((element) { 
            if(element.type == "text")
            json[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            json[element.jsonfield] = element.checkBoxVal;
    });

   if(_metermap.isNotEmpty){
       Map<String, dynamic> meterjson;
      _metermap.forEach((meterkey, meterval) { 
        meterjson  = {
          "bitCodeOfPracticeM" : true,
          "registerList" : []
        };
        _codeOfPractisemap[meterkey].forEach((element) { 
            if(element.type == "text")
            meterjson[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            meterjson[element.jsonfield] = element.checkBoxVal;
        });
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
            _readingmap[meterkey][registerkey].forEach((element) { 
                if(element.type == "text")
                registerjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                registerjson[element.jsonfield] = element.checkBoxVal;
            });
            _regimesmap[meterkey][registerkey].forEach((element) { 
                if(element.type == "text")
                registerjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                registerjson[element.jsonfield] = element.checkBoxVal;
            });
            meterjson["registerList"].add(registerjson);
        });
       
       json["meterList"].add(meterjson);   
      });
    } 
    if(_outStationmap.isNotEmpty){
       Map<String, dynamic> outStationjson;
      _outStationmap.forEach((outstationkey, outstationval) { 
        outStationjson  = {
          "bitUsernamesOS": true,
          "bitPasswordsOS" : true,
          "bitCodeOfPracticeOS" : true,
          "commsList" : []
        };
        _codeOfPractiseOSmap[outstationkey].forEach((element) { 
            if(element.type == "text")
            outStationjson[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            outStationjson[element.jsonfield] = element.checkBoxVal;
        });
        _passwordmap[outstationkey].forEach((element) { 
                if(element.type == "text")
                outStationjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                outStationjson[element.jsonfield] = element.checkBoxVal;
            });
            _usernamemap[outstationkey].forEach((element) { 
                if(element.type == "text")
                outStationjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                outStationjson[element.jsonfield] = element.checkBoxVal;
            });
        outstationval.forEach((element) { 
            if(element.type == "text")
            outStationjson[element.jsonfield] = element.textController.text;
            else if(element.type == "checkBox" )
            outStationjson[element.jsonfield] = element.checkBoxVal;
        });

         Map<String, dynamic> commsjson;

        _commsmap[outstationkey].forEach((commskey, commsval) { 
            commsjson = {};
            commsval.forEach((element) { 
                if(element.type == "text")
                commsjson[element.jsonfield] = element.textController.text;
                else if(element.type == "checkBox" )
                commsjson[element.jsonfield] = element.checkBoxVal;
            });
            
            outStationjson["commsList"].add(commsjson);
        });
       
       json["outStationsList"].add(outStationjson);   
      });
    }

    ConnectivityResult result = await _connectivity.checkConnectivity();
        String status = _updateConnectionStatus(result);
        if (status != "NONE") {
          ResponseModel response  = await ApiService().saveElecJob( ElecCloseJobModel.fromJson(json));
          _showIndicator = false;
          setState(() {
          });
          if (response.statusCode == 1) {
            if(!widget.fromTab){
              widget.dsmodel.onUpdateStatusOnCompleted(context, widget.list[0].intId.toString());
            }else{
              GlobalVar.elecCloseJob++;
            }
            if(!widget.fromTab)
            AppConstants.showSuccessToast(context, response.response);
            else
            AppConstants.showSuccessToast(context, "Saved");
            
            Navigator.of(context).pop("submitted");
          } else {
            AppConstants.showFailToast(context, response.response);
          }
        } else {
          print("********online*****");
          Set<String> _setofUnSubmittedjob = {};
          print(widget.list[0].intId);
          print("*******************");
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(widget.list[0].intId.toString()+"ElecJob", jsonEncode(ElecCloseJobModel.fromJson(json)));
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

            Navigator.of(context).pop("submitted");
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

  showDateTimePicker(TextEditingController controller, String question) async{
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year - 5), 
      lastDate: DateTime(DateTime.now().year + 5)
      );
      setState(() {
        if(question == "Start Date"){
          startDate = date;
        }
        if(question == "End Date"){
          endDate = date;
        }
        if(date!=null)
        
        controller.text =date.day.toString() +"/"+date.month.toString() + "/"+ date.year.toString();
      });
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
 
  List<Widget> _getParticularWidgets(String headername, {int pos, int meterpos}) {
    List<Widget> _list = [];
    List<CloseJobQuestionModel> _closejobQuestionlist;
    if (headername == "CodeOfPractiseM") {
      _closejobQuestionlist = _codeOfPractisemap[pos];
    } else if (headername == "Site Visit") {
      _closejobQuestionlist = ElecJobViewModel.instance.siteVisitList;
    } else if (headername == "Supply") {
      _closejobQuestionlist = ElecJobViewModel.instance.supplyList;
    }else if (headername == "Reading") {
      _closejobQuestionlist = _readingmap[meterpos][pos];
    }else if (headername == "Regimes") {
      _closejobQuestionlist = _regimesmap[meterpos][pos];
    }else if (headername == "CodeOfPractiseOS") {
      _closejobQuestionlist = _codeOfPractiseOSmap[pos];
    }else if (headername == "Password") {
      _closejobQuestionlist = _passwordmap[pos];
    }else if (headername == "Usernames") {
      _closejobQuestionlist = _usernamemap[pos];
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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


  
  List<Widget> _getListViewWidget() {
    _list = [];

    ElecJobViewModel.instance.addElecCloseJobList.forEach((element) {
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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
                  showDateTimePicker(element.textController,element.strQuestion);
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
                          ElecJobViewModel.instance.meterCount++;
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
        for (int i = 0; i <= ElecJobViewModel.instance.meterCount; i++){
          if(!_metermap.keys.contains(i)){
            _metermap[i] = ElecJobViewModel.meterList().meterList;
            _codeOfPractisemap[i] = ElecJobViewModel.codeOfPractiseMList().codePractiseList;
            _registerCount[i] = 0;
            _registermap[i] = {};
            _readingmap[i] = {};
            _regimesmap[i] = {};
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
          _codeOfPractisemap = {};
          _registermap = {};
          _readingmap = {};
          _registermap = {};
          _regimesmap = {};
          _registerCount = {};
          ElecJobViewModel.instance.meterCount = 0;       
        }
      }
      if(element.strQuestion == "Out Stations") {
        if(element.checkBoxVal){
        for (int i = 0; i <= ElecJobViewModel.instance.outStationCount; i++){
          if(!_outStationmap.keys.contains(i)){
            _outStationmap[i] = ElecJobViewModel.outStationList().outStationList;
            _codeOfPractiseOSmap[i] = ElecJobViewModel.codeOfPractiseOSList().codeOfPractiseOSList;
            _commsCount[i] = 0;
            _commsmap[i] = {};
            _usernamemap[i] = ElecJobViewModel.usernameList().usernameList;
            _passwordmap[i] = ElecJobViewModel.passwordList().passwordList;
          }
          Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getOutStationWidget(i, _outStationmap[i]) ,
              ),
          ));
          _list.add(ctn);
        }
        }
        else{
          _outStationmap = {};
          _codeOfPractiseOSmap = {};
          _commsmap = {};
          _commsCount = {};
          _passwordmap = {};
          _usernamemap = {};
    
          ElecJobViewModel.instance.outStationCount = 0;
        }
      }
      if (element.strQuestion == "Site Visit" && element.checkBoxVal) {
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
      if (element.strQuestion == "Supply" && element.checkBoxVal) {
        Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("Supply") ,
              ),
          ));
          _list.add(ctn);
      }
    });

    _list.add(
      Column(
        children: [
          AppButton(
            onTap: (){
            validate();
              },
            width: 100,
            height: 40,
            radius: 10,
            color: AppColors.green,
            buttonText: widget.fromTab? "Save" : "Submit Job",   
            textStyle: TextStyle(
              color: Colors.white
            ),                       
          ),
          SizedBox(height: 20.0,)
        ],
      )     
    );
    return _list;
  }

  @override
  void initState() {
    _list = [];
    _metermap = {};
    _codeOfPractisemap = {};
    _registermap = {};
    _readingmap = {};
    _registermap = {};
    _regimesmap = {};
    _registerCount = {};
    
    _outStationmap = {};
    _codeOfPractiseOSmap = {};
    _commsmap = {};
    _commsCount = {};
    _passwordmap = {};
    _usernamemap = {};
        
    _formKey = GlobalKey<FormState>();
    try{
    CheckTable checkTable = widget.list.firstWhere((element) => element.strFuel.toString() == "ELECTRICITY");
    ElecJobViewModel.instance.initialize(checkTable);
    
    }catch(e){
    ElecJobViewModel.instance.initialize(widget.list[0]);
      
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.fromTab? AppBar(
        backgroundColor: AppColors.green,
        title: Text("Electricity Close Job",
        style: TextStyle(color: Colors.white)),
      ):
      PreferredSize(
         preferredSize: Size.zero ,
         child: SizedBox(height: 0.0, width: 0.0,)) ,
      body: _showIndicator? 
        AppConstants.circulerProgressIndicator():
        Form(
        key: _formKey,
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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
                                if (pos == ElecJobViewModel.instance.meterCount) {
                                  _metermap.remove(pos);
                                  _codeOfPractisemap.remove(pos);
                                  _registerCount.remove(pos);
                                  _registermap.remove(pos);
                                  _readingmap.remove(pos);
                                  _regimesmap.remove(pos);
                                  ElecJobViewModel.instance.meterCount--;
                                  setState(() {});
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                if (pos == ElecJobViewModel.instance.meterCount) {
                                  ElecJobViewModel.instance.meterCount++;
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
      if (element.type == "header" &&
          element.strQuestion == "Code Of Practice") {
            Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("CodeOfPractiseM", pos: pos) ,
              ),
          ));
          _list.add(ctn);

      }
      if (element.type == "checkBox" && element.strQuestion == "Register") {
        for (int i = 0; i <= _registerCount[pos]; i++){
          if(!_registermap[pos].keys.contains(i)){
            _registermap[pos][i] = ElecJobViewModel.registerList().registerList;
            _readingmap[pos][i] = ElecJobViewModel.readingList().readingList;
            _regimesmap[pos][i] = ElecJobViewModel.regimesList().regimesList;
          }Widget ctn = Padding(
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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
                                  _readingmap[meterpos].remove(pos);
                                  _regimesmap[meterpos].remove(pos);
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

      if (element.strQuestion == "Reading" && element.checkBoxVal) {
        Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("Reading", pos: pos, meterpos: meterpos) ,
              ),
          ));
          _list.add(ctn);
      }
      if (element.strQuestion == "Time Pattern Regimes" && element.checkBoxVal) {
        Widget ctn = Padding(
            padding: EdgeInsets.all(10.0),
           child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Column(
                children: _getParticularWidgets("Regimes", pos: pos, meterpos: meterpos) ,
              ),
          ));
          _list.add(ctn);
      }
    });
    return _list;
  }
  
  List<Widget> _getOutStationWidget(int pos, List<CloseJobQuestionModel> _outStationList) {
    List<Widget> _list = [];
    _outStationList.forEach((element) {
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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
                                if (pos == ElecJobViewModel.instance.outStationCount) {
                                  _outStationmap.remove(pos);
                                  _codeOfPractiseOSmap.remove(pos);
                                  _commsCount.remove(pos);
                                  _commsmap.remove(pos);
                                  _usernamemap.remove(pos);
                                  _passwordmap.remove(pos);
                                  ElecJobViewModel.instance.outStationCount--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == ElecJobViewModel.instance.outStationCount) {
                                  ElecJobViewModel.instance.outStationCount++;
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
      if (element.type == "header" &&
          element.strQuestion == "Code Of Practice") {
        _list.addAll(_getParticularWidgets("CodeOfPractiseOS", pos: pos));
      }
      if (element.type == "checkBox" && element.strQuestion == "Comms") {
        for (int i = 0; i <= _commsCount[pos]; i++){
          if(!_commsmap[pos].keys.contains(i)){
            _commsmap[pos][i] = ElecJobViewModel.commsList().commsList;
          }
          _list.addAll(_getCommsWidgets(pos, i, _commsmap[pos][i]));
        }
      }
      if (element.type == "header" &&
          element.strQuestion == "Password") {
        _list.addAll(_getParticularWidgets("Password", pos: pos));
      }
      if (element.type == "header" &&
          element.strQuestion == "Usernames") {
        _list.addAll(_getParticularWidgets("Usernames", pos: pos));
      }
    });
    return _list;
  }

  List<Widget> _getCommsWidgets(int outStationpos, int pos, List<CloseJobQuestionModel> _commsList ) {
    List<Widget> _list = [];
    _commsList.forEach((element) {
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
                  else if(element.strQuestion == "End Date" && endDate!=null && startDate !=null){
                   if(endDate.difference(startDate).inDays<0)
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
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}",
                style: TextStyle(
                  color: AppColors.whiteColor
                ),),
                trailing: element.isMandatory
                    ? Container(
                      height: 40.0,
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                if (pos == _commsCount[outStationpos]) {
                                  _commsmap[outStationpos].remove(pos);
                                  _commsCount[outStationpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add, color: Colors.white,),
                              onPressed: () {
                                if (pos == _commsCount[outStationpos]) {
                                  _commsCount[outStationpos]++;
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



}

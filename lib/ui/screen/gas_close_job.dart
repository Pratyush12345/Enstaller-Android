import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/gas_job_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/viewmodel/gas_close_job_viewmodel.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
class GasCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  final bool fromTab;
  GasCloseJob({@required this.list, @required this.fromTab});
  
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
  bool _showIndicator = false;

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
    
    
    ResponseModel response  = await ApiService().saveGasJob( GasCloseJobModel.fromJson(json));
      _showIndicator = false;
      setState(() {
      });
      if (response.statusCode == 1) {
         AppConstants.showSuccessToast(context, response.response);
      } else {
        AppConstants.showFailToast(context, response.response);
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
  List<Widget> _getParticularWidgets(String headername, {int pos, int meterpos}) {
    List<Widget> _list = [];
    List<CloseJobQuestionModel> _closejobQuestionlist;
    if (headername == "Site Visit") {
      _closejobQuestionlist = GasJobViewModel.instance.siteVisitList;
    } else if (headername == "Transaction") {
      _closejobQuestionlist = GasJobViewModel.instance.transactionList;
    }

    _closejobQuestionlist.forEach((element) {
      Column clmn;
      if (element.type == "text") {
        clmn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${element.strQuestion}"),
            TextFormField(
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
            )
          ],
        );
      } else if (element.type == "header") {
        clmn = Column(
          children: [
            Container(
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}"),
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
      Column clmn;
      if (element.type == "text") {
        clmn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Text("${element.strQuestion}"),
            TextFormField(
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
            )
          ],
        );
      } else if (element.type == "checkBox") {
        clmn = Column(children: [
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
        ]);
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}"),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 30.0,
                      child: Row(
                        children: [
                          if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                if (pos == _registerCount[meterpos]) {
                                  _registermap[meterpos].remove(pos);
                                  _registerCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add),
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
      Column clmn;
      if (element.type == "text") {
        clmn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Text("${element.strQuestion}"),
            TextFormField(
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
            )
          ],
        );
      } else if (element.type == "checkBox") {
        clmn = Column(children: [
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
        ]);
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}"),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 30.0,
                      child: Row(
                        children: [
                          if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                if (pos == _converterCount[meterpos]) {
                                  _convertersmap[meterpos].remove(pos);
                                  _converterCount[meterpos]--;
                                  setState(() {});
                                }
                              },
                            ),
                          IconButton(
                              icon: Icon(Icons.add),
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
      Column clmn;
      if (element.type == "text") {
        clmn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Text("${element.strQuestion}"),
            TextFormField(
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
            )
          ],
        );
      } else if (element.type == "checkBox") {
        clmn = Column(children: [
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
        ]);
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}"),
                trailing: element.isMandatory
                    ? Container(
                      width: 100.0,
                      height: 30.0,
                      child: Row(
                        children: [
                          
                             if(pos != 0)
                             IconButton(
                              icon: Icon(Icons.delete),
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
                              icon: Icon(Icons.add),
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
          _list.addAll(_getRegisterWidgets(pos ,i, _registermap[pos][i]));
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
          _list.addAll(_getConvertersWidgets(pos ,i, _convertersmap[pos][i]));
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
        clmn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${element.strQuestion}"),
            TextFormField(
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
            )
          ],
        );
      } else if (element.type == "checkBox") {
        clmn = Column(children: [
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
        ]);
      } else {
        clmn = Column(
          children: [
            Container(
              color: AppColors.green,
              child: ListTile(
                title: Text("${element.strQuestion}"),
                trailing: element.isMandatory
                    ? IconButton(
                        icon: Icon(Icons.add),
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
          _list.addAll(_getMeterWidget(i, _metermap[i]));
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
        _list.addAll(_getParticularWidgets("Site Visit"));
      }
      if (element.strQuestion == "Transaction" && element.checkBoxVal) {
        _list.addAll(_getParticularWidgets("Transaction"));
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
        buttonText: "Save",                          
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
    GasJobViewModel.instance.initialize(widget.list[0]);
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: !widget.fromTab? AppBar(title: Text("Gas Close Job"),):
     PreferredSize(
         preferredSize: Size.zero ,
         child: SizedBox(height: 0.0, width: 0.0,)) ,
     body: _showIndicator? 
        AppConstants.circulerProgressIndicator():
        Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
             padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0,4.0 ),
                      child: Column(
              children: _getListViewWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
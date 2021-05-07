import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/elec_close_job.dart';
import 'package:enstaller/ui/screen/gas_close_job.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class BothCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  final DetailsScreenViewModel dsmodel;
  
  final String status;
  
  BothCloseJob({@required this.list, @required this.dsmodel, @required this.status});
  
  @override
  _BothCloseJobState createState() => _BothCloseJobState();
}

class _BothCloseJobState extends State<BothCloseJob> {
  bool _showIndicator = false;
  
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return DefaultTabController(
      length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
        appBar: AppBar(
          
              brightness: Brightness.dark,
         backgroundColor: AppColors.appThemeColor,
         title: Text("Close Jobs",
         style: TextStyle(color: Colors.white)),),
       body: _showIndicator? 
        AppConstants.circulerProgressIndicator(): Column(
            children: [
              Container(
                color: AppColors.appThemeColor,
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Color(0xff3c6577),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          'Electricity Close Job',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Gas Close Job',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      
                    ]),
              ),
              Expanded(
                flex: 2,
                child: TabBarView(children: [
                  ElecCloseJob(
                    list: widget.list,
                    fromTab: true,
                    dsmodel: widget.dsmodel,
                    status: widget.status,
                  ),
                  GasCloseJob(list: widget.list,
                   fromTab: true,
                   status: widget.status,
                   dsmodel: widget.dsmodel,
                  ),
                ]),
              ),
              AppButton(
        onTap: () async{
          if( GlobalVar.elecCloseJob >= 1 && GlobalVar.gasCloseJob >= 1 ){
           setState(() {
           _showIndicator = true;   
           });
           AppConstants.showSuccessToast(context, "Job Saved Successfully");
           await widget.dsmodel.onUpdateStatusOnCompleted(context, widget.list[0].intId.toString());
           
           GlobalVar.elecCloseJob = 0;
           GlobalVar.gasCloseJob = 0;
           setState(() {
           _showIndicator = false;  
           });
           
            Navigator.of(context).pop("submitted");
           
          }
          else if(GlobalVar.closejobsubmittedoffline){
            AppConstants.showSuccessToast(context, "Submitted Offline");
            
            Navigator.of(context).pop("submitted");
          }
          },
        width: 200,
        height: 40,
        radius: 10,
        color: AppColors.appThemeColor,
        buttonText: "Submit Close Job", 
        textStyle: TextStyle(
          color: Colors.white
        ),                         
      ),
      SizedBox(height: 30.0,)

            ],
          ),
      ),
    );
  }
}
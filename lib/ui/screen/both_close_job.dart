import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/elec_close_job.dart';
import 'package:enstaller/ui/screen/gas_close_job.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
class BothCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  final DetailsScreenViewModel dsmodel;
  
  BothCloseJob({@required this.list, @required this.dsmodel});
  
  @override
  _BothCloseJobState createState() => _BothCloseJobState();
}

class _BothCloseJobState extends State<BothCloseJob> {
  bool _showIndicator = false;
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
        appBar: AppBar(
         backgroundColor: AppColors.green,
         title: Text("Close Jobs",
         style: TextStyle(color: Colors.white)),),
       body: _showIndicator? 
        AppConstants.circulerProgressIndicator(): Column(
            children: [
              Container(
                color: AppColors.green,
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
                  ),
                  GasCloseJob(list: widget.list,
                   fromTab: true,
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
           
          }
          else if(GlobalVar.closejobsubmittedoffline){
            AppConstants.showSuccessToast(context, "Submitted Offline");
          }
          },
        width: 200,
        height: 40,
        radius: 10,
        color: AppColors.green,
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
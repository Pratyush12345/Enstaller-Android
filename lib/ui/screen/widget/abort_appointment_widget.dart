import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/abort_appointment_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/abort_appointment_viewmodel.dart';
import 'package:flutter/material.dart';

class AbortAppoinmentWidget extends StatefulWidget {
  final String appointmentID;
  AbortAppoinmentWidget({this.appointmentID});
  @override
  _AbortAppoinmentWidgetState createState() => _AbortAppoinmentWidgetState();
}

class _AbortAppoinmentWidgetState extends State<AbortAppoinmentWidget> {
  String abort_reason;
  String reasonId;
  @override
  Widget build(BuildContext context) {
    return  BaseView<AbortAppointmentViewModel>( 
      onModelReady: (model)=>model.getAbortAppointmentList(),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }else{
          return SingleChildScrollView(
                      child: Container(
              color: AppColors.whiteColor,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        topLeft: Radius.circular(7)
                      ),
                      color: AppColors.appThemeColor,),
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
                  Text(AppStrings.abort_reason,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                  padding: SizeConfig.sidepadding,
                  child: DropdownButton<String>(
                    elevation: 2,
                    isDense: false,
                    items: model.listofReason.map((dropDownStringitem) {
                      return DropdownMenuItem<String>(
                         
                        value: dropDownStringitem,
                        child: Text(
                            dropDownStringitem,
                            // style: TextStyle(
                            //   fontWeight: FontWeight.w500,
                            //   color: Colors.black87
                            // ),
                          ),
                      );
                    }).toList(),
                    onChanged: (newValueSelected) {
                      abort_reason = newValueSelected;
                      model.abortlist.forEach((element) { 
                        if(element.strName == abort_reason.trim()){
                          reasonId = element.intReasonId.toString();
                        }
                      }); 
                      print(reasonId);
                      print(abort_reason);
                      setState(() {});  
                    },
                    isExpanded: true,
                    hint: Text("Choose Reason for Abort Appointment"),
                    value: abort_reason ?? null,
                  ),
                  ),
                
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: (){
                                  final ConfirmAbortAppointment confirmAbortAppointment = ConfirmAbortAppointment(
                                    intId: widget.appointmentID.trim(),
                                    bisAbortRequestApproved: "0",
                                    intAbortRequestedId: reasonId,
                                    isabort: 1,
                                    requestFrom: "Enstaller",
                                    strCancellationComment: "Comment",
                                    strCancellationReason: abort_reason.trim() );
     
                                   model.onConfirmPressed(context, confirmAbortAppointment);
                                  
                                },
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
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
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
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

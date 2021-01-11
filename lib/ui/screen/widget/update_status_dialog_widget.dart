import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';

class UpdateStatusDialogWidget extends StatefulWidget {
  final DetailsScreenViewModel model;
  final String appointmentID;
  UpdateStatusDialogWidget({this.model,this.appointmentID});

  @override
  _UpdateStatusDialogWidgetState createState() => _UpdateStatusDialogWidgetState();
}

class _UpdateStatusDialogWidgetState extends State<UpdateStatusDialogWidget> {



  @override
  Widget build(BuildContext context) {
    return widget.model.state==ViewState.Busy?AppConstants.circulerProgressIndicator():Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7)
            )
          ),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(child: Text(AppStrings.updateStatusC,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: SizeConfig.fontSizeLarge,
                  fontWeight: FontWeight.bold
                ),)),
                InkWell(child: Icon(Icons.clear,color: AppColors.whiteColor,), onTap: (){
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.engineer,
                style: TextStyle(color: AppColors.darkGrayColor, fontWeight: FontWeight.normal),
              ),
              SizeConfig.verticalSpaceSmall(),
              Container(
                height: SizeConfig.screenHeight*.05,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.veryLightGrayColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Text(
                        widget.model.appointmentDetails.appointment.engineerName,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeConfig.verticalSpaceSmall(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.status,
                style: TextStyle(color: AppColors.darkGrayColor, fontWeight: FontWeight.normal),
              ),
              SizeConfig.verticalSpaceSmall(),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.veryLightGrayColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                height: SizeConfig.screenHeight*.05,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: DropdownButton<String>(
                    hint: Text(AppStrings.selectStatus),
                    isExpanded: true,
                    underline: Container(),
                    value: widget.model.selectedStatus,
                    items: widget.model.statusList.map((String value) {
                      return  DropdownMenuItem<String>(
                        value: value,
                        child:  Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {
                      widget.model.onSelectStatus(_);
                      setState(() {

                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: AppButton(
            height: SizeConfig.screenHeight*.05,
            buttonText: AppStrings.UPDATE,
            color: AppColors.green,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor
            ),
            radius: 20,
            onTap: (){

              widget.model.onUpdateStatus(context,widget.appointmentID);
            },
          ),
        ),

        SizeConfig.verticalSpaceMedium(),
      ],
    );
  }
}

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:enstaller/core/viewmodel/stock_chcek_request_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:flutter/material.dart';

class ValidatedListWidget extends StatefulWidget {
  final List<SerialNoModel> list;

  ValidatedListWidget({this.list});
  @override
  _ValidatedListWidget createState() => _ValidatedListWidget();
}

class _ValidatedListWidget extends State<ValidatedListWidget> {



  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.appThemeColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7))),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      AppStrings.SERIAL_NUMBERS,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: SizeConfig.fontSizeLarge,
                          fontWeight: FontWeight.bold),
                    )),
                InkWell(
                    child: Icon(
                      Icons.clear,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
        Padding(
          padding: SizeConfig.sidepadding,
          child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AppointmentDataRow(
                  firstText: widget.list[index].strSerialNo,
                  secondText: "Serial no. not found",
                );
              }),
        ),
        SizeConfig.verticalSpaceMedium(),
      ],
    );
  }
}

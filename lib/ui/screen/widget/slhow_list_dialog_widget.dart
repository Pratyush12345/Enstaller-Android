import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/viewmodel/stock_chcek_request_viewmodel.dart';
import 'package:flutter/material.dart';

class ShowListDialogWidget extends StatefulWidget {
  final StockCheckRequestViewModel model;
  final String requestID;
  ShowListDialogWidget({this.model, this.requestID});
  @override
  _ShowListDialogWidgetState createState() => _ShowListDialogWidgetState();
}

class _ShowListDialogWidgetState extends State<ShowListDialogWidget> {



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
          child: FutureBuilder(
            future: widget.model
                .getSerialNos(widget.requestID),
            builder: (BuildContext context,
                AsyncSnapshot<dynamic> snapshot) {
              return snapshot.connectionState ==
                  ConnectionState.waiting
                  ? AppConstants.circulerProgressIndicator()
                  : ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Text(
                          snapshot.data[index]
                              .strSerialNo,
                          style: AppStyles.BlackStyleWithBold800Font_24(context),
                        ));
                  });
            },
          ),
        ),
        SizeConfig.verticalSpaceMedium(),
      ],
    );
  }
}

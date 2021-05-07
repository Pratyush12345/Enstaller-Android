import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_item_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/check_request_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckRequestScreen extends StatefulWidget {
  @override
  _CheckRequestScreenState createState() => _CheckRequestScreenState();
}

class _CheckRequestScreenState extends State<CheckRequestScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return BaseView<CheckRequestViewModel>(
      onModelReady: (model) => model.initializeData(),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child: AppDrawerWidget(),
            ),
            appBar: AppBar(
              
              brightness: Brightness.dark,
              backgroundColor: AppColors.appThemeColor,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back)),
              ),
              title: Text(
                "${AppStrings.CHECK_REQUEST}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              centerTitle: true,
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: Image.asset(
              //       ImageFile.notification,
              //       color: AppColors.whiteColor,
              //     ),
              //   ),
              // ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.initializeData()),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height),
                          child: (model.serialList.isNotEmpty == true)
                              ? Padding(
                                  padding:
                                      SizeConfig.padding.copyWith(bottom: 100),
                                  child: Padding(
                                    padding: SizeConfig.verticalC13Padding,
                                    child: Container( 
                                      height: (MediaQuery.of(context).size.height /20) * model.list.length,
                                      decoration: BoxDecoration(
                                        
                                          color: AppColors
                                              .appointmentBackGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: model.list,
                                      ),
                                    ),
                                  ))
                              : Center(child: Text(AppStrings.noDataFound))),
                    ),
                  ));
      },
    );
  }

  Widget _serialModel(SerialItemModel serialItemModel) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.SERIAL_NUMBER,
          secondText: serialItemModel?.strSerialNo ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.ITEM_NAME,
          secondText: serialItemModel?.strItemName ?? "",
        ),
      ],
    );
  }
}

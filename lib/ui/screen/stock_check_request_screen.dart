import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/stock_check_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/stock_chcek_request_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/screen/widget/slhow_list_dialog_widget.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/stock_request_reply_screen.dart';
import 'package:flutter/material.dart';

class StockCheckRequestScreen extends StatefulWidget {
  @override
  _StockCheckRequestScreenState createState() =>
      _StockCheckRequestScreenState();
}

class _StockCheckRequestScreenState extends State<StockCheckRequestScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<StockCheckRequestViewModel>(
      onModelReady: (model) => model.initializeData(),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child: AppDrawerWidget(),
            ),
            appBar: AppBar(
              backgroundColor: AppColors.green,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back)),
              ),
              title: Text(
                "${AppStrings.STOCK_REQUEST_CHECK}",
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
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: (model.stockCheckList.isNotEmpty == true)
                            ? Padding(
                                padding:
                                    SizeConfig.padding,
                                child: ListView.builder(
                                  itemCount: model.stockCheckList.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: SizeConfig.verticalC13Padding,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .appointmentBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            _stockModel(
                                                model.stockCheckList[i], model)
//                                Divider(
//                                  color: AppColors.darkGrayColor,
//                                  thickness: 1.0,
//                                ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Text(AppStrings.noDataFound))),
                  ));
      },
    );
  }

  // engineer info
  Widget _stockModel(
      StockCheckModel stockCheckModel, StockCheckRequestViewModel model) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.MOP_USER,
          secondText: stockCheckModel?.strMOPUserName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.MOP_COMMENTS,
          secondText: stockCheckModel?.strComments ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.ENGINEER_REPLY_COMMENTS,
          secondText: stockCheckModel?.strEngReplyComments ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.CURRENT_STATUS,
          secondText: stockCheckModel?.strCurrentStatus ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.REQUESTED_DATE,
          secondText: stockCheckModel?.strRequestedDate ?? "",
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          child: AppButton(
            buttonText: stockCheckModel?.strCurrentStatus == 'Request Pending'
                ? AppStrings.GIVE_REPLY
                : AppStrings.VIEW_REPLY ?? '',
            color: AppColors.green,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              if (stockCheckModel?.strCurrentStatus == 'Request Pending') {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => StockRequestReplyScreen(
                              intRequestId: stockCheckModel.intId,
                            )))
                    .whenComplete(() => {model.initializeData()});
              } else {
                AppConstants.showAppDialog(
                    context: context,
                    child: ShowListDialogWidget(
                      model: model,
                      requestID: stockCheckModel.intId.toString(),
                    ));
              }
            },
          ),
        ),
      ],
    );
  }
}

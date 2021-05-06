import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/order_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/order_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/bar_code_image.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';

import 'add_order_screen.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderScreenViewModel>(
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
                "${AppStrings.ORDERS}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GestureDetector(
                    child: Icon(Icons.add_circle_rounded),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => AddOrderScreen())).whenComplete(() => {model.initializeData()});
                    },
                  )
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                  onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.initializeData()),
                    
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: (model.list.isNotEmpty)
                      ? Padding(
                    padding:
                    SizeConfig.padding,
                    child: ListView.builder(
                      physics: const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      
                      itemCount: model.list.length,
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
                                _orderModelWidget(
                                    model.list[i], model)
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
  Widget _orderModelWidget(
      OrderModel orderModel, OrderScreenViewModel model) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.REFERENCE,
          secondText: orderModel?.strRefrence ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.status,
          secondText: orderModel?.strStatus ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.WAREHOUSE,
          secondText: orderModel?.strWarehouseName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.CREATED_DATE,
          secondText: orderModel?.createdDate ?? "",
        ),

        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonText: AppStrings.DETAILS,
                  color: AppColors.green,
                  textStyle: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                  onTap: () {

                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(intId: orderModel.intOrderId,)));

                  },
                ),
              ),
              SizeConfig.horizontalSpace(2),
              Expanded(
                child: AppButton(
                  buttonText: AppStrings.edit,
                  color: AppColors.green,
                  textStyle: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                  onTap: () {

                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => AddOrderScreen(intOrderId: orderModel.intOrderId,))).whenComplete(() => {model.initializeData()});

                  },
                ),
              ),
              SizeConfig.horizontalSpace(2),
              Expanded(
                child: AppButton(
                  buttonText: AppStrings.barCode,
                  color: AppColors.green,
                  textStyle: TextStyle(
                      color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                  onTap: () {

                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => BarCodeRender(number: orderModel?.strRefrence ?? "")));
                    
                  },
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}

// 3
// 9
// 13
// 14
// 15
// 16
//17
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/order_detail_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {

  final intId;


  OrderDetailScreen({@required this.intId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderDetailViewModel>(
      onModelReady: (model)=>model.initializeData(widget.intId),
      builder: (context,model,child){
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child:AppDrawerWidget(),
            ),
            appBar: AppBar(
              backgroundColor: AppColors.appThemeColor,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      ImageFile.menuIcon,color: AppColors.whiteColor,
                    )),
              ),
              title: Text("${AppStrings.ORDER_DETAILS}",style: TextStyle(
                  color: AppColors.whiteColor
              ),),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:GestureDetector(
                    child: Icon(Icons.download_sharp),
                    onTap: (){
                     //Download CSV
                      model.downloadCSV(widget.intId, context);
                    },
                  )
                ),
              ],
            ),
            body: model.state==ViewState.Busy ?AppConstants.circulerProgressIndicator():
            SingleChildScrollView(
              child: Padding(
                padding: SizeConfig.padding.copyWith(bottom: 100),
                child: Column(
                  children: [

                  Padding(
                    padding: SizeConfig.verticalC13Padding,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors
                              .appointmentBackGroundColor,
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: _orderDetailsWidget(model),
                    ),
                  ),
                    SizeConfig.verticalSpaceMedium(),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: Text(
                        AppStrings.ITEMS,
                        style: AppStyles.BlackStyleWithBold800Font_24(context)
                      )
                    ),
                    SizeConfig.verticalSpaceSmall(),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.list.length  ,itemBuilder: (context, index){
                      return  Padding(
                        padding: SizeConfig.verticalC13Padding,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors
                                  .appointmentBackGroundColor,
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: _orderLineDetailsWidget(model.list[index], model),
                        ),
                      );
                    }),


                  ],
                ),
              ),

            ));
      },
    );
  }

  Widget _orderDetailsWidget(
      OrderDetailViewModel model) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.REFERENCE,
          secondText: model.orderDetailModel?.strRefrence ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.status,
          secondText: model.orderDetailModel?.strStatus ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.CONTRACT_NAME,
          secondText: model.orderDetailModel?.strContractName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.userName,
          secondText: model.orderDetailModel?.strUserName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.REGION,
          secondText: model.orderDetailModel?.strRegionName?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.WAREHOUSE,
          secondText: model.orderDetailModel?.strWarehouseName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.THIRD_PARTY,
          secondText: model.orderDetailModel?.strThirdParty ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.COLLECTION_DATE,
          secondText: model.orderDetailModel?.dteCreatedDate ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.APPROVED,
          secondText: (model.orderDetailModel.isApproved)?AppStrings.yes: AppStrings.no?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.MERGED,
          secondText: (model.orderDetailModel.isMerged)?AppStrings.yes: AppStrings.no?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.MARSHALLING_LANE,
          secondText: model.orderDetailModel?.strMarshallingLane ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.CREATED,
          secondText: model.orderDetailModel?.dteCreatedDate ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.MODIFIED,
          secondText: model.orderDetailModel?.dteModifiedDate ?? "",
        ),
      ],
    );
  }

  Widget _orderLineDetailsWidget(
      OrderLineDetailModel orderLineDetailModel, OrderDetailViewModel model) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.ITEM,
          secondText: orderLineDetailModel?.strItemName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.DESCRIPTION,
          secondText: orderLineDetailModel?.strItemDescription ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.ORDER_QUANTITY,
          secondText: orderLineDetailModel?.decQty.toString() ?? "",
        ),

      ],
    );
  }
}

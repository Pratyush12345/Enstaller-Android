import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/get_user_details_viewmodel.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:enstaller/ui/screen/profile_screen.dart';
import 'package:enstaller/ui/screen/warehouse_screens/check_order_assign_stcok.dart';
import 'package:enstaller/ui/screen/warehouse_screens/stock_update_status.dart';
import 'package:enstaller/ui/screen/widget/drawer_row_widget.dart';
import 'package:flutter/material.dart';


class WareHouseDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        DrawerHeader(child: BaseView<GetUserDetailsViewModel>(
          onModelReady: (model)=>model.getUserDetails(),
          builder: (context,model,child){
            if(model.state==ViewState.Busy){
              return AppConstants.circulerProgressIndicator();
            }else{
              return Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Text(AppConstants.nameTitle(model.user.username),
                        style: AppStyles.GreenStyle_Font,),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    },
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.user.username,style: AppStyles.WhiteStyle_Font20.copyWith(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(model.user.email,style: AppStyles.WhiteStyle_Font20,)
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                      },
                    ),
                  ),

                  InkWell(
                    child: SizedBox(
                      height: 20,
                        child: Image.asset(ImageFile.downArrow,color: AppColors.whiteColor,)),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),


                ],
              );
            }
          },
        ),decoration: BoxDecoration(
          color: AppColors.green
        ),),
        Expanded(
          child: ListView(
            children: [
              DrawerRowWidget(
                title: 'Check Order And\nAssign Stock', 
                assetPath: ImageFile.stock_check_request,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => CheckAndAssignOrder()));
                },
              ),
              DrawerRowWidget(
                title: 'Stock Update Status',
                assetPath: ImageFile.stock_check_request,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => StockUpdateStatus()));
                },
              ),
          ],
          ),
        )
      ],
    );
  }
}

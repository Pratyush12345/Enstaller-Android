import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/home_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/homescreen/view_appointment_list_widget.dart';
import 'package:flutter/material.dart';

import 'home_page_list_widget.dart';
import 'homepage_expandsion_widget.dart';

class ViewSingleDateWidget extends StatelessWidget {
  final String dateString;
  ViewSingleDateWidget({this.dateString});
  @override
  Widget build(BuildContext context) {
    return HomePageExpansionWidget(

      showSecondWidget:true ,
      firstWidget: HomePageListWidget(

        height: SizeConfig.screenHeight*.15,
        dateString: dateString,
        expanded: true,
      ),
      secondWidget:  Container(
//                                color:  AppColors.appbarColor,
        child: BaseView<HomeScreenViewModel>(
          onModelReady: (model)=>model.getTable(dateString),
          builder: (context,secondModel,child){
            if(secondModel.state==ViewState.Busy){
              return AppConstants.circulerProgressIndicator();
            }
            return Container(
//                                      color: AppColors.expansionColor,

              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight:
                      AppConstants.getExpandedListHeight(secondModel.tables.isEmpty,secondModel.tables.length)),
                  child: (secondModel.tables.length>0)
                      ? ViewAppointmentListWidget(
                    tables: secondModel.tables,
                  ) : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color:
                      Colors.white,
                    ),
                    padding:
                    EdgeInsets.all(0),

                    height:
                    MediaQuery.of(context).size.height * 0.21,
                    width:
                    double.infinity,
                    child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppStrings.noDataFound),
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}

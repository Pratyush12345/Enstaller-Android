import 'dart:io';

import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/documnet_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/document_view.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppColors.green);
    return BaseView<DocumnetViewModel>(
      onModelReady: (model) => model.getDocumnetList(),
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
              centerTitle: true,
              title: model.searchBool
                  ? TextField(
                      decoration:
                          InputDecoration(hintText: AppStrings.searchHere,
                          hintStyle: TextStyle(color: Colors.white ),
                          enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,
                          )
                          ),
                          ),
                      onChanged: (val) {
                        model.onSearch(val);
                      },
                    )
                  : Text(
                      AppStrings.DOCUMNETS,
                      style: getTextStyle(
                          color: AppColors.whiteColor, isBold: false),
                    ),
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      model.searchBool ? Icons.clear : Icons.search,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    model.onClickSerach();
                  },
                ),
                // Icon(
                //   Icons.notifications_none,
                //   size: MediaQuery.of(context).size.height * 0.035,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.getDocumnetList()),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
                        child: (model.documentList.isNotEmpty == true)
                            ? Padding(
                                padding:
                                    SizeConfig.padding,
                                child: ListView.builder(
                                  itemCount: model.documentList.length,
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
                                            _engineerInfo(
                                                model.documentList[i], model),
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
  Widget _engineerInfo(
      DocumentResponseModel document, DocumnetViewModel model) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(

              color: (document.bisEngineerRead ||
                                    model.isfileopened[
                                        document.intId.toString()])?Colors.white: AppColors.green,
              border: Border(
                  bottom: BorderSide(color: AppColors.lightGrayDotColor))),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.documentType,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizeConfig.horizontalSpaceMedium(),
                Expanded(
                    flex: 3,
                    child: Text(
                      document?.strDocType ?? "",
                      style: TextStyle(color: (document.bisEngineerRead ||
                                    model.isfileopened[
                                        document.intId.toString()])? AppColors.darkGrayColor :Colors.white),
                      textAlign: TextAlign.start,
                    )),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.lightGrayDotColor))),
          child: Padding(
            padding: SizeConfig.padding,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.file,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizeConfig.horizontalSpaceMedium(),
                Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        String _url = document.strValue +
                            "Upload/SupplierDoc/" +
                            document.strFileName;
                         print("url...................$_url");   
                        String doc = await model.pdfview(_url);
                        print("doc..............................$doc");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DocumentView(
                                  doc: _url,
                                )));
                        model.onPDFOpen(context, document?.intId.toString());
                      },
                      child: Text(
                        document?.strFileName ?? "",
                        style: TextStyle(
                            color: AppColors.darkGrayColor,
                            fontWeight: (document.bisEngineerRead ||
                                    model.isfileopened[
                                        document.intId.toString()])
                                ? FontWeight.normal
                                : FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //survey info

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}

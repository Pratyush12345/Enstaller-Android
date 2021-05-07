import 'package:barcode_scan/barcode_scan.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/checkandassign_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/shared/warehouse_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter/services.dart';

class CheckAndAssignOrder extends StatefulWidget {
  @override
  _CheckAndAssignOrderState createState() => _CheckAndAssignOrderState();
}

class _CheckAndAssignOrderState extends State<CheckAndAssignOrder> {

  final TextEditingController ordercontroller = TextEditingController();
  final TextEditingController serialcontroller = TextEditingController();
  List<CheckAndAssignDataRow> _listOrderLinedetail;
  bool _showOrderErrorMsg;
  bool _showSerialErrorMsg;
  bool _showbelowColumn;
  bool _isIncorrectOrderNo;
  
  _getOrderLineDetail(){
    _listOrderLinedetail = [];
    _listOrderLinedetail.add(CheckAndAssignDataRow(
        firstText: AppStrings.ITEMs,
        secondText: AppStrings.QTY,
      ),);
    _listOrderLinedetail.addAll(CheckAndAssignOrderVM.instance.orderLineDetailList.map((e) => CheckAndAssignDataRow(
        firstText: e?.strItemName ?? "",
        secondText: e?.decQty.toString() ?? "",
      ),).toList());
    return _listOrderLinedetail;
  }
  _showOrderDetail() {
    return Column(
      children: [
       if(CheckAndAssignOrderVM.instance.orderByRefernceModel != null)
        Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7)),
          child: AppButton(
            buttonText: 'Order Details',
            color: AppColors.appThemeColor,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              
            },
          ),
        ),
        CheckAndAssignDataRow(
          firstText: "Reference",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strRefrence ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Status",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strStatus ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "User",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strUserName ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Warehouse",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strWarehouseName ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Collection Date",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.dteCollectionDate ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Approved",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.isApproved ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Merged",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.isMerged ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Created",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.dteCreatedDate ?? "",
        ),
        CheckAndAssignDataRow(
          firstText: "Modified",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.dteModifiedDate ?? "",
        ),
        
      ],
    ),
    SizedBox(height: 25.0,),
    if(CheckAndAssignOrderVM.instance.orderLineDetailList!= null)
    Column(
      children: _getOrderLineDetail(),
    ) ,
    ],
    );
  }
  
  _showListofSerial(){
    return Column(
      children: [
           if(CheckAndAssignOrderVM.instance.showListView.isNotEmpty)
           Container(
             height: MediaQuery.of(context).size.height*0.5,
             child: ListView.builder(
               itemCount: CheckAndAssignOrderVM.instance.showListView.length,
               itemBuilder: (context, index){
                 return Card(
                   color: AppColors.appThemeColor,
                  child: ListTile(
                    title: Text(CheckAndAssignOrderVM.instance.showListView[index].strSerialNo + " - "+
                    CheckAndAssignOrderVM.instance.showListView[index].strItemName ,
                     style: TextStyle(color: Colors.white),
                     ) ,
                     trailing: IconButton(
                       icon: Icon(Icons.cancel_sharp, color: Colors.white,),
                       onPressed: (){
                         CheckAndAssignOrderVM.instance.showListView.removeAt(index);
                         setState(() {
                         });
                       },
                     ),
                  ),
                 );
               }),
           ),
           SizedBox()
      ],
    );
  }
              
  @override
  void initState() {
    _showOrderErrorMsg  = false;
    _showSerialErrorMsg = false;
    _showbelowColumn = false;
    _isIncorrectOrderNo = false;
    CheckAndAssignOrderVM.instance.orderByRefernceModel = null;
    CheckAndAssignOrderVM.instance.orderLineDetailList = null;
    CheckAndAssignOrderVM.instance.showListView = [];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    SizeConfig.sizeConfigInit(context);
    return Scaffold(
      appBar: AppBar(
        
              brightness: Brightness.dark,
        backgroundColor: AppColors.appThemeColor,
        title: Text("Check Order And Assign Stock",
        style: TextStyle(
          color: Colors.white
        ),),),
      drawer: Drawer(
              //child: AppDrawerWidget(),
              child: GlobalVar.roleId == 5 ? WareHouseDrawerWidget() :  AppDrawerWidget(),
            ),  
      body: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
          child: ListView(
          //rossAxisAlignment: CrossAxisAlignment.start,  
          children: [
            Text("Scan Order No."),
            SizedBox(height: 6.0,),
            TextField(
              controller: ordercontroller ,
              onTap:  () async {
                      String barcodeScanRes;
                      try {
                        var result = await BarcodeScanner.scan();
                        print(result.rawContent);
                        
                           ordercontroller.text = result.rawContent.toString();
                           if(ordercontroller.text.contains("-")){

                           _showOrderErrorMsg = await CheckAndAssignOrderVM.instance.checkValidity(context, ordercontroller.text);
                           _showbelowColumn = true;
                           _isIncorrectOrderNo = false;
                        setState(() {
                          
                        });
                           }
                           else{
                             _showOrderErrorMsg = true;
                             _isIncorrectOrderNo = true;
                             setState(() {
                               
                             });
                           }
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
              decoration: InputDecoration(
                
              ),
            ),
            SizedBox(height: 8.0,),
            if(_showOrderErrorMsg && !_isIncorrectOrderNo)
            Text("Order No. Already Assigned",
            style: TextStyle(
              color: Colors.red
            ),),
            if(_isIncorrectOrderNo)
            Text("Invalid Order No.",
            style: TextStyle(
              color: Colors.red
            ),),

            SizedBox(height: 12.0,),
            if(!_showOrderErrorMsg  )
            _showOrderDetail(),

            SizedBox(height: 30.0,),

            if(!_showOrderErrorMsg && _showbelowColumn)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Scan Serial No."),
                SizedBox(height: 6.0,),
            TextField(
              controller: serialcontroller,
              onTap:  () async {
                      String barcodeScanRes;
                      try {
                        var result = await BarcodeScanner.scan();
                        print(result.rawContent);
                        
                           serialcontroller.text = result.rawContent.toString();
                           _showSerialErrorMsg = await CheckAndAssignOrderVM.instance.checkSerialValidty(context, serialcontroller.text, 
                            CheckAndAssignOrderVM.instance.orderByRefernceModel.intId.toString());
                        setState(() {
                          
                        });
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
              decoration: InputDecoration(
                
              ),
            ),
            if(_showSerialErrorMsg)
            Text("Invalid Serial No.",
            style: TextStyle(
              color: Colors.red
            ),),

            SizedBox(height: 12.0,),
            _showListofSerial(),
            Center(
              child: AppButton(
                onTap: (){
                 CheckAndAssignOrderVM.instance.save(context, CheckAndAssignOrderVM.instance.orderByRefernceModel.intId);
                },
                width: 100,
                height: 40,
                radius: 10,
                color: AppColors.appThemeColor,
                buttonText: "Save",   
                textStyle: TextStyle(
                  color: Colors.white
                ),                       
              ),
            )
              ],
            ),
                
          ],
        ),
      )
    );
  }
}
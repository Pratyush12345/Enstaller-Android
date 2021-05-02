import 'package:barcode_scan/barcode_scan.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/checkandassign_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
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
        Text(""),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7)),
          child: AppButton(
            buttonText: 'Oder Details',
            color: AppColors.green,
            textStyle: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            onTap: () {
              
            },
          ),
        ),
        AppointmentDataRow(
          firstText: "Reference",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strRefrence ?? "",
        ),
        AppointmentDataRow(
          firstText: "Status",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strStatus ?? "",
        ),
        AppointmentDataRow(
          firstText: "User",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strUserName ?? "",
        ),
        AppointmentDataRow(
          firstText: "Warehouse",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.strWarehouseName ?? "",
        ),
        AppointmentDataRow(
          firstText: "Collection Date",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.dteCollectionDate ?? "",
        ),
        AppointmentDataRow(
          firstText: "Approved",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.isApproved ?? "",
        ),
        AppointmentDataRow(
          firstText: "Merged",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.isMerged ?? "",
        ),
        AppointmentDataRow(
          firstText: "Created",
          secondText: CheckAndAssignOrderVM.instance.orderByRefernceModel.dteCreatedDate ?? "",
        ),
        AppointmentDataRow(
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
                   color: AppColors.green ,
                  child: ListTile(
                    title: Text(CheckAndAssignOrderVM.instance.showListView[index].strSerialNo,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("Check And Assign Order",
        style: TextStyle(
          color: Colors.white
        ),),),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [
              Text("Enter Order No."),
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
              Text("Invalid Bar code",
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
                  Text("Enetr Serial No."),
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
              Text("Invalid Bar Code Number",
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
                  color: AppColors.green,
                  buttonText: "Save",                          
                ),
              )
                ],
              ),
                  
            ],
          ),
        )
      )
    );
  }
}
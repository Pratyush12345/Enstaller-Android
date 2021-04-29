import 'package:barcode_scan/barcode_scan.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/checkandassign_viewmodel.dart';
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
  bool _showOrderErrorMsg;
  bool _showSerialErrorMsg;

  _showOrderDetail() {
    return Column();
  }

  _showListofSerial(){
    return Column();
  }

  @override
  void initState() {
    _showOrderErrorMsg  = false;
    _showSerialErrorMsg = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("Check And Assign Order"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Enetr Order Np."),
            SizedBox(height: 8.0,),
            TextField(
              controller: ordercontroller ,
              onTap:  () async {
                      String barcodeScanRes;
                      try {
                        var result = await BarcodeScanner.scan();
                        print(result.rawContent);
                        setState(() async {
                           ordercontroller.text = result.rawContent.toString();
                           _showOrderErrorMsg = await CheckAndAssignOrderVM.instance.checkValidity(context);
                          });
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
              decoration: InputDecoration(
                
              ),
            ),
            if(_showOrderErrorMsg)
            Text("Invalid Bar Code Number "),
            SizedBox(height: 12.0,),
            _showOrderDetail(),
            Text("Enetr Order No."),
            SizedBox(height: 8.0,),
            TextField(
              controller: serialcontroller,
              onTap:  () async {
                      String barcodeScanRes;
                      try {
                        var result = await BarcodeScanner.scan();
                        print(result.rawContent);
                        setState(() async {
                           serialcontroller.text = result.rawContent.toString();
                           _showSerialErrorMsg = await CheckAndAssignOrderVM.instance.checkValidity(context);
                          });
                      } on PlatformException {
                        barcodeScanRes = 'Failed to get platform version.';
                      }
                    },
              decoration: InputDecoration(
                
              ),
            ),
            if(_showOrderErrorMsg)
            Text("Invalid Bar Code Number "),
            SizedBox(height: 12.0,),
            _showListofSerial(),
            AppButton(
              onTap: (){
               CheckAndAssignOrderVM.instance.save(context);
              },
              width: 100,
              height: 40,
              radius: 10,
              color: AppColors.green,
              buttonText: "Save",                          
            )    
          ],
        )
      )
    );
  }
}
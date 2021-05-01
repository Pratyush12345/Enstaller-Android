import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/stock_update_status.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:flutter/material.dart';
class StockUpdateStatus extends StatefulWidget {
  @override
  _StockUpdateStatusState createState() => _StockUpdateStatusState();
}

class _StockUpdateStatusState extends State<StockUpdateStatus> {

  int selectedradio;
  @override
  void initState() {
    selectedradio = 0;
    super.initState();
  } 

  _getBatchWidget(StockUpdateStatusViewModel model){
   return Column(
     children: [
       Padding(
                  padding: EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (value) async {
                      model.bValue = value;
                      StockBatchModel stockBatchModel = model.stockBatchList
                      .firstWhere((element) => element.strBatchNumber == value);
                       await model.getPallets(stockBatchModel.intBatchId);
                       setState(() {
                         
                       });
                     },

                    decoration: InputDecoration(
                      hintText: 'Select',
                      labelText: 'Batch Selection',
                    ),
                    value: model.bValue ,
                    items:    
                          model.stockBatchList.map((e) => 
                          DropdownMenuItem<String>(
                                  child: Text(e.strBatchNumber),
                                  value: e.strBatchNumber.toString(),
                                )
                          ).toList(),
                    onSaved: (val) {
                     // widget.saveOrderLine.intContractId = int.parse(val);
                    },
                    validator: (val) {
                      print('value is $val');
                      if (val == null) return 'Please choose an option.';
                      return null;
                    },
                  )),
           SizedBox(height: 8.0,),
           if(model.bValue!=null)
           Container(
             child: GridView.builder(
                padding: EdgeInsets.all(6.0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3
                ),
                itemCount: model.stockPalletList.length,
                itemBuilder: (context, index){
                  return InkWell(
                      onTap: (){
                        setState(() {
                          model.stockPalletList[index].isSelected = true;
                        });
                      },
                      child: Container(
                      decoration: BoxDecoration(
                         borderRadius:  BorderRadius.circular(2.0),
                         color:  model.stockPalletList[index].isSelected? AppColors.green: Colors.brown
                      ),
                      child: Center(
                        child: Text(model.stockPalletList[index].strPalletId,
                        style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  );
                },
        ),
           ),
           SizedBox(height: 8.0,),
           
            
     ],
   );
  }
  _getItemWidget( StockUpdateStatusViewModel model){
   return Column(
     children: [
       AppButton(
              onTap: (){
               //CheckAndAssignOrderVM.instance.save(context);
              },
              width: 100,
              height: 40,
              radius: 10,
              color: AppColors.green,
              buttonText: "Choose CSV file",                          
            )
     ],
   );
  }
 
  @override
  Widget build(BuildContext context) {
    return BaseView<StockUpdateStatusViewModel> (
       onModelReady: (model) => model.initializeData(),
      builder: (context, model, child) {
         return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          title: Text("Stock Update Status",
          style: TextStyle(color: AppColors.whiteColor)),
          actions: [
            IconButton(
              icon: Icon(Icons.download_rounded, color: Colors.white,),
             onPressed: (){
               model.onDownloadPressed();
             })
          ],
          ),
        body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator(): SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                      child: Column(
              children: [
                Padding(
                      padding: EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
                        onChanged: (value) {
                         model.lValue = value;
                         },

                        decoration: InputDecoration(
                          hintText: 'Select',
                          labelText: 'Location Selection',
                        ),
                        value: model.lValue,

                        items:    
                          model.stockLocationList.map((e) => 
                          DropdownMenuItem<String>(
                                  child: Text(e.locationName),
                                  value: e.locationName.toString(),
                                )
                          ).toList(),
                        onSaved: (val) {
                         // widget.saveOrderLine.intContractId = int.parse(val);
                        },
                        validator: (val) {
                          print('value is $val');
                          if (val == null) return 'Please choose an option.';
                          return null;
                        },
                      )),
                SizedBox(height: 20.0,),      
                Padding(
                      padding: EdgeInsets.all(12.0),
                      child: DropdownButtonFormField<String>(
                        onChanged: (value) {
                         model.sValue = value;
                        },

                        decoration: InputDecoration(
                          hintText: 'Select',
                          labelText: 'Status Selection',
                        ),
                        value: model.sValue,
                        items:   
                          model.stockStatusList.map((e) => 
                          DropdownMenuItem<String>(
                                  child: Text(e.strStatusName),
                                  value: e.strStatusName.toString(),
                                )
                          ).toList(),
                        onSaved: (val) {
                         // widget.saveOrderLine.intContractId = int.parse(val);
                        },
                        validator: (val) {
                          print('value is $val');
                          if (val == null) return 'Please choose an option.';
                          return null;
                        },
                      )),
                   SizedBox(height: 20.0,),
                   Text("Comment"),
                   TextField(
                     decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(4.0)
                       )
                     ),
                     maxLines: 5,
                   ),
                   SizedBox(height: 20.0,),
                   Text("Updated By"),
                   Row(
                     children: [
                       Text("By Batch"),
                       Radio(value: 1, groupValue: selectedradio,
                        onChanged: (val){
                          setState(() {
                            selectedradio = val;
                          });
                       }),
                     ],
                   ),
                   Row(
                     children: [
                       Text("By Item"),
                       Radio(value: 2, groupValue: selectedradio,
                        onChanged: (val){
                          setState(() {
                            selectedradio = val;
                          });
                       }),
                     ],
                   ), 
                  if(selectedradio  == 1)   
                  _getBatchWidget(model),
                  
                  if(selectedradio  == 2)   
                  _getItemWidget(model),

                  AppButton(
                  onTap: (){
                   //CheckAndAssignOrderVM.instance.save(context);
                  },
                  width: 100,
                  height: 40,
                  radius: 10,
                  color: AppColors.green,
                  buttonText: "Save",                          
                )
              ],
            ),
          ),
        )
      );
            },
    );
  }
}
import 'package:enstaller/core/constant/app_colors.dart';
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

  _getBatchWidget(){
   return Column(
     children: [
       Padding(
                  padding: EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (value) {
                     // widget.saveOrderLine.intContractId = int.parse(value);
                    },

                    decoration: InputDecoration(
                      hintText: 'Select',
                      labelText: 'Batch Selection',
                    ),
                    value: "Location",
                    items: [],
                        // : [
                        //     DropdownMenuItem<String>(
                        //       child: Text(widget.contractList.firstWhere(
                        //           (element) =>
                        //               element['value'] == cValue)['label']),
                        //       value: cValue.toString(),
                        //     )
                        //   ],
                    onSaved: (val) {
                     // widget.saveOrderLine.intContractId = int.parse(val);
                    },
                    validator: (val) {
                      print('value is $val');
                      if (val == null) return 'Please choose an option.';
                      return null;
                    },
                  )),
            
     ],
   );
  }
  _getItemWidget(){
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("Stock Update Status"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                  padding: EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    onChanged: (value) {
                     // widget.saveOrderLine.intContractId = int.parse(value);
                    },

                    decoration: InputDecoration(
                      hintText: 'Select',
                      labelText: 'Location Selection',
                    ),
                    value: "Location",
                    items: [],
                        // : [
                        //     DropdownMenuItem<String>(
                        //       child: Text(widget.contractList.firstWhere(
                        //           (element) =>
                        //               element['value'] == cValue)['label']),
                        //       value: cValue.toString(),
                        //     )
                        //   ],
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
                     // widget.saveOrderLine.intContractId = int.parse(value);
                    },

                    decoration: InputDecoration(
                      hintText: 'Select',
                      labelText: 'Status Selection',
                    ),
                    value: "Location",
                    items: [],
                        // : [
                        //     DropdownMenuItem<String>(
                        //       child: Text(widget.contractList.firstWhere(
                        //           (element) =>
                        //               element['value'] == cValue)['label']),
                        //       value: cValue.toString(),
                        //     )
                        //   ],
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
                 maxLines: 8,
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
              _getBatchWidget(),
              
              if(selectedradio  == 2)   
              _getItemWidget(),

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
      )
    );
  }
}
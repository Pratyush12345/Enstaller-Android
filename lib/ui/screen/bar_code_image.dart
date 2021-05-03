import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarCodeRender extends StatefulWidget {
  final String number;
  
  BarCodeRender({@required this.number});
  @override
  _BarCodeRenderState createState() => _BarCodeRenderState();
}

class _BarCodeRenderState extends State<BarCodeRender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
              
        title: Text("Bar Code Image",
        style: TextStyle(color: Colors.white),),),
      body: Center(
        child: Padding(
           padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            
                child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width*0.9,
            child: BarCodeImage(
            
                  params: Code128BarCodeParams(
                  widget.number,
                  lineWidth:
                      1.7, // width for a single black/white bar (default: 2.0)
                  barHeight:
                      90.0, // height for the entire widget (default: 100.0)
                  withText:
                      false, // Render with text label or not (default: false)
                ),
                onError: (error) {
                  // Error handler
                  print('error = $error');
                },
              ),
          ),
        ),
      ),
    );
  }
}
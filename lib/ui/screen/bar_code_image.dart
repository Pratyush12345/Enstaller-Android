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
              
        title: Text("Bar Code Image"),),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: BarCodeImage(
          
                  params: Code39BarCodeParams(
                  widget.number,
                  lineWidth:
                      2.0, // width for a single black/white bar (default: 2.0)
                  barHeight:
                      90.0, // height for the entire widget (default: 100.0)
                  withText:
                      true, // Render with text label or not (default: false)
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
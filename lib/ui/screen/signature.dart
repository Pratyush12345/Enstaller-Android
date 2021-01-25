import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignatureScreen extends StatefulWidget {
  
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _SignatureScreenState extends State<SignatureScreen> {
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,"hello");
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Signature(
                    color: color,
                    key: _sign,
                    onSign: () {
                      final sign = _sign.currentState;
                      debugPrint('${sign.points.length} points in the signature');
                    },
                    strokeWidth: strokeWidth,
                  ),
                ),
                color: Colors.black12,
              ),
            ),
            _img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(_img.buffer.asUint8List())),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        color: Colors.green,
                        onPressed: () async {
                          final sign = _sign.currentState;
                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                          final image = await sign.getData();
                          var data = await image.toByteData(format: ui.ImageByteFormat.png);
                          sign.clear();
                          final encoded = base64.encode(data.buffer.asUint8List());
                          setState(() {
                            _img = data;
                            Navigator.pop(context,_img);

                          });
                          debugPrint("onPressed " + encoded);
                        },
                        child: Text(AppStrings.save)),
                    MaterialButton(
                        color: Colors.grey,
                        onPressed: () {
                          final sign = _sign.currentState;
                          sign.clear();
                          setState(() {
                            _img = ByteData(0);
                          });
                          debugPrint("cleared");
                        },
                        child: Text(AppStrings.clear)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            color = color == Colors.green ? Colors.red : Colors.green;
                          });
                          debugPrint("change color");
                        },
                        child: Text(AppStrings.changeColor)),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            int min = 1;
                            int max = 10;
                            int selection = min + (Random().nextInt(max - min));
                            strokeWidth = selection.roundToDouble();
                            debugPrint("change stroke width to $selection");
                          });
                        },
                        child: Text(AppStrings.changeStrokeWidth)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
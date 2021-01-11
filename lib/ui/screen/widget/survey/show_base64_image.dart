import 'dart:convert';
import 'dart:typed_data';

import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class ShowBase64Image extends StatefulWidget {
  final String base64String;

  ShowBase64Image({this.base64String});

  @override
  _ShowBase64ImageState createState() => _ShowBase64ImageState();
}

class _ShowBase64ImageState extends State<ShowBase64Image> {
  Uint8List bytesImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
      Uint8List _bytesImage = Base64Decoder().convert(widget.base64String);
    setState(() {
      bytesImage=_bytesImage;
    });

    }catch(e){
      setState(() {
        bytesImage=null;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return bytesImage!=null?Container(
      height: 100,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(image: MemoryImage(bytesImage),
        fit: BoxFit.contain)
      ),
    ):Container();
  }
}

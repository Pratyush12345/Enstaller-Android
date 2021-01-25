import 'dart:convert';
import 'dart:typed_data';

import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/ui/shared/app_image_widget.dart';
import 'package:flutter/material.dart';

class ViewPAnswerImageWidget extends StatefulWidget {
  final String url;

  ViewPAnswerImageWidget({this.url});

  @override
  _ViewPAnswerImageWidgetState createState() => _ViewPAnswerImageWidgetState();
}

class _ViewPAnswerImageWidgetState extends State<ViewPAnswerImageWidget> {

  @override
  Widget build(BuildContext context) {

    print('url==${widget.url}');
    return widget.url!=null?ViewAppImage(
      imageUrl: widget.url,
      height: 100,
      width: SizeConfig.screenWidth,
    ):Container();
  }
}

import 'package:flutter/material.dart';

class HomePageExpansionWidget extends StatelessWidget {
  final Widget firstWidget,secondWidget;
  final Function onTap;
  final bool showSecondWidget;
  HomePageExpansionWidget({this.onTap,this.firstWidget,this.secondWidget,this.showSecondWidget:false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          firstWidget,
          showSecondWidget?secondWidget:Container()
        ],
      ),
    );
  }
}

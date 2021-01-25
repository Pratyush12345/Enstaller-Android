import 'package:flutter/material.dart';

class CustomExpandedTile extends StatelessWidget {
  final Widget firstChild,secondChild;
  final bool expanded;
  final Function onTap;
  CustomExpandedTile({this.firstChild,this.secondChild,this.expanded,this.onTap});
  @override
  Widget build(BuildContext context) {
    return expanded?secondChild:firstChild;
  }
}

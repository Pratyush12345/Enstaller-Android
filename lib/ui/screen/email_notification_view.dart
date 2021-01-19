import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:simple_html_css/simple_html_css.dart';
class EmailView extends StatelessWidget {
  String html;
  EmailView({@required this.html});

  @override
  Widget build(BuildContext context) {
    //print(html.replaceAll("\r", "").replaceAll("\n",""));
     var document = parse(html);
     print(document.body.outerHtml);
    
    return Scaffold(
      appBar: AppBar(title: Text("Message"),),
      body: Container(
         child: Html(data: document.outerHtml),
    ));
  }
}
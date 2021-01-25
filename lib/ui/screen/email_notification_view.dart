import 'package:flutter/material.dart';
import 'package:html/parser.dart';
class EmailView extends StatelessWidget {
  String html;
  EmailView({@required this.html});

  @override
  Widget build(BuildContext context) {
    //print(html.replaceAll("\r", "").replaceAll("\n",""));
     var document = parse(html);
     print(document.body.outerHtml);
     print(document.body.text);
    
    return Scaffold(
      appBar: AppBar(title: Text("Message"),),
      body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(16.0),
                    child: Text(document.body.text.trim().replaceAll("     ", ""), 
           textAlign: TextAlign.start,
            
           style: TextStyle(fontSize: 14.0,
           
           ),
        
           ),
         ),
    ));
  }
}
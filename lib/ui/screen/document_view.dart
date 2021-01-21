import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class DocumentView extends StatelessWidget {
  String doc;
  DocumentView({@required this.doc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document"),),
      body: Center(
        child:  PDFView(
          filePath: doc,
        )
      ),
    );
  }
}
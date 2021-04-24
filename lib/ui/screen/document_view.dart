import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class DocumentView extends StatelessWidget {
  String doc;
  DocumentView({@required this.doc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document",
      style: TextStyle(
        color: Colors.white
      ),),),
      body: Center(
  //       child:  PDFView(
  //         filePath: doc,
  //          onError: (error) {
  //   print("eror....................."+error.toString());
  // },
  //       )
   child: SfPdfViewer.network(
        doc,
      
      ),
      ),
    );
  }
}
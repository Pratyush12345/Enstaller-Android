import 'dart:convert';

import 'package:flutter/material.dart';

import 'core/model/persion.dart';


class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RaisedButton(onPressed: (){

        List<Payment>payments=List<Payment>.generate(2, (int index) {
          return Payment(name: 'Person $index', personalId: '$index');
        });

        final String requestBody = json.encoder.convert(payments);
        print(requestBody);



      },child: Text('data'),),),
    );
  }
}

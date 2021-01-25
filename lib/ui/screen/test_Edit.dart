import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/material.dart';

class loginDesign extends StatefulWidget {
  @override
  _loginDesignState createState() => _loginDesignState();
}

class _loginDesignState extends State<loginDesign> {
  var globalKeyForForm = GlobalKey<FormState>();
  TextEditingController waiterEmail, hotelEmail, waiterPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 150, 25, 0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 35),
                      child: Form(
                        key: globalKeyForForm,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Waiter Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                ),
                              ),
                              controller: waiterEmail,
                              validator: (waiterEmailText) {
                                if(waiterEmailText.isEmpty) return 'email is required...';

                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          if(globalKeyForForm.currentState.validate()){

                          }
                        },
                        child: Text(
                          AppStrings.signIn,
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.black,
                        textColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
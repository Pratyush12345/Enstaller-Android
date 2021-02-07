import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


Widget commonTextFormField(TextEditingController controller,hinttext, keybordtype,validation,bool enable,context,maxline,bool autovalidation){
  return  TextFormField(
//    autovalidate: autovalidation,
    maxLines: maxline,
    enabled: enable,
    controller: controller,
    keyboardType: keybordtype,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.02, MediaQuery.of(context).size.height*0.02, MediaQuery.of(context).size.width*0.02),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0,)),
        enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.transparent, width: 0.0,),borderRadius: BorderRadius.circular(0.0,)
        ),

        hintText: hinttext,
        errorStyle: TextStyle(color: Colors.red),
        suffixIcon: enable==false?Icon(Icons.keyboard_arrow_down):null

    ),
    validator: (value) {
  if (value.isEmpty) {
  return 'Please enter text';
  }else{
    return null;
  }
    }
  );
}
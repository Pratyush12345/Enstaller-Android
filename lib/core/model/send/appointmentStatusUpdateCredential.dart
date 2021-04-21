

import 'package:flutter/cupertino.dart';

class AppointmentStatusUpdateCredentials {
  String intId;
  String intEngineerId;
  String intBookedBy;
  String strStatus;
  String strEmailActionby;
  AppointmentStatusUpdateCredentials(
      {
        this.intId,
        this.intEngineerId,
        this.intBookedBy,
        this.strStatus,
        @required this.strEmailActionby});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intEngineerId'] = this.intEngineerId;
    data['intBookedBy'] = this.intBookedBy;
    data['strStatus']=this.strStatus;
    data['strEmailActionby']=this.strEmailActionby;
    return data;
  }
}
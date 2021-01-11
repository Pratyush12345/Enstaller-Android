

class AppointmentStatusUpdateCredentials {
  String intId;
  String intEngineerId;
  String intBookedBy;
  String strStatus;

  AppointmentStatusUpdateCredentials(
      {
        this.intId,
        this.intEngineerId,
        this.intBookedBy,this.strStatus});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intEngineerId'] = this.intEngineerId;
    data['intBookedBy'] = this.intBookedBy;
    data['strStatus']=this.strStatus;
    return data;
  }
}
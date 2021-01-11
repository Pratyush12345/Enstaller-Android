class AnswerCredential {
  String intappointmentid;
  String intsurveyid;
  String intsurveyquetionid;
  String stranswer;
  String intcreatedby;
  String bisalive;
  String strfilename;

  AnswerCredential(
      {this.intappointmentid,
        this.intsurveyid,
        this.intsurveyquetionid,
        this.stranswer,
        this.intcreatedby,
        this.bisalive,
        this.strfilename});

  AnswerCredential.fromJson(Map<String, dynamic> json) {
    intappointmentid = json['intappointmentid'];
    intsurveyid = json['intsurveyid'];
    intsurveyquetionid = json['intsurveyquetionid'];
    stranswer = json['stranswer'];
    intcreatedby = json['intcreatedby'];
    bisalive = json['bisalive'];
    strfilename = json['strfilename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intappointmentid'] = this.intappointmentid;
    data['intsurveyid'] = this.intsurveyid;
    data['intsurveyquetionid'] = this.intsurveyquetionid;
    data['stranswer'] = this.stranswer;
    data['intcreatedby'] = this.intcreatedby;
    data['"bisalive"'] = this.bisalive;
    data['strfilename'] = this.strfilename;
    return data;
  }
//  Map<String, dynamic> toJson() => <String, dynamic>{
//    'intappointmentid': intappointmentid,
//    'intsurveyid': intsurveyid,
//    'intsurveyquetionid': intsurveyquetionid,
//    'stranswer': stranswer,
//    'intcreatedby': intcreatedby,
//    'bisalive': bisalive,
//    'strfilename': strfilename,
//
//  };
}
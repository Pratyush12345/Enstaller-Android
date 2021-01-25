class QuestionAnswer {
  int intId;
  int intappointmentId;
  int intSurveyid;
  int intSurveyQuetionId;
  String strQuestionText;
  String strAnswer;
  String strFileName;
  String strSectionName;
  String strQuestiontype;
  int intCreatedby;
  int intSectionID;
  bool bisAlive;
  String fileUrlPath;

  QuestionAnswer(
      {this.intId,
        this.intappointmentId,
        this.intSurveyid,
        this.intSurveyQuetionId,
        this.strQuestionText,
        this.strAnswer,
        this.strFileName,
        this.strSectionName,
        this.strQuestiontype,
        this.intCreatedby,
        this.intSectionID,
        this.fileUrlPath,
        this.bisAlive});

  QuestionAnswer.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intappointmentId = json['intappointmentId'];
    intSurveyid = json['intSurveyid'];
    intSurveyQuetionId = json['intSurveyQuetionId'];
    strQuestionText = json['strQuestionText'];
    strAnswer = json['strAnswer'];
    strFileName = json['strFileName'];
    strSectionName = json['strSectionName'];
    strQuestiontype = json['strQuestiontype'];
    intCreatedby = json['intCreatedby'];
    intSectionID = json['intSectionID'];
    fileUrlPath=json['fileUrlPath'];
    bisAlive = json['bisAlive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intappointmentId'] = this.intappointmentId;
    data['intSurveyid'] = this.intSurveyid;
    data['intSurveyQuetionId'] = this.intSurveyQuetionId;
    data['strQuestionText'] = this.strQuestionText;
    data['strAnswer'] = this.strAnswer;
    data['strFileName'] = this.strFileName;
    data['strSectionName'] = this.strSectionName;
    data['strQuestiontype'] = this.strQuestiontype;
    data['intCreatedby'] = this.intCreatedby;
    data['intSectionID'] = this.intSectionID;
    data['bisAlive'] = this.bisAlive;
    data['fileUrlPath']=this.fileUrlPath;
    return data;
  }
}
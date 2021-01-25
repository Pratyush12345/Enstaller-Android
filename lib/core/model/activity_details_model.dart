import 'package:enstaller/core/constant/app_string.dart';

class ActivityDetailsModel {
  String strComment;
  String strEventType;
  String dteCreatedDate;
  bool bisIsSystemGenerated;
  String strUserName;

  ActivityDetailsModel(
      {this.strComment,
        this.strEventType,
        this.dteCreatedDate,
        this.bisIsSystemGenerated,
        this.strUserName});

  ActivityDetailsModel.fromJson(Map<String, dynamic> json) {
    strComment = json['strComment']==AppStrings.inRoute?AppStrings.enRoute:json['strComment']==AppStrings.onRoute?AppStrings.enRoute:json['strComment'];
    strEventType = json['strEventType'];
    dteCreatedDate = json['dteCreatedDate'];
    bisIsSystemGenerated = json['bisIsSystemGenerated'];
    strUserName = json['strUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strComment'] = this.strComment;
    data['strEventType'] = this.strEventType;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['bisIsSystemGenerated'] = this.bisIsSystemGenerated;
    data['strUserName'] = this.strUserName;
    return data;
  }
}
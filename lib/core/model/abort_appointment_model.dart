class AbortAppointmentModel {
   int intId;
   int intReasonId;
   int intUserId;
   String strName;
  AbortAppointmentModel(
      {this.intId,
        this.intReasonId,
        this.intUserId,
        this.strName,
        });

 AbortAppointmentModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intReasonId = json['intReasonId'];
    intUserId = json['intUserId'];
    strName = json['strName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intReasonId'] = this.intReasonId;
    data['intUserId'] = this.intUserId;
    data['strName'] = this.strName;
    return data;
  }
}


class ConfirmAbortAppointment {
  String intId;
  int isabort;
  String intAbortRequestedId;
  String strCancellationReason;
  String strCancellationComment;
  String bisAbortRequestApproved;
  String requestFrom;

  ConfirmAbortAppointment(
      {this.intId,
      this.isabort,
      this.intAbortRequestedId,
      this.strCancellationReason,
      this.strCancellationComment,
      this.bisAbortRequestApproved,
      this.requestFrom});

  ConfirmAbortAppointment.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    isabort = json['isabort'];
    intAbortRequestedId = json['intAbortRequestedId'];
    strCancellationReason = json['strCancellationReason'];
    strCancellationComment = json['strCancellationComment'];
    bisAbortRequestApproved = json['bisAbortRequestApproved'];
    requestFrom = json['requestFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['isabort'] = this.isabort;
    data['intAbortRequestedId'] = this.intAbortRequestedId;
    data['strCancellationReason'] = this.strCancellationReason;
    data['strCancellationComment'] = this.strCancellationComment;
    data['bisAbortRequestApproved'] = this.bisAbortRequestApproved;
    data['requestFrom'] = this.requestFrom;
    return data;
  }
}
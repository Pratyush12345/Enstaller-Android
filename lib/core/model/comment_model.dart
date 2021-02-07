class CommentModel {
  int intId;
  int intappintmentid;
  String strcomments;
  String dteCapturedAt;
  int intCreatedBy;

  CommentModel(
      {this.intId,
        this.intappintmentid,
        this.strcomments,
        this.dteCapturedAt,
        this.intCreatedBy});

  CommentModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intappintmentid = json['intappintmentid'];
    strcomments = json['strcomments'];
    dteCapturedAt = json['dteCapturedAt'];
    intCreatedBy = json['intCreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intappintmentid'] = this.intappintmentid;
    data['strcomments'] = this.strcomments;
    data['dteCapturedAt'] = this.dteCapturedAt;
    data['intCreatedBy'] = this.intCreatedBy;
    return data;
  }
}
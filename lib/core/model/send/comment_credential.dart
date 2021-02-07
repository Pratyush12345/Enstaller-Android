
class CommentCredential {
  String intappintmentid;
  String strcomments;
  String intCreatedBy;

  CommentCredential(
      {
        this.intappintmentid,
        this.strcomments,
        this.intCreatedBy});

  CommentCredential.fromJson(Map<String, dynamic> json) {
    intappintmentid = json['intappintmentid'];
    strcomments = json['strcomments'];
    intCreatedBy = json['intCreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intappintmentid'] = this.intappintmentid;
    data['strcomments'] = this.strcomments;
    data['intCreatedBy'] = this.intCreatedBy;
    return data;
  }
}
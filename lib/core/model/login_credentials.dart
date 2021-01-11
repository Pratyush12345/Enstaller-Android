class LoginCredential{
  String userName;
  String password;
  String groupType;
  LoginCredential({this.password,this.userName,this.groupType:"password"});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['PassWord'] = this.password;
    data['GrantType'] = this.groupType;
    return data;
  }
}
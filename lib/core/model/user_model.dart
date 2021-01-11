class UserModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  String id;
  String username;
  String name;
  String role;
  String intEngineerId;
  String strEngineerName;
  String issued;
  String expires;
  String email;
  bool rememberMe;

  UserModel(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.id,
        this.username,
        this.name,
        this.role,
        this.intEngineerId,
        this.strEngineerName,
        this.issued,
        this.email,
        this.expires,this.rememberMe:false});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    intEngineerId = json['intEngineerId'];
    strEngineerName = json['strEngineerName'];
    issued = json['.issued'];
    expires = json['.expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['intEngineerId'] = this.intEngineerId;
    data['strEngineerName'] = this.strEngineerName;
    data['.issued'] = this.issued;
    data['.expires'] = this.expires;
    return data;
  }
}
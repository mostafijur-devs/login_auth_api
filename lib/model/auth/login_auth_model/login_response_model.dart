class LoginAuth {
  bool? status;
  String? message;
  Data? data;

  LoginAuth({this.status, this.message, this.data});

  LoginAuth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  bool? isGoogleLogin;
  bool? isFacebookLogin;
  bool? isAppleLogin;
  bool? isSocialLogin;
  bool? isMergedWithGoogle;
  Null? profileImage;
  bool? emailVerify;
  String? createdAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.isGoogleLogin,
        this.isFacebookLogin,
        this.isAppleLogin,
        this.isSocialLogin,
        this.isMergedWithGoogle,
        this.profileImage,
        this.emailVerify,
        this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isGoogleLogin = json['is_google_login'];
    isFacebookLogin = json['is_facebook_login'];
    isAppleLogin = json['is_apple_login'];
    isSocialLogin = json['is_social_login'];
    isMergedWithGoogle = json['is_merged_with_google'];
    profileImage = json['profile_image'];
    emailVerify = json['email_verify'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['is_google_login'] = this.isGoogleLogin;
    data['is_facebook_login'] = this.isFacebookLogin;
    data['is_apple_login'] = this.isAppleLogin;
    data['is_social_login'] = this.isSocialLogin;
    data['is_merged_with_google'] = this.isMergedWithGoogle;
    data['profile_image'] = this.profileImage;
    data['email_verify'] = this.emailVerify;
    data['created_at'] = this.createdAt;
    return data;
  }
}

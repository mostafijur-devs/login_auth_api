class AuthResponse {
  bool? status;
  String? message;
  Data? data;
  Errors? errors;

  AuthResponse({this.status, this.message, this.data, this.errors});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'] != null
        ? new Errors.fromJson(json['errors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Data {
  Users? user;
  String? token;
  String? resetToken;

  Data({this.user, this.token , this.resetToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    token = json['token'];
    resetToken = json['reset_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['reset_token'] = resetToken;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  bool? isGoogleLogin;
  bool? isFacebookLogin;
  bool? isAppleLogin;
  bool? isSocialLogin;
  bool? isMergedWithGoogle;
  String? profileImage;
  bool? emailVerify;
  String? createdAt;

  Users({
    this.id,
    this.name,
    this.email,
    this.isGoogleLogin,
    this.isFacebookLogin,
    this.isAppleLogin,
    this.isSocialLogin,
    this.isMergedWithGoogle,
    this.profileImage,
    this.emailVerify,
    this.createdAt,
  });

  Users.fromJson(Map<String, dynamic> json) {
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

class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? password;
  List<String>? passwordConfirmation;
  List<String>? otp;
  List<String>? resetToken;

  Errors({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.otp,
    this.resetToken,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name']?.cast<String>();
    email = json['email']?.cast<String>();
    password = json['password']?.cast<String>();
    passwordConfirmation = json['password_confirmation']?.cast<String>();
    otp = json['otp']?.cast<String>();
    resetToken = json['reset_token']?.cast<String>();
    // resetToken = json['reset_token'] != null
    //     ? List<String>.from(json['reset_token'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['otp'] = this.otp;
    data['reset_token'] = this.resetToken;
    return data;
  }
}

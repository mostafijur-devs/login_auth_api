class LoginModel {
  String? email;
  String? password;
  String? firebaseDeviceToken;

  LoginModel({this.email, this.password, this.firebaseDeviceToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firebaseDeviceToken = json['firebase_device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firebase_device_token'] = this.firebaseDeviceToken;
    return data;
  }
}

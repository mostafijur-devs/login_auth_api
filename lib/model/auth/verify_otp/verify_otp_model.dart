class VerifyOTPModel {
  String? email;
  String? otp;
  String? firebaseDeviceToken;

  VerifyOTPModel({this.email, this.otp, this.firebaseDeviceToken});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    firebaseDeviceToken = json['firebase_device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['firebase_device_token'] = this.firebaseDeviceToken;
    return data;
  }
}

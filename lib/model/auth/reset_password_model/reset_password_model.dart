class ResetPasswordModel {
  String? password;
  String? passwordConfirmation;
  String? resetToken;

  ResetPasswordModel(
      {this.password, this.passwordConfirmation, this.resetToken});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    resetToken = json['reset_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['reset_token'] = this.resetToken;
    return data;
  }
}

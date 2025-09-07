class RegistrationResponse {
  bool? status;
  String? message;
  Errors? errors;

  RegistrationResponse({this.status, this.message, this.errors,});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? password;
  List<String>? passwordConfirmation;

  Errors({this.name, this.email, this.password, this.passwordConfirmation});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name']?.cast<String>() ;
    email = json['email']?.cast<String>();
    password = json['password']?.cast<String>();
    passwordConfirmation = json['password_confirmation']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}

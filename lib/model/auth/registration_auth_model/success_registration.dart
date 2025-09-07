class SuccessRegistration {
  bool? status;
  String? message;
  Null data;

  SuccessRegistration({this.status, this.message, this.data});

  SuccessRegistration.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

// class RegistrationResponse {
//   Error? error;
//   Success? success;
//
//   RegistrationResponse({this.error, this.success});
//
//   RegistrationResponse.fromJson(Map<String, dynamic> json) {
//     error = json['error'] != null ? new Error.fromJson(json['error']) : null;
//     success =
//     json['success'] != null ? new Success.fromJson(json['success']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.error != null) {
//       data['error'] = this.error!.toJson();
//     }
//     if (this.success != null) {
//       data['success'] = this.success!.toJson();
//     }
//     return data;
//   }
// }
//
// class Error {
//   String? message;
//   Errors? errors;
//
//   Error({this.message, this.errors});
//
//   Error.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     errors =
//     json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.errors != null) {
//       data['errors'] = this.errors!.toJson();
//     }
//     return data;
//   }
// }
//
// class Errors {
//   List<String>? email;
//
//   Errors({this.email});
//
//   Errors.fromJson(Map<String, dynamic> json) {
//     email = json['email'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     return data;
//   }
// }
//
// class Success {
//   bool? status;
//   String? message;
//   Null? data;
//
//   Success({this.status, this.message, this.data});
//
//   Success.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['data'] = this.data;
//     return data;
//   }
// }


class UserResponse {
  bool? status;
  String? message;
  Data? data;

  UserResponse({this.status, this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
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
  PrayerStatistics? prayerStatistics;

  Data(
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
        this.createdAt,
        this.prayerStatistics});

  Data.fromJson(Map<String, dynamic> json) {
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
    prayerStatistics = json['prayer_statistics'] != null
        ? new PrayerStatistics.fromJson(json['prayer_statistics'])
        : null;
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
    if (this.prayerStatistics != null) {
      data['prayer_statistics'] = this.prayerStatistics!.toJson();
    }
    return data;
  }
}

class PrayerStatistics {
  int? totalPrayerCount;
  int? totalPrayerDays;
  int? totalPerfectPrayerDays;
  int? averagePrayersPerDay;
  int? completionPercentage;

  PrayerStatistics(
      {this.totalPrayerCount,
        this.totalPrayerDays,
        this.totalPerfectPrayerDays,
        this.averagePrayersPerDay,
        this.completionPercentage});

  PrayerStatistics.fromJson(Map<String, dynamic> json) {
    totalPrayerCount = json['total_prayer_count'];
    totalPrayerDays = json['total_prayer_days'];
    totalPerfectPrayerDays = json['total_perfect_prayer_days'];
    averagePrayersPerDay = json['average_prayers_per_day'];
    completionPercentage = json['completion_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_prayer_count'] = this.totalPrayerCount;
    data['total_prayer_days'] = this.totalPrayerDays;
    data['total_perfect_prayer_days'] = this.totalPerfectPrayerDays;
    data['average_prayers_per_day'] = this.averagePrayersPerDay;
    data['completion_percentage'] = this.completionPercentage;
    return data;
  }
}

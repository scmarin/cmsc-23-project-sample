import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserInfoModel {
  String name;
  String email;
  List<DocumentReference> entries;
  String status;
  String userType;

  Map<String, dynamic>? preExistingIllnesses;
  String? empNo;
  String? homeUnit;
  String? position;

  String? userName;
  String? college;
  String? course;
  String? studNo;

  UserInfoModel(
      {required this.name,
      required this.email,
      required this.entries,
      required this.status,
      required this.userType,
      this.preExistingIllnesses,
      this.empNo,
      this.homeUnit,
      this.position,
      this.userName,
      this.college,
      this.course,
      this.studNo});

  factory UserInfoModel.fromJsonUser(Map<String, dynamic> json) {
    return UserInfoModel(
        name: json["Name"],
        userName: json["Username"],
        email: json["Email"],
        entries: json["Entries"].cast<DocumentReference>(),
        status: json["Status"],
        userType: json["User Type"],
        preExistingIllnesses: json["Pre-Existing Illnesses"],
        college: json["College"],
        course: json["Course"],
        studNo: json["Student No"]);
  }

  factory UserInfoModel.fromJsonAdminMonitor(Map<String, dynamic> json) {
    return UserInfoModel(
        name: json["Name"],
        email: json["Email"],
        entries: json["Entries"],
        status: json["Status"],
        userType: json["User Type"],
        empNo: json["Employee No"],
        position: json["Position"],
        homeUnit: json["Home Unit"]);
  }

  static List<UserInfoModel> fromJsonArray(String jsonData, String userType) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<UserInfoModel>((dynamic d) {
      return ((userType == "Student")
          ? UserInfoModel.fromJsonUser(d)
          : UserInfoModel.fromJsonAdminMonitor(d));
    }).toList();
  }

  Map<String, dynamic> toJsonUser(UserInfoModel userInfo) {
    return {
      "Name": userInfo.name,
      "Username": userInfo.userName,
      "Email": userInfo.email,
      "Entries": userInfo.entries,
      "Status": userInfo.status,
      "User Type": userInfo.userType,
      "Pre-Existing Illnesses": userInfo.preExistingIllnesses,
      "Employee No": userInfo.empNo,
      "Position": userInfo.position,
      "Home Unit": userInfo.homeUnit,
      "College": userInfo.college,
      "Course": userInfo.course,
      "Student No": userInfo.studNo
    };
  }

  Map<String, dynamic> toJsonAdminMonitor(UserInfoModel userInfo) {
    return {
      "Name": userInfo.name,
      "Email": userInfo.email,
      "Entries": userInfo.entries,
      "Status": userInfo.status,
      "User Type": userInfo.userType,
      "Pre-Existing Illnesses": userInfo.preExistingIllnesses,
      "Employee No": userInfo.empNo,
      "Position": userInfo.position,
      "Home Unit": userInfo.homeUnit
    };
  }
}

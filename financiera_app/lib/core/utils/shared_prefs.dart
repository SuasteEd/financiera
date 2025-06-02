import 'package:financiera_app/main.dart';

class Sharedprefs {
  void clear() {
    sharedPrefs.clear();
  }

  int? get companyID {
    return sharedPrefs.getInt('companyID');
  }

  set companyID(int? value) {
    if (value == null) return;
    sharedPrefs.setInt('companyID', value);
  }

  int? get campaingID {
    return sharedPrefs.getInt('campaingID');
  }

  set campaingID(int? value) {
    if (value == null) return;
    sharedPrefs.setInt('campaingID', value);
  }

  String? get token {
    return sharedPrefs.getString('token');
  }

  set token(String? value) {
    if (value == null) return;
    sharedPrefs.setString('token', value);
  }

  String? get cardNumber {
    return sharedPrefs.getString('cardNumber');
  }

  set cardNumber(String? value) {
    if (value == null) return;
    sharedPrefs.setString('cardNumber', value);
  }

  String? get date {
    return sharedPrefs.getString('date');
  }

  set date(String? value) {
    if (value == null) return;
    sharedPrefs.setString('date', value);
  }

  String? get email {
    return sharedPrefs.getString('email');
  }

  set email(String? value) {
    if (value == null) return;
    sharedPrefs.setString('email', value);
  }

  String? get phone {
    return sharedPrefs.getString('phone');
  }

  set phone(String? value) {
    if (value == null) return;
    sharedPrefs.setString('phone', value);
  }

  String? get password {
    return sharedPrefs.getString('password');
  }

  set password(String? value) {
    if (value == null) return;
    sharedPrefs.setString('password', value);
  }

  String? get userName {
    return sharedPrefs.getString('username');
  }

  set userName(String? value) {
    if (value == null) return;
    sharedPrefs.setString('username', value);
  }

  bool get isLogged {
    return sharedPrefs.getBool('isLogged') ?? false;
  }

  set isLogged(bool value) {
    sharedPrefs.setBool('isLogged', value);
  }

  bool get emailConfirmed {
    return sharedPrefs.getBool('emailConfirmed') ?? false;
  }

  set emailConfirmed(bool value) {
    sharedPrefs.setBool('emailConfirmed', value);
  }

  String get userId {
    return sharedPrefs.getString('userId') ?? '';
  }

  set userId(String value) {
    sharedPrefs.setString('userId', value);
  }

  String get reqID {
    return sharedPrefs.getString('reqID') ?? '1561';
  }

  set reqID(String value) {
    sharedPrefs.setString('reqID', value);
  }

  String get prospectID {
    return sharedPrefs.getString('prospectID') ?? '';
  }

  set prospectID(String value) {
    sharedPrefs.setString('prospectID', value);
  }

  bool get firstTime {
    return sharedPrefs.getBool('firstTime') ?? false;
  }

  set firstTime(bool value) {
    sharedPrefs.setBool('firstTime', value);
  }

  String get name {
    return sharedPrefs.getString('name') ?? '';
  }

  set name(String value) {
    sharedPrefs.setString('name', value);
  }

  String get fullName {
    return sharedPrefs.getString('fullname') ?? '';
  }

  set fullName(String value) {
    sharedPrefs.setString('fullname', value);
  }

  set idCampaing(String value) {
    sharedPrefs.setString('idCampaing', value);
  }

  String get idCampaing {
    return sharedPrefs.getString('idCampaing') ?? '';
  }

  set nameCompany(String value) {
    sharedPrefs.setString('nameCompany', value);
  }

  String get nameCompany {
    return sharedPrefs.getString('nameCompany') ?? '';
  }

  set nameCampaing(String value) {
    sharedPrefs.setString('nameCampaing', value);
  }

  String get nameCampaing {
    return sharedPrefs.getString('nameCampaing') ?? '';
  }

  
}

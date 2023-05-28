import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _skipOnboarding = prefs.getBool('skipOnboarding') ?? _skipOnboarding;
    _isVerified = prefs.getBool('isVerified') ?? _isVerified;
    _mapboxApi = prefs.getString('mapboxApi') ?? _mapboxApi;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _skipOnboarding = false;
  bool get skipOnboarding => _skipOnboarding;
  set skipOnboarding(bool _value) {
    _skipOnboarding = _value;
    prefs.setBool('skipOnboarding', _value);
  }

  bool _isVerified = false;
  bool get isVerified => _isVerified;
  set isVerified(bool _value) {
    _isVerified = _value;
    prefs.setBool('isVerified', _value);
  }

  String _mapboxApi =
      'pk.eyJ1IjoiYWR1aHNvcG8iLCJhIjoiY2xoZmtlbG5jMDluZDNpcGlsdHlscTUyZSJ9.WfnBy8pcxNRIlxyNXw7QBg';
  String get mapboxApi => _mapboxApi;
  set mapboxApi(String _value) {
    _mapboxApi = _value;
    prefs.setString('mapboxApi', _value);
  }
}

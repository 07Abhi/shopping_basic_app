import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shopappstmg/models/http_exceptions.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;

class AuthManager extends ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expirtTime;
  Timer _authTimer;

  bool get isAuth {
    return tokenData != null;
  }

  String get userid {
    return _userId;
  }

  String get tokenData {
    if (_expirtTime != null &&
        _expirtTime.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> _manageAuthentication(
      String email, String password, String requestype) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$requestype?key=AIzaSyCeg_VqjCTJuzKYVEDY1TOPcErz5SDGyPM';
    try {
      final response = await http.post(
        url,
        body: json.jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      var responseData = json.jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expirtTime = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autologout();
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      var data = json.jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryTime': _expirtTime.toIso8601String(),
      });
      await pref.setString('userData', data);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future signUpUser(String email, String password) async {
    return _manageAuthentication(email, password, 'signUp');
  }

  Future signInUser(String email, String password) async {
    return _manageAuthentication(email, password, 'signInWithPassword');
  }

  Future userLogout() async {
    _token = null;
    _userId = null;
    _expirtTime = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.clear();

  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.jsonDecode(pref.getString('userData')) as Map<String, Object>;
    final expiryData = DateTime.parse(extractedData['expiryTime']);
    if (expiryData.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _expirtTime = expiryData;
    notifyListeners();
    autologout();
    return true;
  }

  void autologout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expirtTime.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpire), userLogout);
  }
}

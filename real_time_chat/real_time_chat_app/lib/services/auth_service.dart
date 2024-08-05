import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:real_time_chat_app/global/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService with ChangeNotifier {



  Future<bool> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    try {
      final url = Environment().login;
      final response = await Dio()
          .post(url, data: jsonEncode(data))
          .onError((error, stackTrace) {
        throw error as Error;
      });
      if (response.statusCode == 200) {
        await _saveToken(response.data['token']);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signIn(String name, String email, String password) async {
    final data = {'name': name, 'email': email, 'password': password};
    try {
      final url = Environment().signIn;
      final response = await Dio()
          .post(url, data: jsonEncode(data))
          .onError((error, stackTrace) {
        throw error as Error;
      });
      if (response.statusCode == 200) {
        await _saveToken(response.data['token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
  }

  _saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  Future<String?> checkToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }
}

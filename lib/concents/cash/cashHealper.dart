import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences ?sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    @required String ?key,
    @required bool ?value,
  }) async {
    return await sharedPreferences!.setBool(key!, value!);
  }

  static dynamic getData({
    @required String? key,
  }) {
    return sharedPreferences!.get(key!);
  }

  static Future<bool> saveData({
    @required String? key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key!, value);
    if (value is int) return await sharedPreferences!.setInt(key!, value);
    if (value is bool) return await sharedPreferences!.setBool(key!, value);
    if (value is List<Map<String,dynamic>>) {
      final List<String> jsonList = value.map((item) => jsonEncode(item)).toList();
      return await sharedPreferences!.setStringList(key!, jsonList);
    };
    return true;

  }
  static Future<bool> removeData({
    @required String ?key,
  }) async
  {
    return await sharedPreferences!.remove(key!);
  }
 static Future<bool> setList(List<Map<String,dynamic>> list)async{
    final List<String> jsonList = list.map((item) => jsonEncode(item)).toList();
    return sharedPreferences!.setStringList('list', jsonList);
  }
  static List<String>?jsonList;
   static List<dynamic>?list;
   static  List<dynamic> ?getList() {
      jsonList = sharedPreferences!.getStringList('list');
      final List <dynamic >Listd = jsonList!.map((e) =>(jsonDecode(e))).toList();
    return Listd;
  }
  ////////////////////////////////////////
  static void saveData2(String favKey, List<String> favorites) async {
    sharedPreferences!.setStringList(favKey,favorites);
  }

  static getData2(String favKey) async {
    return sharedPreferences!.getStringList(favKey);
  }

}

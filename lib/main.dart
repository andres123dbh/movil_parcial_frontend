import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import './login/login.dart';
import './products_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  const url = 'http://10.0.2.2:8080/token';
  String? token = prefs.getString("accessToken");  
  if (token != null) {
      var response = await http.get(Uri.parse(url),headers: {"accessToken": token});
      if (response.statusCode == 200) {
          runApp(const GetMaterialApp(title: '', home: ProductsApp()));
      }else{
          runApp(const GetMaterialApp(title: '', home: Login()));
      }
  } else {
    runApp(const GetMaterialApp(title: '', home: Login()));
  }
  
}

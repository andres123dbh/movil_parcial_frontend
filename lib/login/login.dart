import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../products_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Dashboard()
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController emailControllerText = TextEditingController();
  TextEditingController passwordControllerText = TextEditingController();

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const url = 'http://10.0.2.2:8080/login';


    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": emailControllerText.text,
          "password": passwordControllerText.text,
        }));
    if (response.statusCode == 200) {
      var loginArr = json.decode(response.body);
      prefs.setString('accessToken', loginArr['accessToken']);
      Get.to(() => const ProductsApp());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: const Text('Log In'),
        ),
        body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9, 
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text('Log In',style: TextStyle(fontSize: 40)),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: emailControllerText,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: passwordControllerText,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    login();
                  }, 
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(50, 50),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))
                    ),
                  child: const Text('Login',style: TextStyle(fontSize: 20))
                  ),
              ],
          ),
          
        )
      ),
    );  
  }
}


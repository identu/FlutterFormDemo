
import 'dart:io';

import 'package:flutter/material.dart';

import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<bool> checkCredentials(
      String phoneNumber, String password) async {
    final file = File('userdata.txt');

    if (await file.exists()) {
      String fileContents = await file.readAsString();
      //将字符串转化为json对象
      Map<String, dynamic> jsonMap = {};
      fileContents.split('\n').forEach((line) {
        if (line.trim().isNotEmpty) {
          List<String> keyValue = line.split(':');
          String key = keyValue[0].trim();
          String value = keyValue[1].trim();
          jsonMap[key] = value;
        }
      });
      if (jsonMap['PhoneNumber']=='$phoneNumber' && jsonMap['Password']=='$password') {
        print("验证成功");
        print('$phoneNumber'+' '+'$password');
        return true;
      }
    }
    return false; // 输入的信息与txt文件内的信息不匹配
  }

  void login() async {
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;

    bool isValidCredentials = await checkCredentials(phoneNumber, password);

    if (isValidCredentials) {
      // 清空文本框内容
      phoneNumberController.clear();
      passwordController.clear();
      // 登录成功后跳转到主页或其他页面
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('验证失败'),
            content: Text('您输入的信息不正确'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  void goToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: '手机号',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: login,
              child: Text('登录'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: goToRegistration,
              child: Text('创建新用户'),
            ),
          ],
        ),
      ),
    );
  }
}

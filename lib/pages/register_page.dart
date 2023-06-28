import 'dart:io';

import 'package:flutter/material.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    String phoneNumber = phoneNumberController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // 数据验证
    if (phoneNumber.length != 11) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('手机号格式不正确'),
            content: Text('手机号必须是11位数字'),
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
      return;
    }

    if (password.length < 8 || password.length > 16) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('密码格式不正确'),
            content: Text('密码需要是8-16位的任何字符'),
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
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('密码不匹配'),
            content: Text('您必须输入两次相同的密码'),
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
      return;
    }

    // 保存用户数据到本地txt文件
    saveUserData(phoneNumber, username, password);

    // 清空文本框内容
    phoneNumberController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    // 注册成功后跳转到登录页面
    Navigator.pop(context);
  }

  void saveUserData(
      String phoneNumber, String username, String password) async {
    final file = File('userdata.txt');
    String userData = 'PhoneNumber: $phoneNumber\n'
        'Username: $username\n'
        'Password: $password\n';

    await file.writeAsString(userData, mode: FileMode.write);
  }


  void goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
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
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '确认密码',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: register,
              child: Text('注册'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: goToLogin,
              child: Text('已拥有账户？点此登陆'),
            ),
          ],
        ),
      ),
    );
  }
}

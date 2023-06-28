import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登陆成功'),
      ),
      body: Center(
        child: Text('恭喜你注册并登陆成功！'),
      ),
    );
  }
}

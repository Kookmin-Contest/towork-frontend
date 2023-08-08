import 'package:flutter/material.dart';

class adminChoose extends StatefulWidget {
  const adminChoose({super.key});

  @override
  State<adminChoose> createState() => _adminChooseState();
}

class _adminChooseState extends State<adminChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관리자 메뉴'),
      ),
    );
  }
}

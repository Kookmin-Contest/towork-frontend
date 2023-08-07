import 'package:flutter/material.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey)),
                  child: Text('test'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

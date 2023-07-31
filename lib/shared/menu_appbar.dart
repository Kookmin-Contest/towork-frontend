import 'package:flutter/material.dart';

class PlainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PlainAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('테스트 앱바'),
      backgroundColor: const Color(0xff60adda),
      elevation: 3.0,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_alert),
          onPressed: () {},
        )
      ],
    );
  }
}

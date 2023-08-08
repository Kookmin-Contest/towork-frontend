import 'package:flutter/material.dart';

class PlainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PlainAppbar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Color(0xff60adda),
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

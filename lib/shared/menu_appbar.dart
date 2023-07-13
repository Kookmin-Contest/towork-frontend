import 'package:flutter/material.dart';

class RoundAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double barHeight = 50;
  const RoundAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text('메인 화면')),
      actions: <Widget>[
          IconButton(icon: Icon(Icons.perm_identity_rounded), onPressed: () {})
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(48.0),
        ),
      ),
    );
  }
}
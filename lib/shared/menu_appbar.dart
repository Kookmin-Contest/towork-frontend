import 'package:flutter/material.dart';

// 끝이 둥근 Appbar 만들어둔겁니다. 필요없으면 지울 예정
class RoundAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double barHeight = 50;
  const RoundAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text('화면')),
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
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
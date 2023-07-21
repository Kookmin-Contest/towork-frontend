import 'package:flutter/material.dart';

class MenuBottom extends StatefulWidget {
  MenuBottom({super.key, required this.currentindex});
  int currentindex;

  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentindex,
      onTap: _onPageChanged,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.abc_outlined),
            label: "test"
        )
      ],
    );
  }

  void _onPageChanged(int index) {
    if (widget.currentindex == index) return;
    setState(() {
      widget.currentindex = index;
    });
  }
}

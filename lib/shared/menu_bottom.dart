import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int index){
          //TODO : 하단바 메뉴에 아이템 추가하기
          switch (index){
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/');
              break;
            default:
          }
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label : 'Home')
        ]);
  }
}

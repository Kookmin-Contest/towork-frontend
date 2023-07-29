import 'package:flutter/material.dart';

// 끝이 둥근 Appbar 만들어둔겁니다. 필요없으면 지울 예정
class RoundAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double barHeight = 90;
  const RoundAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('메인 화면'),
      centerTitle: true,
      backgroundColor: const Color(0xff60adda),
      elevation: 3.0,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add_alert), onPressed: () {})
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '한국타이어 대전공장',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Text(
                '안녕하세요, 조현진님!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

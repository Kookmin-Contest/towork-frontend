import 'package:flutter/material.dart';

class CommunityMenu extends StatefulWidget {
  const CommunityMenu({Key? key}) : super(key: key);

  @override
  State<CommunityMenu> createState() => _CommunityMenuState();
}

class _CommunityMenuState extends State<CommunityMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.clear, color: Colors.blue),
        title:
            Center(child: Text("이의제기", style: TextStyle(color: Colors.black))),
        backgroundColor:
            Colors.white, // Changed from Color.fromARGB to Colors.white
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              buildContainerWithLabel(
                  "신청 유형", 350.0, 50.0, "휴가 신청", Icons.arrow_drop_down),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: buildContainerWithLabel(
                      "날짜", 200.0, 50.0, "YY/MM/DD", Icons.calendar_today),
                ),
              ),
              SizedBox(height: 30.0),
              buildContainerWithLabel(
                  "요청할 관리자", 350.0, 50.0, "관리자 선택", Icons.arrow_drop_down),
              SizedBox(height: 30.0),
              buildContainerWithLabel(
                  "사유", 350.0, 150.0, "사유는 250자 내외로 작성해주세요."),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Text('제출'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerWithLabel(
      String label, double width, double height, String grayText,
      [IconData? iconData]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          width: width,
          height: height,
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey, width: 2.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  grayText,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              if (iconData != null) Icon(iconData, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CommunityMenu(),
  ));
}

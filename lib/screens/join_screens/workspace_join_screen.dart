import 'package:flutter/material.dart';

class JoinWorkspace extends StatefulWidget {
  const JoinWorkspace({super.key});

  @override
  State<JoinWorkspace> createState() => _JoinWorkspaceState();
}

class _JoinWorkspaceState extends State<JoinWorkspace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('워크스페이스 참가화면'),
      ),
    );
  }
}

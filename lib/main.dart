import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/providers/provider/workspace_provider.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
import 'package:gotowork/screens/signup_screens/signup_choose.dart';
import 'package:gotowork/screens/signup_screens/signup_menu1.dart';
import 'package:gotowork/screens/signup_screens/signup_menu2.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkspaceProvider>(
            create: (_) => WorkspaceProvider()),
        ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKr',
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (BuildContext context) => LogIn(),
        '/signupchoose': (BuildContext context) => SignupChoose(),
        '/signupfirst': (BuildContext context) => SignupMenuFirst(),
        '/signupsecond': (BuildContext context) => SignupMenuSecond(),
      },
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      home: LogIn(),
    );
  }
}

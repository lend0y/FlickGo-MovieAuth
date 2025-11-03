import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const FlickGo());
}

class FlickGo extends StatelessWidget {
  const FlickGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlickGo',
      theme: buildTheme(),
      home: const LoginPage(),
    );
  }
}

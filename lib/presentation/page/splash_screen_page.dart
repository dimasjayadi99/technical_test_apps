import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget{
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage>{

  final int timeLoad = 2;

  @override
  void initState() {
    super.initState();
    directPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void directPage() async {
    await Future.delayed(Duration(seconds: timeLoad));
    if(mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: Text("4Net Prima Solusi", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: 22),)
      )
    );
  }

}
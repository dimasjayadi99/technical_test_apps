import 'package:flutter/material.dart';
import 'package:technical_test_apps/presentation/page/empty_page.dart';
import 'package:technical_test_apps/presentation/page/success_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    super.initState();
  }

  int selectedPage = 0;

  List<Widget> _pageOptions() {
    return [
      const SuccessPage(),
      const EmptyPage(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: _pageOptions()[selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.check_circle, size: 30), label: 'Success'),
            BottomNavigationBarItem(icon: Icon(Icons.hourglass_empty, size: 30), label: 'Empty'),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue.withOpacity(0.3),
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
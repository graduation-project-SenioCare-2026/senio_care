import 'package:flutter/material.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int currentIndex = 0;

  final pages = const [
    Center(child: Text("Home")),
    Center(child: Text("Services")),
    Center(child: Text("SOS")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: AppColors.black,), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_rounded,color: AppColors.black,), label: "services"),
          BottomNavigationBarItem(icon: Icon(Icons.sos,color: AppColors.black,), label: "sos"),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: AppColors.black,), label: "profile"),
        ],
      ),
    );
  }
}

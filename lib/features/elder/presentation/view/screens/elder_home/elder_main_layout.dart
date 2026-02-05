import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/elder_home_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/elder_profile_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/services_tab.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/taps/sos_tab.dart';

class ElderHome extends StatefulWidget {
  const ElderHome({super.key});

  @override
  State<ElderHome> createState() => _ElderHomeState();
}

class _ElderHomeState extends State<ElderHome> {
  int currentIndex = 0;
  List<Widget> taps = [
    ElderHomeTab(),
    SosTab(),
    ServicesTab(),
    ElderProfileTap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          body: taps[currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: AppColors.white,
                  selectedItemColor: AppColors.gradientEnd,
                  unselectedItemColor: AppColors.black.withAlpha(150),
                  selectedIconTheme: IconThemeData(size: 30),
                  unselectedIconTheme: IconThemeData(size: 25),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                    BottomNavigationBarItem(icon: Icon(Icons.sos), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.medical_services), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: ""),
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
}

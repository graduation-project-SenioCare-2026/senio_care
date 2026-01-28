import 'package:flutter/material.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';

class CaregiverHome extends StatelessWidget {
  const CaregiverHome({super.key});

  @override
  Widget build(BuildContext context) {
    final caregiver = ProfileManager().caregiver;
    final user = UserManager().user;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70,),
            // CircleAvatar(child: Image.network(
            //   user?.avatar ?? "", height: 140, width: 140,)),
            Text("caregiver Home"),
            Text(caregiver?.phoneNumber ?? "======"),
            Text(caregiver?.relationship ?? "==="),
            Text(caregiver?.elderIds?.first ?? caregiver?.elders?.first.id??""),
            // Text(user?.role.toString()??"role"),
            Text(user?.email??"email"),
            Text(user?.name??"name"),
            Text(user?.avatar??"role")




          ],
        ),
      ),
    );
  }
}

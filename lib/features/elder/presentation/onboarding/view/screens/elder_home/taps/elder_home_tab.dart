import 'package:flutter/material.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';

class ElderHomeTap extends StatelessWidget {
  const ElderHomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    ElderEntity? elder = ProfileManager().elder;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("elder home"),
          Text(elder?.weight.toString() ?? ""),
          Text(elder?.allergies?.first ?? ""),
        ],
      ),
    );
  }
}

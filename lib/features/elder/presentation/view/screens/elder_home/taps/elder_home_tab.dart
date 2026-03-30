import 'package:flutter/material.dart';
import 'package:senio_care/core/routes/routes_names.dart';

class ElderHomeTab extends StatelessWidget {
  const ElderHomeTab({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Elder Home"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutesNames.addNewMedicineScreen);
          },
            child: Text("add reminder")),
      ),
    );
  }

}
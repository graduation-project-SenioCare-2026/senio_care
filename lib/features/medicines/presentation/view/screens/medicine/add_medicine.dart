import 'package:flutter/material.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import '../../widgets/medicine/add_medicine_view.dart';

class AddMedicineScreen extends StatelessWidget {
  const AddMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final elder = ProfileManager().elder;
    final elderId = elder?.id;
    return AddMedicineView(elderId: elderId ?? "");
  }
}

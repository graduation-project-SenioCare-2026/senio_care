import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../view_model/services_bloc.dart';
import '../widgets/edit_service_card.dart';


class EditServiceScreen extends StatelessWidget {
  const EditServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ServicesBloc>(),
      child: Stack(
        children: [
          BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
          Scaffold(
            appBar: AppBar(
              title: Text("editService".tr()),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: EditServiceCard(),
          ),
        ],
      ),
    );
  }
}
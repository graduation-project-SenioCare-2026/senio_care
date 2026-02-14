import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/graph_body.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';

class CaregiverGraphTab extends StatelessWidget {
  const CaregiverGraphTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "vitalsMonitoring".tr(),
          style: getBoldStyle(
            color: AppColors.black,
            fontSize: context.setSp(FontSize.s24),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (_) => getIt<CaregiverGraphBloc>(),
        child: const GraphBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/view_model/caregiver_graph_bloc.dart';
import 'package:senio_care/features/caregiver/presentation/caregiver_home/taps/graph/views/widgets/graph_body.dart';


class CaregiverGraphTab extends StatelessWidget {
  const CaregiverGraphTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<CaregiverGraphBloc>(),
        child: const GraphBody(),
      ),
    );
  }
}

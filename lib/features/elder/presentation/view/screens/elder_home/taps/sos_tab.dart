import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/sos/sos_view_body.dart';
import 'package:senio_care/features/elder/presentation/view_model/sos/sos_bloc.dart';

class SosTab extends StatelessWidget {
  const SosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SosBloc>(),
      child: CustomScrollView(
          slivers: [
            SosViewBody(),
          ],
        ),
    );
  }
}

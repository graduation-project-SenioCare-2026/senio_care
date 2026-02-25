import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/auth/domain/entity/elder_entity.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_profile/elder_personal_info/elder_personal_info_view_body.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';

class ElderPersonalInfoScreen extends StatefulWidget {
  const ElderPersonalInfoScreen({super.key});

  @override
  State<ElderPersonalInfoScreen> createState() =>
      _ElderPersonalInfoScreenState();
}

class _ElderPersonalInfoScreenState extends State<ElderPersonalInfoScreen> {
  late ElderEntity? _elder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _elder = (args is ElderEntity) ? args : null;
  }

  @override
  Widget build(BuildContext context) {

    final elderId = _elder?.id ?? ProfileManager().elder?.id;

    if (elderId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: BlocProvider(
            create: (context) =>
            getIt<ElderProfileBloc>()..add(GetElderEvent(elderId)),
            child: Column(
              children: [
                const Expanded(child: ElderPersonalInfoViewBody()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
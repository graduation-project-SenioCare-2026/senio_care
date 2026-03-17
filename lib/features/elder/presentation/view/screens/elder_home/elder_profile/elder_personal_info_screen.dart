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
  // Populated when a caregiver navigates here passing an ElderEntity as args.
  // Null when the elder navigates to their own profile.
  ElderEntity? _elderFromArgs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _elderFromArgs = (args is ElderEntity) ? args : null;
  }

  @override
  Widget build(BuildContext context) {
    // Priority:
    //   1. Route argument  → a caregiver is viewing a specific elder
    //   2. ProfileManager  → the logged-in elder is viewing their own profile
    //      ProfileManager().elder is already populated from the login response
    //      (or from the last GetElderEvent call), so no extra fetch is needed
    //      unless we want fresh data.
    final String? elderId =
        _elderFromArgs?.id ?? ProfileManager().elder?.id;

    if (elderId == null) {
      // This should never happen in normal flow because:
      //   - An elder always has ProfileManager().elder set after login
      //   - A caregiver always passes ElderEntity as route argument
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: BlocProvider(
            create: (context) => getIt<ElderProfileBloc>()
            // GetElderEvent fetches fresh data from the API and stores the
            // result in ProfileManager().elder automatically (see bloc).
            // This ensures the screen always shows up-to-date information.
              ..add(GetElderEvent(elderId)),
            child: const Column(
              children: [
                Expanded(child: ElderPersonalInfoViewBody()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
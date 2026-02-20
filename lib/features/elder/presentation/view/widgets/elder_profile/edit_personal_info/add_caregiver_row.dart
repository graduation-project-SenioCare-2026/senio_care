import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_text_form_field.dart';
import 'package:senio_care/core/loaders/loaders.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/validator/validator.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_event.dart';
import 'package:senio_care/features/elder/presentation/view_model/elder_profile/elder_profile_state.dart';

class AddCaregiverRow extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ElderProfileState state;

  const AddCaregiverRow({
    super.key,
    required this.formKey,
    required this.state,
  });

  @override
  State<AddCaregiverRow> createState() => _AddCaregiverRowState();
}

class _AddCaregiverRowState extends State<AddCaregiverRow> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Form(
            key: widget.formKey,
            child: CustomTextFormField(
              controller: _controller,
              hintText: "addCaregiverIdHere".tr(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              prefixIcon: Icon(
                Icons.person_add,
                color: AppColors.blue,
              ),
              validator: (value) => Validator.validateId(value),
            ),
          ),
        ),
        SizedBox(width: context.setWidth(8)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            final id = _controller.text.trim();

            if (id.isEmpty) return;
            if (!(widget.formKey.currentState?.validate() ?? false)) return;

            final alreadyExists =
            widget.state.caregivers.any((c) => c.id == id);

            if (alreadyExists) {
              Loaders.showWarningMessage(
                message: "caregiverAlreadyAdded".tr(),
                context: context,
              );
              return;
            }

            context.read<ElderProfileBloc>().add(AddCaregiverEvent(id));

            _controller.clear();
            widget.formKey.currentState?.reset();
          },
        ),
      ],
    );
  }
}
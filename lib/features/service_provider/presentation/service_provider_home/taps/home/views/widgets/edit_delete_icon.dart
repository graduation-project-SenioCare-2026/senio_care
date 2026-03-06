import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/common_widgets/custom_dialog.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/routes/routes_names.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/service_provider/domain/entity/service_entity.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_bloc.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/view_model/services_event.dart';

class EditDeleteIcon extends StatelessWidget {
  final ServicesEntity? service;
  const EditDeleteIcon({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ServicesBloc>();

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.red)
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => CustomDialog(
                  title: Text('deleteService'.tr()),
                  content: '',
                  confirmText: 'delete'.tr(),
                  onConfirm: () {
                    bloc.add(DeleteServiceEvent(service?.id ?? ''));
                  },
                  cancelText: 'cancel'.tr(),
                  onCancel: () {},
                ),
              );
            },
            child: Icon(Icons.delete, color: Colors.red,size: 24,),
          ),
        ),

        SizedBox(width: context.setWidth(10)),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.blue.shade300)
          ),
          child: GestureDetector(
            onTap: () {
              if (service == null) return;
              bloc.add(SelectedService(service!));
              Navigator.pushNamed(
                context,
                RoutesNames.editServicesScreen,
                arguments: bloc,
              );
            },
            child: Icon(Icons.edit,color: AppColors.blue,size: 24),
          ),
        ),
      ],
    );
  }
}

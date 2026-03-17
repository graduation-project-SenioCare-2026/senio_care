import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/common_widgets/gradient_icon_container.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/create_document_screen.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/medical_documents/medical_documents_event.dart';
import '../../../widgets/elder_profile/medical_documents/medical_documents_list/medical_documents_view_body.dart';

class MedicalDocumentsScreen extends StatefulWidget {
  const MedicalDocumentsScreen({super.key});

  @override
  State<MedicalDocumentsScreen> createState() => _MedicalDocumentsScreenState();
}

class _MedicalDocumentsScreenState extends State<MedicalDocumentsScreen> {
  late String? _elderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _elderId = (args is String) ? args : ProfileManager().elder?.id;
  }

  @override
  Widget build(BuildContext context) {
    if (_elderId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: BlocProvider(
            create: (context) =>
                getIt<MedicalDocumentsBloc>()
                  ..add(GetElderDocuments(_elderId!)),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                        size: context.setWidth(25),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "medicalDocuments".tr(),
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s24),
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          final bloc = context.read<MedicalDocumentsBloc>();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: bloc,
                                child: CreateDocumentScreen(elderId: _elderId!),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.directional(
                            end: context.setWidth(8),
                            bottom: context.setHeight(8),
                          ),
                          child: GradientIconContainer(
                            width: context.setWidth(37),
                            height: context.setHeight(40),
                            radius: context.setMinSize(60),
                            childPadding: 0,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: context.setWidth(40),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: MedicalDocumentsViewBody(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

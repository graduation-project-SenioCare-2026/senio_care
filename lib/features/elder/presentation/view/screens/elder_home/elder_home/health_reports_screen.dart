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
import 'package:senio_care/features/elder/api/models/request/health_reports/create_report_request.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_home_tab/report_period.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/health_reports/health_report_body.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_bloc.dart';
import 'package:senio_care/features/elder/presentation/view_model/health_reports/health_reports_event.dart';

class HealthReportsScreen extends StatefulWidget {
  const HealthReportsScreen({super.key});

  @override
  State<HealthReportsScreen> createState() => _HealthReportsScreenState();
}

class _HealthReportsScreenState extends State<HealthReportsScreen> {
  String? selectedPeriod;
  final List<ReportPeriod> periods = [
    ReportPeriod(key: "daily", label: "Daily Report"),
    ReportPeriod(key: "weekly", label: "Weekly Report"),
    ReportPeriod(key: "monthly", label: "Monthly Report"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<HealthReportsBloc>()
        ..add(GetReports('user_123')),

      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              Container(
                color: Colors.white.withOpacity(0.9),
              ),

              BgGradient(
                midGradientColor: AppColors.white,
                midGradientAlpha: 100,
              ),

              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  surfaceTintColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                      size: context.setWidth(25),
                    ),
                  ),
                  title: FittedBox(
                    child: Text(
                      "aiReports".tr(),
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: context.setSp(FontSize.s24),
                      ),
                    ),
                  ),
                ),

                floatingActionButton:
                GestureDetector(
                  onTap: () {

                    final bloc =
                    context.read<HealthReportsBloc>();

                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                            side: BorderSide(
                              color: AppColors.gray,
                              width: 1.2,
                            ),
                          ),

                          title: Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 25,
                                color:
                                AppColors.gradientEnd,
                              ),

                              SizedBox(width: 10),

                              Text(
                                "selectPeriod".tr(),
                                style:
                                getRegularStyle(
                                  color: AppColors
                                      .gradientEnd,
                                  fontSize:
                                  context.setSp(
                                    FontSize.s20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          content: Column(
                            mainAxisSize:
                            MainAxisSize.min,

                            children:
                            periods.map((period) {
                              return ListTile(
                                title:
                                Text(period.label),

                                onTap: () {
                                  Navigator.pop(
                                    dialogContext,
                                  );

                                  setState(() {
                                    selectedPeriod =
                                        period.key;
                                  });

                                  bloc.add(
                                    CreateReportEvent(
                                      CreateReportRequest(
                                        userId:
                                        ProfileManager()
                                            .elder
                                            ?.id ??
                                            ProfileManager()
                                                .caregiver
                                                ?.elders
                                                ?.first
                                                .id,

                                        reportType:
                                        period.key,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },

                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.only(
                      end: context.setWidth(8),
                      bottom:
                      context.setHeight(8),
                    ),

                    child: GradientIconContainer(
                      width: context.setWidth(55),
                      height:
                      context.setHeight(60),

                      radius:
                      context.setMinSize(60),

                      childPadding: 0,

                      child: Center(
                        child: Icon(
                          Icons.add,
                          size:
                          context.setWidth(50),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                body: HealthReportBody(),
              ),
            ],
          );
        },
      ),
    );
  }
}

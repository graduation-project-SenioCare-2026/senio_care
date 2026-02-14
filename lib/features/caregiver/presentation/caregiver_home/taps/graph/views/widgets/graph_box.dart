import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../../../core/common_widgets/custom_card.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/theme/font_manager.dart';
import '../../../../../../../../core/theme/font_style.dart';
import '../../view_model/caregiver_graph_bloc.dart';

class GraphBox extends StatelessWidget {
  final String routes;
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Color bgIconColor;

  const GraphBox({
    required this.routes,
    required this.value,
    required this.title,
    required this.unit,
    required this.icon,
    required this.color,
    required this.bgIconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            final bloc = context.read<CaregiverGraphBloc>();
            Navigator.pushNamed(context, routes, arguments: bloc);
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: context.setWidth(12),
              left: context.setWidth(12),
            ),
            child: CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.setHeight(5)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: bgIconColor,
                        ),
                        child: Icon(icon, color: color),
                      ),
                      SizedBox(width: context.setWidth(12)),
                      Text(
                        title,
                        style: getRegularStyle(
                          color: AppColors.black,
                          fontSize: context.setSp(FontSize.s18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.setHeight(10)),

                  // Current Value
                  Row(
                    children: [
                      Text(
                        value,
                        style: getBoldStyle(
                          color: AppColors.black,
                          fontSize: context.setSp(FontSize.s20),
                        ),
                      ),
                      SizedBox(width: context.setWidth(5)),
                      Text(
                        unit,
                        style: getRegularStyle(
                          color: AppColors.gray,
                          fontSize: context.setSp(FontSize.s18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.setHeight(10)),

                  // View Graph
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(12),
                      vertical: context.setHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "viewGraph".tr(),
                          style: getRegularStyle(
                            color: AppColors.black,
                            fontSize: context.setSp(FontSize.s12),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

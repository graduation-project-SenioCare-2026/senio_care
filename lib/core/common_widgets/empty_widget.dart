import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/font_style.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final IconData icon;
  const EmptyView({required this.title,required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.tr(),
            style: getRegularStyle(
              color: Colors.grey,
              fontSize: context.setSp(16),
            ),
          ),
          SizedBox(height: context.setHeight(10),),
          Icon(icon,
          size: context.setWidth(40),
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
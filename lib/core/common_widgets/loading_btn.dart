import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class LoadingBtn extends StatelessWidget {
  const LoadingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return  LoadingAnimationWidget.flickr(
      leftDotColor:AppColors.gradientEnd ,
      rightDotColor: AppColors.gradientMiddle,
      size: context.setWidth(30),
    );
  }
}

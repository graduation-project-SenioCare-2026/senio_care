import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/ai_chat_body.dart';

import '../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';

class AiChatViewBody extends StatelessWidget {
  const AiChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'SenioCare Chat',
              style: getBoldStyle(
                color: AppColors.black,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),

          ),
          body: AiChatBody(),
        ),
      ],
    );
  }
}

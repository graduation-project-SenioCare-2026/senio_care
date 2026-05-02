import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/ai_chat_body.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/ai_chat/chat_history_drawer.dart';

import '../../../../../../core/common_widgets/bg_gradient.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';
import '../../../../../../core/theme/font_style.dart';
import '../../../view_model/ai_chat/ai_chat_bloc.dart';
import '../../../view_model/ai_chat/ai_chat_event.dart';

class AiChatViewBody extends StatefulWidget {
  const AiChatViewBody({super.key});

  @override
  State<AiChatViewBody> createState() => _AiChatViewBodyState();
}

class _AiChatViewBodyState extends State<AiChatViewBody> {
  @override
  void initState() {
    String sessionId=DateTime.now().millisecondsSinceEpoch.toString();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(
        ChatSessionStarted(
          UserManager().userId,
          sessionId,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawer: ChatHistoryDrawer(userId: UserManager().userId??"",),
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
            actions: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  tooltip: 'Chat History',
                ),
              ),
            ],
          ),
          body: const AiChatBody(),
        ),
      ],
    );
  }
}
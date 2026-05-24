import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/core/theme/font_manager.dart';
import 'package:senio_care/core/theme/font_style.dart';
import '../../../view_model/ai_chat/ai_chat_bloc.dart';
import '../../../view_model/ai_chat/ai_chat_event.dart';
import '../../../view_model/ai_chat/ai_chat_state.dart';
import 'conversation_details.dart';

class ChatHistoryDrawer extends StatefulWidget {
  final String userId;

  const ChatHistoryDrawer({super.key, required this.userId});

  @override
  State<ChatHistoryDrawer> createState() => _ChatHistoryDrawerState();
}

class _ChatHistoryDrawerState extends State<ChatHistoryDrawer> {
  late ChatBloc _chatBloc; // ✅ saved reference

  @override
  void initState() {
    super.initState();
    _chatBloc = context.read<ChatBloc>(); // ✅ save while widget is active
    _chatBloc.add(ChatHistoryRequested("user_123"));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                children: [
                  Text(
                    'Chat History',
                    style: getBoldStyle(
                      color: AppColors.black,
                      fontSize: context.setSp(FontSize.s20),
                    ),
                  ),
                  const Spacer(),
                  // Refresh button
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                    tooltip: 'Refresh',
                    onPressed: () =>
                        _chatBloc.add(ChatHistoryRequested("user_123")), // ✅
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Body ────────────────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (prev, curr) =>
                    prev.historyStatus != curr.historyStatus,
                builder: (context, state) {
                  // Loading
                  if (state.historyStatus.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (state.historyStatus.isFailure) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(height: 8),
                          const Text('Failed to load history'),
                          TextButton(
                            onPressed: () => _chatBloc.add(
                              // ✅
                              ChatHistoryRequested(widget.userId),
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Empty
                  final sessions = state.historyStatus.data ?? [];
                  if (sessions.isEmpty) {
                    return const Center(
                      child: Text(
                        'No conversations yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // List
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: sessions.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.blue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 18,
                            color: AppColors.blue.shade500,
                          ),
                        ),
                        title: Text(
                          session.headline,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            color: AppColors.black.shade500,
                            fontSize: context.setSp(FontSize.s16),
                          ),
                        ),
                        // subtitle: Text(
                        //   session.preview,
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: const TextStyle(fontSize: 12),
                        // ),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: _chatBloc, // ✅ use saved reference
                                child: ConversationDetailsScreen(
                                  userId: "user_123",
                                  sessionId: session.sessionId,
                                  headline: session.headline,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/font_manager.dart';

class AiMessage extends StatefulWidget {
  final String text;
  const AiMessage({super.key, required this.text});

  @override
  State<AiMessage> createState() => _AiMessageState();
}

class _AiMessageState extends State<AiMessage> with TickerProviderStateMixin {
  late List<AnimationController> _dotControllers;
  late List<Animation<double>> _dotAnimations;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _dotControllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _dotAnimations = _dotControllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: -8,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    _startDotsAnimation();
  }

  void _startDotsAnimation() {
    for (int i = 0; i < _dotControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 160), () {
        if (mounted) {
          _dotControllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _dotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _copyText() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  bool get _hasTable => widget.text.contains('|');

  MarkdownStyleSheet _buildStyleSheet(BuildContext context) {
    return MarkdownStyleSheet(
      textAlign: WrapAlignment.center,
      p: TextStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s18),
        fontWeight: FontWeight.normal,
      ),
      strong: TextStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s18),
        fontWeight: FontWeight.bold,
      ),
      em: TextStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s18),
        fontStyle: FontStyle.italic,
      ),
      tableHead: TextStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s16),
        fontWeight: FontWeight.bold,
      ),
      tableBody: TextStyle(
        color: AppColors.black,
        fontSize: context.setSp(FontSize.s13),
        fontWeight: FontWeight.normal,
      ),
      tableBorder: TableBorder.all(
        color: AppColors.blue.shade200,
        width: 1,
        borderRadius: BorderRadius.circular(8),
      ),
      tableHeadAlign: TextAlign.center,
      tableCellsDecoration: const BoxDecoration(color: Colors.transparent),
      tableCellsPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      tableColumnWidth: const FlexColumnWidth(3),
    );
  }

  Widget _buildMarkdownContent(BuildContext context) {
    final styleSheet = _buildStyleSheet(context);

    if (_hasTable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 0,
            maxWidth:600,
          ),
          child: MarkdownBody(
            data: widget.text,
            fitContent: true,
            styleSheet: styleSheet,
          ),
        ),
      );
    }

    return MarkdownBody(
      data: widget.text,
      fitContent: false,
      styleSheet: styleSheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: context.setHeight(16),
          right: context.setWidth(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: context.setHeight(8),
                  ),
                  width: context.setWidth(32),
                  height: context.setHeight(32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.blue.shade300, AppColors.blue.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.support_agent_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: context.setWidth(5),),
                if(widget.text.isEmpty)
                  _buildTypingIndicator()
              ],
            ),

            // Message content
            widget.text.isEmpty
                ? Container()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMarkdownContent(context),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: _copyText,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _copied
                        ? Icon(
                      key: const ValueKey('copied'),
                      Icons.check_rounded,
                      size: 16,
                      color: AppColors.blue.shade400,
                    )
                        : Icon(
                      key: const ValueKey('copy'),
                      Icons.copy_rounded,
                      size: 20,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTypingIndicator() {
    return Padding(
      padding:  EdgeInsets.only(top:context.setHeight(15)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _dotAnimations[i],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _dotAnimations[i].value),
                child: child,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.blue.shade400,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
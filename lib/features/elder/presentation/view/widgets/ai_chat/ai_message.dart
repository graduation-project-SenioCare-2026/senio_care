import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class AiMessage extends StatelessWidget {
  final String text;
  const AiMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2, right: 10),
              width: 32,
              height: 32,
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
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
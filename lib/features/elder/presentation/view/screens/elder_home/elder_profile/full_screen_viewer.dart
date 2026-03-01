import 'dart:io';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class FullScreenViewer extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  const FullScreenViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<FullScreenViewer> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,

              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: context.setWidth(25),
                ),
              ),
            ),
            body: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: SizedBox.expand(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(
                        bottom: context.setHeight(20),
                        right: context.setHeight(10),
                        left: context.setHeight(10),
                      ),
                      child: Image.file(widget.images[index], fit: BoxFit.fill),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

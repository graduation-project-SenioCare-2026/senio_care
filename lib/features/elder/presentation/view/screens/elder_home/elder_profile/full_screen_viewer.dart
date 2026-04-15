import 'dart:io';
import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/bg_gradient.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';

class FullScreenViewer extends StatefulWidget {
  final List<File>? images;
  final int initialIndex;
  final List<String>? imageUrls;

  const FullScreenViewer({
    super.key,
    this.images,
    this.imageUrls,
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
        Container(color: Colors.white.withOpacity(0.9)),
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
              itemCount: widget.images!=null?widget.images?.length:widget.imageUrls?.length,
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
                      child: widget.images != null
                          ? Image.file(widget.images![index], fit: BoxFit.fill)
                          : Image.network(
                              widget.imageUrls![index],
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Icons.broken_image, size: 50),
                                );
                              },
                            ),
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

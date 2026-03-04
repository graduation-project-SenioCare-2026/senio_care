import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/core/theme/app_colors.dart';
import 'package:senio_care/features/elder/presentation/view/screens/elder_home/elder_profile/full_screen_viewer.dart';

class DocumentImageSlider extends StatefulWidget {
  final List<String> images;

  const DocumentImageSlider({super.key, required this.images});

  @override
  State<DocumentImageSlider> createState() => _DocumentImageSliderState();
}

class _DocumentImageSliderState extends State<DocumentImageSlider> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenViewer(
                        imageUrls: widget.images,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(6),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(context.setWidth(2)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(20),
                      ),
                      border: Border.all(
                        width: context.setWidth(2),
                        color: AppColors.gray,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(18),
                      ),
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.gray,
                            size: context.setWidth(48),
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.gray,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: context.setHeight(12)),

        //Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index
                  ? context.setWidth(10)
                  : context.setWidth(6),
              height: context.setHeight(6),
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.black
                    : AppColors.gray,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

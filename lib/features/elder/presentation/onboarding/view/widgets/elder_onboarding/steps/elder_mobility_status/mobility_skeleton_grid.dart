import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

class MobilitySkeletonGrid extends StatelessWidget {
  const MobilitySkeletonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.setHeight(12),
        crossAxisSpacing: context.setWidth(12),
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card Skeleton
            Container(
              width: double.infinity,
              height: context.setHeight(90),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(
                  context.setWidth(15),
                ),
              ),
            ),
            SizedBox(height: context.setHeight(8)),

            // Text Skeleton
            Container(
              height: context.setHeight(14),
              width: context.setWidth(80),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(
                  context.setWidth(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

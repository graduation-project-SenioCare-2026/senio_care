import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:senio_care/core/common_widgets/custom_card.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

class ProfileSkeleton extends StatelessWidget {
  final int infoRowsCount;
  final bool showAvatar;
  final bool showActions;

  const ProfileSkeleton({
    super.key,
    this.infoRowsCount = 8,
    this.showAvatar = true,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            /// AppBar
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Container(
                height: context.setHeight(20),
                width: context.setWidth(150),
                color: Colors.white,
              ),
              leading: const Icon(Icons.arrow_back_ios),
              actions: showActions
                  ? [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: context.setWidth(10),
                  ),
                  child: Container(
                    width: context.setWidth(30),
                    height: context.setHeight(30),
                    color: Colors.white,
                  ),
                ),
              ]
                  : null,
            ),

            /// Avatar + Name
            if (showAvatar)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: context.setHeight(12)),
                    Container(
                      width: context.setWidth(90),
                      height: context.setHeight(100),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.setHeight(8)),
                    Container(
                      height: context.setHeight(16),
                      width: context.setWidth(120),
                      color: Colors.white,
                    ),
                    SizedBox(height: context.setHeight(24)),
                  ],
                ),
              ),

            /// Info Card
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.setWidth(25),
              ),
              sliver: SliverToBoxAdapter(
                child: CustomCard(
                  child: Column(
                    children: List.generate(
                      infoRowsCount,
                          (index) => Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: context.setWidth(25),
                                height: context.setWidth(25),
                                color: Colors.white,
                              ),
                              SizedBox(width: context.setWidth(8)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: context.setHeight(14),
                                      width: context.setWidth(120),
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: context.setHeight(6),
                                    ),
                                    Container(
                                      height: context.setHeight(12),
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (index != infoRowsCount - 1)
                            const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

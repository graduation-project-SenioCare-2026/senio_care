import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';
import 'package:senio_care/features/elder/presentation/view/widgets/elder_onboarding/steps/elder_mobility_status/mobility_item.dart';

class MobilityGrid extends StatelessWidget {
  final List<dynamic> items;
  final int? selectedIndex;
  final Function(int) onItemSelected;

  const MobilityGrid({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.setHeight(12),
        crossAxisSpacing: context.setWidth(12),
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedIndex == index;

        return MobilityItem(
          item: item,
          isSelected: isSelected,
          index: index,
          onTap: () => onItemSelected(index),
        );
      },
    );
  }
}

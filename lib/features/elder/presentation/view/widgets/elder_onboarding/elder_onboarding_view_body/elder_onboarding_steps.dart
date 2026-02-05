import 'package:flutter/material.dart';
import 'package:senio_care/core/common_widgets/blur_container.dart';

class ElderOnboardingSteps extends StatelessWidget {
  final int index;
  final List<Widget> steps;

  const ElderOnboardingSteps({
    super.key,
    required this.index,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        key: ValueKey(index),
        child: steps[index],
      ),
    );
  }
}

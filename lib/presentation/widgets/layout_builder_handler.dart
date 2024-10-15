import 'package:flutter/material.dart';

class LayoutBuilderHandler extends StatelessWidget {
  final Widget firstPart;
  final Widget secondPart;
  const LayoutBuilderHandler(
      {super.key, required this.firstPart, required this.secondPart});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMoreTallThanWide = constraints.maxHeight > constraints.maxWidth;

      if (isMoreTallThanWide) {
        return Column(
          children: [
            firstPart,
            secondPart,
          ],
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstPart,
            secondPart,
          ],
        );
      }
      return const Placeholder();
    });
  }
}

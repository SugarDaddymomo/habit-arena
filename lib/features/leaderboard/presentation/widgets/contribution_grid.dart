import 'package:flutter/material.dart';

class ContributionGrid extends StatelessWidget {
  final List<int> days;

  const ContributionGrid({
    super.key,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final value = days[index];
        Color color;
        if (value == 0) {
          color = Colors.grey.shade800;
        } else if (value == 1) {
          color = Colors.green.shade300;
        } else if (value == 2) {
          color = Colors.green.shade500;
        } else {
          color = Colors.green.shade700;
        }
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }
}
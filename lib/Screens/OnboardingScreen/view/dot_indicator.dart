import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalItems;
  final double dotSize;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;

  DotIndicator({
    required this.currentIndex,
    required this.totalItems,
    this.dotSize = 10.0,
    this.borderRadius = 5.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalItems, (index) {
        bool isActive = index == currentIndex;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          width: isActive ? dotSize * 2.5 : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              left: isActive ? Radius.circular(borderRadius) : Radius.zero,
              right: isActive ? Radius.circular(borderRadius) : Radius.zero,
            ),
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}

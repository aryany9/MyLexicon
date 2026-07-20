import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap.vertical(this.value, {super.key}) : axis = Axis.vertical;

  const Gap.horizontal(this.value, {super.key}) : axis = Axis.horizontal;

  final double value;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? SizedBox(height: value)
        : SizedBox(width: value);
  }
}

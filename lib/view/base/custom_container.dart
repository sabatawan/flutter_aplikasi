import 'package:flutter/material.dart';
import 'package:flutter_adakami/utill/color_resources.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  Color color;

  CustomContainer({@required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(color: color, child: SafeArea(child: child));
  }
}

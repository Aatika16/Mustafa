import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';

class BeigeButton extends StatelessWidget {
    final double topBottomPadding;
  final double leftRightPadding;
  final Widget widget_;
  final Function OntapFunction;
  final double topBottomMargin;
  final double leftRightMargin;
  const BeigeButton({super.key, required this.topBottomPadding, required this.leftRightPadding, required this.widget_, required this.OntapFunction, required this.topBottomMargin, required this.leftRightMargin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OntapFunction();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: topBottomMargin,
          horizontal: leftRightMargin
        ),
        decoration: BoxDecoration(
          color: Colors.amber.shade400,
          borderRadius: BorderRadius.circular(Constants.buttonBorderRadius),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: topBottomPadding,
                horizontal: leftRightPadding), // Adjust the padding as needed
            child: widget_,
          ),
        ),
      ),
    );
  }
}
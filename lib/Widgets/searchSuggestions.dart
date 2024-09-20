import 'package:flutter/material.dart';
import 'package:ecommerce_shoppe_app/Constants/constants.dart';

class SearchSuggestions extends StatelessWidget {
  final String watch;
  final String price;
  const SearchSuggestions({super.key, required this.watch, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Constants.greyColor),
        ),
      ),
      child: Row(
        children: [
          Text(
            watch,
            style: TextStyle(
              color: Constants.greyColor,
              fontSize: 14,
            ),
          ),
          Text(
            ", $price",
            style: TextStyle(
              color: Constants.greyColor,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_outward_sharp,
            color: Constants.greyColor,
          )
        ],
      ),
    );
  }
}

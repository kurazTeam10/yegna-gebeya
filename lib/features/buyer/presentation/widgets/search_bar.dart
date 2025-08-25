import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final double height;
  final Color borderColor;
  final Color iconColor;
  final Function(String)? onChanged; // <-- add this

  const SearchBarWidget({
    super.key,
    this.height = 50,
    this.borderColor = Colors.grey,
    this.iconColor = const Color(0xFF8D00DE),
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: size.width * 0.003,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: onChanged, // <-- call the function
        decoration: InputDecoration(
          hintText: 'Search products',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: iconColor),
        ),
      ),
    );
  }
}

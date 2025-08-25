import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final double height;
  final Color borderColor;
  final Color iconColor;
  final Function(String)? onChanged;
  final TextEditingController? controller; // <-- store controller

  const SearchBarWidget({
    super.key,
    this.height = 50,
    this.borderColor = Colors.grey,
    this.iconColor = const Color(0xFF8D00DE),
    this.onChanged,
    this.controller, // <-- assign here
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
        controller: controller, // <-- use it
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search products',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: iconColor),
        ),
      ),
    );
  }
}

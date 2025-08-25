import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
<<<<<<< HEAD
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String hintText;
  final EdgeInsetsGeometry? margin;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.margin,
=======
  final double height;
  final Color borderColor;
  final Color iconColor;

  const SearchBarWidget({
    super.key,
    this.height = 50,
    this.borderColor = Colors.grey,
    this.iconColor = const Color(0xFF8D00DE),
>>>>>>> origin
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: screenWidth * 0.065,
            vertical: screenSize.height * 0.02,
          ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: const Color(0xFFE1DBFF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF8D00DE),
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        onChanged: onChanged,
=======
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
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search products',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Color(0xFF8D00DE)),
        ),
>>>>>>> origin
      ),
    );
  }
}

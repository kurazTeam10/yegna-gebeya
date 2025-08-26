import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final double height;
  final Color borderColor;
  final Color iconColor;

  const SearchBar({
    super.key,
    this.height = 50,
    this.borderColor = Colors.grey,
    this.iconColor = const Color(0xFF8D00DE),
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
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search products',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Color(0xFF8D00DE)),
        ),
      ),
    );
  }
}

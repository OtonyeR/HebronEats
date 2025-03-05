import 'package:flutter/material.dart';
import 'package:HebronEats/constants/colors.dart';
import 'package:HebronEats/models/category.dart';

class BuildMenuCategory extends StatefulWidget {
  final Category category;
  final int index;
  final bool isSelected;
  final VoidCallback deSelect;
  final VoidCallback onSelect;
  const BuildMenuCategory(
      {Key? key,
      required this.index,
      required this.isSelected,
      required this.onSelect,
      required this.category,
      required this.deSelect})
      : super(key: key);

  @override
  State<BuildMenuCategory> createState() => _BuildMenuCategoryState();
}

class _BuildMenuCategoryState extends State<BuildMenuCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isSelected ? widget.deSelect : widget.onSelect,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: widget.isSelected ? kPrimaryColor : kDarkWhite,
                borderRadius: BorderRadius.circular(16.0)),
            child: Image.asset(
              widget.category.iconUrl,
              scale: 2.2,
              color: widget.isSelected ? kSecondaryColor : kSecondaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color((0xFF0E191A))),
          ),
        ],
      ),
    );
  }
}

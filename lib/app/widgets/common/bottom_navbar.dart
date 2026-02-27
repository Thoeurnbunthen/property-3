import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';

class BottomNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.home_rounded,
      Icons.search_rounded,
      Icons.favorite_border_rounded,
      Icons.person_outline_rounded,
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == selected;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                items[index],
                color: isSelected ? AppColors.primary : AppColors.grey,
                size: 26,
              ),
            ),
          );
        }),
      ),
    );
  }
}

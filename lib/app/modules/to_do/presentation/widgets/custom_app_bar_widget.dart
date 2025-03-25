import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onThemePressed;
  final VoidCallback onPlanetPressed;

  const CustomAppBarWidget({
    super.key,
    required this.onThemePressed,
    required this.onPlanetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: onPlanetPressed, icon: const Icon(Icons.public)),
              IconButton(onPressed: onThemePressed, icon: const Icon(Icons.color_lens)),
            ],
          ),
          Text(
            "CHORES",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

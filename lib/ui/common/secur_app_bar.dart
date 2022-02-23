import 'package:flutter/material.dart';

class SecurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SecurAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Circular-Std",
          ),
          children: [
            TextSpan(
              text: 'Sec',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            TextSpan(
              text: 'ur',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

class CenteredButtonWidget extends StatelessWidget {
  const CenteredButtonWidget(
      {required this.title, this.onPressed, this.isActive = false, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                color: color(isActive),
                borderRadius: BorderRadius.circular(10)),
            child: Text(title,
                style: TextStyle(fontSize: 20, color: color(!isActive)))));
  }

  Color color(bool isActive) => isActive ? Colors.black : Colors.white;
}

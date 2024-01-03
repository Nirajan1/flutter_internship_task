import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final void Function() onPressedCallback;
  const MainButton({
    required this.title,
    required this.onPressedCallback,
    this.color,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
        // border: Border.all(),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: MaterialButton(
        color: color,
        onPressed: onPressedCallback,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

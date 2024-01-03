import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function() onPressedCallback;
  const MainButton({
    required this.title,
    required this.onPressedCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressedCallback,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

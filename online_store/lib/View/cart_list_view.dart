import 'package:flutter/material.dart';

class CartListViewPage extends StatelessWidget {
  const CartListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text('CartList View'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

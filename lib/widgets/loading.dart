import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Loading", style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}

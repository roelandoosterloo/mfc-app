import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final String subText;
  final IconData icon;
  final Color? iconColor;

  const StatisticCard({
    Key? key,
    required this.title,
    required this.subText,
    required this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff459e8e),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontFamily: 'Stratum',
            ),
          ),
          Icon(
            icon,
            size: 64,
            color: iconColor,
          ),
          Text(
            this.subText,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

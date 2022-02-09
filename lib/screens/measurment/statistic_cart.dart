import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final String subText;
  final IconData? icon;
  final String? mainText;
  final Color? iconColor;

  const StatisticCard({
    Key? key,
    required this.title,
    required this.subText,
    this.icon,
    this.mainText,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
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
          if (icon != null)
            Icon(
              icon,
              size: 64,
              color: iconColor,
            ),
          if (mainText != null)
            Text(
              this.mainText!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Stratum',
              ),
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

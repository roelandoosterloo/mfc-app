import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RadioListTile(
              title: Text("Optie 1"),
              value: "optie 1",
              groupValue: "test",
              onChanged: (text) => null),
          RadioListTile(
              title: Text("Optie 2"),
              value: "optie 2",
              groupValue: "test",
              onChanged: (text) => null),
          RadioListTile(
              title: Text("Optie 3"),
              value: "optie 3",
              groupValue: "test",
              onChanged: (text) => null),
          RadioListTile(
              title: Text("Optie 4"),
              value: "optie 4",
              groupValue: "test",
              onChanged: (text) => null),
          RadioListTile(
              title: Text("Optie 5"),
              value: "optie 5",
              groupValue: "test",
              onChanged: (text) => null),
          ElevatedButton(
            onPressed: () => null,
            child: Text("Opslaan"),
          )
        ],
      ),
    );
  }
}

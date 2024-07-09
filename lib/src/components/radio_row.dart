import 'package:flutter/material.dart';

class RadioRow extends StatelessWidget {
  final bool? isEnabled;
  final String? text;

  const RadioRow({super.key, this.isEnabled, this.text});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          groupValue: 1,
          value: isEnabled! ? 1 : 0,
          onChanged: (dynamic value){},
        ),
        Text(text!)
      ],
    );
  }
}
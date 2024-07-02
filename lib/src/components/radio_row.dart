import 'package:flutter/material.dart';

class RadioRow extends StatelessWidget {
  final bool? isEnabled;
  final String? text;

  const RadioRow({Key? key, this.isEnabled, this.text}) : super(key: key);


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
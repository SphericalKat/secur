import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: CircularNotchedRectangle(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            alignment: Alignment.center,
            enableFeedback: true,
            highlightColor: Colors.pinkAccent[400],
            icon: Icon(
              Feather.home,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => {},
          ),
          IconButton(
            alignment: Alignment.center,
            enableFeedback: true,
            highlightColor: Colors.pinkAccent[400],
            icon: Icon(
              Feather.info,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      color: Colors.teal,
    );
  }
}

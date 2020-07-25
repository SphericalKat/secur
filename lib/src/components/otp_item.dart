import 'dart:async';

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:supercharged/supercharged.dart';

class OTPItem extends StatefulWidget {
  final SecurTOTP securTOTP;

  const OTPItem({Key key, @required this.securTOTP}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OTPItemState(securTOTP);
}

class OTPItemState extends State<OTPItem> {
  String totp = "";
  int timeVal = 0;
  CountDown cd;
  StreamSubscription<Duration> sub;
  final SecurTOTP securTOTP;

  OTPItemState(this.securTOTP);

  void countdown() {
    var timeRemaining = securTOTP.interval -
        DateTime.now().duration().inMicroseconds % securTOTP.interval;
    cd = CountDown(30.seconds);
    sub = cd.stream.listen(null);
    sub.onDone(() {
      countdown();
    });

    sub.onData((data) {
//      if (timeVal == data.inSeconds) return;
      setState(() {
        timeVal = data.inSeconds;
        if (timeVal == 0) {
          totp = securTOTP.getTotp();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    totp = securTOTP.getTotp();
    countdown();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: Column(
        children: <Widget>[
          Text('TOTP: $totp'),
          CircularPercentIndicator(
            radius: 30,
            reverse: true,
            progressColor: Theme.of(context).accentColor,
            animation: true,
            animateFromLastPercent: true,
            percent: timeVal / securTOTP.interval,
            center: Text(timeVal.toString()),
          )
        ],
      )),
    );
  }
}

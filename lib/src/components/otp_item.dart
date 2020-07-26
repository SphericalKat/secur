import 'dart:async';

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
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
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  OTPItemState(this.securTOTP);

  void countdown() {
    cd = CountDown(30.seconds);
    sub = cd.stream.listen(null);
    sub.onDone(() {
      countdown();
    });

    sub.onData((data) {
      if (timeVal == data.inSeconds) return;
      setState(() {
        timeVal = data.inSeconds;
        if (timeVal == 0) {
          totp = securTOTP.getTotp();
        }

        var percent = (timeVal / securTOTP.interval) * 100;

        _chartKey.currentState.updateData(
          [
            CircularStackEntry(
              [
                CircularSegmentEntry(
                  percent,
                  Theme.of(context).accentColor,
                  rankKey: 'completed',
                ),
                CircularSegmentEntry(100 - percent, Theme.of(context).cardColor,
                    rankKey: 'remaining')
              ],
              rankKey: 'progress',
            )
          ],
        );
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
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 18, bottom: 18, left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    totp,
                    style: TextStyle(
                        fontSize: 32, color: Theme.of(context).accentColor),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Text(
                      securTOTP.issuer,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  AnimatedCircularChart(
                    key: _chartKey,
                    size: const Size(32.0, 32.0),
                    initialChartData: <CircularStackEntry>[
                      CircularStackEntry(
                        [
                          CircularSegmentEntry(
                            0,
                            Theme.of(context).accentColor,
                            rankKey: 'completed',
                          ),
                          CircularSegmentEntry(100, Theme.of(context).cardColor,
                              rankKey: 'remaining')
                        ],
                        rankKey: 'progress',
                      )
                    ],
                    chartType: CircularChartType.Pie,
                    percentageValues: true,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

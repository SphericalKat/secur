import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'package:get/get.dart';
import 'package:secur/src/controllers/item_selection_controller.dart';
import 'package:secur/src/countdown/countdown.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/themes/theme.dart';
import 'package:supercharged/supercharged.dart';

class OTPItem extends StatefulWidget {
  final SecurTOTP securTOTP;

  const OTPItem({Key? key, required this.securTOTP}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OTPItemState(securTOTP);
}

class OTPItemState extends State<OTPItem> {
  String totp = "";
  int timeVal = 0;
  late CountDown cd;
  late StreamSubscription<Duration?> sub;
  final SecurTOTP securTOTP;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  OTPItemState(this.securTOTP);

  void countdown() {
    cd = CountDown(30.seconds, refresh: 0.5.seconds);
    sub = cd.stream.listen(null);
    sub.onDone(() {
      countdown();
    });

    sub.onData((data) {
      if (timeVal == data!.inSeconds) return;
      if (this.mounted) {
        setState(() {
          timeVal = data.inSeconds;
          if (timeVal == 0) {
            totp = securTOTP.getTotp();
          }

          var percent = (timeVal / securTOTP.interval!) * 100;

          if (_chartKey.currentState != null) {
            _chartKey.currentState!.updateData(
              [
                CircularStackEntry(
                  [
                    CircularSegmentEntry(
                      percent,
                      Theme.of(context).colorScheme.secondary,
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                        100 - percent, Theme.of(context).cardColor,
                        rankKey: 'remaining')
                  ],
                  rankKey: 'progress',
                )
              ],
            );
          }
        });
      }
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
    var totpKey = securTOTP.secret;
    var isItemSelected =
        ItemSelectionController.to.selectedItems.contains(totpKey);

    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        color: isItemSelected
            ? Theme.of(context).accentColor
            : Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onLongPress: () {
            ItemSelectionController.to.setSelectedItem(totpKey);
          },
          onTap: () {
            // if items are selected
            if (ItemSelectionController.to.areItemsSelected) {
              // if this particular item is not selected
              if (!isItemSelected) {
                // add item to selection
                ItemSelectionController.to.setSelectedItem(totpKey);
              } else {
                // remove item from selection
                ItemSelectionController.to.removeSelectedItem(totpKey);
              }
            } else {
              Clipboard.setData(ClipboardData(text: totp))
                  .then((value) => Get.snackbar(
                        'Done!',
                        'OTP has been copied to clipboard.',
                        snackPosition: SnackPosition.BOTTOM,
                        // colorText: Colors.black,
                      ));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 18, bottom: 18, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${totp.substring(0, totp.length ~/ 2)} ${totp.substring(totp.length ~/ 2)}',
                      style: TextStyle(
                          fontSize: 32,
                          color: isItemSelected
                              ? Colors.white
                              : Theme.of(context).accentColor,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Text(
                              securTOTP.accountName!.replaceFirst(":", ": ") ?? securTOTP.issuer!,
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    isItemSelected ? Colors.white : textColor,
                              ),
                            ),
                    ),
                    isItemSelected
                        ? Container(
                            width: 32,
                            height: 32,
                          )
                        : AnimatedCircularChart(
                            duration: 1.seconds,
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
                                  CircularSegmentEntry(
                                      100, Theme.of(context).cardColor,
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
      ),
    );
  }
}

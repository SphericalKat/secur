import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:secur/src/components/otp_item.dart';
import 'package:secur/src/controllers/item_selection_controller.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/services/barcode_scan.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemSelectionController>(
      init: ItemSelectionController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: controller.areItemsSelected ? null : buildFloatingActionButton(context),
          body: homeBody(context),
          appBar: appBar(context, controller),
        );
      },
    );
  }
}

Widget appBar(BuildContext context, ItemSelectionController controller) {
  if (!controller.areItemsSelected) {
    return AppBar(
      title: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular-Std",
            ),
            children: [
              TextSpan(
                  text: 'Sec',
                  style: TextStyle(color: Theme.of(context).accentColor)),
              TextSpan(text: 'ur', style: TextStyle(color: Colors.white))
            ]),
      ),
      centerTitle: true,
    );
  } else {
    return AppBar(
      title: Text(controller.selectedItems.length.toString()),
      leading: FlatButton(
        onPressed: () {
          controller.removeAllItems();
        },
        child: Icon(Icons.close),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Get.dialog(AlertDialog(
            title: Text(
              'Warning!',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Choosing yes will delete the selected items.'),
                  Text('Do you still wish to proceed?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 18),
                ),
                onPressed: () {
                  navigator.pop();
                  TOTPController.to
                      .deleteTotps(ItemSelectionController.to.selectedItems);
                },
              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 18),
                ),
                onPressed: () => navigator.pop(),
              )
            ],
          )),
          child: Icon(Icons.delete),
        )
      ],
    );
  }
}

Widget homeBody(context) => SafeArea(
      child: Container(
          child: GetBuilder<TOTPController>(
        init: TOTPController(),
        builder: (controller) {
          var values = controller.db.values.toList();
          if (values.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Nothing to see here',
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text('Add an account to get started',
                      style: TextStyle(fontSize: 16))
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: values.length,
                itemBuilder: (ctx, index) {
                  return OTPItem(securTOTP: values[index]);
                });
          }
        },
      )),
    );

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _bottomSheet(context);
    },
    tooltip: 'Add an account',
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
    elevation: 1.0,
  );
}

void _bottomSheet(context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(MaterialCommunityIcons.qrcode_scan),
              title: Text("Scan QR code"),
              onTap: () async {
                navigator.pop();
                await scanBarcode();
              },
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.keyboard),
              title: Text("Enter a provided key"),
              onTap: () {
                navigator.pop();
                Get.snackbar(
                  'TODO',
                  'To be implemented',
                  barBlur: 0.5,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.black87,
                  icon: Icon(Icons.error_outline, color: Colors.red),
                  animationDuration: Duration(milliseconds: 500),
                  backgroundColor: Colors.white,
                  duration: Duration(seconds: 3),
                  borderRadius: 10,
                  maxWidth: 420,
                  isDismissible: true,
                  shouldIconPulse: false,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

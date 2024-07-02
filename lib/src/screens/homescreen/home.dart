import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secur/src/components/otp_item.dart';
import 'package:secur/src/components/radio_row.dart';
import 'package:secur/src/controllers/item_selection_controller.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/services/barcode_scan.dart';
import 'package:secur/src/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemSelectionController>(
      init: ItemSelectionController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: controller.areItemsSelected
              ? null
              : buildFloatingActionButton(context),
          body: homeBody(context),
          appBar: appBar(context, controller) as PreferredSizeWidget?,
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
              TextSpan(text: 'ur', style: TextStyle(color: textColor))
            ]),
      ),
      actions: <Widget>[buildPopupMenu()],
      centerTitle: true,
      elevation: 0,
    );
  } else {
    return AppBar(
      title: Text(controller.selectedItems.length.toString()),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          controller.removeAllItems();
        },
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => Get.dialog(AlertDialog(
            title: Text(
              'Warning!',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                  Get.back();
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
                onPressed: () => Get.back(),
              )
            ],
          )),
        )
      ],
    );
  }
}

Widget buildPopupMenu() => PopupMenuButton<String>(
      icon: Icon(Icons.brightness_4),
      itemBuilder: (BuildContext context) {
        SharedPreferences prefs = Get.find();
        var brightness = prefs.getString(PREFS_BRIGHTNESS) ?? BRIGHNTESS_SYSTEM;

        return [
          PopupMenuItem<String>(
            child: RadioRow(
              text: 'Light theme',
              isEnabled: brightness == BRIGHNTESS_LIGHT,
            ),
            value: BRIGHNTESS_LIGHT,
          ),
          PopupMenuItem<String>(
            child: RadioRow(
              text: 'Dark theme',
              isEnabled: brightness == BRIGHNTESS_DARK,
            ),
            value: BRIGHNTESS_DARK,
          ),
          PopupMenuItem<String>(
            child: RadioRow(
              text: 'System theme',
              isEnabled: brightness == BRIGHNTESS_SYSTEM,
            ),
            value: BRIGHNTESS_SYSTEM,
          ),
        ];
      },
      onSelected: (value) {
        SharedPreferences prefs = Get.find();
        prefs.setString(PREFS_BRIGHTNESS, value);
        Get.changeTheme(getTheme());
      },
    );

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
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.fullscreen),
              title: Text("Scan QR code"),
              onTap: () async {
                Get.back();
                await scanBarcode();
              },
            ),
            ListTile(
              leading: Icon(Icons.keyboard),
              title: Text("Enter a provided key"),
              onTap: () {
                Get.back();
                Get.toNamed('/form');
              },
            ),
          ],
        ),
      );
    },
  );
}

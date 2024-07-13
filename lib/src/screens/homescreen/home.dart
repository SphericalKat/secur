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
  const Home({super.key});

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
          appBar: appBar(context, controller) as PreferredSizeWidget,
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
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular-Std",
            ),
            children: [
              TextSpan(
                  text: 'Sec',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              TextSpan(text: 'ur', style: TextStyle(color: textColor))
            ]),
      ),
      actions: <Widget>[
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.upload_rounded),
                title: const Text('Export backup'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Warning!'),
                        content: const Text(
                            'Your data will be exported in an unencrypted format. Do you still wish to proceed?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.download_rounded),
                title: const Text('Import backup'),
                onTap: () {
                  // Get.toNamed('/settings');
                },
              ),
            ),
          ];
        }),
      ],
      centerTitle: true,
      elevation: 0,
    );
  } else {
    return AppBar(
      title: Text(controller.selectedItems.length.toString()),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          controller.removeAllItems();
        },
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => Get.dialog(AlertDialog(
            title: Text(
              'Warning!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Choosing yes will delete the selected items.'),
                  Text('Do you still wish to proceed?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18),
                ),
                onPressed: () {
                  Get.back();
                  TOTPController.to.deleteTotps(
                    ItemSelectionController.to.selectedItems,
                  );
                },
              ),
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
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
      icon: const Icon(Icons.brightness_4),
      itemBuilder: (BuildContext context) {
        SharedPreferences prefs = Get.find();
        var brightness = prefs.getString(PREFS_BRIGHTNESS) ?? BRIGHNTESS_SYSTEM;

        return [
          PopupMenuItem<String>(
            value: BRIGHNTESS_LIGHT,
            child: RadioRow(
              text: 'Light theme',
              isEnabled: brightness == BRIGHNTESS_LIGHT,
            ),
          ),
          PopupMenuItem<String>(
            value: BRIGHNTESS_DARK,
            child: RadioRow(
              text: 'Dark theme',
              isEnabled: brightness == BRIGHNTESS_DARK,
            ),
          ),
          PopupMenuItem<String>(
            value: BRIGHNTESS_SYSTEM,
            child: RadioRow(
              text: 'System theme',
              isEnabled: brightness == BRIGHNTESS_SYSTEM,
            ),
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
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Text('Add an account to get started',
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
      ),
    );

FloatingActionButton buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _bottomSheet(context);
    },
    tooltip: 'Add an account',
    elevation: 1.0,
    child: const Icon(
      Icons.add,
      color: Colors.white,
    ),
  );
}

void _bottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.fullscreen),
            title: const Text("Scan QR code"),
            onTap: () async {
              Get.back();
              await scanBarcode();
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard),
            title: const Text("Enter a provided key"),
            onTap: () {
              Get.back();
              Get.toNamed('/form');
            },
          ),
        ],
      );
    },
  );
}

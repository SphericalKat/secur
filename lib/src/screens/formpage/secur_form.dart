import 'package:base32/base32.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/themes/theme.dart';

class SecurForm extends StatefulWidget {
  @override
  _SecurFormState createState() => _SecurFormState();
}

class _SecurFormState extends State<SecurForm> {
  final List<int> interval = [15, 30, 60, 120, 300, 600];
  final List<int> digits = [6, 7, 8];
  final List<String> algorithm = ['SHA1', 'SHA256', 'SHA384', 'SHA512'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _secret;
  String? _issuer;
  int? _interval;
  int? _digits;
  String? _algorithm;
  String? _accountName;

  String? stringValidator(String? value) {
    return value.isNullOrBlank! ? 'Field cannot be empty!' : null;
  }

  AppBar appBar(BuildContext context) {
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
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
              TextSpan(text: 'ur', style: TextStyle(color: textColor))
            ]),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  onSaved: (newValue) {
                    _secret = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: 'Secret key',
                    hintText: 'eg: JBSWY3DPEHPK3PXP',
                  ),
                  initialValue: _secret,
                  validator: (String? value) {
                    if (stringValidator(value) == null) {
                      if (value!.length == 32 || value.length == 16) {
                        try {
                          base32.decode(value);
                          return null;
                        } on FormatException catch (_) {
                          return 'The entered secret is invalid.';
                        }
                      }
                    }
                    return 'The entered secret is invalid.';
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    _accountName = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: 'Account Name',
                  ),
                  initialValue: _accountName,
                  validator: stringValidator,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    _issuer = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: 'Issuer',
                    hintText: 'eg: Google',
                  ),
                  initialValue: _issuer,
                  validator: stringValidator,
                ),
                DropdownButtonFormField(
                  hint: Text('interval(s)'),
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  items: interval
                      .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Container(
                            child: Text(e.toString()),
                          )))
                      .toList(),
                  onChanged: (dynamic value) {
                    _interval = value;
                  },
                  onSaved: (dynamic value) {
                    _interval = value ?? 30;
                  },
                ),
                DropdownButtonFormField(
                  hint: Text('Digits'),
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  items: digits
                      .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Container(
                            child: Text(e.toString()),
                          )))
                      .toList(),
                  onChanged: (dynamic value) {
                    _digits = value;
                  },
                  onSaved: (dynamic value) {
                    _digits = value ?? 6;
                  },
                ),
                DropdownButtonFormField(
                  hint: Text('Algorithm'),
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor,
                  ),
                  items: algorithm
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: SizedBox(
                            child: DecoratedBox(
                              child: Text(e.toString()),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (dynamic value) {
                    _algorithm = value;
                  },
                  onSaved: (dynamic value) {
                    _algorithm = value ?? 'SHA1';
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      TOTPController.to.saveTotp(
                        SecurTOTP(
                          secret: _secret,
                          algorithm: _algorithm,
                          digits: _digits,
                          interval: _interval,
                          issuer: _issuer,
                          accountName: _accountName,
                        ),
                      );
                      _formKey.currentState!.deactivate();
                      Get.back();
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

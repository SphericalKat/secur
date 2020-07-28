import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/themes/theme.dart';

class SecurForm extends StatefulWidget {
  @override
  _SecurFormState createState() => _SecurFormState();
}

class _SecurFormState extends State<SecurForm> {
  final List<int> interval = [15, 30, 60, 120, 300, 600];
  final List<int> digits = [6, 7, 8, 9, 10, 11, 12];
  final List<String> algorithm = ['SHA1', 'SHA256', 'SHA384', 'SHA512'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _secret;
  String _issuer;
  int _interval;
  int _digits;
  String _algorithm;
  String _accountName;

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
                  style: TextStyle(color: Theme.of(context).accentColor)),
              TextSpan(text: 'ur', style: TextStyle(color: Colors.white))
            ]),
      ),
      centerTitle: true,
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
                    hintText: 'JBSWY3DPEHPK3PXP',
                  ),
                  initialValue: _secret,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Secret cannot be empty';
                    }
                    return null;
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Secret cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onSaved: (newValue) {
                    _issuer = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: 'Issuer',
                    hintText: 'google',
                  ),
                  initialValue: _issuer,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  dropdownColor: deepBlueSecondary,
                  hint: Text('interval(s)'),
                  items: interval
                      .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Container(
                            child: Text(e.toString()),
                          )))
                      .toList(),
                  onChanged: (value) {
                    _interval = value;
                  },
                  onSaved: (value) {
                    if (value == null) {
                      _interval = 30;
                    } else {
                      _interval = value;
                    }
                  },
                ),
                DropdownButtonFormField(
                  dropdownColor: deepBlueSecondary,
                  hint: Text('Digits'),
                  items: digits
                      .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Container(
                            child: Text(e.toString()),
                          )))
                      .toList(),
                  onChanged: (value) {
                    _digits = value;
                  },
                  onSaved: (value) {
                    if (value == null) {
                      _digits = 6;
                    } else {
                      _digits = value;
                    }
                  },
                ),
                DropdownButtonFormField(
                  dropdownColor: deepBlueSecondary,
                  hint: Text('Algorithm'),
                  items: algorithm
                      .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Container(
                            child: Text(e.toString()),
                          )))
                      .toList(),
                  onChanged: (value) {
                    _algorithm = value;
                  },
                  onSaved: (value) {
                    if (value == null) {
                      _algorithm = 'SHA1';
                    } else {
                      _algorithm = value;
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
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
                      _formKey.currentState.deactivate();
                      Get.back();
                    }
                    return null;
                  },
                  child: Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

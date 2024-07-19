import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:secur/src/controllers/totp_controller.dart';
import 'package:secur/src/models/securtotp.dart';
import 'package:secur/src/totp/utils/backup_result.dart';

class BackupController extends GetxController {
  static BackupController get to => Get.find();

  Future<BackupResult> backup() async {
    final totps = TOTPController.to.getAllTotps();
    final backupJson = totps.map((e) => e.toJson()).toList();
    final backupString = jsonEncode(backupJson);

    final fileName =
        'secur_backup_${DateTime.timestamp().toIso8601String()}.json';

    try {
      String? backupPath = await FilePicker.platform.saveFile(
          dialogTitle: 'Save backup file',
          fileName: fileName,
          bytes: utf8.encode(backupString));
      if (backupPath == null) {
        return BackupResultError("No file selected!");
      }
    } catch (e) {
      print(e);
      return BackupResultError("Error saving file: $e");
    }

    return BackupResultSuccess();
  }

  Future<BackupResult> restore() async {
    FilePickerResult? backupFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (backupFile == null) {
      return BackupResultError("No file selected!");
    }
    if (backupFile.files.first.path == null) {
      return BackupResultError("No file path!");
    }

    // Read the backup file
    try {
      final backupString =
          await File(backupFile.files.first.path!).readAsString();
      List<dynamic> backupJson = jsonDecode(backupString);
      final totps = backupJson.map((e) => SecurTOTP.fromJson(e)).toList();
      await TOTPController.to.saveAllTotps(totps);
    } catch (e) {
      return BackupResultError("Error reading file: $e");
    }

    return BackupResultSuccess();
  }
}

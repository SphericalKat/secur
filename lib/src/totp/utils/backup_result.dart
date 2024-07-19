sealed class BackupResult {}

class BackupResultSuccess extends BackupResult {
}

class BackupResultError extends BackupResult {
  final String message;

  BackupResultError(this.message);
}

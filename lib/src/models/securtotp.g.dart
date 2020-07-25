// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securtotp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecurTOTPAdapter extends TypeAdapter<SecurTOTP> {
  @override
  final int typeId = 0;

  @override
  SecurTOTP read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecurTOTP(
      secret: fields[3] as String,
      algorithm: fields[0] as String,
      digits: fields[1] as int,
      interval: fields[2] as int,
      issuer: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SecurTOTP obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.algorithm)
      ..writeByte(1)
      ..write(obj.digits)
      ..writeByte(2)
      ..write(obj.interval)
      ..writeByte(3)
      ..write(obj.secret)
      ..writeByte(4)
      ..write(obj.issuer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecurTOTPAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersAdapter extends TypeAdapter<Users> {
  @override
  final int typeId = 0;

  @override
  Users read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Users(
      name: fields[0] as String,
      phone: fields[1] as String,
      title: fields[2] as String,
      send: fields[3] as String,
      date: fields[4] as String,
      time: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Users obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.send)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrdersAdapter extends TypeAdapter<Orders> {
  @override
  final int typeId = 1;

  @override
  Orders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Orders(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      title: fields[3] as String,
      table_number: fields[4] as String,
      drinks: fields[5] as String,
      price: fields[6] as String,
      image: fields[7] as String,
      old_price: fields[8] as String,
      number_order: fields[9] as String,
      pay: fields[10] as String,
      send: fields[11] as String,
      date: fields[12] as String,
      time: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Orders obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.table_number)
      ..writeByte(5)
      ..write(obj.drinks)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.old_price)
      ..writeByte(9)
      ..write(obj.number_order)
      ..writeByte(10)
      ..write(obj.pay)
      ..writeByte(11)
      ..write(obj.send)
      ..writeByte(12)
      ..write(obj.date)
      ..writeByte(13)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AllOrdersAdapter extends TypeAdapter<AllOrders> {
  @override
  final int typeId = 2;

  @override
  AllOrders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllOrders(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      title: fields[3] as String,
      table_number: fields[4] as String,
      drinks: fields[5] as String,
      price: fields[6] as String,
      image: fields[7] as String,
      old_price: fields[8] as String,
      number_order: fields[9] as String,
      pay: fields[10] as String,
      send: fields[11] as String,
      date: fields[12] as String,
      time: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllOrders obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.table_number)
      ..writeByte(5)
      ..write(obj.drinks)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.old_price)
      ..writeByte(9)
      ..write(obj.number_order)
      ..writeByte(10)
      ..write(obj.pay)
      ..writeByte(11)
      ..write(obj.send)
      ..writeByte(12)
      ..write(obj.date)
      ..writeByte(13)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllOrdersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

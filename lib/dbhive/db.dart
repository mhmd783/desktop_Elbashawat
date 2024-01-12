import 'package:hive/hive.dart';
part 'db.g.dart';
@HiveType(typeId: 0)
class Users extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String phone;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String send;
  @HiveField(4)
  late String date;
  @HiveField(5)
  late String time;

  Users(
      {required this.name,
      required this.phone,
      required this.title,
      required this.send,
      required this.date,
      required this.time});

}
@HiveType(typeId: 1)
class Orders extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  
  @HiveField(2)
  late String phone;
  @HiveField(3)
  late String title;
  @HiveField(4)
  late String table_number;
  @HiveField(5)
  late String drinks;
  @HiveField(6)
  late String price;
  @HiveField(7)
  late String image;
  @HiveField(8)
  late String old_price;
  @HiveField(9)
  late String number_order;
  @HiveField(10)
  late String pay;
  @HiveField(11)
  late String send;
  @HiveField(12)
  late String date;
  @HiveField(13)
  late String time;

  Orders(
      {required this.id,
      required this.name,
      required this.phone,
      required this.title,
      required this.table_number,
      required this.drinks,
      required this.price,
      required this.image,
      required this.old_price,
      required this.number_order,
      required this.pay,
      required this.send, 
      required this.date,
      required this.time});

}
@HiveType(typeId: 2)
class AllOrders extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  
  @HiveField(2)
  late String phone;
  @HiveField(3)
  late String title;
  @HiveField(4)
  late String table_number;
  @HiveField(5)
  late String drinks;
  @HiveField(6)
  late String price;
  @HiveField(7)
  late String image;
  @HiveField(8)
  late String old_price;
  @HiveField(9)
  late String number_order;
  @HiveField(10)
  late String pay;
  @HiveField(11)
  late String send;
  @HiveField(12)
  late String date;
  @HiveField(13)
  late String time;

  AllOrders(
      {required this.id,
      required this.name,
      required this.phone,
      required this.title,
      required this.table_number,
      required this.drinks,
      required this.price,
      required this.image,
      required this.old_price,
      required this.number_order,
      required this.pay,
      required this.send, 
      required this.date,
      required this.time});

}

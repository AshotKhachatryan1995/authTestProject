import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String login;

  @HiveField(3)
  late String password;

  @HiveField(4)
  late DateTime registrationDate;

  User(
      {required this.id,
      required this.name,
      required this.login,
      required this.password,
      required this.registrationDate});
}

import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId id;

  //will be gotten by database with id
  String role;
  String name;

  User(this.id, this.role, this.name);

}
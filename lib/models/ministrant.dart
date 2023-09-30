import 'package:mongo_dart/mongo_dart.dart';

class Ministrant {
  String name;
  ObjectId id;

  Ministrant(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {'_id': id, 'name': name};
  }

  Ministrant.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'];

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) =>
      other is Ministrant && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode {
    return id.hashCode;
  }
}

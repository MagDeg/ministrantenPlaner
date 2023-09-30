import 'package:mongo_dart/mongo_dart.dart';

import 'ministrant.dart';

class Worship {
  DateTime date;
  String name;
  bool fixed;
  ObjectId id;

  List<ObjectId> ministranten = [];

  Worship(this.date, this.name, this.fixed, this.id);

  addMinistrant(Ministrant ministrant) {
    ministranten.add(ministrant.id);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'date' : date,
      'fixed' : fixed,
      'ministranten' : ministranten,
    };
  }

  Worship.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        date = DateTime.parse(map['date']),
        fixed = map['fixed'],
        id = map['_id'],
        ministranten = map['ministranten'].cast<ObjectId>();

  @override
  String toString() {
    return toMap().toString();
  }

}


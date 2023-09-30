

import 'package:ministranten_planer_web/models/worship.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/ministrant.dart';


const mongoUrl = "mongodb://nele.spdns.eu:27071";
const collectionName = "Main";

class MongoDatabase {


Map<dynamic, dynamic> myMap = {};
  static var db, collection;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    await db.authenticate("dbadmin", "myDByAqWsX");
  }

  static addMinistrant(Ministrant ministrant) async {
    collection = db.collection("Ministranten");
    await collection.insertOne(ministrant.toMap());
  }

  static Future<List<Ministrant>> getMinistrants() async {
    collection = db.collection("Ministranten");
    final data = await collection.find().toList();

    List<Ministrant> ministranten = [];

    data.forEach((e) {
      ministranten.add(Ministrant.fromMap(e));
    });

    var d = await collection.findOne({"_id" : ministranten[0].id});

    return ministranten;
  }

  static Future<Ministrant> getMinistrantWithId(ObjectId id) async {
    collection = db.collection("Ministranten");
    return Ministrant.fromMap(await collection.findOne({"_id" : id}));
  }



  static Future<List<Map<String, dynamic>>> getFixedWorships() async {
    collection = db.collection("Worships");
    return await collection.find({"fixed": true}).toList();
  }

  static Future<List<Map<String, dynamic>>> getWithParameters(String key, dynamic value) async {
    collection = db.collection("Worships");
    var a = await collection.find(where.eq(key, value).gte("date", DateTime.now().toString()).sortBy("date")).toList();
    return a;
  }

  static Future<List<Map<String, dynamic>>> getProgressWorships() async {
    collection = db.collection("Worships");
    var a = await collection.find({"fixed": false}).toList();
    return a;
  }

  static updateWorship(Worship ws) async {
    collection = db.collection("Worships");
    var a = await collection.findOne({"_id" : ws.id});
    a["date"] = ws.date.toString();
    a["name"] = ws.name;
    a["fixed"] = ws.fixed;
    a["ministranten"] = ws.ministranten;
    collection = db.collection("Worships");
    await collection.save(a);
    print("updated");
    print(ws.ministranten);
    print(collection);
  }

  static removeWorship(Worship ws) async {
    collection = db.collection("Worships");
    await collection.remove(where.id(ws.id));
  }

  static insertWorship(DateTime date, String name, bool fixed, List ministranten) async {
    collection = db.collection("Worships");
    await collection.insertOne({
      'date' : date.toString(),
      'name' : name,
      'fixed' : fixed,
      'ministranten' : ministranten
    });
  }

}



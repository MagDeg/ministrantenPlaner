import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import 'package:ministranten_planer_web/variables.dart';

Future<Worship?> getNearestWorship() async {

  List data = await MongoDatabase.getWithParameters("ministranten", user!.id);
  List<Worship> worships = [];

  for (var element in data) {
    worships.add(Worship.fromMap(element));
  }



  if (worships.isEmpty) {
    return null;
  } else {
    return worships[0];
  }
 }
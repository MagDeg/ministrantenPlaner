import 'dart:math';

import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/models/ministrant.dart';
import 'package:ministranten_planer_web/models/plan.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import 'package:ministranten_planer_web/variables.dart';

class Database {

  void loadWorship() {

  }

  void loadMinistranten() async {
    List<Ministrant> ministranten = await MongoDatabase.getMinistrants();
    if(availableMinistrants.isEmpty) {
      availableMinistrants.addAll(ministranten);
    }
  }

  void loadPlan() {

  }
}
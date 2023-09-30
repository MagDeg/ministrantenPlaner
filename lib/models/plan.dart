import 'package:ministranten_planer_web/models/worship.dart';

class Plan {

  DateTime from;
  DateTime to;
  List<Worship> worship = [];

  Plan(this.from, this.to);

  addWorship(Worship gd) {
    worship.add(gd);
  }
}


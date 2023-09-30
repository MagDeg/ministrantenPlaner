import 'package:ministranten_planer_web/models/ministrant.dart';
import 'models/contact_person.dart';
import 'models/user.dart';



User? user;

List<Ministrant> availableMinistrants = [];

///Temporary
List<ContactPerson> contactPerson = [
  ContactPerson("Magnus Degwerth", "Administrator", "magnus.degwerth@outlook.de"),
  ContactPerson("Jakob Heinze", "Oberministrant", "jakob.heinze@t-online.de"),
  ContactPerson("Mathias Kugler", "Diakon", "mathias.kugler@bistum-erfurt.de"),
];

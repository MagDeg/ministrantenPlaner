import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ministranten_planer_web/functions/get_nearest_worship.dart';
import 'package:ministranten_planer_web/presets/main_button_preset.dart';
import 'package:ministranten_planer_web/presets/main_headsup_display_button_preset.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'models/Database.dart';
import 'models/user.dart';
import 'variables.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);



  bool checkIfOM() {
    if(user!.role == "Oberministrant") {
      return true;
    } else {
      return false;
    }
  }



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late DateFormat dateFormat;

  refresh() {
    setState(() {});
  }

  @override
  void initState() {

      ///TODO: Replace by db query with id
      user = User(mongo.ObjectId.fromHexString("64d3ef97bd60d1cd4f0ba6bb"), "Oberministrant", "Magnus Andreas Degwerth");

      Database().loadMinistranten();
      initializeDateFormatting();
      dateFormat = DateFormat.yMMMMd('de');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: SizedBox(width: 200, height: 30, child: FittedBox(child: Text(user!.role, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal))))),
                  const SizedBox(width: 20),
                  Expanded(child: SizedBox(width: 300, height: 30, child: FittedBox(child: Text(user!.name, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal))))), //TODO: implement username getter from cloud
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          backgroundColor: const Color(0xFFffbe00),
        ),
        body: FutureBuilder(
          future: getNearestWorship(),
          builder: (context, snapshot) {
            bool empty;

            if(snapshot.data == null) {
              empty = true;
            } else {
              empty = false;
            }


            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0xFFa6c600),
                              ),


                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                MainHeadsupDisplayButtonPreset("Nächster Gottesdienst",  empty ? "-" : dateFormat.format(DateTime.parse(snapshot.data!.date.toString()))),
                                MainHeadsupDisplayButtonPreset("Nächste Veranstaltung", "30. Oktober 2023"),
                                MainHeadsupDisplayButtonPreset("Anzahl Ministranten", "10"),
                                MainHeadsupDisplayButtonPreset("Anzahl Gottesdienste", "12"),
                            ]
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  MainButtonPreset("/actualPlanPage", Icons.calendar_today_sharp, 'Aktueller Ministrantenplan'),
                                  MainButtonPreset("/newPlanPage", Icons.edit, 'Neuer Ministrantenplan'),
                                  MainButtonPreset('', Icons.announcement, 'Ankündigungen'),
                                  MainButtonPreset('', Icons.library_books_rounded, 'Handbuch'),
                                  Container(
                                    child: MainScreen().checkIfOM() ? MainButtonPreset("/ministrantenListPage", Icons.list, "Ministranten") : null,
                                  ),
                                  MainButtonPreset('/contactPage', Icons.supervisor_account, 'Kontakt'),
                                  MainButtonPreset('', Icons.settings, 'Einstellungen'),

                                ],
                              )
                            )
                          ),

                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
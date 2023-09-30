import 'package:flutter/material.dart';
import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/main_screen.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import 'package:ministranten_planer_web/operator_operations/add_worship_dialog.dart';
import '../../presets/list_tile_worship.dart';


class NewPlanScreen extends StatefulWidget {
  const NewPlanScreen({super.key});




  @override
  State<NewPlanScreen> createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {

  refresh() {
    print("refresh");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: RawMaterialButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/mainPage");
            },
            child: const Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: const Color(0xFFffbe00),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: FutureBuilder(
              future: MongoDatabase.getProgressWorships(),
              builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else {
                 return ListView.builder(
                     itemCount: snapshot.data?.length,
                     itemBuilder: (context, index) {
                       List<Worship> progress = [];

                       for (var element in snapshot.data!) {
                         progress.add(Worship.fromMap(element));
                       }
                       return ListTiles(
                           data: Worship.fromMap(snapshot.data![index]),
                           notifyParent: refresh,
                           changeable: true,
                           listOfProgressWorship: progress);
                     });
               }


              }
            ),
          ),
        ),
        floatingActionButton: const MainScreen().checkIfOM()
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddWorshipDialoge(refresh));
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );

  }

}

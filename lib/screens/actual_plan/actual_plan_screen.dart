import 'package:flutter/material.dart';
import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import '../../presets/list_tile_worship.dart';
import '../../variables.dart';

class ActualPlanScreen extends StatefulWidget {
  const ActualPlanScreen({Key? key}) : super(key: key);

  @override
  State<ActualPlanScreen> createState() => _ActualPlanScreenState();
}

class _ActualPlanScreenState extends State<ActualPlanScreen> {
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: const Color(0xFFffbe00),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: FutureBuilder(
                  future: MongoDatabase.getFixedWorships(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return ListTiles(
                              data: Worship.fromMap(snapshot.data![index]),
                              notifyParent: refresh,
                              changeable: false,
                              deleatOnly: true,
                            );
                          });
                    }
                  }),
            ),
          )),
    );
  }
}

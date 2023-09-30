import 'package:flutter/material.dart';
import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import 'package:ministranten_planer_web/variables.dart';

import '../models/ministrant.dart';

class AddManualToWorship extends StatefulWidget {
  Worship data;

  AddManualToWorship({super.key, required this.data});

  @override
  State<AddManualToWorship> createState() => _AddManualToWorshipState();
}

class _AddManualToWorshipState extends State<AddManualToWorship> {
  List<Ministrant> getAvailableMinistrants() {
    List<Ministrant> ministrant = [];
    ministrant.addAll(availableMinistrants);

    for (var e in widget.data.ministranten) {
      for (var a in ministrant) {
        if (a.id.$oid == e.$oid) {
          ministrant.removeWhere((c) => c.id.$oid == a.id.$oid);
          break;
        }
      }
    }

    return ministrant;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: RawMaterialButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/newPlanPage");
          },
          child: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: const Color(0xFFffbe00),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 3.0, color: Colors.black)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFFffbe00),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Center(
                          child:
                              Text("Im Gottesdienst eingeteilte Ministranten")),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.data.ministranten.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: MongoDatabase.getMinistrantWithId(
                                    widget.data.ministranten[index]),
                                builder: (context, snapshot) {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: Colors.black, width: 2.0)),
                                      child: ListTile(
                                        title: Text("${snapshot.data?.name}"),
                                        onTap: () {
                                          setState(() {
                                            widget.data.ministranten
                                                .removeWhere((e) =>
                                                    e.$oid ==
                                                    snapshot.data?.id.$oid);
                                            MongoDatabase.updateWorship(
                                                widget.data);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                });
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 3.0, color: Colors.black)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFFffbe00),
                          borderRadius: BorderRadius.circular(8.0)),
                      child:
                          const Center(child: Text("Verfügbare Ministranten")),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: getAvailableMinistrants().length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: Colors.black, width: 2.0)),
                                child: ListTile(
                                  title: Text(
                                      getAvailableMinistrants()[index].name),
                                  onTap: () {
                                    setState(() {
                                      widget.data.ministranten.add(
                                          getAvailableMinistrants()[index].id);
                                      MongoDatabase.updateWorship(widget.data);
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

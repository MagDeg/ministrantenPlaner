import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/main_screen.dart';
import 'package:ministranten_planer_web/operator_operations/add_ministrants_manual_to_worship.dart';
import 'package:ministranten_planer_web/variables.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../models/worship.dart';
import '../operator_operations/fix_plan_dialog.dart';

class ListTiles extends StatefulWidget {
  final Worship data;
  final List<Worship>? listOfProgressWorship;
  final Function() notifyParent;
  final bool changeable;
  final bool deleatOnly;

  const ListTiles(
      {super.key,
      required this.data,
      required this.notifyParent,
      required this.changeable,
      this.deleatOnly = false,
      this.listOfProgressWorship});

  @override
  State<ListTiles> createState() => _ListTilesState();
}

class _ListTilesState extends State<ListTiles> {
  late bool exists;

  bool? checkIfMinistrantInList() {
    if (widget.data.ministranten.isNotEmpty) {
      for (var element in widget.data.ministranten) {
        if (element == user!.id) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    exists = checkIfMinistrantInList()!;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          color: exists ? const Color(0xFFa6c600) : const Color(0xFFffbe00),
        ),
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: widget.changeable && const MainScreen().checkIfOM()
              ? ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        MongoDatabase.removeWorship(widget.data);
                        widget.notifyParent();
                      },
                      backgroundColor: const Color(0xFFffe84b),
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      label: 'Löschen',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        bool full = false;
                        if (widget.data.ministranten.length >= 4) {
                          full = true;
                        } else {
                          full = false;
                        }

                        showDialog(
                            context: context,
                            builder: (context) =>
                                FixPlanDialog(full, widget.data));
                        widget.notifyParent();
                      },
                      backgroundColor: const Color(0xFFffe84b),
                      foregroundColor: Colors.black,
                      icon: Icons.check,
                      label: 'Festlegen',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddManualToWorship(data: widget.data)));
                      },
                      backgroundColor: const Color(0xFFffe84b),
                      foregroundColor: Colors.black,
                      icon: Icons.edit,
                      label: 'Manuell',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        //PROBLEM: What is with the fixed Worships? They have to be considered in the list of ministrants that didn't signed in!
                        //SOLUTION: List of progressWorship has to be extended by all the fixed Worships. BUT: There has to be a specified range of worships (like all worships within 2 months)
                        ///TODO: everyone who hasn't singed in at least two times in an range of two or three months should be automatically singed to a worship!

                        List<mongo.ObjectId> participants = [];
                        List<mongo.ObjectId> possible = [];

                        for (var element in availableMinistrants) {
                          possible.add(element.id);
                        }

                        for (var worship in widget.listOfProgressWorship!) {
                          if (participants.isNotEmpty) {
                            for (var ministrant in worship.ministranten) {
                              for (var o in participants) {
                                if (!(o.$oid == ministrant.$oid)) {
                                  participants.add(ministrant);
                                  break;
                                }
                              }
                            }
                          } else {
                            participants.addAll(worship.ministranten);
                          }
                        }

                        for (var p in participants) {
                          for (var avMinistrant in possible) {
                            if (p.$oid == avMinistrant.$oid) {
                              possible.removeWhere(
                                  (e) => e.$oid == avMinistrant.$oid);
                              break;
                            }
                          }
                        }

                        // possible = availableMinistrants.toSet().difference(participants.toSet()).cast<mongo.ObjectId>().toList();

                        for (int i = 0;
                            widget.data.ministranten.length < 4;
                            i++) {
                          if (possible.isNotEmpty) {
                            int a = Random().nextInt(possible.length);
                            widget.data.ministranten.add(possible[a]);
                            possible.remove(possible[a]);
                          } else {
                            break;
                          }
                        }
                        MongoDatabase.updateWorship(widget.data)
                            .then((v) => widget.notifyParent());
                      },
                      backgroundColor: const Color(0xFFffe84b),
                      foregroundColor: Colors.black,
                      icon: Icons.edit_note,
                      label: 'Auto',
                    ),
                  ],
                )
              : widget.deleatOnly
                  ? ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          MongoDatabase.removeWorship(widget.data);
                          widget.notifyParent();
                        },
                        backgroundColor: const Color(0xFFffe84b),
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                        label: 'Löschen',
                      ),
                    ])
                  : null,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        Expanded(
                            child: SizedBox(
                                width: 100,
                                height: 50.0,
                                child: FittedBox(
                                    child: Text(
                                        "${widget.data.date.day}. ${widget.data.date.month}. ${widget.data.date.year}")))),
                        Expanded(
                            child: SizedBox(
                                width: 200,
                                height: 50.0,
                                child:
                                    FittedBox(child: Text(widget.data.name)))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    color: Colors.white24,
                    width: 200,
                    height: 100,
                    padding: const EdgeInsets.all(4),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.data.ministranten.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: MongoDatabase.getMinistrantWithId(
                                  widget.data.ministranten[index]),
                              builder: (context, snapshot) {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "${snapshot.data?.name}, ",
                                      maxLines: 2,
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                )
              ],
            ),
            onTap: () {
              exists = checkIfMinistrantInList()!;

              if (widget.changeable) {
                if (exists) {
                  widget.data.ministranten.removeWhere((e) => e == user!.id);

                  setState(() {
                    exists = false;
                  });
                } else {
                  availableMinistrants.forEach((element) {
                    if (element.id == user!.id) {
                      widget.data.addMinistrant(element);
                    }
                  });
                  setState(() {
                    exists = true;
                  });
                }
                MongoDatabase.updateWorship(widget.data);
              }
            },
          ),
        ),
      ),
    );
  }

  bool orientation() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return true;
    } else {
      return false;
    }
  }

  bool bigScreen() {
    if (MediaQuery.of(context).size.width > 410) {
      return true;
    } else {
      return false;
    }
  }
}

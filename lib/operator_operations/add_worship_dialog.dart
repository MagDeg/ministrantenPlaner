import 'package:flutter/material.dart';
import 'package:ministranten_planer_web/database/database.dart';
import 'package:ministranten_planer_web/functions/showSnackbar.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import 'package:ministranten_planer_web/presets/text_field_operations.dart';
import 'package:ministranten_planer_web/variables.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AddWorshipDialoge extends StatefulWidget {
  final Function() notifyParent;

  const AddWorshipDialoge(@required this.notifyParent, {super.key});

  @override
  State<AddWorshipDialoge> createState() => _AddWorshipDialogeState();
}

class _AddWorshipDialogeState extends State<AddWorshipDialoge> {
  TextEditingController nameController = TextEditingController();

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Neuen Termin hinzufügen",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Text("Startdatum: ")),
                  const SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          DateTime? newEndDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2100),
                              locale: const Locale('de'));
                          if (newEndDate == null) return;
                          setState(() {
                            date = newEndDate!;
                          });
                        },
                        child:
                            Text("${date.day}. ${date.month}. ${date.year}")),
                  )
                ],
              ),
              const SizedBox(height: 15),
              TextFieldOperations("Bezeichnung", nameController, false,
                  TextInputType.text, 1000),
              const SizedBox(height: 15),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.black)),
                onPressed: () async {
                  ///TODO: IMPLEMENT!!!
                  MongoDatabase.insertWorship(
                      date, nameController.text, false, <mongo.ObjectId>[]);
                  //progressPlan.add(Worship(date, nameController.text, false));

                  // widget.notifyParent;
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/newPlanPage");
                },
                child: const Text("Fertig"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

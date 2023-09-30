import 'package:flutter/material.dart';
import 'package:ministranten_planer_web/models/worship.dart';
import '../database/database.dart';
import '../variables.dart';

class FixPlanDialog extends StatefulWidget {
  bool full;
  Worship data;

  FixPlanDialog(this.full, this.data, {super.key});

  @override
  State<FixPlanDialog> createState() => _FixPlanDialogState();
}

class _FixPlanDialogState extends State<FixPlanDialog> {


  @override
  Widget build(BuildContext context) {

    return  AlertDialog(
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Aktuelle Gottesdiensteinteilung festlegen"),
              const SizedBox(height: 20),
              Container(child: widget.full ?  null : const Text("Achtung: Der Gottesdienst hat noch zu wenig Ministranten!", style: TextStyle(color: Color(0xFFffbe00)))),
              const SizedBox(height: 20),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black)
                ),
                onPressed: () {

                  widget.data.fixed = true;
                  MongoDatabase.updateWorship(widget.data);


                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/newPlanPage");
                },
                child: widget.full ?  Container(padding: const EdgeInsets.all(8.0), child: const Text("Festlegen")) : Container(padding: const EdgeInsets.all(8.0), child: const Text("Trotzdem Festlegen")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class MainButtonPreset extends StatelessWidget {
  String routeName;
  String labelName;
  IconData labelIcon;
  MainButtonPreset(this.routeName, this.labelIcon, this.labelName, {super.key});

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
        constraints: const BoxConstraints(
        maxHeight: 200,
        minHeight: 100,
        maxWidth: 170,
        minWidth: 100,
        ),
      child: RawMaterialButton(
        onPressed: () async {
          Navigator.pushReplacementNamed(context, routeName);



        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black,
                width: 5.0,
              ),
              color: const Color(0xFFffbe00),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 120,
                height: 100,
                child: FittedBox(
                  child: Column(
                    children: [
                      Icon(labelIcon, size: 100,),
                      const SizedBox(height: 40),
                      SizedBox(width: 300, child: Center(child: Text(labelName, style: const TextStyle(fontSize: 40)))),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MainHeadsupDisplayButtonPreset extends StatelessWidget {

  String labelName;
  String labelData;
  MainHeadsupDisplayButtonPreset(this.labelName, this.labelData, {super.key});

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
        minHeight: 100,
        maxWidth: 170,
        minWidth: 100,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: const Border(
              bottom: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
            color: Colors.white54,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              // width: 120,
               height: 100,
              child: FittedBox(
                child: Column(
                  children: [
                    SizedBox(width: 500, child: Center(child: Text(labelName, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600)))),
                    const SizedBox(height: 40),
                    Text(labelData, style: const TextStyle(fontSize: 60.0)),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
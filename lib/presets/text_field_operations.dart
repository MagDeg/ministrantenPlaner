import 'package:flutter/material.dart';

class TextFieldOperations extends StatelessWidget {
  String label;
  bool center;
  TextInputType inputType;
  int maxLenght;

  TextEditingController controller;

  TextFieldOperations(this.label, this.controller, this.center, this.inputType, this.maxLenght, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: maxLenght,
        keyboardType: inputType,
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          counterText: "",
          label: center ?  Center(
            child: Text(label),
          ) : Text(label),
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          focusColor: const Color(0xFFfffbac),
          fillColor: const Color(0xFFfffbac),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}

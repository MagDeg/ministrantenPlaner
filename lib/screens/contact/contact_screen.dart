import 'package:flutter/material.dart';

import '../../variables.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

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
            child: ListView.builder(
              itemCount: contactPerson.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        width: 3.0,
                        color: Colors.black,
                      ),
                      color: const Color(0xFFa6c600)
                    ),
                    child: ListTile(
                      title: SizedBox(
                        height: 80.0,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: SizedBox(height: 30.0, width: 200, child: FittedBox(child: Text(contactPerson[index].role)))),
                                  Expanded(child: SizedBox(height: 30.0, width: 200, child: FittedBox(child: Text(contactPerson[index].name)))),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox(height: 30.0, width: 250, child: FittedBox(child: Text(contactPerson[index].contact)))),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        )
      )
    );
  }


}

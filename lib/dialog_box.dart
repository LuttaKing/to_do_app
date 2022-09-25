// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/my_button.dart';

class DialogBox extends StatelessWidget {
 final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({
    super.key,
   required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
          controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Add task'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                  name: 'Save',
                  onPressed: () {
                    onSave();
                  }),
              SizedBox(
                width: 20,
              ),
              MyButton(
                  name: 'Cancel',
                  onPressed: () {
                    onCancel();
                  }),
            ],
          )
        ]),
      ),
    );
  }
}

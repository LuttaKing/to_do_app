// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/dialog_box.dart';
import 'package:to_do_app/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoDB db = TodoDB();
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    // if first time ever
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }
//reference the hive box

  final _controller = TextEditingController();

  // List todoList = [
  //   ['Write code', false],
  //   ['Dance Classes', false]
  // ];

  // check box tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void saveTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: () {
              saveTask();
            },
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            },
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T0 DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            createTask();
          }),
      backgroundColor: Colors.yellow[100],
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: ((context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: ((value) {
                checkBoxChanged(value, index);
              }),
              deleteFunc: (context) {
                deleteTask(index);
              },
            );
          })),
    );
  }
}

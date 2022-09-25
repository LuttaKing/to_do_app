import 'package:hive_flutter/hive_flutter.dart';

class TodoDB {
  List todoList = [];
// reference the hive box
  final _myBox = Hive.box('mybox');

// run this if is first app open ever
  void createInitialData() {
    todoList = [
      ['Write code', false],
      ['Dance Classes', false]
    ];

  }
    //load data from db

    void loadData() {
      todoList = _myBox.get('TODOLIST');
    }

    //update Data
    void updateData() {
      _myBox.put('TODOLIST',todoList);
    }
}

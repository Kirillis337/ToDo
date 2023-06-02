import 'package:hive_flutter/hive_flutter.dart';



class ToDoDB{
  List toDoList=[  ];

  final toDoBox=Hive.box('ToDoBox');

  void loadData(){
      toDoList = toDoBox.get('TODOLIST');
  }
void createInitialData(){

}
  void saveData(){
      toDoBox.put('TODOLIST', toDoList);
  }
}
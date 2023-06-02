import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/dialog.dart';
import 'package:todo/components/todo.dart';
import 'package:todo/data/tododb.dart';

import '../utils/theme.dart';

// ignore_for_file: prefer_const_constructors

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (toDoBox.get('TODOLIST') != null) {
      db.loadData();
    }
    super.initState();
  }

  final toDoBox = Hive.box('ToDoBox');

  // контроллеры текстполей
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int filterState = 0;

  ToDoDB db = ToDoDB();
  List completedData = [];
  List notCompletedData = [];

  //список карт
  void fieldClear() {
    nameController.clear();
    descriptionController.clear();
  }

  void createTask() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DialogBox(
            nameController: nameController,
            descController: descriptionController,
            onSave: () {
              if (nameController.text != '' &&
                  descriptionController.text != '') {
                setState(() {
                  db.toDoList.add([
                    db.toDoList.length,
                    nameController.text,
                    descriptionController.text,
                    false
                  ]);
                });
                fieldClear();
                Navigator.pop(context);
              } else {}
            },
            onCancel: () {
              fieldClear();
              Navigator.pop(context);
            },
          );
        });
    db.saveData();
  }

  void editTask(int index) {
    nameController.text = db.toDoList[index][1];
    descriptionController.text = db.toDoList[index][2];

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DialogBox(
            nameController: nameController,
            descController: descriptionController,
            onSave: () {
              if (nameController.text != '' &&
                  descriptionController.text != '') {
                setState(() {
                                        db.toDoList[index] = [
                        db.toDoList[index][0],
                        nameController.text,
                        descriptionController.text,
                        false
                      ];

                  filterData();
                });
                fieldClear();
                Navigator.pop(context);
              } else {}
            },
            onCancel: () {
              fieldClear();
              Navigator.pop(context);
            },
          );
        });

    db.saveData();
  }

  void deleteTask(int index) {
    setState(() {
      int a=db.toDoList[index][0];
      db.toDoList.removeAt(index);
      for(int j=0;j<db.toDoList.length;j++) {
        if(db.toDoList[j][0]>a) {
          db.toDoList[j][0]-=1;
        }
      }
      filterData();
    });
    db.saveData();
  }

  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][3] = !db.toDoList[index][3];
      filterData();
    });
    db.saveData();
  }

  void filterData() {
    completedData.clear();
    notCompletedData.clear();

    for (int i = 0; i < db.toDoList.length; i++) {
      if (db.toDoList[i][3] == true) {
        completedData.add([
          db.toDoList[i][0],
          db.toDoList[i][1],
          db.toDoList[i][2],
          db.toDoList[i][3],
        ]);
      } else if (db.toDoList[i][3] == false) {
        notCompletedData.add([
          db.toDoList[i][0],
          db.toDoList[i][1],
          db.toDoList[i][2],
          db.toDoList[i][3],
        ]);
      }
    }
  }

  Widget filtredWidget() {
    switch (filterState) {
      case 1:
        return completedData.isEmpty
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2435),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    'Задачи не поставлены'))
            : Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: completedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ToDo(
                        itemName: completedData[index][1].toString(),
                        itemDescr: completedData[index][2],
                        itemCompleted: completedData[index][3],
                        onChanged: (value) =>
                            checkBoxChanged(completedData[index][0]),
                        deleteFunc: (context) =>
                            deleteTask(completedData[index][0]),
                        editFunc: () => editTask(completedData[index][0]),
                      );
                    }),
              );
      case 2:
        return notCompletedData.isEmpty
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2435),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    'Задачи не поставлены'))
            : Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: notCompletedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ToDo(
                        itemName: notCompletedData[index][1].toString(),
                        itemDescr: notCompletedData[index][2],
                        itemCompleted: notCompletedData[index][3],
                        onChanged: (value) =>
                            checkBoxChanged(notCompletedData[index][0]),
                        deleteFunc: (context) =>
                            deleteTask(notCompletedData[index][0]),
                        editFunc: () => editTask(notCompletedData[index][0]),
                      );
                    }),
              );
      default:
        return db.toDoList.isEmpty
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2435),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    'Задачи не поставлены'))
            : Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: db.toDoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ToDo(
                        itemName: db.toDoList[index][1].toString(),
                        itemDescr: db.toDoList[index][2],
                        itemCompleted: db.toDoList[index][3],
                        onChanged: (value) =>
                            checkBoxChanged(db.toDoList[index][0]),
                        deleteFunc: (context) =>
                            deleteTask(db.toDoList[index][0]),
                        editFunc: () => editTask(db.toDoList[index][0]),
                      );
                    }),
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1B28),
      appBar: AppBar(
        title: Text('ToDo list'),
        backgroundColor: thirdColor,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('Показать все')),
              PopupMenuItem(value: 1, child: Text('Завершенные')),
              PopupMenuItem(value: 2, child: Text('Не завершенные')),
            ],
            onSelected: (int value) {
              setState(() {
                filterData();
                filterState = value;
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Текущие задачи',
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
            ),
            filtredWidget(),
            Container(
              padding: const EdgeInsets.all(30.0),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: thirdColor,
        onPressed: () {
          createTask();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

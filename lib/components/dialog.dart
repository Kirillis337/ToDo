import 'package:flutter/material.dart';
import 'package:todo/utils/theme.dart';

import '../data/tododb.dart';
// ignore_for_file: prefer_const_constructors

class DialogBox extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.nameController,
    required this.descController,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  void dispose(){
    super.dispose();
  }
  ToDoDB db = ToDoDB();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return AlertDialog(

      backgroundColor: primaryColor,
      content: SizedBox(
        height: mq.size.height * 0.33,
        width: mq.size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: widget.nameController,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(color: Colors.white24),
                  hintText: 'Введите название задачи',
                  hintStyle: TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: TextField(

                controller: widget.descController,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  labelText: 'Описание',
                  labelStyle: TextStyle(color: Colors.white24),
                  hintText: 'Введите описание задачи',
                  hintStyle: TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: widget.onSave,
                    style: ElevatedButton.styleFrom(backgroundColor: thirdColor),
                    child: Text('Сохранить')),
                ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(backgroundColor: thirdColor),
                    child: Text('Отменить')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

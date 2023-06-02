import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils/theme.dart';


class ToDo extends StatelessWidget {

  String itemName;
  String itemDescr;
  bool itemCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;
  void Function()? editFunc;

  ToDo({
    super.key,
    required this.itemName,
    required this.itemDescr,
    required this.onChanged,
    required this.editFunc,
    required this.deleteFunc,
    this.itemCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      color: secondaryColor,
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),

          children: [
            SlidableAction(
              onPressed: deleteFunc,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
            )


          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Checkbox(
                side: const BorderSide(width: 1.0, color: thirdColor),
                checkColor: Colors.black,
                activeColor: thirdColor,
                value: itemCompleted,
                onChanged: onChanged),
            textColor: Colors.white70,
            iconColor: Theme
                .of(context)
                .primaryColor,

            title: Text(

              itemName,
              style: TextStyle(
                  fontSize: 20,
                  decorationThickness: 3,
                  decoration: itemCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10,),
              child: Text(
                itemDescr,
                style: TextStyle(
                    fontSize: 12,
                    decorationThickness: 3,
                    decoration: itemCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
            trailing: IconButton(
                onPressed: editFunc, icon: const Icon(Icons.edit)),
          ),
        ),
      ),
    );
  }
}


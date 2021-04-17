import 'package:flutter/material.dart';
import 'package:todo_one/globals.dart' as globals;

class SortMenu extends StatefulWidget {
  final Function sort;
  SortMenu(this.sort);

  @override
  _SortMenuState createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  var sortBy = "Estado";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      //height: 100,
      child: DropdownButton<String>(
        isExpanded: true,
        value: sortBy,
        icon: const Icon(Icons.sort),
        onChanged: (String newValue) {
          setState(() {
            sortBy = newValue;
            globals.sortBy = sortBy;
          });
        },
        items: <String>['Estado', 'Prioridad', 'Límite', 'Creación']
            .map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}

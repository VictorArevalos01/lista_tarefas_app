import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/Todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.onDelete});
  final Todo todo;
  final Function(Todo) onDelete;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SizedBox(width: 10,),
            SlidableAction(

              borderRadius: BorderRadius.circular(10),
              onPressed: (context) {

                onDelete(todo);

              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remover',
            ),
          ],
        ),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd/MMM/yyyy - HH:mm').format(todo.date),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),  // Espaço entre a data e o título
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

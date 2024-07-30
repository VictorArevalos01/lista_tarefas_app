import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/models/Todo.dart';
import 'package:lista_tarefas/repositories/todo_repository.dart';
import 'package:lista_tarefas/widgets/todo_list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletado;
  int? posicao;
  String? errorText;
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas', style: TextStyle(color: Color(0xff00d7f3)),),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Adicione uma tarefa",
                          errorText: errorText,
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff00d7f3), width: 2)
                          ),labelStyle: TextStyle(
                          color: Color(0xff00d7f3)
                        ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                          if(text.isEmpty){
                            setState(() {
                              errorText = "A tarefa não pode ser vazia";
                            });
                            return;
                          }
                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              date: DateTime.now(),
                            );
                            todos.add(newTodo);
                            errorText = null;
                          });
                          todoController.clear();
                          todoRepository.saveTodoList(todos);

                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: remove,
                        )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: mostraCaixaDialogo,
                      child: Text(
                        "Limpar tudo",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void remove(Todo todo) {
    deletado = todo;
    posicao = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
      todoRepository.saveTodoList(todos);
    });

    final snackBar = SnackBar(
      content: Text('Tarefa ${todo.title} foi removida'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.insert(posicao!, deletado!);
          });
          todoRepository.saveTodoList(todos);
        },
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void removeTudo() {
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }

  void mostraCaixaDialogo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar Tudo?'),
        content: Text("Tem certeza que deseja remover tudo?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              removeTudo();
            },
            child: Text("Limpar tudo"),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Todo.dart';
const  todoListKey = 'todo_list';
class TodoRepository{


  late SharedPreferences sharedPreferences;
  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDocoded = jsonDecode(jsonString) as List;
    return jsonDocoded.map((e) => Todo.fromJson(e)).toList();
  }
  void saveTodoList(List<Todo> todos){
    final jsonString = jsonEncode(todos);
    sharedPreferences.setString(todoListKey, jsonString);
  }
}
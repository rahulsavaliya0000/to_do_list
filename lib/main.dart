import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(
//     MaterialApp(
//       home: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TodoListApp(),
//     );
//   }
// }

// class TodoListApp extends StatefulWidget {
//   @override
//   _TodoListAppState createState() => _TodoListAppState();
// }

// class _TodoListAppState extends State<TodoListApp> {
//   List<TodoItem> _todoList = [];
//   TextEditingController _textEditingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadTodoList();
//   }

//   void _loadTodoList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? todoListStrings = prefs.getStringList('todoList');

//     if (todoListStrings != null) {
//       setState(() {
//         _todoList = todoListStrings
//             .map((todoString) => TodoItem.fromMap(jsonDecode(todoString)))
//             .toList();
//       });
//     }
//   }

//   void _saveTodoList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> todoListStrings =
//         _todoList.map((todoItem) => jsonEncode(todoItem.toMap())).toList();

//     await prefs.setStringList('todoList', todoListStrings);
//     await _saveTodoListToFile(todoListStrings);
//   }

//   Future<File> _getLocalFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return File('${directory.path}/todoList.json');
//   }

//   Future<File> _saveTodoListToFile(List<String> todoListStrings) async {
//     final file = await _getLocalFile();
//     return file.writeAsString(jsonEncode(todoListStrings));
//   }

//   Future<List<String>> _readTodoListFromFile() async {
//     try {
//       final file = await _getLocalFile();
//       final contents = await file.readAsString();
//       return List<String>.from(jsonDecode(contents));
//     } catch (e) {
//       return [];
//     }
//   }

//   void _addTodoItem(String itemText) {
//     setState(() {
//       final todoItem = TodoItem(text: itemText, isDone: false);
//       _todoList.add(todoItem);
//       _textEditingController.clear();
//       _saveTodoList();
//     });
//   }

//   void _removeTodoItem(int index) {
//     setState(() {
//       _todoList.removeAt(index);
//       _saveTodoList();
//     });
//   }

//   void _toggleTodoItem(int index) {
//     setState(() {
//       _todoList[index].isDone = !_todoList[index].isDone;
//       _saveTodoList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _todoList.length,
//               itemBuilder: (context, index) {
//                 final todoItem = _todoList[index];
//                 return ListTile(
//                   leading: Checkbox(
//                     value: todoItem.isDone,
//                     onChanged: (value) => _toggleTodoItem(index),
//                   ),
//                   title: Text(
//                     todoItem.text,
//                     style: TextStyle(
//                       decoration: todoItem.isDone
//                           ? TextDecoration.lineThrough
//                           : TextDecoration.none,
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () => _removeTodoItem(index),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textEditingController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter a task',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () => _addTodoItem(_textEditingController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TodoItem {
//   String text;
//   bool isDone;

//   TodoItem({required this.text, required this.isDone});

//   Map<String, dynamic> toMap() {
//     return {
//       'text': text,
//       'isDone': isDone,
//     };
//   }

//   factory TodoItem.fromMap(Map<String, dynamic> map) {
//     return TodoItem(
//       text: map['text'],
//       isDone: map['isDone'],
//     );
//   }
// }

//2 this code is in simple up one is hard

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(TodoListApp());
}

class TodoItem {
  final String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<TodoItem> todos = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> loadTodos() async {
    final SharedPreferences prefs = await _prefs;
    final List<String>? savedTodos = prefs.getStringList('todos');
    if (savedTodos != null) {
      setState(() {
        todos = savedTodos
            .map((todo) => TodoItem(
                  task: todo.split(':')[0],
                  isCompleted: todo.split(':')[1] == 'true',
                ))
            .toList();
      });
    }
  }

  Future<void> saveTodos() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> savedTodos =
        todos.map((todo) => '${todo.task}:${todo.isCompleted}').toList();
    await prefs.setStringList('todos', savedTodos);
  }

  void addTodo() {
    final newTodo = _textEditingController.text;
    if (newTodo.isNotEmpty) {
      setState(() {
        todos.insert(0, TodoItem(task: newTodo));
        saveTodos();
        print('/*/*/*/*/*/*/*/*/');
      });
      _textEditingController.clear();
    }
  }

  void removeTodoAtIndex(int index) {
    setState(() {
      todos.removeAt(index);
      saveTodos();
    });
  }

  void toggleTodoCompletion(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
      saveTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _prefs,
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index]; // Reverse the todos list
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTodoAtIndex(index),
                      ),
                      title: Text(
                        todo.task,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) => toggleTodoCompletion(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a Task',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    size: 28,
                    Icons.add,
                    shadows: [Shadow(blurRadius: 25, color: Colors.blueGrey)],
                    color: Color.fromRGBO(542, 56, 856, 568),
                    weight: 45,
                  ),
                  onPressed: addTodo,
                  highlightColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

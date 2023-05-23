
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:to_do_list/todoitem.dart';

// import 'main.dart';

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
//             .map((todoString) =>
//                 TodoItem.fromMap(todoString as Map<String, dynamic>))
//             .toList();
//       });
//     }
//   }

//   void _saveTodoList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<Map<String, dynamic>> todoListStrings =
//         _todoList.map((todoItem) => todoItem.toMap()).toList();

//     await prefs.setStringList('todoList', todoListStrings.cast<String>());
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

//   void _toggleTodoItem(int index) 
//   async{
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? todoListStrings = prefs.getStringList('todoList');
//     setState(() {
//       var isDone;
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
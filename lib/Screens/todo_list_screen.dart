import 'package:flutter/material.dart';
import '../components/my_drawer.dart';
import 'todo.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  List<Todo> filteredTodos = [];

  TextEditingController todoController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.grey.shade300, fontSize: 20),
        backgroundColor: Colors.black,
        title: const Text('T o D o  A p p'),
        iconTheme: IconThemeData(color: Colors.grey.shade300),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterTodos,
              style: TextStyle(
                color: Colors.grey.shade300
              ),
              decoration:  InputDecoration(
                hintText: 'Search... ToDo',
                hintStyle: TextStyle(
                  color:  Colors.grey.shade600
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                prefixIcon: const Icon(Icons.search),
                fillColor: Colors.black54,
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.shade900.withOpacity(0.9),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: _buildTodoItem(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    style: TextStyle(
                        color: Colors.grey.shade300
                    ),
                    decoration:  InputDecoration(
                      fillColor: Colors.black54,
                      filled: true,
                      hintText: 'Enter a new to-do',
                      hintStyle: TextStyle(
                          color:  Colors.grey.shade600
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.grey.shade300),
                  onPressed: addTodo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(int index) {
    return ListTile(
      title: Text(
        filteredTodos[index].title,
        style: TextStyle(
          color: filteredTodos[index].isCompleted ? Colors.grey : Colors.white,
          decoration: filteredTodos[index].isCompleted
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          filteredTodos[index].isCompleted
              ? Icons.check_circle
              : Icons.circle_outlined,
          color: Colors.grey.shade300,
        ),
        onPressed: () {
          setState(() {
            filteredTodos[index].isCompleted =
            !filteredTodos[index].isCompleted;
          });
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.grey.shade300),
        onPressed: () {
          setState(() {
            todos.remove(filteredTodos[index]);
            filterTodos(searchController.text);
          });
        },
      ),
      onTap: () {
        _editTodoDialog(index);
      },
    );
  }

  void _editTodoDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Edit To-Do',
            style: TextStyle(color: Colors.grey.shade300),
          ),
          content: TextField(
            style: TextStyle(color: Colors.grey.shade300),
            controller: TextEditingController(text: filteredTodos[index].title),
            onChanged: (value) {
              setState(() {
                filteredTodos[index].title = value;
              });
            },
          ),
          actions: [
            ElevatedButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () {
                setState(() {
                  todos[todos.indexOf(filteredTodos[index])].title =
                      filteredTodos[index].title;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void filterTodos(String query) {
    setState(() {
      filteredTodos = todos
          .where((todo) =>
          todo.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addTodo() {
    setState(() {
      if (todoController.text.isNotEmpty) {
        todos.add(Todo(title: todoController.text));
        todoController.clear();
        filterTodos(searchController.text);
      } else {
        _showAlertDialog('Please enter a task first');
      }
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text(message),
          titleTextStyle:  TextStyle(fontSize: 18,color: Colors.grey.shade300),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list/src/data/local_data_sources/models/todo_model.dart';
import 'package:todo_list/src/data/services/todo_service.dart';

class TodoFilterPage extends StatefulWidget {
  final String? filter;

  const TodoFilterPage({super.key, this.filter});

  @override
  State<TodoFilterPage> createState() => _TodoFilterPageState();
}

class _TodoFilterPageState extends State<TodoFilterPage> {
  final List<Todo> _todoList = <Todo>[];
  final TodoServices _todoServices = TodoServices();

  @override
  void initState() {
    super.initState();
    getTodosFilters();
  }

  getTodosFilters() async {
    var todos = await _todoServices.readTodoByFilter(widget.filter);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];

        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos Filters')),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: ((context, index) {
            return Card(
              elevation: 8,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_todoList[index].title.toString()),
                  ],
                ),
                subtitle: Text(_todoList[index].description.toString()),
                trailing: Text(_todoList[index].todoDate.toString()),
              ),
            );
          }),
        )),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list/src/data/local_data_sources/models/todo_model.dart';
import 'package:todo_list/src/data/services/todo_service.dart';
import 'package:todo_list/src/my_app.dart';
import 'package:todo_list/src/presentation/components/drawer_bar.dart';
import '../components/theme_store_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoServices _todoServices = TodoServices();

  final List<Todo> _todoList = <Todo>[];

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    var todos = await _todoServices.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.filter = todo['filter'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        elevation: 5,
        actions: [
          AnimatedBuilder(
            animation: themeStore,
            builder: (context, child) {
              return Switch(
                  value: themeStore.isDartTheme,
                  onChanged: (value) {
                    themeStore.shitchTheme();
                  });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyApp.TODO_PAGE);
        },
        child: const Icon(Icons.add),
      ),
      drawer: DrawerBar(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_todoList[index].title.toString()),
                  ],
                ),
                subtitle: Text(_todoList[index].filter.toString()),
                trailing: Text(_todoList[index].todoDate.toString()),
              ),
            );
          }),
    );
  }
}

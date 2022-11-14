import 'package:flutter/material.dart';
import 'package:todo_list/src/my_app.dart';
import 'package:todo_list/src/presentation/components/drawer_bar.dart';
import '../components/theme_store_widget.dart';

class HomePage extends StatelessWidget {
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
      drawer: const DrawerBar(),
    );
  }
}

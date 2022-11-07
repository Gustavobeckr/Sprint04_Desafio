import 'package:flutter/material.dart';
import 'package:todo_list/pages/home_page.dart';
import 'widgets/theme_store_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeStore,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo List',
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
          ),
          themeMode: themeStore.themeMode,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        );
      },
    );
  }
}

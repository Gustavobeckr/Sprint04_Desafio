import 'package:flutter/material.dart';
import 'package:todo_list/layers/ui/pages/home_page.dart';
import 'layers/ui/components/theme_store_widget.dart';

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
          title: 'Todo List',
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

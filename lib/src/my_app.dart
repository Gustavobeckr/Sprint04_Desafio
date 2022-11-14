import 'package:flutter/material.dart';
import 'package:todo_list/src/presentation/pages/filter_page.dart';
import 'package:todo_list/src/presentation/pages/todo_filter_page.dart';
import 'package:todo_list/src/presentation/pages/todo_page.dart';
import 'presentation/components/theme_store_widget.dart';
import 'presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  static const HOME_PAGE = '/';
  static const FILTER_PAGE = '/filter_page';
  static const TODO_PAGE = '/todo_page';
  static const TODO_FILTER_PAGE = '/todo_filter_page';

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
          initialRoute: MyApp.HOME_PAGE,
          routes: {
            HOME_PAGE: (context) => HomePage(),
            FILTER_PAGE: (context) => const FilterPage(),
            TODO_PAGE: (context) => const TodoPage(),
            TODO_FILTER_PAGE: (context) => const TodoFilterPage(),
          },
        );
      },
    );
  }
}

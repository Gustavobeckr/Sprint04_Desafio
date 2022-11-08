import 'package:flutter/material.dart';
import 'package:todo_list/src/layers/ui/pages/filter_page.dart';
import 'layers/ui/components/theme_store_widget.dart';
import 'layers/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  static const HOME_PAGE = '/';
  static const FILTER_PAGE = '/filter_page';

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
          },
        );
      },
    );
  }
}

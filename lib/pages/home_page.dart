import 'package:flutter/material.dart';
import '../widgets/theme_store_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
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
          )
        ],
      ),
    );
  }
}

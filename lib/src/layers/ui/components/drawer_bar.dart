import 'package:flutter/material.dart';
import 'package:todo_list/src/my_app.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              accountName: Text(
                'Gustavo Becker',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              accountEmail: Text(
                'gustavobecker@gmail.com',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.home),
              title: const Text('HOME'),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(MyApp.FILTER_PAGE),
              leading: const Icon(Icons.menu),
              title: const Text('Filters'),
            )
          ],
        ),
      ),
    );
  }
}

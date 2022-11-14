import 'package:flutter/material.dart';
import 'package:todo_list/src/data/services/filter_services.dart';
import 'package:todo_list/src/my_app.dart';
import 'package:todo_list/src/presentation/pages/todo_filter_page.dart';

class DrawerBar extends StatefulWidget {
  @override
  State<DrawerBar> createState() => _DrawerBarState();
}

class _DrawerBarState extends State<DrawerBar> {
  final FilterServices _filterServices = FilterServices();

  final List<Widget> _filterList = <Widget>[];

  @override
  void initState() {
    super.initState();
    getAllFilter();
  }

  getAllFilter() async {
    var filters = await _filterServices.readFilter();

    filters.forEach((filter) {
      _filterList.add(InkWell(
        onTap: (() =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TodoFilterPage(
                filter: filter['title'],
              );
            }))),
        child: ListTile(
          title: Text(filter['title']),
        ),
      ));
    });
  }

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
            ),
            const Divider(),
            Column(
              children: _filterList,
            ),
          ],
        ),
      ),
    );
  }
}

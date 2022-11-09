import 'package:flutter/material.dart';
import 'package:todo_list/src/data/services/filter/filter_model.dart';
import 'package:todo_list/src/data/services/filter/filter_services.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Filter _filter = Filter();
  final FilterServices _filterServices = FilterServices();

  _formDailog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: const Text('Add Filter'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      hintText: 'Write a title', labelText: 'Title'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description'),
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _filter.title = _titleController.text;
                    _filter.description = _descriptionController.text;
                    _filterServices.saveFilter(_filter);
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Title'),
        elevation: 5,
      ),
      body: const Center(child: Text('Titles')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formDailog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

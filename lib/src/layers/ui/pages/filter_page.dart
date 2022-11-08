import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _dateController,
                  decoration: const InputDecoration(
                    hintText: 'Write a date',
                  ),
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
                    print(
                        'Title: ${(_titleController).text}, Description: ${(_descriptionController).text}');
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

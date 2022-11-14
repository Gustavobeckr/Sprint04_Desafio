import 'package:flutter/material.dart';
import 'package:todo_list/src/data/local_data_sources/models/todo_model.dart';
import 'package:todo_list/src/data/services/filter_services.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/src/data/services/todo_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDescriptionController =
      TextEditingController();
  final TextEditingController todoDateController = TextEditingController();

  var _selectValue;

  final List<DropdownMenuItem> _filter = <DropdownMenuItem>[];

  @override
  void initState() {
    super.initState();
    _loadFilter();
  }

  _loadFilter() async {
    final FilterServices filterServices = FilterServices();

    var filters = await filterServices.readFilter();
    filters.forEach((filter) {
      setState(() {
        _filter.add(DropdownMenuItem(
          value: filter['title'],
          child: Text(filter['title']),
        ));
      });
    });
  }

  late DateTime _dataTime = DateTime.now();

  _selectTodoDate(context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: _dataTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      setState(() {
        _dataTime = pickedDate;
        todoDateController.text = DateFormat.yMMMd().format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Page')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextFormField(
            controller: todoTitleController,
            decoration: const InputDecoration(
                label: Text('Title'), hintText: 'Write Todo Title'),
          ),
          TextFormField(
            controller: todoDescriptionController,
            decoration: const InputDecoration(
                label: Text('Description'), hintText: 'Write Todo Description'),
          ),
          TextFormField(
            controller: todoDateController,
            decoration: InputDecoration(
                label: const Text('Date'),
                hintText: 'Write Todo Date',
                prefixIcon: InkWell(
                  onTap: () {
                    _selectTodoDate(context);
                  },
                  child: const Icon(Icons.calendar_today),
                )),
          ),
          DropdownButtonFormField(
            items: _filter,
            value: _selectValue,
            hint: const Text('Filter'),
            onChanged: (value) {
              setState(() {
                _selectValue = value;
              });
            },
          ),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                var todoObject = Todo();

                todoObject.title = todoTitleController.text;
                todoObject.description = todoDescriptionController.text;
                todoObject.isFinished = 0;
                todoObject.filter = _selectValue.toString();
                todoObject.todoDate = todoDateController.text;

                var todoService = TodoServices();
                var result = await todoService.saveTodo(todoObject);
                print(result);
              },
              child: const Text('Confirm'))
        ]),
      ),
    );
  }
}

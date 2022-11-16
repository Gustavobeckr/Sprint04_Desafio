import 'package:flutter/material.dart';
import 'package:todo_list/src/data/local_data_sources/models/filter_model.dart';
import 'package:todo_list/src/data/services/filter_services.dart';

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

  final List<Filter> _filterList = [];

  final TextEditingController _editTitleController = TextEditingController();
  final TextEditingController _editDescriptionController =
      TextEditingController();

  var filter;

  @override
  void initState() {
    super.initState();
    getAllFilters();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllFilters() async {
    var filters = await _filterServices.readFilter();
    filters.forEach((filter) {
      setState(() {
        var filterModel = Filter();
        filterModel.title = filter['title'];
        filterModel.description = filter['description'];
        filterModel.id = filter['id'];
        _filterList.add(filterModel);
      });
    });
  }

  _editFilter(context, filterId) async {
    filter = await _filterServices.readFilterById(filterId);
    setState(() {
      _editTitleController.text = filter[0]['title'];
      _editDescriptionController.text = filter[0]['description'];
    });
    _formEditDailog(context);
  }

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
                  onPressed: () async {
                    Navigator.pop(context);
                    _filter.title = _titleController.text;
                    _filter.description = _descriptionController.text;
                    var result = await _filterServices.saveFilter(_filter);
                    getAllFilters();
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  _formEditDailog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: const Text('Edit Filter'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: _editTitleController,
                  decoration: const InputDecoration(
                      hintText: 'Write a title', labelText: 'Title'),
                ),
                TextFormField(
                  controller: _editDescriptionController,
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
                  onPressed: () async {
                    _filter.id = filter[0]['id'];
                    _filter.title = _editTitleController.text;
                    _filter.description = _editDescriptionController.text;
                    var result = await _filterServices.editFilter(_filter);

                    if (result > 0) {
                      Navigator.pop(context);
                      getAllFilters();
                    }
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  _deleteDialog(BuildContext context, filterId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: const Text('Remove'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    var result = await _filterServices.deleteFilter(filterId);

                    if (result > 0) {
                      getAllFilters();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  _successSnackBar(message) {
    var snackBar = SnackBar(content: message);
    _globalKey.currentState!.showBottomSheet((context) => snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Filter Title'),
        elevation: 5,
      ),
      body: ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Card(
                elevation: 10,
                child: ListTile(
                  leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _editFilter(context, _filterList[index].id);
                      }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_filterList[index].title.toString()),
                      IconButton(
                          onPressed: () {
                            _deleteDialog(context, _filterList[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _formDailog(context);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

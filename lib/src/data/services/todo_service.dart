import 'package:todo_list/src/data/local_data_sources/models/todo_model.dart';
import 'package:todo_list/src/data/local_data_sources/repository.dart';

class TodoServices {
  final Repository _repository = Repository();

  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  readTodos() async {
    return await _repository.readData('todos');
  }

  readTodoByFilter(filter) async {
    return await _repository.readDateByFilter('todos', 'filter', filter);
  }
}

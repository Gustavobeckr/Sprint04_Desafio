import 'package:todo_list/src/data/local_data_sources/repository.dart';
import 'filter_model.dart';

class FilterServices {
  final Repository _repository = Repository();

  saveFilter(Filter filter) async {
    return await _repository.insertData('filters', filter.filterMap());
  }

  readFilter() async {
    return await _repository.readData('filters');
  }
}

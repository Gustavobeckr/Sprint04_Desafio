import 'package:todo_list/src/data/local_data_sources/repository.dart';
import '../local_data_sources/models/filter_model.dart';

class FilterServices {
  final Repository _repository = Repository();

  saveFilter(Filter filter) async {
    return await _repository.insertData('filters', filter.filterMap());
  }

  readFilter() async {
    return await _repository.readData('filters');
  }

  readFilterById(filterId) async {
    return await _repository.readDataById('filters', filterId);
  }

  editFilter(Filter filter) async {
    return await _repository.editData('filters', filter.filterMap());
  }

  deleteFilter(FilterId) async {
    return await _repository.deleteData('filters', FilterId);
  }
}

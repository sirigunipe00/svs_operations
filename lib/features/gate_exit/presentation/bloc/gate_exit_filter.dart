import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/cubit/base/filters_cubit.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';

class GateExitFilterCubit extends FiltersCubit {
  GateExitFilterCubit() : super(PageListFilters.initial());

  @override
  void onChangeStatus(String status) {
    final newState = state.copyWith(status: status);
    emitSafeState(newState);
  }

  @override
  void onSearch([String? query]) {
    if (query.doesNotHaveValue) {
      emitSafeState(PageListFilters(status: state.status));
    } else {
      final newState = state.copyWith(query: query);
      emitSafeState(newState);
    }
  }

  @override
  void reset() {
    emitSafeState(PageListFilters.initial());
  }
}

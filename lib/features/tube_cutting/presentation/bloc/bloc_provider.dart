import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/data/tube_cutting_repo.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operations_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';

typedef WorkOrderList
    = NetworkRequestCubit<List<WorkOrderItem>, Tuple3<String, String?, String>>;
typedef WorkOrderListState = NetworkRequestState<List<WorkOrderItem>>;

typedef GetUserOperations = NetworkRequestCubit<OperationsModel, None>;
typedef GetUserOperationsState = NetworkRequestState<OperationsModel>;

typedef OperationStatus = NetworkRequestCubit<OperationScanModel, String>;
typedef OperationStatusState = NetworkRequestState<OperationScanModel>;


typedef ChildItemStatus = NetworkRequestCubit<List<ChildStatusModel>, String>;
typedef ChildItemStatusState = NetworkRequestState<List<ChildStatusModel>>;

// typedef CreateItemCubit = NetworkRequestCubit<String, AddItemModel>;
// typedef CreateItemState = NetworkRequestState<String>;

// typedef UpdateItemCubit = NetworkRequestCubit<String, UpdateItemModel>;
// typedef UpdateItemState = NetworkRequestState<String>;

@lazySingleton
class TubeCuttingBlocProvider {
  const TubeCuttingBlocProvider(this.repo);

  final TubeCuttingRepo repo;

  static TubeCuttingBlocProvider get() => $sl.get<TubeCuttingBlocProvider>();

  WorkOrderList workOrderList() => WorkOrderList(
      onRequest: (params, state) =>
          repo.workOrderlist(params!.value1, params.value2, params.value3));

  GetUserOperations operaionsList() =>
      GetUserOperations(onRequest: (params, state) => repo.fetchOperations());

  OperationStatus getOperationsStatus() => OperationStatus(onRequest: (params, state) => repo.operationScanStatus(params!));


  ChildItemStatus childStatusCubit() => ChildItemStatus(onRequest: (params, state) => repo.getChildStatus(params!));

  // CreateItemCubit createItemCubit() => CreateItemCubit(onRequest: (params, state) => repo.createItem(params!));

  // UpdateItemCubit updateItemCubit() => UpdateItemCubit(onRequest: (params, state) => repo.updateItem(params!));
}

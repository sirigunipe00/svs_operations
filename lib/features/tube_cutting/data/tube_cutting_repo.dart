
import 'package:svs_operations/core/utils/typedefs.dart';
import 'package:svs_operations/features/tube_cutting/model/add_item_model.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operations_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';


abstract interface class TubeCuttingRepo {
  AsyncValueOf<List<WorkOrderItem>> workOrderlist(String operation, String? query, String status);
  AsyncValueOf<OperationsModel> fetchOperations();
  AsyncValueOf<OperationScanModel> operationScanStatus(String operation);
  AsyncValueOf<String> createItem(AddItemModel model);
  AsyncValueOf<String> updateItem(AddItemModel model);
  AsyncValueOf<List<ChildStatusModel>> getChildStatus(String jobCard);
}

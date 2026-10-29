import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/data/tube_cutting_repo.dart';
import 'package:svs_operations/features/tube_cutting/model/add_item_model.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operations_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';

@LazySingleton(as: TubeCuttingRepo)
class TubeCuttingRepoimpl extends BaseApiRepository implements TubeCuttingRepo {
  const TubeCuttingRepoimpl(
    super.client,
  );

  @override
  AsyncValueOf<List<WorkOrderItem>> workOrderlist(
      String operation, String? query, String status) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.jobCard,
        reqParams: {
          'fields': ['*'],
          'order_by': 'creation desc',
          'limit_page_length': 'None',
          'filters': [
            ['operation', '=', operation],
            if (status.isNotEmpty && status.toLowerCase() != 'all')
              ['status', '=', status],
          ],
          if (query != null && query.isNotEmpty)
            'or_filters': [
              ['work_order', 'like', '%$query%'],
              ['name', 'like', '%$query%'],
            ],
        },
        parser: (p0) {
          final data = p0['data'] as List<dynamic>;
          return data.map((e) => WorkOrderItem.fromJson(e)).toList();
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<OperationsModel> fetchOperations() async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.userOperations,
        reqParams: {
          'user': user().email,
          'fields': ['*'],
        },
        parser: (p0) {
          final message = p0['message'] as Map<String, dynamic>;
          final data = message['data'] as Map<String, dynamic>;

          return OperationsModel.fromJson({
            'data': data,
          });
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<OperationScanModel> operationScanStatus(String operation) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.getList,
        reqParams: {
          "doctype": "Operation",
          "fields": ["*"],
          'filters': [
            ['name', '=', operation],
          ],
        },
        parser: (p0) {
          final message = p0['message'] as List<dynamic>;

          return OperationScanModel.fromJson(
            Map<String, dynamic>.from(message.first as Map),
          );
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<List<ChildStatusModel>> getChildStatus(String jobCard) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: '${Urls.jobCard}/$jobCard',
        reqParams: {
          "doctype": "",
          "fields": ["*"],
        },
        parser: (p0) {
          final message = p0['data']['time_logs'] as List<dynamic>;
          final data = message
              .map(
                (e) => ChildStatusModel.fromJson(e),
              )
              .toList();
          return data;
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<String> createItem(AddItemModel model) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.addItem,
        body: jsonEncode({
          "job_card": model.jobCard,
          "work_order": model.workOrder,
          "operation": model.operation,
          "user": model.employee,
          "machine": model.machine,
          "input_tray": model.inputTray,
          "counter_start_readings": model.startReadings,
          "custom_cut_quantity": model.cutQnty,
          "counter_start_image": model.startImage,
        }),
        parser: (p0) {
          return p0['message']['message'] as String;
        },
      );

      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<String> updateItem(AddItemModel model) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.updateItem,
        body: jsonEncode({
          "job_card": model.jobCard,
          "work_order": model.workOrder,
          "operation": model.operation,
          "child_id": model.childId,
          "output_tray": model.outputTray,
          "counter_end_readings": model.endReadings,
          "rejection_tray": model.rejectionTray,
          "rejection_counter": model.rejectionCounter,
          "custom_scrap_kgs": model.scrapKgs,
          "rejection_tray_image": model.rejectionTrayImage,
          "counter_end_image": model.endImage,
        }),
        parser: (p0) {
          return p0['message']['message'] as String;
        },
      );

      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }
}

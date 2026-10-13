import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';
import 'package:svs_operations/features/gate_exit/data/gate_exit_repo.dart';
import 'package:svs_operations/features/gate_exit/model/gate_exit.dart';
import 'package:svs_operations/features/gate_exit/model/new_gate_exit_form.dart';

@LazySingleton(as: GateExitRepo)
class GateExitRepoImpl extends BaseApiRepository implements GateExitRepo {
  const GateExitRepoImpl(super.client);

  @override
  AsyncValueOf<List<GateExit>> fetchGateExits(
      int start, int end, PageListFilters filters) async {
    return await executeSafely(() async {
      final requestConfig = RequestConfig(
        url: Urls.gateExitList,
        parser: (json) {
          final data = json['message']['data'];
          if (data is Map<String, dynamic>) {
            return [GateExit.fromJson(data)];
          } else {
            final listdata = data as List<dynamic>;
            return listdata.map((e) => GateExit.fromJson(e)).toList();
          }
        },
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        reqParams: {
          if (filters.query.containsValidValue &&
              filters.query != null &&
              filters.query!.length >= 2) ...{
            'name': filters.query,
          },
          'status': filters.status,
          'startrow': start,
          'endrow': end,
        },
      );
      final response = await get(requestConfig);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<GateExit> getGateExit(String name) async {
    return await executeSafely(() async {
      final requestConfig = RequestConfig(
        url: Urls.getGateExit,
        parser: (json) {
          final data = json['message']['data'] as List<dynamic>;
          return GateExit.fromJson(data.firstOrNull);
        },
        reqParams: {'name': name},
      );
      final response = await get(requestConfig);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<String?> getvehicleNumber(String siNumber) async {
    return await executeSafely(() async {
      final config = RequestConfig(
          url: Urls.getVehicleNumber,
          parser: (json) {
            final data = json['message']['data'] as List<dynamic>;
            if (data.isEmpty) return null;
            final vechileNo = data.first['vehicle_no'] as String?;
            return vechileNo.valueOrEmpty;
          },
          reqParams: {'si_number': siNumber});
      $logger.devLog(config);

      final response = await get(config);
      return response.process((r) => right(r.data));
    });
  }

  @override
  AsyncValueOf<Pair<String, String>> createGateExit(
      NewGateExitForm form) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.newGateExit,
        parser: (json) {
          final data = json['message']['data'];
          if (data is Map<String, dynamic>) {
            return data['name'] as String?;
          } else {
            final listData = data as List<dynamic>;
            return listData.first['name'] as String?;
          }
        },
        body: jsonEncode(form.toJson()),
      );

      final response = await post(config);
      return response.process((docNo) {
        final msgWithDocNo =
            """The Gate Exit details "${docNo.data}" have been saved successfully. Please submit it before leaving""";
        return right(Pair(docNo.data.valueOrEmpty, msgWithDocNo));
      });
    });
  }

  @override
  AsyncValueOf<Pair<String, String>> submitGateExit(
      NewGateExitForm form) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.submitGateExit,
        parser: (json) {
          final data = json['message']['data'];
          if (data is Map<String, dynamic>) {
            return data['name'] as String?;
          } else {
            final listData = data as List<dynamic>;
            return listData.first['name'] as String?;
          }
        },
        body: jsonEncode(form.toJson()),
      );
      $logger.devLog(config);
      final response = await post(config);
      return response.process((docNo) {
        final msgWithDocNo =
            """Gate Exit "${docNo.data}" Submitted successfully.""";
        return right(Pair(docNo.data.valueOrEmpty, msgWithDocNo));
      });
    });
  }
}

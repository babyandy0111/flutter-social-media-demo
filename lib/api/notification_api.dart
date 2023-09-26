// Dart imports:
import 'dart:async';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/notification_model/notification_model.dart';
import '../utils/http/http_utils.dart';

// final apiService Provider((ref)=>PoductAPI());

final apiService = Provider((ref) => NotificationAPI());

class NotificationAPI {
  Future<List<NotificationModel>> fetchProducts(
      {required int pageIndex, required int pageSize}) async {
    var response = await HttpUtils.get(
        path:
            'https://jsonplaceholder.typicode.com/photos?_start=$pageIndex&_limit=$pageSize');
    var modelList = List<NotificationModel>.from(
        response.map((x) => NotificationModel.fromJson(x)));
    return modelList;
  }
}

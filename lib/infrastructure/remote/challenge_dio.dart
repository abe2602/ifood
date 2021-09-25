import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:domain/exceptions.dart';

class ChallengeDio extends DioForNative {
  ChallengeDio(BaseOptions options) : super(options);

  @override
  Future<Response<T>> request<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await super.request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
    } catch (error) {
      if (error is DioError && error.error is SocketException) {
        throw NoConnectionException();
      } else {
        rethrow;
      }
    }
  }
}

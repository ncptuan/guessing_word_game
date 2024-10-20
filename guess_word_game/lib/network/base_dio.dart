import 'package:dio/dio.dart';

import '../models/model.dart';

int _connectTimeOut = 15000;
int _receiveTimeOut = 15000;
int _sendTimeOut = 10000;

class BaseDio {
  Dio dio = Dio();
  final String baseUrl;
  int? connectTimeOut;
  int? receiveTimeOut;
  int? sendTimeOut;

  BaseDio(
    this.baseUrl, {
    this.connectTimeOut,
    this.receiveTimeOut,
    this.sendTimeOut,
  }) {
    final BaseOptions options = BaseOptions(
      connectTimeout: Duration(
        milliseconds: connectTimeOut ?? _connectTimeOut,
      ),
      receiveTimeout: Duration(
        milliseconds: receiveTimeOut ?? _receiveTimeOut,
      ),
      sendTimeout: Duration(
        milliseconds: sendTimeOut ?? _sendTimeOut,
      ),
      baseUrl: baseUrl,
    );
    dio = Dio(options);
  }

  Future<Response?> request({
    required Method method,
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      Options options = Options(
        method: method.getMethodValue(),
        headers: headers,
      );
      Response response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      return null;
    }
  }
}

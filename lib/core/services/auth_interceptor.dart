import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'token_manager.dart';

class AuthInterceptor extends Interceptor {
  // Get the token and add it to the request headers
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get token from secure storage
    String? token = await TokenManager.getToken();

    // If the token is available, add it to the Authorization header
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  // You can implement other methods like onResponse or onError if necessary
  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}

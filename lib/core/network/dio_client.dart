import 'dart:async';
import 'package:dio/dio.dart';

import '../connectivity /connectivity_service.dart';

class DioClient {
  final Dio dio;
  final ConnectivityService connectivityService;

  DioClient({
    required this.connectivityService,
  }) : dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    // 1. Auth + common headers
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // TODO: inject token from secure storage
          final token = await _getAuthToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Content-Type'] = 'application/json';

          handler.next(options);
        },
      ),
    );

    // 2. Logging (dev only)
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    // 3. Connectivity guard + retry
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          // If no connectivity, fail fast with domain error
          final isOnline = connectivityService.isOnline;
          if (!isOnline) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                type: DioExceptionType.connectionError,
                error: 'No internet connection',
              ),
            );
          }

          // Retry only for transient errors
          final shouldRetry = _shouldRetry(error);
          if (shouldRetry) {
            try {
              final response = await _retry(error.requestOptions);
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(error);
            }
          }

          handler.next(error);
        },
      ),
    );
  }

  bool _shouldRetry(DioException error) {
    // Retry on timeouts + 5xx
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return true;
    }

    final status = error.response?.statusCode ?? 0;
    return status >= 500;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Simple exponential backoff
    await Future.delayed(const Duration(seconds: 2));

    return dio.fetch(requestOptions);
  }

  Future<String?> _getAuthToken() async {
    // TODO: FlutterSecureStorage or similar
    return null;
  }
}

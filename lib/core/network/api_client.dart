import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiClient {
  final DioClient dioClient;

  ApiClient(this.dioClient);

  Future<Response<T>> get<T>(String path) {
    return dioClient.dio.get<T>(path);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return dioClient.dio.post<T>(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) {
    return dioClient.dio.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path) {
    return dioClient.dio.delete<T>(path);
  }
}

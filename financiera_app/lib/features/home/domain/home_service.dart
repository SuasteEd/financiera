import 'package:dio/dio.dart';
import 'package:financiera_app/core/utils/shared_prefs.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';
import 'package:financiera_app/features/login/domain/user_model.dart';

class HomeService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://64.23.214.143:8951/api'));
  // final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<ClientResponse>?> getClients() async {
    try {
      final prefs = Sharedprefs();
      final token = prefs.token;
      final response = await _dio.get(
        '/clients',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        final clients =
            data.map((client) => ClientResponse.fromJson(client)).toList();
        return clients;
      }

      return null;
    } on DioException catch (e) {
      print('Error al iniciar sesión: ${e.response?.data ?? e.message}');
      return null;
    }
  }

  Future<bool> postClient(ClientResponse client) async {
    try {
      final prefs = Sharedprefs();
      final token = prefs.token;
      final response = await _dio.post(
        '/clients',
        data: client.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      print('Error al iniciar sesión: ${e.response?.data ?? e.message}');
      return false;
    }
  }


  Future<bool> putClient(ClientResponse client) async {
    try {
      final prefs = Sharedprefs();
      final token = prefs.token;
      final response = await _dio.put(
        '/clients/${client.id}',
        data: client.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      print('Error al iniciar sesión: ${e.response?.data ?? e.message}');
      return false;
    }
  }
}

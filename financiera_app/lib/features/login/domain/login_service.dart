import 'package:dio/dio.dart';
import 'package:financiera_app/core/utils/shared_prefs.dart';
import 'package:financiera_app/features/login/domain/user_model.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://64.23.214.143:8951/api'));
  // final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<UserModel?> login(String email, String password) async {
    try {
      final prefs = Sharedprefs();
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // final user = response.data['user'];
        final token = response.data['token'];
        prefs.token = token;
        print('Token guardado: $token');
        final user = UserModel.fromJson(response.data['user']);
        print('Usuario: ${user}');
        return user;
      }

      return null;
    } on DioException catch (e) {
      print('Error al iniciar sesión: ${e.response?.data ?? e.message}');
      return null;
    }
  }
}

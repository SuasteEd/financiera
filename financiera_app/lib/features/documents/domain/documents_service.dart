import 'package:dio/dio.dart';
import 'package:financiera_app/core/utils/shared_prefs.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';

class DocService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://64.23.214.143:8951/api'));

  // Método para obtener documentos
  Future<List<ClientResponse>?> getDocuments(int id) async {
    try {
      final prefs = Sharedprefs();
      final token = prefs.token;
      final response = await _dio.get(
        '/clients/$id/documents',
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
      print('Error al obtener documentos: ${e.response?.data ?? e.message}');
      return null;
    }
  }

  // Método para subir un archivo
  Future<bool> uploadDocument({
    required int clientId,
    required String filePath,
    required String type,
  }) async {
    try {
      final prefs = Sharedprefs();
      final token = prefs.token;

      // Crear el archivo y el formulario de datos
      FormData formData = FormData.fromMap({
        'type': type,
        'file': await MultipartFile.fromFile(filePath, filename: 'file'),
      });

      // Enviar la solicitud de carga
      final response = await _dio.post(
        '/clients/$clientId/documents',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Verificar la respuesta
      if (response.statusCode == 200) {
        print('Documento subido exitosamente');
        return true;
      } else {
        print('Error al subir documento: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('Error al subir documento: ${e.response?.data ?? e.message}');
      return false;
    }
  }
}

import 'dart:io';
import 'package:dio/dio.dart';

class UploadService {
  final Dio _dio;

  UploadService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
              ),
            );

  Future<Map<String, dynamic>> uploadPhoto(
    File file, {
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      final fileName = file.path.split(Platform.pathSeparator).last;

      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(file.path, filename: fileName),
        'uploaded_at': DateTime.now().toIso8601String(),
        'source': 'photo_gallery_camera_app',
      });

      final response = await _dio.post(
        'https://postman-echo.com/post',
        data: formData,
        onSendProgress: onProgress,
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data as Map);
      }
      throw Exception('Upload gagal (status ${response.statusCode})');
    } on DioException catch (e) {
      throw Exception(_mapError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan saat upload: $e');
    }
  }

  String _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Upload timeout. Periksa jaringan internet Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server upload.';
      case DioExceptionType.badResponse:
        return 'Server upload error: ${e.response?.statusCode}';
      default:
        return 'Gagal upload: ${e.message}';
    }
  }
}

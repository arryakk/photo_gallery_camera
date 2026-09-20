import 'package:dio/dio.dart';
import '../models/photo_model.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
              ),
            );

  Future<List<Photo>> fetchPhotos({int page = 1, int limit = 100}) async {
    try {
      final response = await _dio.get(
        'https://picsum.photos/v2/list',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data
            .map((item) => Photo.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Gagal memuat data (status ${response.statusCode})');
    } on DioException catch (e) {
      throw Exception(_mapError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  String _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi timeout. Periksa jaringan internet Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server. Periksa koneksi internet.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}';
      default:
        return 'Gagal mengambil data: ${e.message}';
    }
  }
}

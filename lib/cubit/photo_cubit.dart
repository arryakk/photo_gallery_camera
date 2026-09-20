import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/photo_model.dart';
import '../services/api_service.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final ApiService _apiService;

  PhotoCubit({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(const PhotoInitial());

  Future<void> fetchPhotos() async {
    emit(const PhotoLoading());
    try {
      final photos = await _apiService.fetchPhotos(page: 1, limit: 100);
      emit(PhotoLoaded(allPhotos: photos, filteredPhotos: photos));
    } catch (e) {
      emit(PhotoError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> refreshPhotos() async {
    try {
      final photos = await _apiService.fetchPhotos(page: 1, limit: 100);
      final currentState = state;
      final query = currentState is PhotoLoaded ? currentState.query : '';
      emit(PhotoLoaded(
        allPhotos: photos,
        filteredPhotos: _applyFilter(photos, query),
        query: query,
      ));
    } catch (e) {
      emit(PhotoError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void searchPhotos(String query) {
    final currentState = state;
    if (currentState is PhotoLoaded) {
      emit(currentState.copyWith(
        query: query,
        filteredPhotos: _applyFilter(currentState.allPhotos, query),
      ));
    }
  }

  List<Photo> _applyFilter(List<Photo> photos, String query) {
    if (query.trim().isEmpty) return photos;
    final lowerQuery = query.toLowerCase();
    return photos
        .where((photo) =>
            photo.author.toLowerCase().contains(lowerQuery) ||
            photo.id.toLowerCase().contains(lowerQuery))
        .toList();
  }
}

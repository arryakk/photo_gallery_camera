import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/photo_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteInitial());

  List<Photo> get _currentFavorites {
    final currentState = state;
    if (currentState is FavoriteLoaded) return currentState.favorites;
    return const [];
  }

  bool isFavorite(String photoId) {
    return _currentFavorites.any((photo) => photo.id == photoId);
  }

  void toggleFavorite(Photo photo) {
    final favorites = List<Photo>.from(_currentFavorites);
    final index = favorites.indexWhere((p) => p.id == photo.id);
    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(photo);
    }
    emit(FavoriteLoaded(favorites));
  }

  void removeFavorite(String photoId) {
    final favorites = List<Photo>.from(_currentFavorites)
      ..removeWhere((p) => p.id == photoId);
    emit(FavoriteLoaded(favorites));
  }
}

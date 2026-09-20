import 'package:equatable/equatable.dart';
import '../models/photo_model.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {
  const PhotoInitial();
}

class PhotoLoading extends PhotoState {
  const PhotoLoading();
}

class PhotoLoaded extends PhotoState {
  final List<Photo> allPhotos;
  final List<Photo> filteredPhotos;
  final String query;

  const PhotoLoaded({
    required this.allPhotos,
    required this.filteredPhotos,
    this.query = '',
  });

  PhotoLoaded copyWith({
    List<Photo>? allPhotos,
    List<Photo>? filteredPhotos,
    String? query,
  }) {
    return PhotoLoaded(
      allPhotos: allPhotos ?? this.allPhotos,
      filteredPhotos: filteredPhotos ?? this.filteredPhotos,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [allPhotos, filteredPhotos, query];
}

class PhotoError extends PhotoState {
  final String message;

  const PhotoError(this.message);

  @override
  List<Object?> get props => [message];
}

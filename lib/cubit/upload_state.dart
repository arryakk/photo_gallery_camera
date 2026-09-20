import 'package:equatable/equatable.dart';

class UploadHistoryItem extends Equatable {
  final String fileName;
  final int fileSizeBytes;
  final DateTime uploadedAt;
  final bool success;

  const UploadHistoryItem({
    required this.fileName,
    required this.fileSizeBytes,
    required this.uploadedAt,
    required this.success,
  });

  @override
  List<Object?> get props => [fileName, fileSizeBytes, uploadedAt, success];
}

abstract class UploadState extends Equatable {
  final List<UploadHistoryItem> history;

  const UploadState({this.history = const []});

  @override
  List<Object?> get props => [history];
}

class UploadInitial extends UploadState {
  const UploadInitial({super.history});
}

class Uploading extends UploadState {
  final double progress;

  const Uploading({this.progress = 0, super.history});

  @override
  List<Object?> get props => [progress, history];
}

class UploadSuccess extends UploadState {
  final Map<String, dynamic> response;

  const UploadSuccess(this.response, {super.history});

  @override
  List<Object?> get props => [response, history];
}

class UploadFailed extends UploadState {
  final String message;

  const UploadFailed(this.message, {super.history});

  @override
  List<Object?> get props => [message, history];
}

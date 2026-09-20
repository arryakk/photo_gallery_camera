import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/upload_service.dart';
import 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final UploadService _uploadService;

  UploadCubit({UploadService? uploadService})
      : _uploadService = uploadService ?? UploadService(),
        super(const UploadInitial());

  Future<void> uploadPhoto(File file) async {
    final currentHistory = state.history;
    emit(Uploading(progress: 0, history: currentHistory));

    final fileName = file.path.split(Platform.pathSeparator).last;
    final fileSize = await file.length();

    try {
      final response = await _uploadService.uploadPhoto(
        file,
        onProgress: (sent, total) {
          if (total > 0) {
            final progress = sent / total;
            emit(Uploading(progress: progress, history: currentHistory));
          }
        },
      );

      final newHistory = List<UploadHistoryItem>.from(currentHistory)
        ..insert(
          0,
          UploadHistoryItem(
            fileName: fileName,
            fileSizeBytes: fileSize,
            uploadedAt: DateTime.now(),
            success: true,
          ),
        );

      emit(UploadSuccess(response, history: newHistory));
    } catch (e) {
      final newHistory = List<UploadHistoryItem>.from(currentHistory)
        ..insert(
          0,
          UploadHistoryItem(
            fileName: fileName,
            fileSizeBytes: fileSize,
            uploadedAt: DateTime.now(),
            success: false,
          ),
        );

      emit(UploadFailed(
        e.toString().replaceFirst('Exception: ', ''),
        history: newHistory,
      ));
    }
  }

  void reset() {
    emit(UploadInitial(history: state.history));
  }
}

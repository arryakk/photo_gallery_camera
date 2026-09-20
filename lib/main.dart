import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/photo_cubit.dart';
import 'cubit/favorite_cubit.dart';
import 'cubit/upload_cubit.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PhotoGalleryCameraApp());
}

class PhotoGalleryCameraApp extends StatelessWidget {
  const PhotoGalleryCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PhotoCubit()..fetchPhotos()),
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => UploadCubit()),
      ],
      child: MaterialApp.router(
        title: 'Photo Gallery Camera',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}

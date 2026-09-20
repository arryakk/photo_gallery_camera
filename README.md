# Photo Gallery Camera

Aplikasi Flutter untuk tugas kuliah yang mencakup:
- Render Page
- Routing & Navigation (go_router + Bottom Navigation Bar)
- Network & Data Fetching (Dio)
- External Sensor: Camera (image_picker)
- State Management (flutter_bloc / Cubit)

## Struktur Folder

```
lib/
├── main.dart
├── routes/
│   └── app_router.dart
├── models/
│   └── photo_model.dart
├── services/
│   ├── api_service.dart
│   └── upload_service.dart
├── cubit/
│   ├── photo_cubit.dart
│   ├── photo_state.dart
│   ├── upload_cubit.dart
│   ├── upload_state.dart
│   ├── favorite_cubit.dart
│   └── favorite_state.dart
├── pages/
│   ├── home_page.dart
│   ├── detail_page.dart
│   ├── camera_page.dart
│   ├── favorite_page.dart
│   └── about_page.dart
├── widgets/
│   ├── photo_card.dart
│   ├── loading_shimmer.dart
│   ├── custom_app_bar.dart
│   ├── empty_state.dart
│   └── error_state.dart
└── theme/
    └── app_theme.dart
```

## Cara Menjalankan

Karena folder native (`android/`, `ios/`, `web/`, dll) hanya dihasilkan oleh Flutter SDK
melalui `flutter create`, ikuti langkah berikut:

1. Buat project Flutter kosong baru (untuk mendapatkan folder native):
   ```bash
   flutter create photo_gallery_camera
   ```

2. Salin/timpa isi folder `lib/`, folder `test/`, dan file `pubspec.yaml` dari paket ini
   ke dalam project yang baru dibuat (timpa file yang sudah ada).

3. Install dependency:
   ```bash
   flutter pub get
   ```

4. **Tambahkan izin native** (WAJIB agar kamera & internet berfungsi):

   ### Android — `android/app/src/main/AndroidManifest.xml`
   Tambahkan di dalam tag `<manifest>` (sebelum tag `<application>`):
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-feature android:name="android.hardware.camera" android:required="false" />
   ```

   Pastikan `minSdkVersion` di `android/app/build.gradle` minimal **21**.

   ### iOS — `ios/Runner/Info.plist`
   Tambahkan di dalam tag `<dict>`:
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>Aplikasi memerlukan akses kamera untuk mengambil foto.</string>
   <key>NSPhotoLibraryUsageDescription</key>
   <string>Aplikasi memerlukan akses galeri untuk menyimpan foto.</string>
   ```

5. Jalankan aplikasi:
   ```bash
   flutter run
   ```

   Untuk web (fitur kamera akan menggunakan file picker browser):
   ```bash
   flutter run -d chrome
   ```

## Endpoint API

- **List Foto:** `GET https://picsum.photos/v2/list?page=1&limit=100`
- **Upload Foto:** `POST https://httpbin.org/post` (multipart/form-data)

## Cubit & State

### PhotoCubit
`PhotoInitial` → `PhotoLoading` → `PhotoLoaded` / `PhotoError`

### UploadCubit
`UploadInitial` → `Uploading(progress)` → `UploadSuccess` / `UploadFailed`
(setiap state membawa `history: List<UploadHistoryItem>` untuk fitur Upload History)

### FavoriteCubit
`FavoriteInitial` → `FavoriteLoaded(favorites)`

## Routing (go_router)

Menggunakan `StatefulShellRoute.indexedStack` agar Bottom Navigation Bar
mempertahankan state tiap tab (Gallery, Favorites, About).

| Path        | Halaman      | Keterangan                              |
|-------------|--------------|-------------------------------------------|
| `/`         | HomePage     | Tab Gallery — grid foto, search, statistik|
| `/favorite` | FavoritePage | Tab Favorites — daftar foto favorit       |
| `/about`    | AboutPage    | Tab About — info aplikasi & mahasiswa     |
| `/detail`   | DetailPage   | Detail foto (full screen, `extra: Photo`) |
| `/camera`   | CameraPage   | Ambil & upload foto (full screen)         |

Floating Action Button kamera tersedia secara global di semua tab.

## Fitur Utama

- **Home:** loading shimmer, error state, empty state, pull-to-refresh, search
  realtime, grid responsif (2 kolom di HP, hingga 5 kolom di layar lebar),
  hero animation, favorite button, statistics card (Total/Favorite/Uploaded).
- **Detail:** hero animation, tombol Add to Favorite, tombol Open Camera, dan
  tap gambar untuk membuka fullscreen viewer dengan `InteractiveViewer` (zoom).
- **Camera:** ambil foto, retake, tampilkan ukuran file & waktu pengambilan,
  upload dengan progress indicator + loading overlay, dialog sukses/gagal,
  serta riwayat upload (Upload History).
- **Favorite:** grid foto favorit dengan tombol hapus, empty state.
- **About:** identitas aplikasi, info mahasiswa, dan daftar teknologi.
- **Dark Mode:** otomatis mengikuti tema sistem (`ThemeMode.system`).

## Catatan

- Fitur kamera memerlukan **perangkat fisik** atau emulator dengan dukungan kamera.
- Di web/desktop, `image_picker` akan membuka dialog pemilihan file sebagai fallback.
- Data favorit dan riwayat upload disimpan di memori (in-memory state via Cubit),
  sehingga akan reset saat aplikasi ditutup — cocok untuk kebutuhan tugas kuliah.
  Untuk persistensi permanen, dapat dikembangkan lebih lanjut menggunakan
  `shared_preferences` atau database lokal seperti `sqflite`/`hive`.


# PHOTO GALLERY CAMERA

Aplikasi Flutter untuk tugas praktikum Pemrograman Mobile yang menyediakan fitur galeri foto, pencarian foto, detail foto, kamera, upload foto, dan daftar foto favorit.

## Pengembang

- **Nama:** Arya Dipta
- **Akun GitHub:** [arryakk](https://github.com/arryakk)

## Deskripsi

PHOTO GALLERY CAMERA merupakan aplikasi mobile berbasis Flutter yang dikembangkan untuk mempraktikkan beberapa konsep pemrograman mobile, yaitu:

- Render Page
- Routing dan Navigation menggunakan `go_router`
- Bottom Navigation Bar
- Network dan Data Fetching menggunakan Dio
- External Sensor: Camera menggunakan `image_picker`
- State Management menggunakan `flutter_bloc` dan Cubit
- Pengelolaan foto favorit
- Upload foto

## Status Proyek

Proyek awal perkuliahan dan pengembangan aplikasi Flutter.

## Fitur Utama

### 1. Gallery

- Menampilkan koleksi foto dari Lorem Picsum API.
- Menampilkan foto dalam bentuk grid responsif.
- Menampilkan loading shimmer.
- Menampilkan error state dan empty state.
- Mendukung pull-to-refresh.
- Pencarian foto secara realtime.
- Menampilkan statistik foto, favorit, dan upload.

### 2. Detail Foto

- Menampilkan detail foto.
- Menambahkan foto ke daftar favorit.
- Membuka kamera dari halaman detail.
- Membuka foto dalam tampilan fullscreen.
- Mendukung zoom menggunakan `InteractiveViewer`.

### 3. Camera dan Upload

- Mengambil foto menggunakan kamera perangkat.
- Memilih foto melalui file picker sebagai fallback pada web atau desktop.
- Melakukan retake foto.
- Menampilkan ukuran file dan waktu pengambilan.
- Mengunggah foto dengan indikator progress.
- Menampilkan dialog hasil upload.
- Menampilkan riwayat upload.

### 4. Favorite

- Menampilkan daftar foto favorit.
- Menghapus foto dari daftar favorit.
- Menampilkan empty state ketika belum ada foto favorit.

### 5. About

- Menampilkan informasi aplikasi.
- Menampilkan informasi pengembang.
- Menampilkan teknologi yang digunakan.

### 6. Dark Mode

- Mengikuti tema sistem perangkat secara otomatis.

## Teknologi yang Digunakan

- **Framework:** Flutter
- **Bahasa Pemrograman:** Dart
- **State Management:** flutter_bloc / Cubit
- **HTTP Client:** Dio
- **Routing:** go_router
- **Camera dan Image Picker:** image_picker
- **API Foto:** Lorem Picsum
- **Version Control:** Git dan GitHub

## Struktur Folder

```text
lib/
├── main.dart
├── routes/
│   └── app_router.dart
├── models/
│   └── photo_model.dart
├── services/
│   ├── api_service.dart
│   ├── photo_service.dart
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

### 1. Clone Repository

```bash
git clone https://github.com/arryakk/photo_gallery_camera.git
```

### 2. Masuk ke Folder Proyek

```bash
cd photo_gallery_camera
```

### 3. Install Dependency

```bash
flutter pub get
```

### 4. Jalankan Aplikasi

Untuk menjalankan pada perangkat atau emulator:

```bash
flutter run
```

Untuk menjalankan pada browser Chrome:

```bash
flutter run -d chrome
```

## Endpoint API

### List Foto

```http
GET https://picsum.photos/v2/list?page=1&limit=100
```

API ini digunakan untuk mengambil daftar foto yang ditampilkan pada halaman Gallery.

### Upload Foto

```http
POST https://httpbin.org/post
```

Endpoint upload digunakan untuk menguji proses pengiriman foto menggunakan metode multipart/form-data.

> Pastikan endpoint upload yang digunakan dalam kode aplikasi sesuai dengan konfigurasi pada file service proyek.

## Routing

Aplikasi menggunakan `go_router` dan `StatefulShellRoute.indexedStack` untuk mempertahankan state pada setiap tab Bottom Navigation Bar.

| Path | Halaman | Keterangan |
|---|---|---|
| `/` | HomePage | Gallery dan daftar foto |
| `/favorite` | FavoritePage | Daftar foto favorit |
| `/about` | AboutPage | Informasi aplikasi dan pengembang |
| `/detail` | DetailPage | Detail foto |
| `/camera` | CameraPage | Pengambilan dan upload foto |

## State Management

### PhotoCubit

```text
PhotoInitial
    → PhotoLoading
    → PhotoLoaded / PhotoError
```

### UploadCubit

```text
UploadInitial
    → Uploading(progress)
    → UploadSuccess / UploadFailed
```

Upload state juga menyimpan riwayat upload sesuai implementasi aplikasi.

### FavoriteCubit

```text
FavoriteInitial
    → FavoriteLoaded(favorites)
```

## Konfigurasi Kamera dan Internet

### Android

Pastikan izin kamera dan internet sudah tersedia pada:

```text
android/app/src/main/AndroidManifest.xml
```

Izin yang dibutuhkan:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature
    android:name="android.hardware.camera"
    android:required="false" />
```

### iOS

Pastikan deskripsi penggunaan kamera dan galeri telah ditambahkan pada:

```text
ios/Runner/Info.plist
```

> Konfigurasi native perlu disesuaikan dengan platform dan kebutuhan aplikasi.

## Catatan

- Fitur kamera sebaiknya diuji menggunakan perangkat fisik atau emulator yang mendukung kamera.
- Pada web atau desktop, `image_picker` dapat menggunakan dialog pemilihan file sebagai fallback.
- Data favorit dan riwayat upload disimpan dalam memori melalui Cubit, sehingga dapat di-reset ketika aplikasi ditutup.
- Penyimpanan permanen dapat dikembangkan menggunakan `shared_preferences`, `sqflite`, atau `hive`.

## Repository GitHub

[https://github.com/arryakk/photo_gallery_camera](https://github.com/arryakk/photo_gallery_camera)
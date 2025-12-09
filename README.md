
# ChanMovie - Aplikasi Film dan Serial TV

Aplikasi mobile Flutter untuk menjelajahi film dan serial TV terbaru dengan fitur pencarian dan detail lengkap.

## Penjelasan Aplikasi

ChanMovie adalah aplikasi mobile yang dibangun dengan Flutter untuk platform Android dan iOS. Aplikasi ini memungkinkan pengguna untuk:

- Menjelajahi Film: Lihat film populer, sedang tayang, dan rating tertinggi
- Menjelajahi Serial TV: Temukan serial TV populer, rating tertinggi, dan yang sedang tayang
- Pencarian: Cari film atau serial TV berdasarkan judul
- Detail Lengkap: Lihat informasi detail, poster, rating, dan deskripsi
- Trending: Lihat konten yang sedang tren mingguan atau harian

## Demo

[![Demo Video](https://img.youtube.com/vi/UP5PGvU6RPg/maxresdefault.jpg)](https://youtu.be/UP5PGvU6RPg)

[![Laporan UAS](https://docs.google.com/document/d/1wbFAlnBex3sRCDDQ0zN5Ql13kCaTD5EhoMg1IZDBR-s/edit?pli=1&tab=t.0)

### Fitur Utama
- UI responsif dengan tema gelap  
- Pencarian real-time  
- Loading indicator dan error handling  
- Navigasi yang lancar dengan tab  
- Detail lengkap film dan serial TV  
- Arsitektur terpisah (Service layer dan UI layer)

## Daftar Endpoint API yang Digunakan

Aplikasi ini menggunakan The Movie Database (TMDB) API v3 sebagai sumber data utama.

### Movie Endpoints
1. **Popular Movies**  
   Endpoint: `GET /movie/popular`  
   URL: `https://api.themoviedb.org/3/movie/popular?api_key={API_KEY}`

2. **Now Playing Movies**  
   Endpoint: `GET /movie/now_playing`  
   URL: `https://api.themoviedb.org/3/movie/now_playing?api_key={API_KEY}`

3. **Top Rated Movies**  
   Endpoint: `GET /movie/top_rated`  
   URL: `https://api.themoviedb.org/3/movie/top_rated?api_key={API_KEY}`

### TV Series Endpoints
1. **Popular TV Series**  
   Endpoint: `GET /tv/popular`  
   URL: `https://api.themoviedb.org/3/tv/popular?api_key={API_KEY}`

2. **Top Rated TV Series**  
   Endpoint: `GET /tv/top_rated`  
   URL: `https://api.themoviedb.org/3/tv/top_rated?api_key={API_KEY}`

3. **On The Air TV Series**  
   Endpoint: `GET /tv/on_the_air`  
   URL: `https://api.themoviedb.org/3/tv/on_the_air?api_key={API_KEY}`

### Trending Endpoints
1. **Trending All (Week)**  
   Endpoint: `GET /trending/all/week`  
   URL: `https://api.themoviedb.org/3/trending/all/week?api_key={API_KEY}`

2. **Trending All (Day)**  
   Endpoint: `GET /trending/all/day`  
   URL: `https://api.themoviedb.org/3/trending/all/day?api_key={API_KEY}`

### Search Endpoints
1. **Multi Search**  
   Endpoint: `GET /search/multi`  
   URL: `https://api.themoviedb.org/3/search/multi?api_key={API_KEY}&query={SEARCH_QUERY}`

## Cara Instalasi

### Persyaratan Sistem
- Flutter SDK (versi 2.17.0 atau lebih baru)
- Dart SDK
- Android Studio atau VS Code
- Device Android/iOS atau emulator

### Langkah Instalasi

1. Clone Repository:
   ```bash
   git clone https://github.com/username/chanmovie.git
   cd chanmovie
   ```

2. Install Dependencies:

   ```bash
   flutter pub get
   ```

3. Setup API Key TMDB:

   * Daftar akun di TMDB
   * Dapatkan API Key dari Settings > API
   * Buka file `lib/apikey/apikey.dart`
   * Ganti nilai berikut:

     ```dart
     const String apikey = 'YOUR_API_KEY_HERE';
     ```

4. Jalankan Aplikasi:

   ```bash
   flutter run
   ```

### Build untuk Production

Android APK:

```bash
flutter build apk --release
```

iOS (hanya di macOS):

```bash
flutter build ios --release
```

## Struktur Proyek

```
lib/
├── apikey/
│   └── apikey.dart              # API Key TMDB
├── Auth/                        # Halaman autentikasi
├── DetailScreen/                # Detail film dan serial TV
├── HomePage/                    # Halaman utama
├── Models/                      # Model data (Movie, TV Series, Trending)
├── RepeatedFunction/            # Komponen reusable
├── SectionHomeUi/               # Section UI utama
├── Services/                    # Service layer untuk API calls
│   ├── movie_service.dart
│   ├── tv_series_service.dart
│   ├── search_service.dart
│   └── trending_service.dart
├── SqfLitelocalstorage/         # Local storage
└── main.dart                    # Entry point aplikasi
```

## Teknologi yang Digunakan

* Framework: Flutter
* Bahasa: Dart
* State Management: StatefulWidget + setState
* HTTP Client: http package
* Local Storage: Shared Preferences, SQFlite
* API: The Movie Database (TMDB) API v3
* UI Components: Material Design

## Dependencies Utama

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  animated_splash_screen: ^1.3.0
  carousel_slider: ^5.0.0
  fluttertoast: ^8.1.2
  font_awesome_flutter: ^10.3.0
  http: ^1.1.2
  image_cropper: ^8.0.2
  image_picker: ^1.0.5
  path_provider: ^2.0.11
  shared_preferences: ^2.1.2
  sqflite: ^2.2.2
  url_launcher: ^6.1.7
  webview_flutter: ^4.4.2
  youtube_player_flutter: ^9.1.0
```

## Troubleshooting

### Invalid API key

* Pastikan API Key TMDB sudah benar pada file `lib/apikey/apikey.dart`
* Periksa apakah API Key masih aktif

### Network request failed

* Periksa koneksi internet
* Layanan TMDB mungkin sedang tidak tersedia

### Build Error

* Jalankan `flutter clean` lalu `flutter pub get`
* Pastikan Flutter SDK versi terbaru

## Lisensi

Proyek ini menggunakan lisensi MIT. Informasi lebih detail tersedia pada file `LICENSE`.

## Kontribusi

Kontribusi sangat diterima. Silakan buat Issue atau Pull Request untuk perbaikan atau penambahan fitur.

## Kontak

Jika ada pertanyaan, silakan hubungi developer atau buat issue di repository ini.

---

Dibangun menggunakan Flutter.

```

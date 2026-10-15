# BinaCare — Aplikasi Layanan Konseling Siswa

## Deskripsi

BinaCare merupakan aplikasi layanan konseling siswa berbasis mobile yang dikembangkan menggunakan Flutter dan bahasa pemrograman Dart. Aplikasi ini dirancang untuk membantu siswa mengajukan konseling kepada Guru Bimbingan dan Konseling (Guru BK) serta membantu Guru BK mengelola pengajuan konseling.

Aplikasi memiliki dua peran pengguna, yaitu Siswa dan Guru BK.

## Fitur Aplikasi

### 1. Login dan Register
- Halaman Login dengan pilihan peran Siswa dan Guru BK.
- Halaman Register dengan formulir sesuai peran pengguna.
- Validasi input pada formulir.

### 2. Dashboard Siswa
- Menampilkan menu layanan konseling.
- Mengakses halaman pengajuan konseling.
- Menampilkan menu status, jadwal, dan riwayat konseling sesuai halaman yang tersedia.

### 3. Pengajuan Konseling
- Mengisi keperluan dan cerita permasalahan.
- Memilih Guru BK.
- Memilih jadwal konseling.
- Validasi sederhana sebelum pengajuan dikirim.

### 4. Dashboard Guru BK
- Melihat daftar pengajuan konseling.
- Melihat detail pengajuan siswa.
- Menerima atau menolak pengajuan.
- Menentukan tanggal, waktu, dan tempat untuk pengajuan yang diterima.

### 5. Jadwal Konseling Guru BK
- Melihat pengajuan yang telah diterima dan memiliki jadwal.
- Memfilter jadwal berdasarkan kategori Semua, Mendatang, dan Selesai.

### 6. Data Siswa
- Melihat daftar siswa berdasarkan data pengajuan konseling.
- Melihat detail informasi siswa.

### 7. Riwayat Konseling Guru BK
- Melihat pengajuan yang telah diproses.
- Memfilter riwayat berdasarkan status Diterima dan Ditolak.
- Menampilkan jadwal untuk pengajuan yang diterima dan alasan penolakan untuk pengajuan yang ditolak.

## Teknologi yang Digunakan
- Flutter
- Dart
- Visual Studio Code
- Git dan GitHub

## Struktur Proyek

Proyek BinaCare memiliki struktur utama Flutter yang terdiri dari folder `lib` untuk kode aplikasi, folder platform untuk menjalankan aplikasi, serta file konfigurasi proyek.

- `lib/` — Berisi kode sumber dan halaman aplikasi.
- `android/` — Berisi konfigurasi platform Android.
- `web/` — Berisi konfigurasi platform web.
- `test/` — Berisi file pengujian.
- `pubspec.yaml` — Berisi konfigurasi proyek dan dependensi Flutter.
- `README.md` — Dokumentasi proyek.

## Cara Menjalankan Aplikasi

1. Clone repositori GitHub:

   `git clone https://github.com/2413025066/BinaCare.git`

2. Masuk ke folder proyek:

   `cd BinaCare`

3. Unduh dependensi:

   `flutter pub get`

4. Jalankan aplikasi:

   `flutter run`

Pastikan Flutter SDK telah terpasang dan emulator atau perangkat telah disiapkan.

## Batasan Pengembangan

Aplikasi masih berupa prototype. Beberapa fitur menggunakan data sementara (*mock data*) dan belum tersimpan secara permanen. Integrasi Firebase Authentication dan Cloud Firestore belum dilakukan. Fitur lain seperti notifikasi, pencatatan hasil konseling, dan tindak lanjut dapat dikembangkan pada tahap berikutnya.

## Pengembang

- Nama: Dinda Aulia Natasya
- NPM: 2413025066
- Kelas: PTI 24B
- Program Studi: Pendidikan Teknologi Informasi
- Universitas: Universitas Lampung
- Mata Kuliah: Mobile Programming
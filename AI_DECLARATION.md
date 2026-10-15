# AI DECLARATION — BINACARE

## 1. Informasi Proyek

- **Nama Proyek:** BinaCare — Aplikasi Layanan Konseling Siswa
- **Nama Pengembang:** Dinda Aulia Natasya
- **NPM:** 2413025066
- **Kelas:** PTI 24B
- **Program Studi:** Pendidikan Teknologi Informasi
- **Universitas:** Universitas Lampung
- **Mata Kuliah:** Mobile Programming
- **Teknologi:** Flutter dan Dart
- **Repositori GitHub:** https://github.com/2413025066/BinaCare

## 2. Daftar Alat AI yang Digunakan

Alat kecerdasan buatan (AI) yang digunakan selama proses pengembangan aplikasi BinaCare adalah **ChatGPT dari OpenAI**.

ChatGPT digunakan sebagai alat bantu dalam memahami kode Flutter dan Dart, mencari solusi terhadap kendala pemrograman, menyempurnakan tampilan antarmuka, mengembangkan alur fitur, serta menyusun dokumentasi proyek.

Penggunaan AI dilakukan sebagai pendukung proses pembelajaran dan pengembangan aplikasi. Saran yang diberikan tetap perlu ditinjau dan disesuaikan dengan kebutuhan proyek.

## 3. Pembagian Peran Pengembangan

### A. Modul yang Mendapat Bantuan AI

**1. Halaman Login dan Register**

AI membantu memberikan saran untuk menyempurnakan tampilan halaman Login dan Register agar lebih ringkas dan rapi. Bantuan juga mencakup penyusunan formulir, validasi input, pilihan peran Siswa dan Guru BK, serta navigasi menuju halaman yang sesuai.

**2. Dashboard Siswa**

AI membantu memberikan saran untuk penyempurnaan tampilan Dashboard Siswa dan penyusunan menu layanan agar informasi lebih terstruktur dan mudah diakses.

**3. Pengajuan Konseling**

AI membantu memahami alur pengajuan konseling, penyusunan formulir, pemilihan Guru BK, pemilihan jadwal, dan validasi input sebelum pengajuan dikirim.

**4. Dashboard Guru BK**

AI membantu memberikan saran untuk pengembangan tampilan dashboard, penyajian daftar pengajuan konseling, penampilan detail pengajuan, serta interaksi dasar untuk menerima atau menolak pengajuan.

**5. Jadwal Konseling Guru BK**

AI membantu memberikan saran mengenai penyajian jadwal konseling dan penyaringan jadwal berdasarkan kategori yang tersedia.

**6. Data Siswa**

AI membantu memberikan saran untuk penyajian daftar siswa berdasarkan data pengajuan konseling dan tampilan detail informasi siswa.

**7. Riwayat Konseling Guru BK**

AI membantu memberikan saran mengenai penyajian pengajuan yang telah diproses, status pengajuan, jadwal untuk pengajuan yang diterima, dan alasan penolakan untuk pengajuan yang ditolak.

**8. Pemecahan Masalah Kode**

AI membantu menjelaskan kesalahan kode Flutter dan memberikan alternatif perbaikan. Salah satu kendala yang pernah dibahas adalah penggunaan `const` pada teks yang memuat variabel dinamis di Dashboard Guru BK.

**9. Dokumentasi Proyek**

AI membantu menyusun dan merapikan dokumentasi, termasuk `README.md`, `AI_DECLARATION.md`, dan laporan progres pengembangan aplikasi BinaCare.

### B. Peran dan Pekerjaan Pengembang

Pengembang bertanggung jawab terhadap proses pengembangan dan hasil akhir aplikasi BinaCare, meliputi:

1. Menentukan kebutuhan dan tujuan pengembangan aplikasi.
2. Membuat dan mengelola proyek Flutter.
3. Menyesuaikan kode dengan struktur dan kebutuhan proyek.
4. Mengatur serta memeriksa navigasi ant halaman.
5. Meninjau saran AI sebelum menerapkannya pada aplikasi.
6. Menjalankan aplikasi untuk memeriksa hasil implementasi.
7. Memperbaiki bagian yang tidak sesuai dengan kebutuhan aplikasi.
8. Mengelola kode sumber menggunakan Git dan GitHub.
9. Memastikan dokumentasi sesuai dengan kondisi aplikasi yang sebenarnya.

AI berperan sebagai alat bantu, sedangkan pengembang bertanggung jawab untuk memahami, meninjau, dan memeriksa hasil implementasi. Pembagian tersebut tidak berarti seluruh kode pada modul yang disebutkan dibuat oleh AI.

## 4. Studi Kasus Prompting

### Studi Kasus 1 — Penyempurnaan Tampilan Login dan Register

**A. Permasalahan**

Pada proses pengembangan aplikasi BinaCare, tampilan halaman Login dan Register perlu disempurnakan agar lebih ringkas dan rapi. Perubahan tampilan perlu tetap mempertahankan fungsi utama, seperti pilihan peran pengguna, validasi formulir, dan navigasi ant halaman.

**B. Contoh Prompt**

> Bantu sesuaikan tampilan halaman Login dan Register pada aplikasi BinaCare menggunakan Flutter agar lebih ringkas dan rapi. Pertahankan fungsi utama, validasi formulir, pilihan peran Siswa dan Guru BK, serta navigasi menuju halaman yang sesuai.

**C. Hasil Awal dari AI**

AI memberikan saran penyesuaian kode Flutter, terutama pada ukuran komponen, jarak antarelemen, susunan formulir, dan tampilan tombol agar halaman terlihat lebih ringkas.

**D. Penyesuaian oleh Pengembang**

Saran yang diberikan disesuaikan dengan struktur halaman Login dan Register yang digunakan dalam proyek BinaCare. Bagian tampilan dirapikan dengan tetap memperhatikan fungsi formulir, pilihan peran, validasi input, dan navigasi. Fungsi yang tersedia perlu diperiksa kembali setelah perubahan diterapkan.

**E. Hasil Pengembangan**

Halaman Login dan Register telah disesuaikan menjadi lebih ringkas. Penyempurnaan dilakukan pada tampilan antarmuka tanpa mengubah tujuan utama halaman tersebut.

### Studi Kasus 2 — Perbaikan Kesalahan Penggunaan `const` pada Dashboard Guru BK

**A. Permasalahan**

Ketika mengembangkan Dashboard Guru BK, ditemukan kesalahan penggunaan `const` pada teks yang memuat variabel dinamis. Kesalahan tersebut perlu diperbaiki agar halaman dapat dijalankan kembali.

**B. Contoh Prompt**

> Saya sedang mengembangkan Dashboard Guru BK menggunakan Flutter. Terdapat kesalahan penggunaan `const` pada teks yang memuat variabel dinamis. Bantu jelaskan penyebab kesalahan tersebut dan berikan solusi perbaikannya.

**C. Hasil Awal dari AI**

AI menjelaskan bahwa `const` digunakan untuk objek yang nilainya dapat ditentukan secara konstan. Pada widget yang bergantung pada nilai dinamis, penggunaan `const` perlu disesuaikan dengan kondisi kode.

**D. Penyesuaian oleh Pengembang**

Perbaikan dilakukan dengan menghapus `const` pada bagian kode yang memuat variabel dinamis. Setelah perubahan diterapkan, Dashboard Guru BK dijalankan kembali untuk memeriksa apakah kesalahan tersebut sudah teratasi.

**E. Hasil Pengembangan**

Kesalahan penggunaan `const` berhasil diperbaiki sehingga Dashboard Guru BK dapat dijalankan kembali.

**Catatan studi kasus:** Prompt di atas dirumuskan kembali untuk dokumentasi berdasarkan pekerjaan yang pernah dibahas selama pengembangan BinaCare, bukan kutipan persis dari riwayat percakapan. Hasil awal AI dan penyesuaian yang dicantumkan harus sesuai dengan proses yang benar-benar dilakukan. Jika diperlukan, bukti dapat dilengkapi dengan potongan kode sebelum dan sesudah perubahan.

## 5. Batasan Penggunaan AI

Penggunaan AI dalam pengembangan BinaCare memiliki beberapa batasan:

1. Saran AI tidak selalu dapat langsung diterapkan dan perlu disesuaikan dengan struktur proyek.
2. Kode yang diperoleh melalui bantuan AI perlu diperiksa dan diuji.
3. AI digunakan sebagai alat bantu pembelajaran, bukan pengganti pemahaman pengembang terhadap kode.
4. Beberapa fitur masih menggunakan data sementara sehingga perubahan data belum tersimpan secara permanen.
5. Firebase Authentication dan Cloud Firestore belum terintegrasi pada tahap pengembangan yang didokumentasikan.
6. Fitur lanjutan, seperti notifikasi, penyimpanan permanen hasil konseling, dan tindak lanjut konseling, masih memerlukan pengembangan lebih lanjut.

## 6. Pernyataan Transparansi

Dokumen ini dibuat sebagai bentuk transparansi penggunaan AI selama proses pengembangan aplikasi BinaCare. ChatGPT digunakan untuk membantu memahami kode, mencari alternatif penyelesaian masalah, menyempurnakan tampilan antarmuka, mengembangkan alur fitur, dan menyusun dokumentasi.

Pengembang bertanggung jawab untuk meninjau saran AI, menyesuaikan implementasi dengan kebutuhan aplikasi, memahami kode yang digunakan, serta memeriksa hasil pengembangan.

Dokumen ini disusun untuk menjelaskan bentuk bantuan AI yang digunakan dan tanggung jawab pengembang terhadap proses implementasi, pengujian, serta hasil akhir proyek BinaCare.

import 'package:flutter/material.dart';

class JadwalGuruPage extends StatefulWidget {
  final List<Map<String, String>> daftarPengajuan;

  const JadwalGuruPage({
    super.key,
    required this.daftarPengajuan,
  });

  @override
  State<JadwalGuruPage> createState() => _JadwalGuruPageState();
}

class _JadwalGuruPageState extends State<JadwalGuruPage> {
  static const Color biru = Color(0xFF2F6FA3);
  static const Color biruGelap = Color(0xFF214F82);
  static const Color latar = Color(0xFFF5F8FC);
  static const Color teks = Color(0xFF202B3C);
  static const Color teksSekunder = Color(0xFF778396);
  static const Color garis = Color(0xFFE7EDF4);

  String _filter = 'Semua';

  List<Map<String, String>> get _semuaJadwal {
    final data = widget.daftarPengajuan.where((item) {
      return item['status'] == 'Diterima' &&
          item['jadwalTanggal'] != null;
    }).toList();

    data.sort((a, b) {
      final tanggalA = _parseTanggal(a['jadwalTanggal'] ?? '');
      final tanggalB = _parseTanggal(b['jadwalTanggal'] ?? '');

      if (tanggalA == null && tanggalB == null) return 0;
      if (tanggalA == null) return 1;
      if (tanggalB == null) return -1;

      return tanggalA.compareTo(tanggalB);
    });

    return data;
  }

  List<Map<String, String>> get _jadwal {
    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);

    if (_filter == 'Mendatang') {
      return _semuaJadwal.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal'] ?? '');
        return tanggal != null && !tanggal.isBefore(hariIni);
      }).toList();
    }

    if (_filter == 'Selesai') {
      return _semuaJadwal.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal'] ?? '');
        return tanggal != null && tanggal.isBefore(hariIni);
      }).toList();
    }

    return _semuaJadwal;
  }

  DateTime? _parseTanggal(String value) {
    const bulan = <String, int>{
      'Januari': 1,
      'Februari': 2,
      'Maret': 3,
      'April': 4,
      'Mei': 5,
      'Juni': 6,
      'Juli': 7,
      'Agustus': 8,
      'September': 9,
      'Oktober': 10,
      'November': 11,
      'Desember': 12,
    };

    final bagian = value.trim().split(RegExp(r'\s+'));
    if (bagian.length != 3) return null;

    final hari = int.tryParse(bagian[0]);
    final nomorBulan = bulan[bagian[1]];
    final tahun = int.tryParse(bagian[2]);

    if (hari == null || nomorBulan == null || tahun == null) {
      return null;
    }

    final hasil = DateTime(tahun, nomorBulan, hari);

    if (hasil.day != hari ||
        hasil.month != nomorBulan ||
        hasil.year != tahun) {
      return null;
    }

    return hasil;
  }

  int _jumlahFilter(String filter) {
    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);

    if (filter == 'Mendatang') {
      return _semuaJadwal.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal'] ?? '');
        return tanggal != null && !tanggal.isBefore(hariIni);
      }).length;
    }

    if (filter == 'Selesai') {
      return _semuaJadwal.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal'] ?? '');
        return tanggal != null && tanggal.isBefore(hariIni);
      }).length;
    }

    return _semuaJadwal.length;
  }

  @override
  Widget build(BuildContext context) {
    final jadwal = _jadwal;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: teks),
        title: const Text(
          'Jadwal Konseling',
          style: TextStyle(
            color: teks,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                children: [
                  _bannerJadwal(),
                  const SizedBox(height: 24),
                  const Text(
                    'Ringkasan Jadwal',
                    style: TextStyle(
                      color: teks,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Expanded(
                        child: _kartuRingkasan(
                          judul: 'Semua',
                          jumlah: _jumlahFilter('Semua'),
                          ikon: Icons.calendar_month_rounded,
                          warna: biru,
                          warnaLatar: const Color(0xFFEAF3FA),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _kartuRingkasan(
                          judul: 'Mendatang',
                          jumlah: _jumlahFilter('Mendatang'),
                          ikon: Icons.event_available_rounded,
                          warna: const Color(0xFF218653),
                          warnaLatar: const Color(0xFFE5F6EC),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _kartuRingkasan(
                          judul: 'Selesai',
                          jumlah: _jumlahFilter('Selesai'),
                          ikon: Icons.history_rounded,
                          warna: const Color(0xFF8A63B8),
                          warnaLatar: const Color(0xFFF0EAFE),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Daftar Jadwal',
                    style: TextStyle(
                      color: teks,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _filterJadwal(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Jadwal konseling siswa',
                          style: TextStyle(
                            color: teksSekunder,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${jadwal.length} jadwal',
                          style: const TextStyle(
                            color: biru,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  if (jadwal.isEmpty)
                    _tampilanKosong()
                  else
                    ...jadwal.map(_kartuJadwal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerJadwal() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF347DB6), biruGelap],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: biru.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            color: Color(0xFFFFD88A),
                            size: 14,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Manajemen Konseling',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Jadwal Guru BK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pantau jadwal konseling dan persiapkan '
                      'layanan terbaik untuk siswa.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.88),
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kartuRingkasan({
    required String judul,
    required int jumlah,
    required IconData ikon,
    required Color warna,
    required Color warnaLatar,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: garis),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF253858).withOpacity(0.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: warnaLatar,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(ikon, color: warna, size: 19),
          ),
          const SizedBox(height: 12),
          Text(
            '$jumlah',
            style: TextStyle(
              color: warna,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            judul,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: teksSekunder,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterJadwal() {
    const pilihan = ['Semua', 'Mendatang', 'Selesai'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: pilihan.map((label) {
          final aktif = _filter == label;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              avatar: aktif
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
              label: Text(label),
              selected: aktif,
              showCheckmark: false,
              selectedColor: biru,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: aktif ? biru : garis,
              ),
              labelStyle: TextStyle(
                color: aktif ? Colors.white : teks,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 7,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              onSelected: (_) {
                setState(() => _filter = label);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _tampilanKosong() {
    String pesan;

    if (_filter == 'Selesai') {
      pesan = 'Belum ada jadwal konseling yang lewat.';
    } else if (_filter == 'Mendatang') {
      pesan = 'Belum ada jadwal konseling mendatang.';
    } else {
      pesan = 'Jadwal akan muncul setelah pengajuan siswa '
          'diterima dan tanggal konseling ditentukan.';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 34),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: garis),
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF3FA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.event_note_rounded,
              size: 40,
              color: biru,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Belum Ada Jadwal',
            style: TextStyle(
              color: teks,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            pesan,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: teksSekunder,
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuJadwal(Map<String, String> item) {
    final tanggal = _parseTanggal(item['jadwalTanggal'] ?? '');
    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final selesai = tanggal != null && tanggal.isBefore(hariIni);

    final tanggalTeks = item['jadwalTanggal'] ?? '-';
    final bagianTanggal = tanggalTeks.split(' ');
    final nomorHari =
        bagianTanggal.isNotEmpty ? bagianTanggal.first : '-';
    final namaBulan =
        bagianTanggal.length > 1 ? bagianTanggal[1] : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: garis),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF253858).withOpacity(0.035),
            blurRadius: 13,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: selesai
                      ? const Color(0xFFF0EAFE)
                      : const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      nomorHari,
                      style: TextStyle(
                        color: selesai
                            ? const Color(0xFF8A63B8)
                            : biru,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      namaBulan,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: selesai
                            ? const Color(0xFF8A63B8)
                            : biru,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nama'] ?? '-',
                      style: const TextStyle(
                        color: teks,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Kelas ${item['kelas'] ?? '-'}',
                      style: const TextStyle(
                        color: teksSekunder,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: selesai
                            ? const Color(0xFFF0EAFE)
                            : const Color(0xFFE5F6EC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            selesai
                                ? Icons.check_circle_outline_rounded
                                : Icons.event_available_rounded,
                            size: 13,
                            color: selesai
                                ? const Color(0xFF8A63B8)
                                : const Color(0xFF218653),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            selesai ? 'Tanggal terlewati' : 'Terjadwal',
                            style: TextStyle(
                              color: selesai
                                  ? const Color(0xFF8A63B8)
                                  : const Color(0xFF218653),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: garis),
          ),
          _infoJadwal(
            Icons.access_time_rounded,
            'Waktu',
            item['jadwalWaktu'] ?? '-',
          ),
          _infoJadwal(
            Icons.location_on_outlined,
            'Tempat',
            item['jadwalTempat'] ?? '-',
          ),
          _infoJadwal(
            Icons.chat_bubble_outline_rounded,
            'Keperluan',
            item['alasan'] ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _infoJadwal(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: biru,
              size: 18,
            ),
          ),
          const SizedBox(width: 11),
          SizedBox(
            width: 65,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: const TextStyle(
                  color: teksSekunder,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                value,
                style: const TextStyle(
                  color: teks,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


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
  static const Color latar = Color(0xFFF6F8FA);
  static const Color teks = Color(0xFF202124);

  String _filter = 'Semua';

  List<Map<String, String>> get _jadwal {
    final data = widget.daftarPengajuan.where((item) {
      return item['status'] == 'Diterima' &&
          item['jadwalTanggal'] != null;
    }).toList();

    if (_filter == 'Mendatang') {
      final sekarang = DateTime.now();

      return data.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal']!);
        return tanggal != null &&
            !tanggal.isBefore(
              DateTime(sekarang.year, sekarang.month, sekarang.day),
            );
      }).toList();
    }

    if (_filter == 'Selesai') {
      final sekarang = DateTime.now();

      return data.where((item) {
        final tanggal = _parseTanggal(item['jadwalTanggal']!);
        return tanggal != null &&
            tanggal.isBefore(
              DateTime(sekarang.year, sekarang.month, sekarang.day),
            );
      }).toList();
    }

    return data;
  }

  DateTime? _parseTanggal(String value) {
    const bulan = {
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

    final bagian = value.split(' ');
    if (bagian.length != 3) return null;

    final hari = int.tryParse(bagian[0]);
    final nomorBulan = bulan[bagian[1]];
    final tahun = int.tryParse(bagian[2]);

    if (hari == null || nomorBulan == null || tahun == null) {
      return null;
    }

    return DateTime(tahun, nomorBulan, hari);
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
        title: const Text(
          'Jadwal Konseling',
          style: TextStyle(
            color: teks,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: teks),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: biru,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jadwal Guru BK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Kelola jadwal konseling siswa '
                          'yang telah diterima.',
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  _filterChip('Semua'),
                  _filterChip('Mendatang'),
                  _filterChip('Selesai'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: Text(
                'Daftar Jadwal (${jadwal.length})',
                style: const TextStyle(
                  color: teks,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: jadwal.isEmpty
                  ? _tampilanKosong()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        24,
                      ),
                      itemCount: jadwal.length,
                      itemBuilder: (context, index) {
                        return _kartuJadwal(jadwal[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label) {
    final aktif = _filter == label;

    return ChoiceChip(
      label: Text(label),
      selected: aktif,
      selectedColor: biru,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: aktif ? Colors.white : teks,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) {
        setState(() => _filter = label);
      },
    );
  }

  Widget _tampilanKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 68,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Jadwal',
              style: TextStyle(
                color: teks,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _filter == 'Selesai'
                  ? 'Belum ada jadwal konseling yang lewat.'
                  : _filter == 'Mendatang'
                      ? 'Belum ada jadwal konseling mendatang.'
                      : 'Terima pengajuan siswa dan atur jadwal '
                          'untuk menampilkannya di sini.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuJadwal(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: biru.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: biru,
                  size: 27,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kelas ${item['kelas'] ?? '-'}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.check_circle,
                color: Color(0xFF218653),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1),
          ),
          _infoJadwal(
            Icons.calendar_month_outlined,
            'Tanggal',
            item['jadwalTanggal'] ?? '-',
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
            Icons.chat_bubble_outline,
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: biru),
          const SizedBox(width: 10),
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: teks,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
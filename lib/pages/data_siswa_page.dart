
import 'package:flutter/material.dart';

class DataSiswaPage extends StatelessWidget {
  final List<Map<String, String>> daftarPengajuan;

  const DataSiswaPage({
    super.key,
    required this.daftarPengajuan,
  });

  static const Color biru = Color(0xFF2F6FA3);
  static const Color latar = Color(0xFFF6F8FA);
  static const Color teks = Color(0xFF202124);

  // Mengambil siswa berdasarkan nama dan kelas agar tidak berulang.
  List<Map<String, String>> get _daftarSiswa {
    final Map<String, Map<String, String>> siswaUnik = {};

    for (final pengajuan in daftarPengajuan) {
      final nama = pengajuan['nama'] ?? '';
      final kelas = pengajuan['kelas'] ?? '';
      final kunci = '$nama-$kelas';

      if (nama.isNotEmpty) {
        siswaUnik.putIfAbsent(kunci, () => pengajuan);
      }
    }

    return siswaUnik.values.toList();
  }

  Color _warnaStatus(String status) {
    switch (status) {
      case 'Diterima':
        return const Color(0xFF218653);
      case 'Ditolak':
        return Colors.red.shade700;
      default:
        return const Color(0xFFB7791F);
    }
  }

  Color _latarStatus(String status) {
    switch (status) {
      case 'Diterima':
        return const Color(0xFFE7F6EC);
      case 'Ditolak':
        return const Color(0xFFFDECEC);
      default:
        return const Color(0xFFFFF4DB);
    }
  }

  void _lihatDetail(
    BuildContext context,
    Map<String, String> siswa,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Siswa',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: teks,
                    ),
                  ),
                  const SizedBox(height: 22),
                  _detail(
                    Icons.person_outline,
                    'Nama Siswa',
                    siswa['nama'] ?? '-',
                  ),
                  _detail(
                    Icons.school_outlined,
                    'Kelas',
                    siswa['kelas'] ?? '-',
                  ),
                  _detail(
                    Icons.chat_bubble_outline,
                    'Keperluan Konseling',
                    siswa['alasan'] ?? '-',
                  ),
                  _detail(
                    Icons.calendar_today_outlined,
                    'Tanggal Pengajuan',
                    siswa['tanggal'] ?? '-',
                  ),
                  _detail(
                    Icons.info_outline,
                    'Status Pengajuan',
                    siswa['status'] ?? '-',
                  ),
                  if (siswa['status'] == 'Diterima' &&
                      siswa['jadwalTanggal'] != null) ...[
                    _detail(
                      Icons.calendar_month_outlined,
                      'Tanggal Konseling',
                      siswa['jadwalTanggal']!,
                    ),
                    _detail(
                      Icons.access_time,
                      'Waktu Konseling',
                      siswa['jadwalWaktu'] ?? '-',
                    ),
                    _detail(
                      Icons.location_on_outlined,
                      'Tempat Konseling',
                      siswa['jadwalTempat'] ?? '-',
                    ),
                  ],
                  if (siswa['status'] == 'Ditolak' &&
                      siswa['alasanPenolakan'] != null)
                    _detail(
                      Icons.info_outline,
                      'Alasan Penolakan',
                      siswa['alasanPenolakan']!,
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detail(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: biru, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: teks,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final siswa = _daftarSiswa;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: teks),
        title: const Text(
          'Data Siswa',
          style: TextStyle(
            color: teks,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: biru,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Siswa Konseling',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Siswa yang tercatat pernah '
                          'mengajukan konseling.',
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
                    Icons.groups_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Daftar Siswa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${siswa.length} siswa',
                      style: const TextStyle(
                        color: biru,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: siswa.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 14),
                            Text(
                              'Belum Ada Data Siswa',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: teks,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Data siswa akan muncul setelah '
                              'ada pengajuan konseling.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16, 0, 16, 24,
                      ),
                      itemCount: siswa.length,
                      itemBuilder: (context, index) {
                        final item = siswa[index];
                        final status = item['status'] ?? 'Menunggu';

                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                            side: const BorderSide(
                              color: Color(0xFFE5E7EB),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(17),
                            onTap: () => _lihatDetail(context, item),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        const Color(0xFFEAF3FA),
                                    child: Text(
                                      (item['nama'] ?? '?')[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: biru,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['nama'] ?? '-',
                                          style: const TextStyle(
                                            color: teks,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Kelas ${item['kelas'] ?? '-'}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          item['alasan'] ?? '-',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: teks,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 9),
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 9,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _latarStatus(status),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            status,
                                            style: TextStyle(
                                              color: _warnaStatus(status),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

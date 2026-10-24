
import 'package:flutter/material.dart';

class DataSiswaPage extends StatefulWidget {
  final List<Map<String, String>> daftarPengajuan;

  const DataSiswaPage({
    super.key,
    required this.daftarPengajuan,
  });

  @override
  State<DataSiswaPage> createState() => _DataSiswaPageState();
}

class _DataSiswaPageState extends State<DataSiswaPage> {
  static const Color biru = Color(0xFF2F6FA3);
  static const Color biruGelap = Color(0xFF214F82);
  static const Color latar = Color(0xFFF5F8FC);
  static const Color teks = Color(0xFF202B3C);
  static const Color teksSekunder = Color(0xFF778396);
  static const Color garis = Color(0xFFE7EDF4);

  final TextEditingController _pencarianController =
      TextEditingController();

  String _kataKunci = '';
  String _filterStatus = 'Semua';

  List<Map<String, String>> get _daftarSiswa {
    final Map<String, Map<String, String>> siswaUnik = {};

    for (final pengajuan in widget.daftarPengajuan) {
      final nama = (pengajuan['nama'] ?? '').trim();
      final kelas = (pengajuan['kelas'] ?? '').trim();

      if (nama.isEmpty) continue;

      final kunci = '${nama.toLowerCase()}-${kelas.toLowerCase()}';

      if (!siswaUnik.containsKey(kunci)) {
        siswaUnik[kunci] = Map<String, String>.from(pengajuan);
      } else {
        // Simpan pengajuan terbaru yang ditemukan untuk siswa yang sama.
        // Data di sini tetap berupa data sementara dari daftar pengajuan.
        siswaUnik[kunci] = Map<String, String>.from(pengajuan);
      }
    }

    return siswaUnik.values.toList();
  }

  List<Map<String, String>> get _siswaTersaring {
    return _daftarSiswa.where((siswa) {
      final nama = (siswa['nama'] ?? '').toLowerCase();
      final kelas = (siswa['kelas'] ?? '').toLowerCase();
      final kata = _kataKunci.toLowerCase().trim();
      final status = siswa['status'] ?? 'Menunggu';

      final cocokPencarian =
          nama.contains(kata) || kelas.contains(kata);

      final cocokStatus =
          _filterStatus == 'Semua' || status == _filterStatus;

      return cocokPencarian && cocokStatus;
    }).toList();
  }

  int _jumlahStatus(String status) {
    if (status == 'Semua') return _daftarSiswa.length;

    return _daftarSiswa
        .where((siswa) => (siswa['status'] ?? 'Menunggu') == status)
        .length;
  }

  Color _warnaStatus(String status) {
    switch (status) {
      case 'Diterima':
        return const Color(0xFF218653);
      case 'Ditolak':
        return const Color(0xFFD64545);
      default:
        return const Color(0xFFB7791F);
    }
  }

  Color _latarStatus(String status) {
    switch (status) {
      case 'Diterima':
        return const Color(0xFFE5F6EC);
      case 'Ditolak':
        return const Color(0xFFFDECEC);
      default:
        return const Color(0xFFFFF4DB);
    }
  }

  IconData _ikonStatus(String status) {
    switch (status) {
      case 'Diterima':
        return Icons.check_circle_rounded;
      case 'Ditolak':
        return Icons.cancel_rounded;
      default:
        return Icons.hourglass_top_rounded;
    }
  }

  String _inisial(String nama) {
    final namaBersih = nama.trim();

    if (namaBersih.isEmpty) return '?';

    final bagian = namaBersih
        .split(RegExp(r'\s+'))
        .where((kata) => kata.isNotEmpty)
        .toList();

    if (bagian.length >= 2) {
      return '${bagian[0][0]}${bagian[1][0]}'.toUpperCase();
    }

    return bagian.first[0].toUpperCase();
  }

  void _lihatDetail(Map<String, String> siswa) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final status = siswa['status'] ?? 'Menunggu';

        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(sheetContext).size.height * 0.85,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDE4EC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'Detail Siswa',
                    style: TextStyle(
                      color: teks,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF347DB6), biruGelap],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white.withOpacity(0.18),
                          child: Text(
                            _inisial(siswa['nama'] ?? ''),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                siswa['nama'] ?? '-',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Kelas ${siswa['kelas'] ?? '-'}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _detailItem(
                    Icons.chat_bubble_outline_rounded,
                    'Keperluan Konseling',
                    siswa['alasan'] ?? '-',
                  ),
                  _detailItem(
                    Icons.calendar_today_outlined,
                    'Tanggal Pengajuan',
                    siswa['tanggal'] ?? '-',
                  ),
                  _detailItem(
                    Icons.info_outline_rounded,
                    'Status Pengajuan',
                    status,
                  ),
                  if (status == 'Diterima' &&
                      siswa['jadwalTanggal'] != null) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Divider(color: garis),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Informasi Jadwal',
                      style: TextStyle(
                        color: teks,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _detailItem(
                      Icons.calendar_month_rounded,
                      'Tanggal Konseling',
                      siswa['jadwalTanggal'] ?? '-',
                    ),
                    _detailItem(
                      Icons.access_time_rounded,
                      'Waktu Konseling',
                      siswa['jadwalWaktu'] ?? '-',
                    ),
                    _detailItem(
                      Icons.location_on_outlined,
                      'Tempat Konseling',
                      siswa['jadwalTempat'] ?? '-',
                    ),
                  ],
                  if (status == 'Ditolak' &&
                      siswa['alasanPenolakan'] != null)
                    _detailItem(
                      Icons.comment_outlined,
                      'Alasan Penolakan',
                      siswa['alasanPenolakan'] ?? '-',
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: biru,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Tutup Detail',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
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

  Widget _detailItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: biru, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: teksSekunder,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: teks,
                    fontWeight: FontWeight.w700,
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
  void dispose() {
    _pencarianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final siswa = _siswaTersaring;

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
                  _bannerSiswa(),
                  const SizedBox(height: 24),
                  const Text(
                    'Ringkasan Siswa',
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
                          judul: 'Total Siswa',
                          jumlah: _jumlahStatus('Semua'),
                          ikon: Icons.groups_rounded,
                          warna: biru,
                          warnaLatar: const Color(0xFFEAF3FA),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _kartuRingkasan(
                          judul: 'Diterima',
                          jumlah: _jumlahStatus('Diterima'),
                          ikon: Icons.check_circle_outline_rounded,
                          warna: const Color(0xFF218653),
                          warnaLatar: const Color(0xFFE5F6EC),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _kartuRingkasan(
                          judul: 'Menunggu',
                          jumlah: _jumlahStatus('Menunggu'),
                          ikon: Icons.hourglass_top_rounded,
                          warna: const Color(0xFFB7791F),
                          warnaLatar: const Color(0xFFFFF4DB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Direktori Siswa',
                    style: TextStyle(
                      color: teks,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _kolomPencarian(),
                  const SizedBox(height: 14),
                  _filterSiswa(),
                  const SizedBox(height: 17),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Daftar siswa konseling',
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
                          '${siswa.length} siswa',
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
                  if (siswa.isEmpty)
                    _tampilanKosong()
                  else
                    ...siswa.map(_kartuSiswa),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerSiswa() {
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
            top: -28,
            child: Container(
              width: 115,
              height: 115,
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
                            'Manajemen Siswa',
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
                      'Data Siswa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lihat informasi siswa dan pantau '
                      'status pengajuan konseling.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.88),
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.groups_rounded,
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

  Widget _kolomPencarian() {
    return TextField(
      controller: _pencarianController,
      onChanged: (value) {
        setState(() => _kataKunci = value);
      },
      decoration: InputDecoration(
        hintText: 'Cari nama atau kelas siswa...',
        hintStyle: const TextStyle(
          color: Color(0xFF9AA5B4),
          fontSize: 12,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: biru,
        ),
        suffixIcon: _kataKunci.isNotEmpty
            ? IconButton(
                tooltip: 'Hapus pencarian',
                onPressed: () {
                  _pencarianController.clear();
                  setState(() => _kataKunci = '');
                },
                icon: const Icon(Icons.close_rounded),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: garis),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: garis),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: biru, width: 1.4),
        ),
      ),
    );
  }

  Widget _filterSiswa() {
    const pilihan = ['Semua', 'Menunggu', 'Diterima', 'Ditolak'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: pilihan.map((status) {
          final aktif = _filterStatus == status;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(status),
              selected: aktif,
              showCheckmark: false,
              selectedColor: biru,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: aktif ? biru : garis,
              ),
              labelStyle: TextStyle(
                color: aktif ? Colors.white : teks,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (_) {
                setState(() => _filterStatus = status);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _tampilanKosong() {
    final adaPencarian = _kataKunci.trim().isNotEmpty ||
        _filterStatus != 'Semua';

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
              Icons.groups_outlined,
              size: 40,
              color: biru,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            adaPencarian
                ? 'Siswa Tidak Ditemukan'
                : 'Belum Ada Data Siswa',
            style: const TextStyle(
              color: teks,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            adaPencarian
                ? 'Coba gunakan kata kunci atau filter status lain.'
                : 'Data siswa akan muncul setelah ada pengajuan '
                    'konseling.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: teksSekunder,
              fontSize: 12,
              height: 1.6,
            ),
          ),
          if (adaPencarian) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                _pencarianController.clear();
                setState(() {
                  _kataKunci = '';
                  _filterStatus = 'Semua';
                });
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reset Filter'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _kartuSiswa(Map<String, String> siswa) {
    final status = siswa['status'] ?? 'Menunggu';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: garis),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF253858).withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _lihatDetail(siswa),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        biru.withOpacity(0.15),
                        biru.withOpacity(0.06),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      _inisial(siswa['nama'] ?? ''),
                      style: const TextStyle(
                        color: biru,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        siswa['nama'] ?? '-',
                        style: const TextStyle(
                          color: teks,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.school_outlined,
                            size: 14,
                            color: teksSekunder,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Kelas ${siswa['kelas'] ?? '-'}',
                              style: const TextStyle(
                                color: teksSekunder,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        siswa['alasan'] ?? 'Belum ada keterangan',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: teks,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _latarStatus(status),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _ikonStatus(status),
                                  color: _warnaStatus(status),
                                  size: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  status,
                                  style: TextStyle(
                                    color: _warnaStatus(status),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (siswa['jadwalTanggal'] != null)
                            const Icon(
                              Icons.event_available_rounded,
                              color: Color(0xFF218653),
                              size: 15,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Padding(
                  padding: EdgeInsets.only(top: 13),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9AA5B4),
                    size: 23,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

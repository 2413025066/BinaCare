
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

  // Satu siswa hanya ditampilkan satu kali.
  List<Map<String, String>> get _daftarSiswa {
    final Map<String, Map<String, String>> siswaUnik = {};

    for (final pengajuan in widget.daftarPengajuan) {
      final nama = (pengajuan['nama'] ?? '').trim();
      final kelas = (pengajuan['kelas'] ?? '').trim();

      if (nama.isEmpty) continue;

      final kunci = '${nama.toLowerCase()}-${kelas.toLowerCase()}';

      siswaUnik.putIfAbsent(
        kunci,
        () => Map<String, String>.from(pengajuan),
      );
    }

    return siswaUnik.values.toList();
  }

  // Mengambil seluruh pengajuan milik siswa yang dipilih.
  List<Map<String, String>> _pengajuanUntukSiswa(
    Map<String, String> siswa,
  ) {
    final nama = (siswa['nama'] ?? '').trim().toLowerCase();
    final kelas = (siswa['kelas'] ?? '').trim().toLowerCase();

    return widget.daftarPengajuan.where((pengajuan) {
      return (pengajuan['nama'] ?? '').trim().toLowerCase() == nama &&
          (pengajuan['kelas'] ?? '').trim().toLowerCase() == kelas;
    }).toList();
  }

  List<Map<String, String>> get _siswaTersaring {
    final kata = _kataKunci.trim().toLowerCase();

    return _daftarSiswa.where((siswa) {
      final nama = (siswa['nama'] ?? '').toLowerCase();
      final kelas = (siswa['kelas'] ?? '').toLowerCase();

      return nama.contains(kata) || kelas.contains(kata);
    }).toList();
  }

  String _inisial(String nama) {
    final bagian = nama
        .trim()
        .split(RegExp(r'\s+'))
        .where((kata) => kata.isNotEmpty)
        .toList();

    if (bagian.isEmpty) return '?';
    if (bagian.length >= 2) {
      return '${bagian[0][0]}${bagian[1][0]}'.toUpperCase();
    }

    return bagian.first[0].toUpperCase();
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

  void _lihatDetail(Map<String, String> siswa) {
    final semuaPengajuan = _pengajuanUntukSiswa(siswa);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
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
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 26),
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

                // Identitas siswa.
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
                        backgroundColor:
                            Colors.white.withOpacity(0.18),
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

                const SizedBox(height: 22),
                Text(
                  'Riwayat Pengajuan (${semuaPengajuan.length})',
                  style: const TextStyle(
                    color: teks,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),

                ...semuaPengajuan.asMap().entries.map((entry) {
                  final nomor = entry.key + 1;
                  final pengajuan = entry.value;
                  final status = pengajuan['status'] ?? 'Menunggu';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 13),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: latar,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: garis),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Pengajuan $nomor',
                                style: const TextStyle(
                                  color: teks,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
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
                          ],
                        ),
                        const SizedBox(height: 15),
                        _detailItem(
                          Icons.chat_bubble_outline_rounded,
                          'Keperluan Konseling',
                          pengajuan['alasan'] ?? '-',
                        ),
                        _detailItem(
                          Icons.calendar_today_outlined,
                          'Tanggal Pengajuan',
                          pengajuan['tanggal'] ?? '-',
                        ),
                        if (status == 'Diterima') ...[
                          const Divider(color: garis),
                          const SizedBox(height: 8),
                          const Text(
                            'Informasi Jadwal',
                            style: TextStyle(
                              color: teks,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 13),
                          _detailItem(
                            Icons.calendar_month_rounded,
                            'Tanggal Konseling',
                            pengajuan['jadwalTanggal'] ?? '-',
                          ),
                          _detailItem(
                            Icons.access_time_rounded,
                            'Waktu Konseling',
                            pengajuan['jadwalWaktu'] ?? '-',
                          ),
                          _detailItem(
                            Icons.location_on_outlined,
                            'Tempat Konseling',
                            pengajuan['jadwalTempat'] ?? '-',
                          ),
                        ],
                        if (status == 'Ditolak')
                          _detailItem(
                            Icons.comment_outlined,
                            'Alasan Penolakan',
                            pengajuan['alasanPenolakan'] ?? '-',
                          ),
                      ],
                    ),
                  );
                }),

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
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            _bannerSiswa(),
            const SizedBox(height: 24),
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Daftar siswa yang pernah mengajukan konseling',
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
                      'Lihat informasi siswa yang pernah '
                      'mengajukan layanan konseling.',
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

  Widget _tampilanKosong() {
    final adaPencarian = _kataKunci.trim().isNotEmpty;

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
                ? 'Coba gunakan nama atau kelas yang lain.'
                : 'Data siswa akan muncul setelah ada pengajuan '
                    'konseling.',
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

  Widget _kartuSiswa(Map<String, String> siswa) {
    final semuaPengajuan = _pengajuanUntukSiswa(siswa);

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
                        '${semuaPengajuan.length} pengajuan konseling',
                        style: const TextStyle(
                          color: teksSekunder,
                          fontSize: 12,
                        ),
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

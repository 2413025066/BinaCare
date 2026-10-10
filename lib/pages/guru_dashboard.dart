
import 'package:flutter/material.dart';
import 'profil_guru_page.dart';

class GuruDashboard extends StatefulWidget {
  const GuruDashboard({super.key});

  @override
  State<GuruDashboard> createState() => _GuruDashboardState();
}

class _GuruDashboardState extends State<GuruDashboard> {
  static const Color biru = Color(0xFF2F6FA3);
  static const Color latar = Color(0xFFF6F8FA);
  static const Color teks = Color(0xFF202124);

  final String _namaGuru = 'Nama Guru BK';

  final List<Map<String, String>> _daftarPengajuan = [
    {
      'nama': 'Andi Saputra',
      'kelas': 'VIII A',
      'alasan': 'Kesulitan belajar',
      'tanggal': '09 Oktober 2026',
      'status': 'Menunggu',
    },
    {
      'nama': 'Siti Rahma',
      'kelas': 'VII B',
      'alasan': 'Masalah pertemanan',
      'tanggal': '09 Oktober 2026',
      'status': 'Menunggu',
    },
    {
      'nama': 'Budi Pratama',
      'kelas': 'IX A',
      'alasan': 'Konsultasi akademik',
      'tanggal': '08 Oktober 2026',
      'status': 'Diterima',
    },
  ];

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _bukaProfil() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const ProfilGuruPage(),
      ),
    );
  }

  void _terimaPengajuan(int index) {
    if (_daftarPengajuan[index]['status'] != 'Menunggu') {
      _tampilkanPesan('Pengajuan ini sudah diproses.');
      return;
    }

    setState(() {
      _daftarPengajuan[index]['status'] = 'Diterima';
    });

    _tampilkanPesan(
      'Pengajuan ${_daftarPengajuan[index]['nama']} diterima.',
    );
  }

  void _tolakPengajuan(int index) {
    if (_daftarPengajuan[index]['status'] != 'Menunggu') {
      _tampilkanPesan('Pengajuan ini sudah diproses.');
      return;
    }

    setState(() {
      _daftarPengajuan[index]['status'] = 'Ditolak';
    });

    _tampilkanPesan(
      'Pengajuan ${_daftarPengajuan[index]['nama']} ditolak.',
    );
  }

  void _lihatDetail(int index) {
    final pengajuan = _daftarPengajuan[index];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Detail Pengajuan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: teks,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _detailItem(
                    Icons.person_outline,
                    'Nama Siswa',
                    pengajuan['nama']!,
                  ),
                  _detailItem(
                    Icons.school_outlined,
                    'Kelas',
                    pengajuan['kelas']!,
                  ),
                  _detailItem(
                    Icons.chat_bubble_outline,
                    'Alasan Konseling',
                    pengajuan['alasan']!,
                  ),
                  _detailItem(
                    Icons.calendar_today_outlined,
                    'Tanggal Pengajuan',
                    pengajuan['tanggal']!,
                  ),
                  _detailItem(
                    Icons.info_outline,
                    'Status',
                    pengajuan['status']!,
                  ),
                  const SizedBox(height: 18),
                  if (pengajuan['status'] == 'Menunggu')
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                              _tolakPengajuan(index);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Tolak'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                              _terimaPengajuan(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: biru,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Terima'),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetContext),
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

  void _lihatSemuaPengajuan() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: latar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(sheetContext).size.height * 0.75,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 10, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Semua Pengajuan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: teks,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _daftarPengajuan.isEmpty
                      ? const Center(
                          child: Text('Belum ada pengajuan.'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            16, 0, 16, 20,
                          ),
                          itemCount: _daftarPengajuan.length,
                          itemBuilder: (context, index) {
                            return _pengajuanCard(index);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bukaNotifikasi() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifikasi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: teks,
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 40,
                    color: biru,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Notifikasi akan ditampilkan di sini ketika '
                  'fitur notifikasi sudah diaktifkan.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bukaMenu(String menu) {
    switch (menu) {
      case 'Pengajuan Konseling':
        _lihatSemuaPengajuan();
        break;
      case 'Jadwal Konseling':
        _tampilkanPesan(
          'Halaman Jadwal Konseling akan dibuat berikutnya.',
        );
        break;
      case 'Data Siswa':
        _tampilkanPesan(
          'Halaman Data Siswa akan dibuat berikutnya.',
        );
        break;
      case 'Riwayat Konseling':
        _tampilkanPesan(
          'Halaman Riwayat Konseling akan dibuat berikutnya.',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final jumlahMenunggu = _daftarPengajuan
        .where((item) => item['status'] == 'Menunggu')
        .length;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: biru.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: biru,
                size: 22,
              ),
            ),
            const SizedBox(width: 9),
            const Text(
              'BinaCare',
              style: TextStyle(
                color: teks,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: _bukaNotifikasi,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: teks,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              onTap: _bukaProfil,
              borderRadius: BorderRadius.circular(30),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFEAF3FA),
                child: Icon(
                  Icons.person_rounded,
                  color: biru,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, $_namaGuru 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: teks,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Selamat datang di Dashboard Guru BK.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 18),

              // Banner dibuat lebih ringkas.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: biru,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pengajuan Konseling',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$jumlahMenunggu pengajuan menunggu '
                            'untuk diproses.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.90),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 11),
                          ElevatedButton(
                            onPressed: _lihatSemuaPengajuan,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: biru,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              minimumSize: const Size(0, 36),
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Lihat Pengajuan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Layanan Guru BK',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: teks,
                ),
              ),
              const SizedBox(height: 11),

              // Tinggi kartu ditetapkan langsung, bukan memakai rasio.
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 120,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                children: [
                  _menuCard(
                    icon: Icons.assignment_outlined,
                    title: 'Pengajuan Konseling',
                    subtitle: 'Kelola permohonan siswa',
                    onTap: () => _bukaMenu('Pengajuan Konseling'),
                  ),
                  _menuCard(
                    icon: Icons.calendar_month_outlined,
                    title: 'Jadwal Konseling',
                    subtitle: 'Atur jadwal konseling',
                    onTap: () => _bukaMenu('Jadwal Konseling'),
                  ),
                  _menuCard(
                    icon: Icons.groups_outlined,
                    title: 'Data Siswa',
                    subtitle: 'Informasi siswa',
                    onTap: () => _bukaMenu('Data Siswa'),
                  ),
                  _menuCard(
                    icon: Icons.history_rounded,
                    title: 'Riwayat Konseling',
                    subtitle: 'Lihat riwayat layanan',
                    onTap: () => _bukaMenu('Riwayat Konseling'),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pengajuan Terbaru',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _lihatSemuaPengajuan,
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: biru,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (_daftarPengajuan.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 38,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text('Belum ada pengajuan konseling.'),
                    ],
                  ),
                )
              else
                ...List.generate(
                  _daftarPengajuan.length < 3
                      ? _daftarPengajuan.length
                      : 3,
                  (index) => _pengajuanCard(index),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: biru.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: biru,
                  size: 19,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: teks,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pengajuanCard(int index) {
    final pengajuan = _daftarPengajuan[index];
    final status = pengajuan['status']!;

    late final Color warnaStatus;
    late final Color latarStatus;

    if (status == 'Diterima') {
      warnaStatus = const Color(0xFF218653);
      latarStatus = const Color(0xFFE7F6EC);
    } else if (status == 'Ditolak') {
      warnaStatus = Colors.red.shade700;
      latarStatus = const Color(0xFFFDECEC);
    } else {
      warnaStatus = const Color(0xFFB7791F);
      latarStatus = const Color(0xFFFFF4DB);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: biru.withValues(alpha: 0.10),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: biru,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengajuan['nama']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Kelas ${pengajuan['kelas']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pengajuan['alasan']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: teks,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: latarStatus,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: warnaStatus,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  pengajuan['tanggal']!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _lihatDetail(index),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 34),
                ),
                child: const Text('Detail'),
              ),
            ],
          ),
          if (status == 'Menunggu') ...[
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _tolakPengajuan(index),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                    ),
                    child: const Text('Tolak'),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _terimaPengajuan(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: biru,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 9),
                    ),
                    child: const Text('Terima'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: biru, size: 21),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: teks,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

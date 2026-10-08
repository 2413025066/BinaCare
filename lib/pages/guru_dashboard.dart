import 'package:flutter/material.dart';

class GuruDashboard extends StatefulWidget {
  const GuruDashboard({super.key});

  @override
  State<GuruDashboard> createState() => _GuruDashboardState();
}

class _GuruDashboardState extends State<GuruDashboard> {
  int _selectedIndex = 0;

  // Data pengajuan sementara / dummy
  final List<Map<String, dynamic>> _pengajuan = [
    {
      'nama': 'Andi Pratama',
      'keperluan': 'Masalah belajar',
      'tanggal': '24 September 2026',
      'waktu': '10.00 - 11.00',
      'status': 'Menunggu',
    },
    {
      'nama': 'Siti Aulia',
      'keperluan': 'Konseling pribadi',
      'tanggal': '25 September 2026',
      'waktu': '13.00 - 14.00',
      'status': 'Menunggu',
    },
    {
      'nama': 'Rizky Ramadhan',
      'keperluan': 'Masalah pertemanan',
      'tanggal': '26 September 2026',
      'waktu': '09.00 - 10.00',
      'status': 'Menunggu',
    },
  ];

  // ================= NOTIFIKASI =================

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title akan dibuat selanjutnya.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= TERIMA PENGAJUAN =================

  void _terimaPengajuan(int index) {
    setState(() {
      _pengajuan[index]['status'] = 'Diterima';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pengajuan konseling berhasil diterima.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= TOLAK PENGAJUAN =================

  void _tolakPengajuan(int index) {
    final TextEditingController alasanController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Tolak Pengajuan',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Berikan alasan penolakan kepada siswa.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: alasanController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Contoh: Jadwal tersebut sudah penuh.',
                  filled: true,
                  fillColor: const Color(0xFFF6F8FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () {
                if (alasanController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Alasan penolakan harus diisi.',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                setState(() {
                  _pengajuan[index]['status'] = 'Ditolak';
                  _pengajuan[index]['alasan'] =
                      alasanController.text.trim();
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pengajuan ditolak dan alasan berhasil disimpan.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB83A3A),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Tolak Pengajuan'),
            ),
          ],
        );
      },
    );
  }

  // ================= DETAIL PENGAJUAN =================

  void _lihatDetail(int index) {
    final data = _pengajuan[index];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Detail Pengajuan',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 20),

              _detailItem(
                Icons.person_outline_rounded,
                'Nama Siswa',
                data['nama'],
              ),

              _detailItem(
                Icons.subject_rounded,
                'Keperluan',
                data['keperluan'],
              ),

              _detailItem(
                Icons.calendar_month_outlined,
                'Tanggal',
                data['tanggal'],
              ),

              _detailItem(
                Icons.access_time_rounded,
                'Waktu',
                data['waktu'],
              ),

              _detailItem(
                Icons.info_outline_rounded,
                'Status',
                data['status'],
              ),

              if (data['alasan'] != null)
                _detailItem(
                  Icons.comment_outlined,
                  'Alasan Penolakan',
                  data['alasan'],
                ),

              const SizedBox(height: 15),

              if (data['status'] == 'Menunggu')
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _tolakPengajuan(index);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFB83A3A),
                          side: const BorderSide(
                            color: Color(0xFFB83A3A),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                        child: const Text('Tolak'),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _terimaPengajuan(index);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6FA3),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                        child: const Text('Terima'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  // ================= BOTTOM NAVIGATION =================

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _showComingSoon('Jadwal Konseling');
    } else if (index == 2) {
      _showComingSoon('Riwayat Konseling');
    } else if (index == 3) {
      _showComingSoon('Profil');
    }
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final int jumlahMenunggu = _pengajuan
        .where((item) => item['status'] == 'Menunggu')
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // ================= APP BAR =================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'BinaCare',
          style: TextStyle(
            color: Color(0xFF2F6FA3),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showComingSoon('Notifikasi'),
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF202124),
              size: 28,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ================= BODY =================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= GREETING =================

              const Text(
                'Halo, Guru BK 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Kelola layanan konseling siswa dengan mudah.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 22),

              // ================= PENGAJUAN BARU =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F6FA3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pengajuan Baru',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            '$jumlahMenunggu pengajuan menunggu konfirmasi',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.85),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white.withOpacity(0.9),
                      size: 28,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= MENU UTAMA =================

              const Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.assignment_outlined,
                      title: 'Pengajuan\nKonseling',
                      onTap: () => _showComingSoon(
                        'Pengajuan Konseling',
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _menuCard(
                      icon: Icons.calendar_month_outlined,
                      title: 'Jadwal\nKonseling',
                      onTap: () => _showComingSoon(
                        'Jadwal Konseling',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.groups_outlined,
                      title: 'Data\nSiswa',
                      onTap: () => _showComingSoon(
                        'Data Siswa',
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _menuCard(
                      icon: Icons.history_rounded,
                      title: 'Riwayat\nKonseling',
                      onTap: () => _showComingSoon(
                        'Riwayat Konseling',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= PENGAJUAN TERBARU =================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pengajuan Terbaru',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),

                  TextButton(
                    onPressed: () => _showComingSoon(
                      'Semua Pengajuan',
                    ),
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: Color(0xFF2F6FA3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ================= LIST PENGAJUAN =================

              ...List.generate(
                _pengajuan.length,
                (index) {
                  return _pengajuanCard(
                    index,
                    _pengajuan[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // ================= BOTTOM NAVIGATION =================

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onBottomNavTap,
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor: const Color(0xFFEAF3FA),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // ================= MENU CARD =================

  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2F6FA3),
                  size: 24,
                ),
              ),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= PENGAJUAN CARD =================

  Widget _pengajuanCard(
    int index,
    Map<String, dynamic> data,
  ) {
    final String status = data['status'];

    Color statusBackground;
    Color statusText;
    IconData statusIcon;

    if (status == 'Diterima') {
      statusBackground = const Color(0xFFE8F5E9);
      statusText = const Color(0xFF2E7D32);
      statusIcon = Icons.check_circle_outline_rounded;
    } else if (status == 'Ditolak') {
      statusBackground = const Color(0xFFFDECEC);
      statusText = const Color(0xFFB83A3A);
      statusIcon = Icons.cancel_outlined;
    } else {
      statusBackground = const Color(0xFFFFF4D6);
      statusText = const Color(0xFF9A6A00);
      statusIcon = Icons.access_time_rounded;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _lihatDetail(index),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF3FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF2F6FA3),
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['nama'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202124),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        data['keperluan'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${data['tanggal']} • ${data['waktu']}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 15,
                      color: statusText,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusText,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              if (status == 'Menunggu') ...[
                OutlinedButton(
                  onPressed: () {
                    _tolakPengajuan(index);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        const Color(0xFFB83A3A),
                    side: const BorderSide(
                      color: Color(0xFFB83A3A),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Tolak',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {
                    _terimaPengajuan(index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2F6FA3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Terima',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),

          if (status == 'Ditolak' &&
              data['alasan'] != null) ...[
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDECEC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFB83A3A),
                    size: 18,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      'Alasan: ${data['alasan']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7A3030),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ================= DETAIL ITEM =================

  Widget _detailItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2F6FA3),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF777777),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF202124),
                    height: 1.35,
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
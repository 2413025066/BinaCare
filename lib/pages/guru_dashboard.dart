import 'package:flutter/material.dart';
import 'profil_guru_page.dart';
import 'jadwal_guru_page.dart';
import 'data_siswa_page.dart';
import 'riwayat_konseling_guru_page.dart';

class GuruDashboard extends StatefulWidget {
  const GuruDashboard({super.key});

  @override
  State<GuruDashboard> createState() => _GuruDashboardState();
}

class _GuruDashboardState extends State<GuruDashboard> {
  static const Color biru = Color(0xFF2F6FA3);
  static const Color biruGelap = Color(0xFF214F82);
  static const Color latar = Color(0xFFF5F8FC);
  static const Color teks = Color(0xFF202B3C);
  static const Color teksSekunder = Color(0xFF778396);
  static const Color garis = Color(0xFFE7EDF4);

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
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  void _bukaProfil() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const ProfilGuruPage(),
      ),
    );
  }

  String _formatTanggal(DateTime value) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${value.day} ${bulan[value.month - 1]} ${value.year}';
  }

  String _formatJam(TimeOfDay value) {
    return '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _terimaPengajuan(int index) async {
    if (_daftarPengajuan[index]['status'] != 'Menunggu') {
      _tampilkanPesan('Pengajuan ini sudah diproses.');
      return;
    }

    DateTime? tanggal;
    TimeOfDay? jamMulai;
    TimeOfDay? jamSelesai;
    final tempatController = TextEditingController(text: 'Ruang BK');

    try {
      final hasil = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => StatefulBuilder(
          builder: (dialogContext, setDialogState) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Row(
              children: [
                Icon(Icons.event_available_rounded, color: biru),
                SizedBox(width: 10),
                Expanded(child: Text('Atur Jadwal Konseling')),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
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
                                _daftarPengajuan[index]['nama'] ?? '-',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Kelas ${_daftarPengajuan[index]['kelas'] ?? '-'}',
                                style: const TextStyle(
                                  color: teksSekunder,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _dialogPickerButton(
                    icon: Icons.calendar_month_rounded,
                    label: tanggal == null
                        ? 'Pilih tanggal'
                        : _formatTanggal(tanggal!),
                    onTap: () async {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);

                      final picked = await showDatePicker(
                        context: dialogContext,
                        initialDate: tanggal ?? today,
                        firstDate: today,
                        lastDate: DateTime(now.year + 3),
                      );

                      if (picked != null) {
                        setDialogState(() => tanggal = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 9),
                  _dialogPickerButton(
                    icon: Icons.login_rounded,
                    label: jamMulai == null
                        ? 'Pilih jam mulai'
                        : 'Mulai ${_formatJam(jamMulai!)}',
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: dialogContext,
                        initialTime: jamMulai ??
                            const TimeOfDay(hour: 9, minute: 0),
                      );

                      if (picked != null) {
                        setDialogState(() => jamMulai = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 9),
                  _dialogPickerButton(
                    icon: Icons.logout_rounded,
                    label: jamSelesai == null
                        ? 'Pilih jam selesai'
                        : 'Selesai ${_formatJam(jamSelesai!)}',
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: dialogContext,
                        initialTime: jamSelesai ??
                            const TimeOfDay(hour: 9, minute: 30),
                      );

                      if (picked != null) {
                        setDialogState(() => jamSelesai = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: tempatController,
                    decoration: InputDecoration(
                      labelText: 'Tempat konseling',
                      hintText: 'Contoh: Ruang BK',
                      prefixIcon:
                          const Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: garis),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Batal'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (tanggal == null ||
                      jamMulai == null ||
                      jamSelesai == null ||
                      tempatController.text.trim().isEmpty) {
                    _tampilkanPesan(
                      'Lengkapi tanggal, jam, dan tempat konseling.',
                    );
                    return;
                  }

                  final start =
                      jamMulai!.hour * 60 + jamMulai!.minute;
                  final finish =
                      jamSelesai!.hour * 60 + jamSelesai!.minute;

                  if (finish <= start) {
                    _tampilkanPesan(
                      'Jam selesai harus setelah jam mulai.',
                    );
                    return;
                  }

                  Navigator.pop(dialogContext, true);
                },
                icon: const Icon(Icons.check_rounded, size: 18),
                label: const Text('Simpan Jadwal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: biru,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      if (hasil != true || !mounted) return;

      setState(() {
        _daftarPengajuan[index]['status'] = 'Diterima';
        _daftarPengajuan[index]['jadwalTanggal'] =
            _formatTanggal(tanggal!);
        _daftarPengajuan[index]['jadwalWaktu'] =
            '${_formatJam(jamMulai!)} - ${_formatJam(jamSelesai!)}';
        _daftarPengajuan[index]['jadwalTempat'] =
            tempatController.text.trim();
      });

      _tampilkanPesan(
        'Pengajuan diterima dan jadwal berhasil dibuat.',
      );
    } finally {
      tempatController.dispose();
    }
  }

  Widget _dialogPickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 19),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(label),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: biru,
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 13,
          ),
          side: const BorderSide(color: garis),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }

  Future<void> _tolakPengajuan(int index) async {
    if (_daftarPengajuan[index]['status'] != 'Menunggu') {
      _tampilkanPesan('Pengajuan ini sudah diproses.');
      return;
    }

    final alasanController = TextEditingController();

    try {
      final alasan = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.assignment_late_outlined,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text('Tolak Pengajuan'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tuliskan alasan penolakan untuk '
                '${_daftarPengajuan[index]['nama'] ?? 'siswa ini'}.',
                style: const TextStyle(
                  color: teksSekunder,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: alasanController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Alasan penolakan',
                  hintText: 'Masukkan alasan yang jelas',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: garis),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final alasan = alasanController.text.trim();

                if (alasan.isEmpty) {
                  _tampilkanPesan(
                    'Alasan penolakan wajib diisi.',
                  );
                  return;
                }

                Navigator.pop(dialogContext, alasan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Tolak Pengajuan'),
            ),
          ],
        ),
      );

      if (alasan == null || !mounted) return;

      setState(() {
        _daftarPengajuan[index]['status'] = 'Ditolak';
        _daftarPengajuan[index]['alasanPenolakan'] = alasan;
      });

      _tampilkanPesan(
        'Pengajuan ditolak. Alasan berhasil disimpan.',
      );
    } finally {
      alasanController.dispose();
    }
  }

  void _lihatDetail(int index) {
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(height: 22),
                  const Text(
                    'Detail Pengajuan',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: teks,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _detailItem(
                    Icons.person_outline_rounded,
                    'Nama Siswa',
                    _daftarPengajuan[index]['nama'] ?? '-',
                  ),
                  _detailItem(
                    Icons.school_outlined,
                    'Kelas',
                    _daftarPengajuan[index]['kelas'] ?? '-',
                  ),
                  _detailItem(
                    Icons.chat_bubble_outline_rounded,
                    'Alasan Konseling',
                    _daftarPengajuan[index]['alasan'] ?? '-',
                  ),
                  _detailItem(
                    Icons.calendar_today_outlined,
                    'Tanggal Pengajuan',
                    _daftarPengajuan[index]['tanggal'] ?? '-',
                  ),
                  _detailItem(
                    Icons.info_outline_rounded,
                    'Status',
                    _daftarPengajuan[index]['status'] ?? '-',
                  ),
                  if (_daftarPengajuan[index]['status'] == 'Ditolak' &&
                      _daftarPengajuan[index]['alasanPenolakan'] != null)
                    _detailItem(
                      Icons.comment_outlined,
                      'Alasan Penolakan',
                      _daftarPengajuan[index]['alasanPenolakan']!,
                    ),
                  if (_daftarPengajuan[index]['status'] == 'Diterima' &&
                      _daftarPengajuan[index]['jadwalTanggal'] != null) ...[
                    _detailItem(
                      Icons.event_rounded,
                      'Tanggal Konseling',
                      _daftarPengajuan[index]['jadwalTanggal']!,
                    ),
                    _detailItem(
                      Icons.access_time_rounded,
                      'Waktu Konseling',
                      _daftarPengajuan[index]['jadwalWaktu']!,
                    ),
                    _detailItem(
                      Icons.location_on_outlined,
                      'Tempat Konseling',
                      _daftarPengajuan[index]['jadwalTempat']!,
                    ),
                  ],
                  const SizedBox(height: 10),
                  if (_daftarPengajuan[index]['status'] == 'Menunggu')
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                              _tolakPengajuan(index);
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              size: 18,
                            ),
                            label: const Text('Tolak'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(
                                color: Color(0xFFF0B8B8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                              _terimaPengajuan(index);
                            },
                            icon: const Icon(
                              Icons.check_rounded,
                              size: 18,
                            ),
                            label: const Text('Terima'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: biru,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FA),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: biru, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: teksSekunder,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: teks,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _lihatSemuaPengajuan() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          height: MediaQuery.of(sheetContext).size.height * 0.78,
          decoration: const BoxDecoration(
            color: latar,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 17, 12, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Semua Pengajuan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: teks,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _daftarPengajuan.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada pengajuan.',
                          style: TextStyle(color: teksSekunder),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          20,
                        ),
                        itemCount: _daftarPengajuan.length,
                        itemBuilder: (_, index) =>
                            _pengajuanCard(index),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bukaNotifikasi() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (sheetContext) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifikasi',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: teks,
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAF3FA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 39,
                    color: biru,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Belum ada notifikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: teks,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Notifikasi akan ditampilkan di sini ketika fitur '
                'notifikasi sudah diaktifkan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: teksSekunder,
                  height: 1.5,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: biru,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bukaMenu(String menu) {
    switch (menu) {
      case 'Pengajuan Konseling':
        _lihatSemuaPengajuan();
        break;

      case 'Jadwal Konseling':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => JadwalGuruPage(
              daftarPengajuan: _daftarPengajuan,
            ),
          ),
        );
        break;

      case 'Data Siswa':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => DataSiswaPage(
              daftarPengajuan: _daftarPengajuan,
            ),
          ),
        );
        break;

      case 'Riwayat Konseling':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => RiwayatKonselingGuruPage(
              daftarPengajuan: _daftarPengajuan,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final jumlahMenunggu = _daftarPengajuan
        .where((item) => item['status'] == 'Menunggu')
        .length;

    final jumlahDiterima = _daftarPengajuan
        .where((item) => item['status'] == 'Diterima')
        .length;

    final jumlahDitolak = _daftarPengajuan
        .where((item) => item['status'] == 'Ditolak')
        .length;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4D91D0), biruGelap],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 11),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BinaCare',
                  style: TextStyle(
                    color: teks,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'LAYANAN KONSELING',
                  style: TextStyle(
                    color: teksSekunder,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
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
              size: 26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: _bukaProfil,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: biru.withOpacity(0.25),
                    width: 1.5,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 17,
                  backgroundColor: Color(0xFFEAF3FA),
                  child: Icon(
                    Icons.person_rounded,
                    color: biru,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DASHBOARD GURU BK',
                style: TextStyle(
                  color: teksSekunder,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Halo, $_namaGuru 👋',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: teks,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Mari bantu siswa tumbuh dan berkembang hari ini.',
                style: TextStyle(
                  fontSize: 13,
                  color: teksSekunder,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _bannerPengajuan(jumlahMenunggu),
              const SizedBox(height: 26),
              const Text(
                'Ringkasan Pengajuan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: teks,
                ),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      title: 'Menunggu',
                      jumlah: jumlahMenunggu,
                      icon: Icons.hourglass_top_rounded,
                      warna: const Color(0xFFD99A23),
                      warnaLatar: const Color(0xFFFFF5DF),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      title: 'Diterima',
                      jumlah: jumlahDiterima,
                      icon: Icons.check_circle_outline_rounded,
                      warna: const Color(0xFF218653),
                      warnaLatar: const Color(0xFFE5F6EC),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      title: 'Ditolak',
                      jumlah: jumlahDitolak,
                      icon: Icons.cancel_outlined,
                      warna: const Color(0xFFD64545),
                      warnaLatar: const Color(0xFFFDECEC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 27),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Layanan Guru BK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: teks,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '4 Layanan',
                      style: TextStyle(
                        color: biru,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.28,
                children: [
                  _menuCard(
                    icon: Icons.assignment_outlined,
                    title: 'Pengajuan Konseling',
                    subtitle: 'Kelola permohonan siswa',
                    onTap: () => _bukaMenu('Pengajuan Konseling'),
                  ),
                  _menuCard(
                    icon: Icons.calendar_month_rounded,
                    title: 'Jadwal Konseling',
                    subtitle: 'Atur waktu konseling',
                    onTap: () => _bukaMenu('Jadwal Konseling'),
                  ),
                  _menuCard(
                    icon: Icons.groups_rounded,
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
              const SizedBox(height: 27),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pengajuan Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
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
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              if (_daftarPengajuan.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: garis),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.inbox_rounded,
                        size: 42,
                        color: Color(0xFF9AA7B5),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Belum ada pengajuan konseling.',
                        style: TextStyle(color: teksSekunder),
                      ),
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

  Widget _bannerPengajuan(int jumlahMenunggu) {
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
            color: biru.withOpacity(0.20),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            top: -25,
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
                            'Pusat Layanan BK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Pengajuan Konseling',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      jumlahMenunggu == 0
                          ? 'Semua pengajuan sudah diproses.'
                          : 'Ada $jumlahMenunggu pengajuan yang menunggu tindakan Anda.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.88),
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      onPressed: _lihatSemuaPengajuan,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                      ),
                      label: const Text(
                        'Lihat Pengajuan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: biru,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.assignment_turned_in_rounded,
                  color: Colors.white,
                  size: 29,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required int jumlah,
    required IconData icon,
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
            color: const Color(0xFF253858).withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: warnaLatar,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: warna, size: 19),
          ),
          const SizedBox(height: 12),
          Text(
            '$jumlah',
            style: TextStyle(
              color: warna,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
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

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          biru.withOpacity(0.15),
                          biru.withOpacity(0.06),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: biru, size: 23),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Colors.blueGrey.shade300,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      color: teks,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: teksSekunder,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pengajuanCard(int index) {
    final pengajuan = _daftarPengajuan[index];
    final status = pengajuan['status'] ?? 'Menunggu';

    final Color warnaStatus;
    final Color latarStatus;
    final IconData ikonStatus;

    if (status == 'Diterima') {
      warnaStatus = const Color(0xFF218653);
      latarStatus = const Color(0xFFE5F6EC);
      ikonStatus = Icons.check_circle_rounded;
    } else if (status == 'Ditolak') {
      warnaStatus = const Color(0xFFD64545);
      latarStatus = const Color(0xFFFDECEC);
      ikonStatus = Icons.cancel_rounded;
    } else {
      warnaStatus = const Color(0xFFB7791F);
      latarStatus = const Color(0xFFFFF4DB);
      ikonStatus = Icons.hourglass_top_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: garis),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF253858).withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: biru,
                  size: 25,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengajuan['nama'] ?? '-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: teks,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kelas ${pengajuan['kelas'] ?? '-'}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: teksSekunder,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      pengajuan['alasan'] ?? '-',
                      style: const TextStyle(
                        fontSize: 12,
                        color: teks,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: latarStatus,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      ikonStatus,
                      color: warnaStatus,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: warnaStatus,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(height: 1, color: garis),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: teksSekunder,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  pengajuan['tanggal'] ?? '-',
                  style: const TextStyle(
                    fontSize: 11,
                    color: teksSekunder,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _lihatDetail(index),
                style: TextButton.styleFrom(
                  foregroundColor: biru,
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  minimumSize: const Size(0, 34),
                ),
                child: const Text(
                  'Detail',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (status == 'Menunggu') ...[
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _tolakPengajuan(index),
                    icon: const Icon(Icons.close_rounded, size: 16),
                    label: const Text('Tolak'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFD64545),
                      side: const BorderSide(
                        color: Color(0xFFF1CACA),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _terimaPengajuan(index),
                    icon: const Icon(Icons.check_rounded, size: 16),
                    label: const Text('Terima'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: biru,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
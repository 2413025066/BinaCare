import 'package:flutter/material.dart';

class AjukanKonselingPage extends StatefulWidget {
  const AjukanKonselingPage({super.key});

  @override
  State<AjukanKonselingPage> createState() => _AjukanKonselingPageState();
}

class _AjukanKonselingPageState extends State<AjukanKonselingPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keperluanController =
      TextEditingController();

  final TextEditingController _masalahController =
      TextEditingController();

  String? selectedGuru;
  DateTime? selectedTanggal;
  String? selectedWaktu;

  final List<Map<String, String>> daftarGuru = [
    {
      'nama': 'Siti Rahma, S.Pd.',
      'jabatan': 'Guru BK',
    },
    {
      'nama': 'Budi Santoso, S.Pd.',
      'jabatan': 'Guru BK',
    },
    {
      'nama': 'Rina Marlina, S.Pd.',
      'jabatan': 'Guru BK',
    },
  ];

  final List<String> daftarWaktu = [
    '08.00 - 09.00',
    '09.00 - 10.00',
    '10.00 - 11.00',
    '13.00 - 14.00',
    '14.00 - 15.00',
  ];

  @override
  void dispose() {
    _keperluanController.dispose();
    _masalahController.dispose();
    super.dispose();
  }

  // ================= PILIH TANGGAL =================

  Future<void> _pilihTanggal() async {
    final DateTime sekarang = DateTime.now();

    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: selectedTanggal ?? sekarang,
      firstDate: sekarang,
      lastDate: DateTime(
        sekarang.year + 1,
        sekarang.month,
        sekarang.day,
      ),
      helpText: 'Pilih tanggal konseling',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      fieldLabelText: 'Tanggal konseling',
      fieldHintText: 'dd/mm/yyyy',
    );

    if (tanggal != null) {
      setState(() {
        selectedTanggal = tanggal;
      });
    }
  }

  // ================= FORMAT TANGGAL =================

  String _formatTanggal(DateTime? tanggal) {
    if (tanggal == null) {
      return 'Pilih tanggal konseling';
    }

    const List<String> namaHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    const List<String> namaBulan = [
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

    final String hari = namaHari[tanggal.weekday - 1];
    final String bulan = namaBulan[tanggal.month - 1];

    return '$hari, ${tanggal.day} $bulan ${tanggal.year}';
  }

  // ================= SUBMIT =================

  void _submitPengajuan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedGuru == null) {
      _showMessage('Silakan pilih Guru BK terlebih dahulu.');
      return;
    }

    if (selectedTanggal == null) {
      _showMessage('Silakan pilih tanggal konseling.');
      return;
    }

    if (selectedWaktu == null) {
      _showMessage('Silakan pilih waktu konseling.');
      return;
    }

    final guru = daftarGuru.firstWhere(
      (item) => item['nama'] == selectedGuru,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi Pengajuan',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pastikan data konseling sudah benar.',
                style: TextStyle(
                  color: Color(0xFF666666),
                ),
              ),

              const SizedBox(height: 18),

              _detailKonfirmasi(
                Icons.person_outline,
                'Guru BK',
                guru['nama']!,
              ),

              const SizedBox(height: 12),

              _detailKonfirmasi(
                Icons.calendar_today_outlined,
                'Tanggal',
                _formatTanggal(selectedTanggal),
              ),

              const SizedBox(height: 12),

              _detailKonfirmasi(
                Icons.access_time_rounded,
                'Waktu',
                selectedWaktu!,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Periksa Lagi'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                showDialog(
                  context: this.context,
                  builder: (context) {
                    return AlertDialog(
                      icon: const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Color(0xFF2F6FA3),
                        size: 52,
                      ),
                      title: const Text(
                        'Pengajuan Berhasil',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      content: const Text(
                        'Pengajuan konseling berhasil dikirim dan sedang menunggu konfirmasi Guru BK.',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(this.context);
                            },
                            child: const Text('Kembali'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6FA3),
                foregroundColor: Colors.white,
              ),
              child: const Text('Kirim Pengajuan'),
            ),
          ],
        );
      },
    );
  }

  // ================= SNACKBAR =================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= DETAIL KONFIRMASI =================

  Widget _detailKonfirmasi(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF2F6FA3),
          size: 21,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // ================= APP BAR =================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF202124),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Ajukan Konseling',
          style: TextStyle(
            color: Color(0xFF2F6FA3),
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ================= BODY =================

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= KEPERLUAN =================

              const Text(
                'Keperluan Konseling',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              TextFormField(
                controller: _keperluanController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Contoh: Masalah belajar',
                  prefixIcon: const Icon(
                    Icons.subject_rounded,
                    color: Color(0xFF4B5563),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Keperluan konseling harus diisi.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ================= MASALAH =================

              const Text(
                'Ceritakan Masalahmu',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              TextFormField(
                controller: _masalahController,
                maxLines: 5,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText:
                      'Tuliskan masalah atau hal yang ingin kamu konsultasikan...',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 8,
                      top: 14,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ceritakan masalah yang ingin dikonsultasikan.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ================= PILIH GURU =================

              const Text(
                'Pilih Guru BK',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              DropdownButtonFormField<String>(
                initialValue: selectedGuru,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF4B5563),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
                hint: const Text('Pilih Guru BK'),
                items: daftarGuru.map((guru) {
                  return DropdownMenuItem<String>(
                    value: guru['nama'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guru['nama']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          guru['jabatan']!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGuru = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // ================= TANGGAL =================

              const Text(
                'Pilih Tanggal Konseling',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              InkWell(
                onTap: _pilihTanggal,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFF2F6FA3),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          _formatTanggal(selectedTanggal),
                          style: TextStyle(
                            fontSize: 15,
                            color: selectedTanggal == null
                                ? const Color(0xFF777777)
                                : const Color(0xFF202124),
                            fontWeight: selectedTanggal == null
                                ? FontWeight.normal
                                : FontWeight.w600,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF777777),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ================= WAKTU =================

              const Text(
                'Pilih Waktu Konseling',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 9),

              DropdownButtonFormField<String>(
                initialValue: selectedWaktu,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.access_time_rounded,
                    color: Color(0xFF4B5563),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
                hint: const Text('Pilih waktu tersedia'),
                items: daftarWaktu.map((waktu) {
                  return DropdownMenuItem<String>(
                    value: waktu,
                    child: Text(
                      waktu,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWaktu = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              // ================= BUTTON =================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitPengajuan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6FA3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Kirim Pengajuan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
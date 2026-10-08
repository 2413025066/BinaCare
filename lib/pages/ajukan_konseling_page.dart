import 'package:flutter/material.dart';

class AjukanKonselingPage extends StatefulWidget {
  const AjukanKonselingPage({super.key});

  @override
  State<AjukanKonselingPage> createState() =>
      _AjukanKonselingPageState();
}

class _AjukanKonselingPageState
    extends State<AjukanKonselingPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ceritaController =
      TextEditingController();

  String? _kategori;
  String? _guruBk;
  String? _jam;
  String _urgensi = 'Sedang';

  DateTime? _tanggalKonseling;

  final List<String> _kategoriList = [
    'Akademik',
    'Pertemanan',
    'Keluarga',
    'Pribadi',
    'Emosi',
    'Lainnya',
  ];

  // Nama Guru BK sementara.
  // Nanti bisa diganti dengan data dari database.
  final List<String> _guruBkList = [
    'Ibu Siti Rahma, S.Pd.',
    'Bapak Andi Wijaya, S.Pd.',
    'Ibu Rina Maharani, S.Psi.',
  ];

  final List<String> _jamList = [
    '08:00 - 08:30',
    '08:30 - 09:00',
    '09:00 - 09:30',
    '10:00 - 10:30',
    '10:30 - 11:00',
    '11:00 - 11:30',
    '13:00 - 13:30',
    '13:30 - 14:00',
    '14:00 - 14:30',
    '14:30 - 15:00',
  ];

  @override
  void dispose() {
    _ceritaController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final DateTime sekarang = DateTime.now();

    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalKonseling ?? sekarang,
      firstDate: sekarang,
      lastDate: DateTime(
        sekarang.year + 1,
        sekarang.month,
        sekarang.day,
      ),
      helpText: 'Pilih tanggal konseling',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2F6FA3),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF202124),
            ),
          ),
          child: child!,
        );
      },
    );

    if (tanggal != null) {
      setState(() {
        _tanggalKonseling = tanggal;
      });
    }
  }

  String _formatTanggal(DateTime tanggal) {
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

    return '${tanggal.day} ${namaBulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  void _kirimPengajuan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_tanggalKonseling == null) {
      _tampilkanPesan(
        'Silakan pilih tanggal konseling terlebih dahulu.',
      );
      return;
    }

    if (_jam == null) {
      _tampilkanPesan(
        'Silakan pilih jam konseling terlebih dahulu.',
      );
      return;
    }

    _tampilkanDialogBerhasil();
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _tampilkanDialogBerhasil() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF2E8B57),
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pengajuan Berhasil',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'Pengajuan konseling kamu berhasil dibuat. '
            'Silakan menunggu konfirmasi dari Guru BK.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Selesai',
                style: TextStyle(
                  color: Color(0xFF2F6FA3),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Ajukan Konseling',
          style: TextStyle(
            color: Color(0xFF202124),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF202124),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ================= HEADER =================

                const Text(
                  'Ceritakan yang kamu rasakan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Isi informasi berikut untuk mengajukan '
                  'sesi konseling dengan Guru BK.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(height: 24),

                // ================= KATEGORI =================

                _label('Kategori Masalah'),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: _kategori,
                  decoration: _inputDecoration(
                    icon: Icons.category_outlined,
                    hint: 'Pilih kategori masalah',
                  ),
                  items: _kategoriList.map((kategori) {
                    return DropdownMenuItem<String>(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _kategori = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori masalah wajib dipilih';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ================= GURU BK =================

                _label('Guru BK'),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: _guruBk,
                  decoration: _inputDecoration(
                    icon: Icons.person_outline_rounded,
                    hint: 'Pilih Guru BK',
                  ),
                  items: _guruBkList.map((guru) {
                    return DropdownMenuItem<String>(
                      value: guru,
                      child: Text(
                        guru,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _guruBk = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Guru BK wajib dipilih';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ================= TANGGAL =================

                _label('Tanggal Konseling'),

                const SizedBox(height: 8),

                InkWell(
                  onTap: _pilihTanggal,
                  borderRadius: BorderRadius.circular(13),
                  child: InputDecorator(
                    decoration: _inputDecoration(
                      icon: Icons.calendar_month_outlined,
                      hint: 'Pilih tanggal',
                    ),
                    child: Text(
                      _tanggalKonseling == null
                          ? 'Pilih tanggal konseling'
                          : _formatTanggal(
                              _tanggalKonseling!,
                            ),
                      style: TextStyle(
                        fontSize: 14,
                        color: _tanggalKonseling == null
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF202124),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= JAM =================

                _label('Jam Konseling'),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: _jam,
                  decoration: _inputDecoration(
                    icon: Icons.access_time_rounded,
                    hint: 'Pilih jam konseling',
                  ),
                  items: _jamList.map((jam) {
                    return DropdownMenuItem<String>(
                      value: jam,
                      child: Text(jam),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _jam = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jam konseling wajib dipilih';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ================= CERITA =================

                _label('Ceritakan Masalahmu'),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _ceritaController,
                  maxLines: 6,
                  textInputAction: TextInputAction.newline,
                  decoration: _inputDecoration(
                    icon: Icons.chat_bubble_outline_rounded,
                    hint: 'Ceritakan masalah yang ingin kamu '
                        'konsultasikan...',
                  ).copyWith(
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ceritakan masalah yang ingin dikonsultasikan';
                    }

                    if (value.trim().length < 10) {
                      return 'Ceritakan sedikit lebih lengkap';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ================= URGENSI =================

                _label('Tingkat Urgensi'),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _urgencyOption(
                        'Rendah',
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _urgencyOption(
                        'Sedang',
                        Icons.remove_rounded,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _urgencyOption(
                        'Tinggi',
                        Icons.keyboard_arrow_up_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ================= PRIVASI =================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF3FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xFF2F6FA3),
                        size: 21,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Cerita yang kamu sampaikan bersifat '
                          'pribadi dan hanya digunakan untuk '
                          'membantu proses konseling.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF2F6FA3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ================= BUTTON =================

                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton.icon(
                    onPressed: _kirimPengajuan,
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 20,
                    ),
                    label: const Text(
                      'Kirim Pengajuan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FA3),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= LABEL =================

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF202124),
      ),
    );
  }

  // ================= INPUT DECORATION =================

  InputDecoration _inputDecoration({
    required IconData icon,
    required String hint,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF2F6FA3),
        size: 21,
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 14,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFF2F6FA3),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  // ================= URGENCY OPTION =================

  Widget _urgencyOption(
    String value,
    IconData icon,
  ) {
    final bool selected = _urgensi == value;

    return InkWell(
      onTap: () {
        setState(() {
          _urgensi = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 48,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEAF3FA)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color(0xFF2F6FA3)
                : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? const Color(0xFF2F6FA3)
                  : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: selected
                    ? const Color(0xFF2F6FA3)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
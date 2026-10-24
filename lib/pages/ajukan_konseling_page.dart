
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

  static const Color _primary = Color(0xFF2F6FA3);
  static const Color _darkBlue = Color(0xFF1E4F7A);
  static const Color _background = Color(0xFFF4F7FB);
  static const Color _textDark = Color(0xFF202124);
  static const Color _textGrey = Color(0xFF6B7280);

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
    final sekarang = DateTime.now();

    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalKonseling ?? sekarang,
      firstDate: DateTime(
        sekarang.year,
        sekarang.month,
        sekarang.day,
      ),
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
              primary: _primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: _textDark,
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
    const namaBulan = [
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
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.fromLTRB(
            24, 24, 24, 8,
          ),
          title: const Column(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: Color(0xFFE5F5EC),
                child: Icon(
                  Icons.check_rounded,
                  color: Color(0xFF238653),
                  size: 38,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Pengajuan Berhasil!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
            ],
          ),
          content: const Text(
            'Pengajuan konseling kamu berhasil dibuat. '
            'Silakan menunggu konfirmasi dari Guru BK.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: _textGrey,
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
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
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Ajukan Konseling',
          style: TextStyle(
            color: _textDark,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconTheme: const IconThemeData(
          color: _textDark,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              18, 16, 18, 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 22),

                // FORM KONSELING
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF193B60)
                            .withValues(alpha: 0.045),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        'Informasi Konseling',
                        'Lengkapi informasi berikut',
                        Icons.assignment_outlined,
                      ),
                      const SizedBox(height: 22),

                      _label('Kategori Masalah'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _kategori,
                        isExpanded: true,
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
                          setState(() => _kategori = value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kategori masalah wajib dipilih';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _label('Guru BK'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _guruBk,
                        isExpanded: true,
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
                          setState(() => _guruBk = value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Guru BK wajib dipilih';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _label('Tanggal Konseling'),
                      const SizedBox(height: 8),
                      _dateField(),

                      const SizedBox(height: 20),

                      _label('Jam Konseling'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _jam,
                        isExpanded: true,
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
                          setState(() => _jam = value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jam konseling wajib dipilih';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      const Divider(
                        color: Color(0xFFEEF1F5),
                        height: 1,
                      ),
                      const SizedBox(height: 24),

                      _sectionTitle(
                        'Ceritakan Masalahmu',
                        'Tuliskan hal yang ingin kamu konsultasikan',
                        Icons.chat_bubble_outline_rounded,
                      ),
                      const SizedBox(height: 18),

                      TextFormField(
                        controller: _ceritaController,
                        maxLines: 6,
                        textInputAction: TextInputAction.newline,
                        decoration: _inputDecoration(
                          icon: Icons.edit_note_rounded,
                          hint: 'Ceritakan masalah yang ingin '
                              'kamu konsultasikan...',
                        ).copyWith(
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ceritakan masalah yang ingin dikonsultasikan';
                          }
                          if (value.trim().length < 10) {
                            return 'Ceritakan sedikit lebih lengkap';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      _sectionTitle(
                        'Tingkat Urgensi',
                        'Seberapa mendesak kamu membutuhkan bantuan?',
                        Icons.flag_outlined,
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: _urgencyOption(
                              'Rendah',
                              Icons.keyboard_arrow_down_rounded,
                              const Color(0xFF258653),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: _urgencyOption(
                              'Sedang',
                              Icons.remove_rounded,
                              _primary,
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: _urgencyOption(
                              'Tinggi',
                              Icons.keyboard_arrow_up_rounded,
                              const Color(0xFFD9534F),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      _privacyNotice(),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _kirimPengajuan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send_rounded, size: 19),
                              SizedBox(width: 10),
                              Text(
                                'Kirim Pengajuan',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                const Center(
                  child: Text(
                    'BinaCare • Teman untuk tumbuh dan berkembang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 11,
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

  // HEADER GRADIENT
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, _darkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -20,
            child: Icon(
              Icons.favorite_rounded,
              size: 120,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Ceritakan yang kamu rasakan',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu tidak harus menghadapi semuanya '
                'sendirian. Guru BK siap mendengarkan.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: _primary,
            size: 21,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _textGrey,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: _textDark,
      ),
    );
  }

  Widget _dateField() {
    final sudahPilih = _tanggalKonseling != null;

    return InkWell(
      onTap: _pilihTanggal,
      borderRadius: BorderRadius.circular(15),
      child: InputDecorator(
        decoration: _inputDecoration(
          icon: Icons.calendar_month_outlined,
          hint: 'Pilih tanggal konseling',
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                sudahPilih
                    ? _formatTanggal(_tanggalKonseling!)
                    : 'Pilih tanggal konseling',
                style: TextStyle(
                  fontSize: 14,
                  color: sudahPilih
                      ? _textDark
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: _textGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _privacyNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD8EAF7),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            color: _primary,
            size: 22,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privasi kamu penting',
                  style: TextStyle(
                    color: _darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Ceritakan dengan nyaman. Informasi ini '
                  'ditujukan untuk membantu proses konseling.',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required IconData icon,
    required String hint,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: _primary,
        size: 21,
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 13,
      ),
      filled: true,
      fillColor: const Color(0xFFFAFBFD),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE5EAF0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE5EAF0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: _primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _urgencyOption(
    String value,
    IconData icon,
    Color color,
  ) {
    final selected = _urgensi == value;

    return InkWell(
      onTap: () {
        setState(() => _urgensi = value);
      },
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 75,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.08)
              : const Color(0xFFFAFBFD),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? color
                : const Color(0xFFE5EAF0),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? color : _textGrey,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.w800
                    : FontWeight.w500,
                color: selected ? color : _textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

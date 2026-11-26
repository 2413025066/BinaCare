
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalKonselingPage extends StatefulWidget {
  const JadwalKonselingPage({super.key});

  @override
  State<JadwalKonselingPage> createState() =>
      _JadwalKonselingPageState();
}

class _JadwalKonselingPageState extends State<JadwalKonselingPage> {
  static const Color primaryColor = Color(0xFF2F6FA3);
  static const Color darkBlue = Color(0xFF1E4F7A);
  static const Color backgroundColor = Color(0xFFF4F7FB);
  static const Color textDark = Color(0xFF202124);
  static const Color textGrey = Color(0xFF6B7280);

  String selectedFilter = 'Semua';

  String _formatTanggal(dynamic value) {
    if (value == null) return '-';

    DateTime date;

    if (value is Timestamp) {
      date = value.toDate();
    } else if (value is DateTime) {
      date = value;
    } else {
      return '-';
    }

    const bulan = [
      'Januari', 'Februari', 'Maret', 'April',
      'Mei', 'Juni', 'Juli', 'Agustus',
      'September', 'Oktober', 'November', 'Desember'
    ];

    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Silakan login terlebih dahulu.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Jadwal Konseling',
          style: TextStyle(
            color: textDark,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconTheme: const IconThemeData(color: textDark),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('pengajuan_konseling')
              .where('siswaId', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Gagal mengambil jadwal dari Firestore. '
                    'Periksa koneksi dan aturan database.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            final semuaData = snapshot.data?.docs ?? [];

            // Jadwal hanya ditampilkan jika pengajuan diterima
            // atau sudah selesai.
            final jadwalList = semuaData
                .map((doc) => doc.data())
                .where((data) {
                  final status = (data['status'] ?? '')
                      .toString()
                      .toLowerCase();

                  return status == 'diterima' ||
                      status == 'dikonfirmasi' ||
                      status == 'selesai';
                })
                .toList();

            jadwalList.sort((a, b) {
              final aDate = a['tanggalKonseling'];
              final bDate = b['tanggalKonseling'];

              final dateA = aDate is Timestamp
                  ? aDate.toDate()
                  : DateTime(2000);

              final dateB = bDate is Timestamp
                  ? bDate.toDate()
                  : DateTime(2000);

              return dateA.compareTo(dateB);
            });

            final totalDikonfirmasi = jadwalList.where((data) {
              final status = (data['status'] ?? '')
                  .toString()
                  .toLowerCase();

              return status == 'diterima' ||
                  status == 'dikonfirmasi';
            }).length;

            final totalSelesai = jadwalList.where((data) {
              return (data['status'] ?? '')
                      .toString()
                      .toLowerCase() ==
                  'selesai';
            }).length;

            final jadwalTampil = selectedFilter == 'Selesai'
                ? jadwalList.where((data) {
                    return (data['status'] ?? '')
                            .toString()
                            .toLowerCase() ==
                        'selesai';
                  }).toList()
                : jadwalList;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 20),
                  _summaryCard(
                    total: jadwalList.length,
                    dikonfirmasi: totalDikonfirmasi,
                    selesai: totalSelesai,
                  ),
                  const SizedBox(height: 25),
                  _sectionTitle(
                    'Daftar Jadwal',
                    'Lihat informasi sesi konselingmu',
                    Icons.event_note_rounded,
                  ),
                  const SizedBox(height: 15),
                  _filterChips(),
                  const SizedBox(height: 16),
                  if (jadwalTampil.isEmpty)
                    _emptyState()
                  else
                    ...jadwalTampil.map(_buildJadwalCard),
                  const SizedBox(height: 12),
                  _informationCard(),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'BinaCare • Teman untuk tumbuh dan berkembang',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryColor, darkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -18,
            child: Icon(
              Icons.calendar_month_rounded,
              size: 120,
              color: Colors.white.withValues(alpha: 0.08),
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
                  Icons.event_available_rounded,
                  size: 27,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Jadwal Konselingmu',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Persiapkan dirimu untuk sesi konseling. '
                'Guru BK siap mendengarkan dan membantumu.',
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

  Widget _summaryCard({
    required int total,
    required int dikonfirmasi,
    required int selesai,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF0F4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF193B60).withValues(alpha: 0.035),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Jadwal',
            style: TextStyle(
              color: textDark,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  icon: Icons.calendar_month_rounded,
                  label: 'Total Jadwal',
                  value: '$total',
                  color: primaryColor,
                  background: const Color(0xFFEAF3FA),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryItem(
                  icon: Icons.event_available_rounded,
                  label: 'Dikonfirmasi',
                  value: '$dikonfirmasi',
                  color: const Color(0xFF2876B5),
                  background: const Color(0xFFEAF3FA),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryItem(
                  icon: Icons.task_alt_rounded,
                  label: 'Selesai',
                  value: '$selesai',
                  color: const Color(0xFF258653),
                  background: const Color(0xFFE8F5EC),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 9),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textGrey,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
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
          child: Icon(icon, color: primaryColor, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterChips() {
    return Wrap(
      spacing: 9,
      children: ['Semua', 'Selesai'].map((filter) {
        final active = selectedFilter == filter;

        return ChoiceChip(
          label: Text(filter),
          selected: active,
          showCheckmark: false,
          selectedColor: primaryColor,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: active
                ? primaryColor
                : const Color(0xFFE5EAF0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          labelStyle: TextStyle(
            color: active ? Colors.white : textGrey,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          onSelected: (_) {
            setState(() {
              selectedFilter = filter;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> item) {
    final status = (item['status'] ?? '').toString();
    final selesai = status.toLowerCase() == 'selesai';

    final statusColor = selesai
        ? const Color(0xFF258653)
        : primaryColor;

    final statusBackground = selesai
        ? const Color(0xFFE8F5EC)
        : const Color(0xFFEAF3FA);

    final tanggal = _formatTanggal(item['tanggalKonseling']);
    final jam = item['jamKonseling']?.toString() ?? '-';
    final guru = item['guruBk']?.toString() ?? '-';
    final kategori = item['kategori']?.toString() ?? '-';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF0F4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF193B60).withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  selesai
                      ? Icons.task_alt_rounded
                      : Icons.event_available_rounded,
                  color: statusColor,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Konseling $kategori',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        selesai ? 'Selesai' : 'Dikonfirmasi',
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          const Divider(
            height: 1,
            color: Color(0xFFEEF1F5),
          ),
          const SizedBox(height: 17),
          _infoRow(Icons.person_outline_rounded, 'Guru BK', guru),
          const SizedBox(height: 15),
          _infoRow(Icons.calendar_month_outlined, 'Tanggal', tanggal),
          const SizedBox(height: 15),
          _infoRow(Icons.access_time_rounded, 'Waktu', jam),
          const SizedBox(height: 15),
          _infoRow(
            Icons.location_on_outlined,
            'Tempat',
            item['tempat']?.toString() ?? 'Ruang BK',
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: primaryColor),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: textGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF0F4)),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFFEAF3FA),
            child: Icon(
              Icons.event_busy_rounded,
              size: 32,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Belum ada jadwal',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: textDark,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Jadwal konseling akan muncul di sini '
            'setelah pengajuanmu diterima oleh Guru BK.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.6,
              color: textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD8EAF7)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: primaryColor,
            size: 22,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jangan Lupa Hadir',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: darkBlue,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Harap datang sesuai jadwal. Jika berhalangan '
                  'hadir, silakan hubungi Guru BK untuk '
                  'mendiskusikan jadwal kembali.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: Color(0xFF315A78),
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

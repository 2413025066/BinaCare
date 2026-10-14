
import 'package:flutter/material.dart';

class JadwalKonselingPage extends StatefulWidget {
  const JadwalKonselingPage({super.key});

  @override
  State<JadwalKonselingPage> createState() =>
      _JadwalKonselingPageState();
}

class _JadwalKonselingPageState extends State<JadwalKonselingPage> {
  final Color primaryColor = const Color(0xFF2F6FA3);

  String selectedFilter = 'Semua';

  final List<Map<String, String>> jadwalList = [
    {
      'topik': 'Kesulitan belajar dan akademik',
      'guru': 'Ibu Siti Rahma, S.Pd.',
      'tanggal': '15 Oktober 2026',
      'waktu': '09:00 - 09:30',
      'tempat': 'Ruang BK',
      'status': 'Dikonfirmasi',
    },
    {
      'topik': 'Konsultasi pemilihan jurusan',
      'guru': 'Ibu Siti Rahma, S.Pd.',
      'tanggal': '20 Oktober 2026',
      'waktu': '10:00 - 10:30',
      'tempat': 'Ruang BK',
      'status': 'Dikonfirmasi',
    },
    {
      'topik': 'Konseling pengembangan diri',
      'guru': 'Bapak Andi Pratama, S.Pd.',
      'tanggal': '5 Oktober 2026',
      'waktu': '13:00 - 13:30',
      'tempat': 'Ruang BK',
      'status': 'Selesai',
    },
  ];

  List<Map<String, String>> get filteredJadwal {
    if (selectedFilter == 'Selesai') {
      return jadwalList
          .where((jadwal) => jadwal['status'] == 'Selesai')
          .toList();
    }

    return jadwalList;
  }

  @override
  Widget build(BuildContext context) {
    final jadwal = filteredJadwal;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Jadwal Konseling',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jadwal Kamu',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Lihat jadwal konseling yang telah disetujui oleh Guru BK.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 22),

            // RINGKASAN JADWAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Jadwal',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${jadwalList.length} jadwal konseling',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Pastikan kamu hadir tepat waktu.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // JUDUL DAFTAR
            const Text(
              'Daftar Jadwal',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),
            const SizedBox(height: 14),

            // FILTER: SEMUA DAN SELESAI
            Row(
              children: ['Semua', 'Selesai'].map((filter) {
                final bool active = selectedFilter == filter;

                return Padding(
                  padding: const EdgeInsets.only(right: 9),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: active,
                    showCheckmark: false,
                    selectedColor: primaryColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: active
                          ? primaryColor
                          : const Color(0xFFE5E7EB),
                    ),
                    labelStyle: TextStyle(
                      color: active
                          ? Colors.white
                          : const Color(0xFF4B5563),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),

            // DAFTAR KARTU JADWAL
            if (jadwal.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
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
                      Icons.event_busy_rounded,
                      size: 45,
                      color: Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada jadwal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF374151),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Jadwal konseling akan ditampilkan di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...jadwal.map((item) => _buildJadwalCard(item)),

            const SizedBox(height: 22),

            // INFORMASI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF2F6FA3),
                    size: 22,
                  ),
                  SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      'Harap datang sesuai jadwal. Jika berhalangan hadir, '
                      'silakan hubungi Guru BK.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF315A78),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, String> item) {
    final bool selesai = item['status'] == 'Selesai';

    final Color statusColor = selesai
        ? const Color(0xFF2E7D32)
        : primaryColor;

    final Color statusBackground = selesai
        ? const Color(0xFFE8F5E9)
        : const Color(0xFFEAF3FA);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  selesai
                      ? Icons.task_alt_rounded
                      : Icons.event_available_rounded,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['topik']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                    const SizedBox(height: 7),
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
                        item['status']!,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
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
            color: Color(0xFFEEEEEE),
          ),
          const SizedBox(height: 15),
          _infoRow(
            Icons.person_outline_rounded,
            'Guru BK',
            item['guru']!,
          ),
          const SizedBox(height: 12),
          _infoRow(
            Icons.calendar_today_outlined,
            'Tanggal',
            item['tanggal']!,
          ),
          const SizedBox(height: 12),
          _infoRow(
            Icons.access_time_rounded,
            'Waktu',
            item['waktu']!,
          ),
          const SizedBox(height: 12),
          _infoRow(
            Icons.location_on_outlined,
            'Tempat',
            item['tempat']!,
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
        Icon(
          icon,
          size: 19,
          color: const Color(0xFF6B7280),
        ),
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
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

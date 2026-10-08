import 'package:flutter/material.dart';

class JadwalKonselingPage extends StatelessWidget {
  const JadwalKonselingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // ============================================================
      // APP BAR
      // ============================================================

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

      // ============================================================
      // BODY
      // ============================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ======================================================
            // JUDUL
            // ======================================================

            const Text(
              'Jadwal Kamu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Berikut jadwal konseling yang telah disetujui oleh Guru BK.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // KARTU JADWAL
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2F6FA3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ==================================================
                  // HEADER KARTU
                  // ==================================================

                  Row(
                    children: [

                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius:
                              BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.event_available_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 13),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Konseling Akademik',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Jadwal telah dikonfirmasi',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // GURU BK
                  // ==================================================

                  _infoRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Guru BK',
                    value: 'Ibu Siti Rahma, S.Pd.',
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // TANGGAL
                  // ==================================================

                  _infoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Tanggal',
                    value: '15 Oktober 2026',
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // WAKTU
                  // ==================================================

                  _infoRow(
                    icon: Icons.access_time_rounded,
                    label: 'Waktu',
                    value: '09:00 - 09:30',
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // TEMPAT
                  // ==================================================

                  _infoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Tempat',
                    value: 'Ruang BK',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ======================================================
            // DETAIL KONSELING
            // ======================================================

            const Text(
              'Detail Konseling',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 13),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // ==================================================
                  // TOPIK
                  // ==================================================

                  const Text(
                    'Topik Konseling',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Kesulitan belajar dan akademik',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202124),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ==================================================
                  // STATUS
                  // ==================================================

                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Dikonfirmasi',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ======================================================
            // INFORMASI
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF2F6FA3),
                    size: 22,
                  ),

                  SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      'Harap datang sesuai jadwal. Jika kamu berhalangan hadir, silakan hubungi Guru BK.',
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

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // INFO ROW
  // ==============================================================

  static Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          color: Colors.white,
          size: 21,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
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
}
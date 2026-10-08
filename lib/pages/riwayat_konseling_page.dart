import 'package:flutter/material.dart';

class RiwayatKonselingPage extends StatelessWidget {
  const RiwayatKonselingPage({super.key});

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
          'Riwayat Konseling',
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
              'Riwayat Konseling',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Daftar konseling yang pernah kamu ajukan.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // RIWAYAT 1
            // ======================================================

            _historyCard(
              context: context,
              category: 'Konseling Akademik',
              teacher: 'Ibu Siti Rahma, S.Pd.',
              date: '15 Oktober 2026',
              time: '09:00 - 09:30',
              status: 'Dikonfirmasi',
              statusColor: const Color(0xFF2E7D32),
              statusBackground: const Color(0xFFE8F5E9),
            ),

            const SizedBox(height: 14),

            // ======================================================
            // RIWAYAT 2
            // ======================================================

            _historyCard(
              context: context,
              category: 'Konseling Pertemanan',
              teacher: 'Bapak Andi Wijaya, S.Pd.',
              date: '5 Oktober 2026',
              time: '10:00 - 10:30',
              status: 'Selesai',
              statusColor: const Color(0xFF2F6FA3),
              statusBackground: const Color(0xFFEAF3FA),
            ),

            const SizedBox(height: 14),

            // ======================================================
            // RIWAYAT 3
            // ======================================================

            _historyCard(
              context: context,
              category: 'Konseling Pribadi',
              teacher: 'Ibu Rina Maharani, S.Psi.',
              date: '28 September 2026',
              time: '13:00 - 13:30',
              status: 'Selesai',
              statusColor: const Color(0xFF2F6FA3),
              statusBackground: const Color(0xFFEAF3FA),
            ),

            const SizedBox(height: 25),

            // ======================================================
            // INFORMASI PRIVASI
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF2F6FA3),
                    size: 21,
                  ),

                  SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      'Riwayat konseling bersifat pribadi dan hanya dapat dilihat oleh kamu dan Guru BK yang menangani konseling.',
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
  // CARD RIWAYAT
  // ==============================================================

  Widget _historyCard({
    required BuildContext context,
    required String category,
    required String teacher,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
    required Color statusBackground,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          _showHistoryDetail(
            context,
            category: category,
            teacher: teacher,
            date: date,
            time: time,
            status: status,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // ICON
              // ==================================================

              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Color(0xFF2F6FA3),
                  size: 24,
                ),
              ),

              const SizedBox(width: 13),

              // ==================================================
              // INFORMASI RIWAYAT
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      teacher,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TANGGAL
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF777777),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // WAKTU
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ==================================================
              // STATUS
              // ==================================================

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9CA3AF),
                    size: 21,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // DETAIL RIWAYAT
  // ==============================================================

  void _showHistoryDetail(
    BuildContext context, {
    required String category,
    required String teacher,
    required String date,
    required String time,
    required String status,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ==================================================
                // GARIS ATAS
                // ==================================================

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

                const SizedBox(height: 20),

                // ==================================================
                // JUDUL
                // ==================================================

                const Text(
                  'Detail Konseling',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // DETAIL
                // ==================================================

                _detailItem(
                  'Topik',
                  category,
                ),

                _detailItem(
                  'Guru BK',
                  teacher,
                ),

                _detailItem(
                  'Tanggal',
                  date,
                ),

                _detailItem(
                  'Waktu',
                  time,
                ),

                _detailItem(
                  'Status',
                  status,
                ),

                const SizedBox(height: 8),

                // ==================================================
                // TOMBOL TUTUP
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FA3),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Tutup',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
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

  // ==============================================================
  // DETAIL ITEM
  // ==============================================================

  Widget _detailItem(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
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

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
            ),
          ),
        ],
      ),
    );
  }
}
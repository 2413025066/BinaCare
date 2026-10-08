import 'package:flutter/material.dart';

class StatusPengajuanPage extends StatelessWidget {
  const StatusPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Status Pengajuan',
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
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= STATUS UTAMA =================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4D6),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.hourglass_top_rounded,
                          color: Color(0xFF9A6A00),
                          size: 25,
                        ),
                      ),

                      const SizedBox(width: 13),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Menunggu Konfirmasi',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9A6A00),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Pengajuan sedang diperiksa oleh Guru BK.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Divider(
                    color: Color(0xFFE5E7EB),
                  ),

                  const SizedBox(height: 16),

                  // ================= KATEGORI =================

                  _detailItem(
                    icon: Icons.category_outlined,
                    title: 'Kategori',
                    value: 'Akademik',
                  ),

                  const SizedBox(height: 16),

                  // ================= GURU =================

                  _detailItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Guru BK',
                    value: 'Ibu Siti Rahma, S.Pd.',
                  ),

                  const SizedBox(height: 16),

                  // ================= TANGGAL =================

                  _detailItem(
                    icon: Icons.calendar_month_outlined,
                    title: 'Tanggal',
                    value: '15 Oktober 2026',
                  ),

                  const SizedBox(height: 16),

                  // ================= JAM =================

                  _detailItem(
                    icon: Icons.access_time_rounded,
                    title: 'Jam',
                    value: '09:00 - 09:30',
                  ),

                  const SizedBox(height: 16),

                  // ================= URGENSI =================

                  _detailItem(
                    icon: Icons.flag_outlined,
                    title: 'Tingkat Urgensi',
                    value: 'Sedang',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= PROGRESS =================

            const Text(
              'Proses Pengajuan',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                children: [

                  _timelineItem(
                    icon: Icons.send_rounded,
                    title: 'Pengajuan dikirim',
                    description:
                        'Pengajuan konseling berhasil dikirim.',
                    active: true,
                    isLast: false,
                  ),

                  _timelineItem(
                    icon: Icons.hourglass_top_rounded,
                    title: 'Menunggu konfirmasi',
                    description:
                        'Guru BK sedang memeriksa pengajuan.',
                    active: true,
                    isLast: false,
                  ),

                  _timelineItem(
                    icon: Icons.check_circle_outline_rounded,
                    title: 'Disetujui',
                    description:
                        'Menunggu persetujuan Guru BK.',
                    active: false,
                    isLast: false,
                  ),

                  _timelineItem(
                    icon: Icons.event_available_outlined,
                    title: 'Jadwal konseling',
                    description:
                        'Jadwal akan tersedia setelah pengajuan disetujui.',
                    active: false,
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= CERITA =================

            const Text(
              'Cerita yang Disampaikan',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: const Text(
                'Saya ingin berkonsultasi mengenai kesulitan belajar.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ================= INFO =================

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
                    Icons.info_outline_rounded,
                    color: Color(0xFF2F6FA3),
                    size: 21,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Status akan berubah setelah Guru BK '
                      'memberikan konfirmasi terhadap pengajuan '
                      'konseling kamu.',
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
          ],
        ),
      ),
    );
  }

  // ================= DETAIL ITEM =================

  static Widget _detailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FA),
            borderRadius: BorderRadius.circular(11),
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
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= TIMELINE =================

  static Widget _timelineItem({
    required IconData icon,
    required String title,
    required String description,
    required bool active,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: 35,
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFEAF3FA)
                      : const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: active
                      ? const Color(0xFF2F6FA3)
                      : const Color(0xFF9CA3AF),
                ),
              ),

              if (!isLast)
                Container(
                  width: 2,
                  height: 45,
                  color: active
                      ? const Color(0xFFD7E7F2)
                      : const Color(0xFFE5E7EB),
                ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 18,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: active
                        ? const Color(0xFF202124)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: active
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
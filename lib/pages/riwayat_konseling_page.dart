
import 'package:flutter/material.dart';

class RiwayatKonselingPage extends StatelessWidget {
  const RiwayatKonselingPage({super.key});

  static const Color primary = Color(0xFF2F6FA3);
  static const Color primaryDark = Color(0xFF205783);
  static const Color background = Color(0xFFF5F8FC);
  static const Color textDark = Color(0xFF202124);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5EAF1);

  static const List<Map<String, String>> history = [
    {
      'category': 'Konseling Akademik',
      'teacher': 'Ibu Siti Rahma, S.Pd.',
      'date': '15 Oktober 2026',
      'time': '09:00 - 09:30',
      'status': 'Dikonfirmasi',
    },
    {
      'category': 'Konseling Pertemanan',
      'teacher': 'Bapak Andi Wijaya, S.Pd.',
      'date': '5 Oktober 2026',
      'time': '10:00 - 10:30',
      'status': 'Selesai',
    },
    {
      'category': 'Konseling Pribadi',
      'teacher': 'Ibu Rina Maharani, S.Psi.',
      'date': '28 September 2026',
      'time': '13:00 - 13:30',
      'status': 'Selesai',
    },
  ];

  int get totalSelesai =>
      history.where((item) => item['status'] == 'Selesai').length;

  int get totalDikonfirmasi =>
      history.where((item) => item['status'] == 'Dikonfirmasi').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: textDark),
        title: const Text(
          'Riwayat Konseling',
          style: TextStyle(
            color: textDark,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildSummary(),
            const SizedBox(height: 25),
            _buildSectionHeader(),
            const SizedBox(height: 14),
            ...history.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: _historyCard(context, item),
              ),
            ),
            const SizedBox(height: 8),
            _buildPrivacyCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primary, primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Perjalanan Konselingmu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lihat kembali daftar konseling dan perkembangan layananmu.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.history_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Row(
      children: [
        Expanded(
          child: _summaryCard(
            icon: Icons.event_note_rounded,
            label: 'Total Riwayat',
            value: '${history.length}',
            color: primary,
            backgroundColor: const Color(0xFFEAF3FA),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _summaryCard(
            icon: Icons.check_circle_outline_rounded,
            label: 'Selesai',
            value: '$totalSelesai',
            color: const Color(0xFF238653),
            backgroundColor: const Color(0xFFE8F6EE),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _summaryCard(
            icon: Icons.calendar_month_rounded,
            label: 'Terjadwal',
            value: '$totalDikonfirmasi',
            color: const Color(0xFFB7791F),
            backgroundColor: const Color(0xFFFFF4D9),
          ),
        ),
      ],
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Riwayat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: textDark,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Pilih salah satu riwayat untuk melihat detail.',
          style: TextStyle(
            fontSize: 13,
            color: textMuted,
          ),
        ),
      ],
    );
  }

  Widget _historyCard(
    BuildContext context,
    Map<String, String> item,
  ) {
    final status = item['status'] ?? '-';
    final isDone = status == 'Selesai';
    final statusColor = isDone
        ? const Color(0xFF238653)
        : const Color(0xFFB7791F);
    final statusBackground = isDone
        ? const Color(0xFFE8F6EE)
        : const Color(0xFFFFF4D9);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showHistoryDetail(context, item),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.psychology_alt_rounded,
                      color: primary,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['category'] ?? '-',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['teacher'] ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
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
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(height: 1, color: borderColor),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: primary,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      item['date'] ?? '-',
                      style: const TextStyle(
                        fontSize: 12,
                        color: textMuted,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item['time'] ?? '-',
                    style: const TextStyle(
                      fontSize: 11,
                      color: textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lihat detail',
                    style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: primary,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD5E7F5),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            color: primary,
            size: 22,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privasi Konseling',
                  style: TextStyle(
                    color: primaryDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Riwayat konseling bersifat pribadi. Jaga kerahasiaan informasi yang berkaitan dengan proses konselingmu.',
                  style: TextStyle(
                    color: Color(0xFF315A78),
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

  void _showHistoryDetail(
    BuildContext context,
    Map<String, String> item,
  ) {
    final status = item['status'] ?? '-';
    final isDone = status == 'Selesai';
    final statusColor = isDone
        ? const Color(0xFF238653)
        : const Color(0xFFB7791F);
    final statusBackground = isDone
        ? const Color(0xFFE8F6EE)
        : const Color(0xFFFFF4D9);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(26),
              ),
            ),
            child: SingleChildScrollView(
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
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FA),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          color: primary,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail Konseling',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: textDark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Informasi riwayat konselingmu',
                              style: TextStyle(
                                fontSize: 12,
                                color: textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Topik Konseling',
                          style: TextStyle(
                            fontSize: 12,
                            color: textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['category'] ?? '-',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: statusBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _detailItem(
                    Icons.person_outline_rounded,
                    'Guru BK',
                    item['teacher'] ?? '-',
                  ),
                  _detailItem(
                    Icons.calendar_today_outlined,
                    'Tanggal',
                    item['date'] ?? '-',
                  ),
                  _detailItem(
                    Icons.access_time_rounded,
                    'Waktu',
                    item['time'] ?? '-',
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
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
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primary, size: 20),
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
                    color: textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textDark,
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

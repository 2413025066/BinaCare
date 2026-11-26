
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusPengajuanPage extends StatelessWidget {
  const StatusPengajuanPage({super.key});

  static const Color _primary = Color(0xFF2F6FA3);
  static const Color _darkBlue = Color(0xFF1E4F7A);
  static const Color _background = Color(0xFFF4F7FB);
  static const Color _textDark = Color(0xFF202124);
  static const Color _textGrey = Color(0xFF6B7280);

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
        body: Center(child: Text('Silakan login terlebih dahulu.')),
      );
    }

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Status Pengajuan',
          style: TextStyle(
            color: _textDark,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconTheme: const IconThemeData(color: _textDark),
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
                    'Gagal mengambil data pengajuan. '
                    'Periksa koneksi dan aturan Firestore.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: _primary),
              );
            }

            final documents = snapshot.data?.docs ?? [];

            if (documents.isEmpty) {
              return _emptyState();
            }

            // Urutkan berdasarkan waktu pengajuan terbaru.
            documents.sort((a, b) {
              final aTime = a.data()['createdAt'];
              final bTime = b.data()['createdAt'];

              final aDate = aTime is Timestamp
                  ? aTime.toDate()
                  : DateTime(2000);

              final bDate = bTime is Timestamp
                  ? bTime.toDate()
                  : DateTime(2000);

              return bDate.compareTo(aDate);
            });

            final data = documents.first.data();

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 20),
                  _statusCard(data),
                  const SizedBox(height: 24),
                  _sectionTitle(
                    'Proses Pengajuan',
                    'Pantau perkembangan pengajuan konselingmu',
                    Icons.timeline_rounded,
                  ),
                  const SizedBox(height: 14),
                  _timelineCard(data),
                  const SizedBox(height: 24),
                  _sectionTitle(
                    'Detail Pengajuan',
                    'Informasi konseling yang kamu ajukan',
                    Icons.assignment_outlined,
                  ),
                  const SizedBox(height: 14),
                  _detailCard(data),
                  const SizedBox(height: 24),
                  _sectionTitle(
                    'Cerita yang Disampaikan',
                    'Ringkasan masalah yang ingin dikonsultasikan',
                    Icons.chat_bubble_outline_rounded,
                  ),
                  const SizedBox(height: 14),
                  _storyCard(data),
                  const SizedBox(height: 18),
                  _infoCard(),
                  const SizedBox(height: 18),
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

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.assignment_outlined,
              size: 65,
              color: Color(0xFF9CA3AF),
            ),
            SizedBox(height: 16),
            Text(
              'Belum Ada Pengajuan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Pengajuan konseling yang kamu kirim akan '
              'ditampilkan di halaman ini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: _textGrey,
                height: 1.5,
              ),
            ),
          ],
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
            top: -18,
            child: Icon(
              Icons.assignment_turned_in_rounded,
              size: 115,
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
                  Icons.track_changes_rounded,
                  size: 27,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Pantau Pengajuanmu',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lihat status dan perkembangan permintaan '
                'konselingmu bersama Guru BK.',
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

  Widget _statusCard(Map<String, dynamic> data) {
    final status = (data['status'] ?? 'Menunggu').toString();

    final bool waiting = status.toLowerCase() == 'menunggu';
    final bool rejected = status.toLowerCase() == 'ditolak';

    final Color statusColor = waiting
        ? const Color(0xFF9A6A00)
        : rejected
            ? Colors.red.shade700
            : _primary;

    final Color statusBackground = waiting
        ? const Color(0xFFFFF4D6)
        : rejected
            ? const Color(0xFFFFEAEA)
            : const Color(0xFFEAF3FA);

    final IconData statusIcon = waiting
        ? Icons.hourglass_top_rounded
        : rejected
            ? Icons.cancel_outlined
            : Icons.check_circle_outline_rounded;

    final String statusText = waiting
        ? 'Menunggu Konfirmasi'
        : status;

    final String message = waiting
        ? 'Pengajuanmu sedang menunggu pemeriksaan dari Guru BK.'
        : rejected
            ? 'Pengajuanmu belum disetujui oleh Guru BK.'
            : status.toLowerCase() == 'diterima'
                ? 'Pengajuanmu telah diterima oleh Guru BK.'
                : 'Status pengajuanmu telah diperbarui.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: statusBackground),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF193B60).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(statusIcon, color: statusColor, size: 29),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STATUS SAAT INI',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                        color: _textGrey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: statusBackground.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    color: statusColor, size: 20),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _primary, size: 21),
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
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: _textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timelineCard(Map<String, dynamic> data) {
    final status = (data['status'] ?? 'Menunggu')
        .toString()
        .toLowerCase();

    
    final bool rejected = status == 'ditolak';
    final bool accepted = status == 'diterima' ||
        status == 'selesai';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 8),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _timelineItem(
            icon: Icons.send_rounded,
            title: 'Pengajuan dikirim',
            description: 'Pengajuan konseling berhasil dikirim.',
            active: true,
            isLast: false,
          ),
          _timelineItem(
            icon: Icons.hourglass_top_rounded,
            title: 'Menunggu konfirmasi',
            description: 'Pengajuan menunggu pemeriksaan Guru BK.',
            active: true,
            isLast: false,
          ),
          _timelineItem(
            icon: rejected
                ? Icons.cancel_outlined
                : Icons.check_circle_outline_rounded,
            title: rejected ? 'Ditolak' : 'Keputusan Guru BK',
            description: rejected
                ? 'Pengajuan belum disetujui.'
                : accepted
                    ? 'Pengajuan telah diterima.'
                    : 'Menunggu keputusan dari Guru BK.',
            active: accepted || rejected,
            isLast: false,
          ),
          _timelineItem(
            icon: Icons.event_available_outlined,
            title: 'Jadwal konseling',
            description: accepted
                ? 'Tanggal: ${_formatTanggal(data['tanggalKonseling'])}, Jam: ${data['jamKonseling'] ?? '-'}'
                : 'Informasi jadwal menunggu persetujuan Guru BK.',
            active: accepted,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _detailCard(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _detailItem(
            icon: Icons.category_outlined,
            title: 'Kategori',
            value: data['kategori']?.toString() ?? '-',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.person_outline_rounded,
            title: 'Guru BK',
            value: data['guruBk']?.toString() ?? '-',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.calendar_month_outlined,
            title: 'Tanggal',
            value: _formatTanggal(data['tanggalKonseling']),
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.access_time_rounded,
            title: 'Jam',
            value: data['jamKonseling']?.toString() ?? '-',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.flag_outlined,
            title: 'Tingkat Urgensi',
            value: data['urgensi']?.toString() ?? '-',
          ),
        ],
      ),
    );
  }

  Widget _detailDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(height: 1, color: Color(0xFFEEF1F5)),
    );
  }

  Widget _storyCard(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            size: 27,
            color: _primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              data['cerita']?.toString() ?? '-',
              style: const TextStyle(
                fontSize: 14,
                height: 1.7,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
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
          Icon(Icons.info_outline_rounded, color: _primary, size: 22),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Status',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _darkBlue,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Informasi pada halaman ini diperbarui secara '
                  'otomatis mengikuti perubahan data pengajuan '
                  'di Cloud Firestore.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FA),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: _primary, size: 21),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: _textGrey)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timelineItem({
    required IconData icon,
    required String title,
    required String description,
    required bool active,
    required bool isLast,
  }) {
    final Color activeColor =
        active ? _primary : const Color(0xFFB8C0CA);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 38,
          child: Column(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFEAF3FA)
                      : const Color(0xFFF1F3F6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active
                        ? const Color(0xFFD5E8F7)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Icon(icon, size: 18, color: activeColor),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 48,
                  color: active
                      ? const Color(0xFFD5E8F7)
                      : const Color(0xFFE5E7EB),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: active ? _textDark : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: active ? _textGrey : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
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
    );
  }
}


import 'package:flutter/material.dart';

class StatusPengajuanPage extends StatelessWidget {
  const StatusPengajuanPage({super.key});

  static const Color _primary = Color(0xFF2F6FA3);
  static const Color _darkBlue = Color(0xFF1E4F7A);
  static const Color _background = Color(0xFFF4F7FB);
  static const Color _textDark = Color(0xFF202124);
  static const Color _textGrey = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 20),

              _statusCard(),
              const SizedBox(height: 24),

              _sectionTitle(
                'Proses Pengajuan',
                'Pantau perkembangan pengajuan konselingmu',
                Icons.timeline_rounded,
              ),
              const SizedBox(height: 14),
              _timelineCard(),
              const SizedBox(height: 24),

              _sectionTitle(
                'Detail Pengajuan',
                'Informasi konseling yang kamu ajukan',
                Icons.assignment_outlined,
              ),
              const SizedBox(height: 14),
              _detailCard(),
              const SizedBox(height: 24),

              _sectionTitle(
                'Cerita yang Disampaikan',
                'Ringkasan masalah yang ingin dikonsultasikan',
                Icons.chat_bubble_outline_rounded,
              ),
              const SizedBox(height: 14),
              _storyCard(),
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

  Widget _statusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFFE5A3)),
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
                  color: const Color(0xFFFFF4D6),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.hourglass_top_rounded,
                  color: Color(0xFF9A6A00),
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STATUS SAAT INI',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                        color: _textGrey,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Menunggu Konfirmasi',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF9A6A00),
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
              color: const Color(0xFFFFFAEB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF9A6A00),
                  size: 20,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Pengajuanmu sedang menunggu pemeriksaan '
                    'dari Guru BK. Silakan menunggu konfirmasi.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF856000),
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

  Widget _timelineCard() {
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
            description: 'Guru BK sedang memeriksa pengajuan.',
            active: true,
            isLast: false,
          ),
          _timelineItem(
            icon: Icons.check_circle_outline_rounded,
            title: 'Disetujui',
            description: 'Menunggu keputusan dari Guru BK.',
            active: false,
            isLast: false,
          ),
          _timelineItem(
            icon: Icons.event_available_outlined,
            title: 'Jadwal konseling',
            description:
                'Informasi jadwal tersedia setelah pengajuan disetujui.',
            active: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _detailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _detailItem(
            icon: Icons.category_outlined,
            title: 'Kategori',
            value: 'Akademik',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.person_outline_rounded,
            title: 'Guru BK',
            value: 'Ibu Siti Rahma, S.Pd.',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.calendar_month_outlined,
            title: 'Tanggal',
            value: '15 Oktober 2026',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.access_time_rounded,
            title: 'Jam',
            value: '09:00 - 09:30',
          ),
          _detailDivider(),
          _detailItem(
            icon: Icons.flag_outlined,
            title: 'Tingkat Urgensi',
            value: 'Sedang',
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

  Widget _storyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote_rounded,
            size: 27,
            color: _primary,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Saya ingin berkonsultasi mengenai kesulitan belajar.',
              style: TextStyle(
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
          Icon(
            Icons.info_outline_rounded,
            color: _primary,
            size: 22,
          ),
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
                  'Status pada halaman ini masih berupa contoh. '
                  'Pada tahap berikutnya, status dapat dihubungkan '
                  'dengan data pengajuan dari aplikasi.',
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _textGrey,
                ),
              ),
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
                child: Icon(
                  icon,
                  size: 18,
                  color: activeColor,
                ),
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

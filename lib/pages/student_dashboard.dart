
import 'package:flutter/material.dart';
import 'ajukan_konseling_page.dart';
import 'status_pengajuan_page.dart';
import 'jadwal_konseling_page.dart';
import 'riwayat_konseling_page.dart';
import 'profil_siswa_page.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  static const Color primaryColor = Color(0xFF2F6FA3);
  static const Color backgroundColor = Color(0xFFF4F7FB);
  static const Color textColor = Color(0xFF202B3C);
  static const Color secondaryTextColor = Color(0xFF7A8798);

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'BinaCare',
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0xFFE7EDF4)),
            ),
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur notifikasi akan dibuat selanjutnya.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: textColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SAPAAN DAN PROFIL
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Halo, Siswa 👋',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                            letterSpacing: -0.7,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Bagaimana kabarmu hari ini?',
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _openPage(
                      context,
                      const ProfilSiswaPage(),
                    ),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE1EAF3),
                        ),
                      ),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FA),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: primaryColor,
                          size: 29,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // BANNER KONSELING
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2F6FA3),
                      Color(0xFF438BC0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -25,
                      top: -35,
                      child: Container(
                        width: 145,
                        height: 145,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 35,
                      bottom: -55,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'RUANG CERITAMU',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 13),
                                const Text(
                                  'Butuh tempat\nuntuk bercerita?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    height: 1.25,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Guru BK siap mendengarkan\nceritamu dengan nyaman.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.88),
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                ElevatedButton(
                                  onPressed: () => _openPage(
                                    context,
                                    const AjukanKonselingPage(),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: primaryColor,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 17,
                                      vertical: 13,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Ajukan Konseling',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(width: 7),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.13),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 29),

              // JUDUL LAYANAN
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Layanan Konseling',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pilih layanan yang kamu butuhkan.',
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F0F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '4 Layanan',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // MENU LAYANAN
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.edit_note_rounded,
                      title: 'Ajukan Konseling',
                      subtitle: 'Buat pengajuan baru',
                      iconColor: const Color(0xFF3479B5),
                      iconBackground: const Color(0xFFEAF3FC),
                      onTap: () => _openPage(
                        context,
                        const AjukanKonselingPage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: _menuCard(
                      icon: Icons.assignment_outlined,
                      title: 'Status Pengajuan',
                      subtitle: 'Cek status pengajuan',
                      iconColor: const Color(0xFF8A64C7),
                      iconBackground: const Color(0xFFF1EBFC),
                      onTap: () => _openPage(
                        context,
                        const StatusPengajuanPage(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 13),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.calendar_month_rounded,
                      title: 'Jadwal Konseling',
                      subtitle: 'Lihat jadwalmu',
                      iconColor: const Color(0xFF239B87),
                      iconBackground: const Color(0xFFE5F6F1),
                      onTap: () => _openPage(
                        context,
                        const JadwalKonselingPage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: _menuCard(
                      icon: Icons.history_rounded,
                      title: 'Riwayat Konseling',
                      subtitle: 'Lihat konseling sebelumnya',
                      iconColor: const Color(0xFFD18A3B),
                      iconBackground: const Color(0xFFFFF3E3),
                      onTap: () => _openPage(
                        context,
                        const RiwayatKonselingPage(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // FOOTER
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: primaryColor.withValues(alpha: 0.6),
                      size: 20,
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'BinaCare · Ruang aman untuk ceritamu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE7EDF4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: iconColor.withValues(alpha: 0.75),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

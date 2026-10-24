
import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilSiswaPage extends StatelessWidget {
  const ProfilSiswaPage({super.key});

  static const Color primary = Color(0xFF2F6FA3);
  static const Color primaryDark = Color(0xFF205783);
  static const Color background = Color(0xFFF5F8FC);
  static const Color textDark = Color(0xFF202124);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5EAF1);

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
          'Profil Saya',
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
            _buildProfileHeader(),
            const SizedBox(height: 25),
            _buildSectionTitle(
              'Informasi Pribadi',
              'Informasi identitas yang terdaftar di BinaCare.',
            ),
            const SizedBox(height: 14),
            _buildDataCard(),
            const SizedBox(height: 20),
            _buildPrivacyCard(),
            const SizedBox(height: 25),
            _buildLogoutButton(context),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'BinaCare • Layanan Konseling Siswa',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 23),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primary, primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.17),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.65),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 52,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Ahmad Rizky',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(width: 6),
                Text(
                  'Siswa • XI IPA 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Profil pengguna BinaCare',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: textDark,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: textMuted,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          _profileItem(
            icon: Icons.badge_outlined,
            label: 'Nomor Induk Siswa',
            value: '123456',
          ),
          _buildDivider(),
          _profileItem(
            icon: Icons.school_outlined,
            label: 'Kelas',
            value: 'XI IPA 1',
          ),
          _buildDivider(),
          _profileItem(
            icon: Icons.email_outlined,
            label: 'Alamat Email',
            value: 'ahmad.rizky@email.com',
          ),
          _buildDivider(),
          _profileItem(
            icon: Icons.phone_outlined,
            label: 'Nomor Telepon',
            value: '081234567890',
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Divider(
        height: 1,
        color: borderColor,
      ),
    );
  }

  Widget _profileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FA),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 13),
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
              const SizedBox(height: 5),
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
            Icons.shield_outlined,
            color: primary,
            size: 23,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privasi Data Kamu',
                  style: TextStyle(
                    color: primaryDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Data profil kamu bersifat pribadi dan digunakan untuk mendukung layanan konseling di sekolah.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
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

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout_rounded, size: 19),
        label: const Text(
          'Keluar dari Akun',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFD32F2F),
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFF0CACA),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEEEE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFD32F2F),
                  size: 29,
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Keluar dari akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu akan kembali ke halaman login BinaCare.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: textMuted,
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: textMuted,
                      side: const BorderSide(color: borderColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Ya, Keluar',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

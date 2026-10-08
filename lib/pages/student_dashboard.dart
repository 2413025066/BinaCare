import 'package:flutter/material.dart';
import 'ajukan_konseling_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  void _openAjukanKonseling() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AjukanKonselingPage(),
      ),
    );
  }

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title akan dibuat selanjutnya.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _showComingSoon('Jadwal Konseling');
    } else if (index == 2) {
      _showComingSoon('Riwayat Konseling');
    } else if (index == 3) {
      _showComingSoon('Profil');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'BinaCare',
          style: TextStyle(
            color: Color(0xFF2F6FA3),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showComingSoon('Notifikasi'),
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF202124),
              size: 28,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= GREETING =================
              const Text(
                'Halo, Siswa 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Ada yang ingin kamu ceritakan hari ini?',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 22),

              // ================= CTA =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F6FA3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Butuh tempat untuk bercerita?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 7),

                          Text(
                            'Ajukan konseling dengan Guru BK.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 15),

                          ElevatedButton(
                            onPressed: _openAjukanKonseling,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF2F6FA3),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 11,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Ajukan Sekarang',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= STATUS =================
              const Text(
                'Pengajuan Terakhir',
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
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF3FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF2F6FA3),
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 13),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konseling Akademik',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202124),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Guru BK 1',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF777777),
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
                        color: const Color(0xFFFFF4D6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Menunggu',
                        style: TextStyle(
                          color: Color(0xFF9A6A00),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= AKSES CEPAT =================
              const Text(
                'Akses Cepat',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.edit_note_rounded,
                      title: 'Ajukan\nKonseling',
                      onTap: _openAjukanKonseling,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _menuCard(
                      icon: Icons.calendar_month_outlined,
                      title: 'Jadwal\nKonseling',
                      onTap: () =>
                          _showComingSoon('Jadwal Konseling'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _menuCard(
                      icon: Icons.history_rounded,
                      title: 'Riwayat\nKonseling',
                      onTap: () =>
                          _showComingSoon('Riwayat Konseling'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _menuCard(
                      icon: Icons.person_outline_rounded,
                      title: 'Profil\nSaya',
                      onTap: () => _showComingSoon('Profil'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onBottomNavTap,
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor: const Color(0xFFEAF3FA),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // ================= MENU CARD =================
  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2F6FA3),
                  size: 24,
                ),
              ),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
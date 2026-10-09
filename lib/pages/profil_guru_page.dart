
import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilGuruPage extends StatefulWidget {
  const ProfilGuruPage({super.key});

  @override
  State<ProfilGuruPage> createState() => _ProfilGuruPageState();
}

class _ProfilGuruPageState extends State<ProfilGuruPage> {
  static const Color biru = Color(0xFF2F6FA3);
  static const Color latar = Color(0xFFF6F8FA);
  static const Color teks = Color(0xFF202124);

  final TextEditingController _namaController =
      TextEditingController(text: 'Nama Guru BK');
  final TextEditingController _nipController =
      TextEditingController();
  final TextEditingController _emailController =
      TextEditingController();

  bool _sedangEdit = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nipController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _simpanProfil() {
    if (_namaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap tidak boleh kosong.'),
        ),
      );
      return;
    }

    setState(() {
      _sedangEdit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui sementara.'),
      ),
    );
  }

  void _logout() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Konfirmasi Logout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya, Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: teks,
          ),
        ),
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: teks,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu profil
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: biru,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: biru,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _namaController.text.isEmpty
                          ? 'Nama Guru BK'
                          : _namaController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Guru Bimbingan dan Konseling',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Informasi pribadi
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Informasi Pribadi',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: teks,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (_sedangEdit) {
                        _simpanProfil();
                      } else {
                        setState(() {
                          _sedangEdit = true;
                        });
                      }
                    },
                    icon: Icon(
                      _sedangEdit
                          ? Icons.save_outlined
                          : Icons.edit_outlined,
                      size: 18,
                    ),
                    label: Text(
                      _sedangEdit ? 'Simpan' : 'Edit',
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: biru,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              _fieldProfil(
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person_outline_rounded,
                controller: _namaController,
              ),

              const SizedBox(height: 16),

              _fieldProfil(
                label: 'NIP',
                hint: 'Masukkan NIP',
                icon: Icons.badge_outlined,
                controller: _nipController,
              ),

              const SizedBox(height: 16),

              _fieldProfil(
                label: 'Email',
                hint: 'Masukkan email',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),

              // Tombol logout
              OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout_rounded),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'BinaCare • Guru BK',
                  style: TextStyle(
                    color: Color(0xFF8A8F98),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldProfil({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: teks,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: _sedangEdit,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: _sedangEdit ? biru : Colors.grey,
            ),
            filled: true,
            fillColor: _sedangEdit
                ? Colors.white
                : const Color(0xFFF0F2F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFFE2E5E9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFFE2E5E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: biru,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFFE2E5E9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

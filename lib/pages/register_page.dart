
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedRole = 'Siswa';

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final namaController = TextEditingController();
  final nisController = TextEditingController();
  final kelasController = TextEditingController();
  final nipController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nisController.dispose();
    kelasController.dispose();
    nipController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ================= REGISTER =================

  void register() {
    if (namaController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showMessage('Semua data harus diisi.');
      return;
    }

    if (selectedRole == 'Siswa') {
      if (nisController.text.trim().isEmpty ||
          kelasController.text.trim().isEmpty) {
        _showMessage('NIS dan kelas harus diisi.');
        return;
      }
    } else {
      if (nipController.text.trim().isEmpty) {
        _showMessage('NIP harus diisi untuk Guru BK.');
        return;
      }
    }

    final email = emailController.text.trim();

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(email)) {
      _showMessage('Masukkan alamat email yang valid.');
      return;
    }

    if (passwordController.text.length < 6) {
      _showMessage('Password minimal 6 karakter.');
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {
      _showMessage('Konfirmasi password tidak sesuai.');
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Validasi Berhasil',
            style: TextStyle(fontSize: 18),
          ),
          content: const Text(
            'Data pendaftaran sudah lengkap dan valid. '
            'Akun belum tersimpan karena database belum '
            'terhubung. Silakan lanjutkan pengembangan '
            'integrasi login dan database.',
            style: TextStyle(fontSize: 13),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FB),
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            color: Color(0xFF2F6FA3),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            child: Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0xFFE5E7EB),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= LOGO =================

                    const Center(
                      child: Icon(
                        Icons.person_add_alt_1,
                        size: 34,
                        color: Color(0xFF2F6FA3),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Center(
                      child: Text(
                        'Buat Akun BinaCare',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ================= ROLE =================

                    _label('Daftar sebagai'),

                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _roleButton('Siswa'),
                          ),
                          Expanded(
                            child: _roleButton('Guru BK'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= NAMA =================

                    _label('Nama Lengkap'),

                    _textField(
                      controller: namaController,
                      hint: 'Masukkan nama lengkap',
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 9),

                    // ================= DATA SISWA =================

                    if (selectedRole == 'Siswa') ...[
                      _label('NIS'),

                      _textField(
                        controller: nisController,
                        hint: 'Masukkan NIS',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 9),

                      _label('Kelas'),

                      _textField(
                        controller: kelasController,
                        hint: 'Contoh: XII IPA 1',
                        icon: Icons.school_outlined,
                      ),

                      const SizedBox(height: 9),
                    ],

                    // ================= DATA GURU =================

                    if (selectedRole == 'Guru BK') ...[
                      _label('NIP'),

                      _textField(
                        controller: nipController,
                        hint: 'Masukkan NIP',
                        icon: Icons.badge_outlined,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 9),
                    ],

                    // ================= EMAIL =================

                    _label('Email'),

                    _textField(
                      controller: emailController,
                      hint: 'Masukkan email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 9),

                    // ================= PASSWORD =================

                    _label('Password'),

                    _textField(
                      controller: passwordController,
                      hint: 'Masukkan password',
                      icon: Icons.lock_outline,
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 9),

                    // ================= KONFIRMASI PASSWORD =================

                    _label('Konfirmasi Password'),

                    _textField(
                      controller: confirmPasswordController,
                      hint: 'Ulangi password',
                      icon: Icons.lock_outline,
                      obscureText: obscureConfirmPassword,
                      suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword =
                                !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 13),

                    // ================= BUTTON REGISTER =================

                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6FA3),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sudah punya akun? Masuk',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF2F6FA3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= LABEL =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF202124),
        ),
      ),
    );
  }

  // ================= TEXT FIELD =================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 11),
        prefixIcon: Icon(
          icon,
          size: 16,
          color: const Color(0xFF4B5563),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFF2F6FA3),
            width: 1.2,
          ),
        ),
      ),
    );
  }

  // ================= ROLE BUTTON =================

  Widget _roleButton(String role) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          role,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? const Color(0xFF2F6FA3)
                : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

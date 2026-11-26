
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color primaryColor = Color(0xFF2F6FA3);
  static const Color backgroundColor = Color(0xFFF6F8FA);

  String selectedRole = 'Siswa';

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

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

  // ================= REGISTER FIREBASE =================

  Future<void> register() async {
    if (isLoading) return;

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
    final password = passwordController.text;

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(email)) {
      _showMessage('Masukkan alamat email yang valid.');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password minimal 6 karakter.');
      return;
    }

    if (password != confirmPasswordController.text) {
      _showMessage('Konfirmasi password tidak sesuai.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    User? newUser;

    try {
      // 1. Membuat akun Firebase Authentication
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      newUser = credential.user;

      if (newUser == null) {
        throw Exception('Akun gagal dibuat.');
      }

      // 2. Menyiapkan data pengguna
      final Map<String, dynamic> userData = {
        'uid': newUser.uid,
        'nama': namaController.text.trim(),
        'email': email,
        'role': selectedRole,
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (selectedRole == 'Siswa') {
        userData['nis'] = nisController.text.trim();
        userData['kelas'] = kelasController.text.trim();
      } else {
        userData['nip'] = nipController.text.trim();
      }

      // 3. Menyimpan data ke Cloud Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.uid)
          .set(userData);

      // 4. Logout agar pengguna masuk melalui halaman Login
      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      // 5. Menampilkan pesan berhasil
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Pendaftaran Berhasil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'Akun BinaCare berhasil dibuat. '
              'Silakan masuk menggunakan email dan '
              'password yang telah didaftarkan.',
              style: TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email sudah terdaftar.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'weak-password':
          message = 'Password terlalu lemah.';
          break;
        case 'operation-not-allowed':
          message =
              'Pendaftaran email/password belum diaktifkan.';
          break;
        default:
          message = e.message ?? 'Pendaftaran gagal.';
      }

      if (mounted) {
        _showMessage(message);
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        _showMessage(
          'Akun mungkin sudah dibuat, tetapi data profil gagal disimpan: ${e.message}',
        );
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Terjadi kesalahan: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ================= PESAN =================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
            size: 23,
          ),
          onPressed: isLoading
              ? null
              : () {
                  Navigator.pop(context);
                },
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        color: Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // LOGO

                          const Center(
                            child: Icon(
                              Icons.person_add_alt_1,
                              size: 45,
                              color: primaryColor,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Center(
                            child: Text(
                              'Buat Akun BinaCare',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF202124),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // ROLE

                          _label('Daftar sebagai'),

                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F3F5),
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _roleButton('Siswa'),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: _roleButton('Guru BK'),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // NAMA

                          _label('Nama Lengkap'),

                          const SizedBox(height: 7),

                          _textField(
                            controller: namaController,
                            hint: 'Masukkan nama lengkap',
                            icon: Icons.person_outline,
                          ),

                          const SizedBox(height: 15),

                          // DATA SISWA

                          if (selectedRole == 'Siswa') ...[
                            _label('NIS'),

                            const SizedBox(height: 7),

                            _textField(
                              controller: nisController,
                              hint: 'Masukkan NIS',
                              icon: Icons.badge_outlined,
                              keyboardType: TextInputType.number,
                            ),

                            const SizedBox(height: 15),

                            _label('Kelas'),

                            const SizedBox(height: 7),

                            _textField(
                              controller: kelasController,
                              hint: 'Contoh: XII IPA 1',
                              icon: Icons.school_outlined,
                            ),

                            const SizedBox(height: 15),
                          ],

                          // DATA GURU

                          if (selectedRole == 'Guru BK') ...[
                            _label('NIP'),

                            const SizedBox(height: 7),

                            _textField(
                              controller: nipController,
                              hint: 'Masukkan NIP',
                              icon: Icons.badge_outlined,
                              keyboardType: TextInputType.number,
                            ),

                            const SizedBox(height: 15),
                          ],

                          // EMAIL

                          _label('Email'),

                          const SizedBox(height: 7),

                          _textField(
                            controller: emailController,
                            hint: 'Masukkan email',
                            icon: Icons.email_outlined,
                            keyboardType:
                                TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 15),

                          // PASSWORD

                          _label('Password'),

                          const SizedBox(height: 7),

                          _textField(
                            controller: passwordController,
                            hint: 'Masukkan password',
                            icon: Icons.lock_outline,
                            obscureText: obscurePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword =
                                      !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 21,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // KONFIRMASI PASSWORD

                          _label('Konfirmasi Password'),

                          const SizedBox(height: 7),

                          _textField(
                            controller: confirmPasswordController,
                            hint: 'Ulangi password',
                            icon: Icons.lock_outline,
                            obscureText: obscureConfirmPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureConfirmPassword =
                                      !obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 21,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // BUTTON REGISTER

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading ? null : register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                    const Color(0xFF8EABC2),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 21,
                                      height: 21,
                                      child:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Daftar',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // LINK LOGIN

                          Center(
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                    },
                              child: const Text(
                                'Sudah punya akun? Masuk',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
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
            );
          },
        ),
      ),
    );
  }

  // ================= LABEL =================

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF202124),
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
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF202124),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF9CA3AF),
        ),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: const Color(0xFF4B5563),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          minHeight: 48,
        ),
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // ================= ROLE BUTTON =================

  Widget _roleButton(String role) {
    final isSelected = selectedRole == role;

    return Material(
      color: isSelected
          ? Colors.white
          : Colors.transparent,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: isLoading
            ? null
            : () {
                setState(() {
                  selectedRole = role;
                });
              },
        borderRadius: BorderRadius.circular(9),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : Colors.transparent,
              width: 1.3,
            ),
          ),
          child: Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.w500,
              color: isSelected
                  ? primaryColor
                  : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}

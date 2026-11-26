
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_page.dart';
import 'student_dashboard.dart';
import 'guru_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _nisController =
      TextEditingController();
  final TextEditingController _nipController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  String selectedRole = 'Siswa';
  bool _obscurePassword = true;
  bool _isLoading = false;

  static const Color primaryColor = Color(0xFF2F6FA3);
  static const Color backgroundColor = Color(0xFFF6F8FA);

  @override
  void dispose() {
    _emailController.dispose();
    _nisController.dispose();
    _nipController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= LOGIN FIREBASE =================

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final identifier = selectedRole == 'Siswa'
          ? _nisController.text.trim()
          : _nipController.text.trim();

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Akun tidak ditemukan.');
      }

      final userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDocument.exists) {
        await FirebaseAuth.instance.signOut();
        _showMessage(
          'Data profil belum ditemukan. Silakan hubungi administrator.',
        );
        return;
      }

      final userData = userDocument.data()!;

      final savedRole = userData['role']?.toString();

      final savedIdentifier = selectedRole == 'Siswa'
          ? userData['nis']?.toString()
          : userData['nip']?.toString();

      if (savedRole != selectedRole) {
        await FirebaseAuth.instance.signOut();
        _showMessage(
          'Role tidak sesuai dengan akun yang terdaftar.',
        );
        return;
      }

      if (savedIdentifier == null ||
          savedIdentifier.trim() != identifier) {
        await FirebaseAuth.instance.signOut();

        _showMessage(
          selectedRole == 'Siswa'
              ? 'NIS tidak sesuai dengan akun.'
              : 'NIP tidak sesuai dengan akun.',
        );
        return;
      }

      if (!mounted) return;

      if (selectedRole == 'Siswa') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentDashboard(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GuruDashboard(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          message = 'Email atau password salah.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'user-disabled':
          message = 'Akun ini telah dinonaktifkan.';
          break;
        case 'too-many-requests':
          message = 'Terlalu banyak percobaan. Coba lagi nanti.';
          break;
        case 'network-request-failed':
          message = 'Periksa koneksi internet kamu.';
          break;
        default:
          message = 'Login gagal: ${e.message ?? e.code}';
      }

      _showMessage(message);
    } on FirebaseException catch (e) {
      _showMessage(
        'Gagal mengambil data pengguna: ${e.message ?? e.code}',
      );
    } catch (e) {
      _showMessage('Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ================= REGISTER =================

  void _openRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // LOGO

                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'BinaCare',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Layanan Konseling Siswa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // CARD LOGIN

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.03,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF202124),
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'Masuk untuk menggunakan BinaCare.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),

                              const SizedBox(height: 20),

                              _fieldLabel('Masuk sebagai'),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Expanded(
                                    child: _roleButton(
                                      title: 'Siswa',
                                      icon: Icons.school_outlined,
                                      selected:
                                          selectedRole == 'Siswa',
                                      onTap: () {
                                        setState(() {
                                          selectedRole = 'Siswa';
                                        });
                                        _formKey.currentState?.reset();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _roleButton(
                                      title: 'Guru BK',
                                      icon: Icons.support_agent_outlined,
                                      selected:
                                          selectedRole == 'Guru BK',
                                      onTap: () {
                                        setState(() {
                                          selectedRole = 'Guru BK';
                                        });
                                        _formKey.currentState?.reset();
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              // EMAIL

                              _fieldLabel('Email'),

                              const SizedBox(height: 7),

                              TextFormField(
                                controller: _emailController,
                                keyboardType:
                                    TextInputType.emailAddress,
                                textInputAction:
                                    TextInputAction.next,
                                style: const TextStyle(fontSize: 14),
                                decoration: _inputDecoration(
                                  hint: 'Masukkan email',
                                  icon: Icons.email_outlined,
                                ),
                                validator: (value) {
                                  final email =
                                      value?.trim() ?? '';

                                  if (email.isEmpty) {
                                    return 'Email harus diisi.';
                                  }

                                  if (!RegExp(
                                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                  ).hasMatch(email)) {
                                    return 'Masukkan email yang valid.';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              // NIS / NIP

                              _fieldLabel(
                                selectedRole == 'Siswa'
                                    ? 'NIS'
                                    : 'NIP',
                              ),

                              const SizedBox(height: 7),

                              TextFormField(
                                controller: selectedRole == 'Siswa'
                                    ? _nisController
                                    : _nipController,
                                keyboardType: TextInputType.number,
                                textInputAction:
                                    TextInputAction.next,
                                style: const TextStyle(fontSize: 14),
                                decoration: _inputDecoration(
                                  hint: selectedRole == 'Siswa'
                                      ? 'Masukkan NIS'
                                      : 'Masukkan NIP',
                                  icon: Icons.badge_outlined,
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return selectedRole == 'Siswa'
                                        ? 'NIS harus diisi.'
                                        : 'NIP harus diisi.';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 15),

                              // PASSWORD

                              _fieldLabel('Password'),

                              const SizedBox(height: 7),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _login(),
                                style: const TextStyle(fontSize: 14),
                                decoration: _inputDecoration(
                                  hint: 'Masukkan password',
                                  icon: Icons.lock_outline_rounded,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword =
                                            !_obscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF6B7280),
                                      size: 21,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Password harus diisi.';
                                  }

                                  if (value.length < 6) {
                                    return 'Password minimal 6 karakter.';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 22),

                              // TOMBOL MASUK

                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed:
                                      _isLoading ? null : _login,
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
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 21,
                                          height: 21,
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Masuk',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // LINK REGISTER

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Belum punya akun?',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _isLoading
                                        ? null
                                        : _openRegister,
                                    child: const Text(
                                      'Daftar',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'BinaCare • Layanan Konseling Siswa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= FIELD LABEL =================

  Widget _fieldLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF202124),
      ),
    );
  }

  // ================= INPUT DECORATION =================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF9CA3AF),
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF4B5563),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 46,
        minHeight: 48,
      ),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
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
    );
  }

  // ================= ROLE BUTTON =================

  Widget _roleButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: selected
          ? const Color(0xFFEAF3FA)
          : const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? primaryColor
                  : const Color(0xFFE5E7EB),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: selected
                    ? primaryColor
                    : const Color(0xFF6B7280),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: selected
                        ? primaryColor
                        : const Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

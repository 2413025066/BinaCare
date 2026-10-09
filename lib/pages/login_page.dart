import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _nisController.dispose();
    _nipController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ================= LOGIN =================

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // LOGIN SEMENTARA
    // Belum memeriksa data melalui database.

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
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Column(
                children: [
                  // ================= LOGO =================

                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: Color(0xFF2F6FA3),
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'BinaCare',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FA3),
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Layanan Konseling Siswa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ================= CARD LOGIN =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
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

                          const SizedBox(height: 6),

                          const Text(
                            'Masuk untuk menggunakan BinaCare.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // ================= ROLE =================

                          const Text(
                            'Masuk sebagai',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202124),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: _roleButton(
                                  title: 'Siswa',
                                  icon: Icons.school_outlined,
                                  selected: selectedRole == 'Siswa',
                                  onTap: () {
                                    setState(() {
                                      selectedRole = 'Siswa';
                                    });
                                    _formKey.currentState?.reset();
                                  },
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _roleButton(
                                  title: 'Guru BK',
                                  icon: Icons.support_agent_outlined,
                                  selected: selectedRole == 'Guru BK',
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

                          const SizedBox(height: 20),

                          // ================= EMAIL =================

                          _fieldLabel('Email'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              hint: 'Masukkan email',
                              icon: Icons.email_outlined,
                            ),
                            validator: (value) {
                              final email = value?.trim() ?? '';

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

                          const SizedBox(height: 18),

                          // ================= NIS / NIP =================

                          _fieldLabel(
                            selectedRole == 'Siswa' ? 'NIS' : 'NIP',
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: selectedRole == 'Siswa'
                                ? _nisController
                                : _nipController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
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

                          const SizedBox(height: 18),

                          // ================= PASSWORD =================

                          _fieldLabel('Password'),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _login(),
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
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password harus diisi.';
                              }

                              if (value.length < 6) {
                                return 'Password minimal 6 karakter.';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          // ================= LOGIN BUTTON =================

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2F6FA3),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ================= REGISTER =================

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                onPressed: _openRegister,
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Color(0xFF2F6FA3),
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

                  const SizedBox(height: 18),

                  const Text(
                    'BinaCare • Layanan Konseling Siswa',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF4B5563),
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF2F6FA3),
          width: 1.5,
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
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2F6FA3)
                  : const Color(0xFFE5E7EB),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 21,
                color: selected
                    ? const Color(0xFF2F6FA3)
                    : const Color(0xFF6B7280),
              ),

              const SizedBox(width: 7),

              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: selected
                      ? const Color(0xFF2F6FA3)
                      : const Color(0xFF4B5563),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
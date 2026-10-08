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

  final TextEditingController _passwordController =
      TextEditingController();

  String selectedRole = 'Siswa';

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ================= LOGIN =================

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Sementara belum menggunakan database.
    // Jika role Siswa, masuk ke Dashboard Siswa.
    if (selectedRole == 'Siswa') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const StudentDashboard(),
        ),
      );
    }

    // Jika role Guru BK, masuk ke Dashboard Guru BK.
    else {
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
                                  selected:
                                      selectedRole == 'Siswa',
                                  onTap: () {
                                    setState(() {
                                      selectedRole = 'Siswa';
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _roleButton(
                                  title: 'Guru BK',
                                  icon:
                                      Icons.support_agent_outlined,
                                  selected:
                                      selectedRole == 'Guru BK',
                                  onTap: () {
                                    setState(() {
                                      selectedRole = 'Guru BK';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ================= EMAIL =================

                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202124),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _emailController,
                            keyboardType:
                                TextInputType.emailAddress,
                            textInputAction:
                                TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Masukkan email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF4B5563),
                              ),
                              filled: true,
                              fillColor:
                                  const Color(0xFFF8FAFC),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                ),
                              ),
                              focusedBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF2F6FA3),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Email harus diisi.';
                              }

                              if (!value.contains('@')) {
                                return 'Masukkan email yang valid.';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // ================= PASSWORD =================

                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202124),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction:
                                TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _login();
                            },
                            decoration: InputDecoration(
                              hintText: 'Masukkan password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Color(0xFF4B5563),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword =
                                        !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons
                                          .visibility_outlined
                                      : Icons
                                          .visibility_off_outlined,
                                  color:
                                      const Color(0xFF6B7280),
                                ),
                              ),
                              filled: true,
                              fillColor:
                                  const Color(0xFFF8FAFC),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFE5E7EB),
                                ),
                              ),
                              focusedBorder:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF2F6FA3),
                                  width: 1.5,
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
                                shape:
                                    RoundedRectangleBorder(
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
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum punya akun?',
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      Color(0xFF6B7280),
                                ),
                              ),

                              TextButton(
                                onPressed: _openRegister,
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color:
                                        Color(0xFF2F6FA3),
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w700,
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
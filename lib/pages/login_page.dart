
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
              horizontal: 16,
              vertical: 8,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ================= LOGO =================

                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: Color(0xFF2F6FA3),
                      size: 23,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'BinaCare',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F6FA3),
                    ),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    'Layanan Konseling Siswa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ================= CARD LOGIN =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF202124),
                            ),
                          ),

                          const SizedBox(height: 2),

                          const Text(
                            'Masuk untuk menggunakan BinaCare.',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF6B7280),
                            ),
                          ),

                          const SizedBox(height: 9),

                          // ================= ROLE =================

                          _fieldLabel('Masuk sebagai'),

                          const SizedBox(height: 4),

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
                              const SizedBox(width: 6),
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

                          const SizedBox(height: 8),

                          // ================= EMAIL =================

                          _fieldLabel('Email'),

                          const SizedBox(height: 3),

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 12),
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

                          const SizedBox(height: 7),

                          // ================= NIS / NIP =================

                          _fieldLabel(
                            selectedRole == 'Siswa' ? 'NIS' : 'NIP',
                          ),

                          const SizedBox(height: 3),

                          TextFormField(
                            controller: selectedRole == 'Siswa'
                                ? _nisController
                                : _nipController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 12),
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

                          const SizedBox(height: 7),

                          // ================= PASSWORD =================

                          _fieldLabel('Password'),

                          const SizedBox(height: 3),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _login(),
                            style: const TextStyle(fontSize: 12),
                            decoration: _inputDecoration(
                              hint: 'Masukkan password',
                              icon: Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
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
                                  size: 17,
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

                          const SizedBox(height: 10),

                          // ================= LOGIN BUTTON =================

                          SizedBox(
                            width: double.infinity,
                            height: 34,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF2F6FA3),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // ================= REGISTER =================

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Belum punya akun?',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: _openRegister,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 3,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Color(0xFF2F6FA3),
                                    fontSize: 10,
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

                  const SizedBox(height: 6),

                  const Text(
                    'BinaCare • Layanan Konseling Siswa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
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
        fontSize: 11,
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
      hintStyle: const TextStyle(fontSize: 11),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF4B5563),
        size: 16,
      ),
      suffixIcon: suffixIcon,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 30,
      ),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
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
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2F6FA3)
                  : const Color(0xFFE5E7EB),
              width: selected ? 1.2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15,
                color: selected
                    ? const Color(0xFF2F6FA3)
                    : const Color(0xFF6B7280),
              ),
              const SizedBox(width: 3),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: selected
                        ? const Color(0xFF2F6FA3)
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
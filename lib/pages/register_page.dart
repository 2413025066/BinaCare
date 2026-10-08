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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    if (namaController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data harus diisi.'),
        ),
      );
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi password tidak sesuai.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pendaftaran Berhasil'),
          content: Text(
            'Akun $selectedRole berhasil dibuat. '
            'Silakan login menggunakan akun yang telah didaftarkan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
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
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.person_add_alt_1,
                        size: 50,
                        color: Color(0xFF2F6FA3),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Center(
                      child: Text(
                        'Buat Akun BinaCare',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: namaController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama lengkap',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: emailController,
                      keyboardType:
                          TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Masukkan email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword =
                                  !obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Konfirmasi Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                          confirmPasswordController,
                      obscureText:
                          obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText:
                            'Masukkan kembali password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureConfirmPassword =
                                  !obscureConfirmPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Daftar sebagai',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(12),
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

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF2F6FA3),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sudah punya akun? Masuk',
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

  Widget _roleButton(String role) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          role,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.normal,
            color: isSelected
                ? const Color(0xFF2F6FA3)
                : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
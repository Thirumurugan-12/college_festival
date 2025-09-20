import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import 'login_otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.orbitron(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your phone number to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.accentCyan),
                ),
                const SizedBox(height: 48),
                TextField(
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: AppColors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: AppColors.accentCyan),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.accentCyan),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.accentPink,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginOTPScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPink,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get OTP',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

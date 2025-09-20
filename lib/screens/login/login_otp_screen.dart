import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import 'my_entry_screen.dart';

class LoginOTPScreen extends StatelessWidget {
  const LoginOTPScreen({super.key});

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
                  'Enter OTP',
                  style: GoogleFonts.orbitron(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'A 4-digit code has been sent to your number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.accentCyan),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildOtpBox()),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MyEntryScreen()),
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
                    'Verify',
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

  Widget _buildOtpBox() {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(color: AppColors.white, fontSize: 24),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.accentCyan),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.accentPink, width: 2),
          ),
        ),
      ),
    );
  }
}

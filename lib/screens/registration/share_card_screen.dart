import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

class ShareCardScreen extends StatelessWidget {
  const ShareCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Your Share Card',
                  style: GoogleFonts.orbitron(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.accentPurple, AppColors.accentPink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentPink.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.primaryBg,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your Name',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'College Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Icon(
                        Icons.qr_code_2,
                        size: 100,
                        color: AppColors.white,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Scan to listen to my song!',
                        style: TextStyle(fontSize: 14, color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    foregroundColor: AppColors.primaryBg,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Done',
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
